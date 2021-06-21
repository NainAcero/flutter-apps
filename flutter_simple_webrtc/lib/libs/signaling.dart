import 'package:flutter_simple_webrtc/models/heroe.dart';
import 'package:flutter_simple_webrtc/utils/webrtc_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_incall_manager/incall.dart';

typedef OnConnected(Map<String, Heroe> heroes);
typedef OnAssigned(String? heroName);
typedef OnTaken(String heroName);
typedef OnDisconnected(String heroName);
typedef OnLocalStream(MediaStream stream);
typedef OnRemoteStream(MediaStream stream);
typedef OnResponse(dynamic data);
typedef OnRequest(dynamic data);
typedef OnCancelRequest();
typedef OnFinishCall();

class Signaling {
  IO.Socket? _socket;
  late OnConnected onConnected;
  late OnAssigned onAssigned;
  late OnTaken onTaken;
  late OnDisconnected onDisconnected;
  RTCPeerConnection? _peer;
  late OnLocalStream onLocalStream;
  late OnRemoteStream onRemoteStream;
  late OnResponse onResponse;
  late OnRequest onRequest;
  late OnCancelRequest onCancelRequest;
  late OnFinishCall onFinishCall;
  
  MediaStream? _localStream;
  String? _him, _requestId;
  RTCSessionDescription? _incommingOffer;
  IncallManager? _incallManager = IncallManager();

  bool _isFrontCamera = true, _mute = false;

  Future<void> init() async{
    _localStream = await navigator.mediaDevices.getUserMedia(
      WebRTCConfig.mediaConstraints
    );

    onLocalStream(_localStream!);
    _connect();
  }

  _connect() {
    _socket = IO.io('https://backend-super-hero-call.herokuapp.com', <String, dynamic> {
      'transports': ['websocket'],
    });

    _socket!.on('on-connected', (data){
      final tmp = Map.from(data);

      final Map<String, Heroe> heroes = tmp.map((key, value) {
        final Heroe hero = Heroe.fromJson(value);
        return MapEntry<String, Heroe>(key, hero);
      });
      onConnected(heroes);
    });

    _socket!.on('on-assigned', (heroName) {
      onAssigned(heroName);
    });

    _socket!.on('on-taken', (heroName) {
      onTaken(heroName);
    });

    _socket!.on('on-disconnected', (heroName) {
      onDisconnected(heroName);
    });

    _socket!.on('on-request', (data) {
      _incallManager!.startRingtone('DEFAULT', 'default', 10);
      _him = data['superHeroName'];
      _requestId = data['requestId'];
      final tmp = data['offer'];

      _incommingOffer = RTCSessionDescription(tmp['sdp'], tmp['type']);
      onRequest(data);
    });

    _socket!.on('on-cancel-request', (_) {
      _incallManager!.stopRingtone();
      _finishCall();
      onCancelRequest();
    });

    _socket!.on('on-response', (answer) async{
      if(answer == null){
        _finishCall();
      } else {
        RTCSessionDescription tmp = RTCSessionDescription(answer['sdp'], answer['type']);
        await _peer!.setRemoteDescription(tmp);
      }

      onResponse(answer);
    });

    _socket!.on('on-candidate', (data) async{
      if(_peer != null) {
        final iceCandidate =  RTCIceCandidate(data['candidate'], data['sdpMid'], data['sdpMLineIndex']);
        await _peer!.addCandidate(iceCandidate);
      }
    });

    _socket!.on('on-finish-call', (_) {
      _finishCall();
      onFinishCall();
    });
  }

  emit(String event, dynamic data) {
    _socket?.emit(event, data);
  }

  Future<void> _createdPeer() async {
    _peer = await createPeerConnection(WebRTCConfig.configuration, {});
    _peer!.addStream(_localStream!);
    _peer!.onIceCandidate = (RTCIceCandidate? iceCandidate) {
      if(iceCandidate != null){
        if(_him != null){
          emit('candidate', {
            'him': _him,
            'candidate': iceCandidate.toMap()
          });
        }
      }
    };
    
    _peer!.onAddStream = (MediaStream stream) {
      onRemoteStream(stream);
      _incallManager!.start();
      _incallManager!.setForceSpeakerphoneOn(
        flag: ForceSpeakerType.FORCE_ON
      );
    };
  }

  callTo(String heroName) async{
    _him = heroName;
    await _createdPeer();
    final RTCSessionDescription offer = await _peer!.createOffer(WebRTCConfig.offerSdpConstraints);
    await _peer!.setLocalDescription(offer);
    emit('request', {"superHeroName": heroName, "offer": offer.toMap()});
  }

  acceptOrDecline(bool accept) async {
    _incallManager!.stopRingtone();
    if(accept) {
      await _createdPeer();
      await _peer!.setRemoteDescription(_incommingOffer!);
      final RTCSessionDescription answer = await _peer!.createAnswer(WebRTCConfig.offerSdpConstraints);
      _peer!.setLocalDescription(answer);

      emit('response', {
        "requestId": _requestId,
        "answer": answer.toMap()
      });
      
    } else {
      emit('response', {'requestId': _requestId, 'answer': null});
      _finishCall();
    }
  }

  finishCurrentCall() {
    _socket?.emit('finish-call');
    _finishCall();
  }

  cancelRequest() {
    _finishCall();
    _socket!.emit('cancel-request');
  }

  changeCamera() {
    _isFrontCamera = !_isFrontCamera;
    _localStream!.getVideoTracks()[0].switchCamera();
  }

  setMicrophoneMute(bool mute) {
    _mute = mute;
    _localStream!.getAudioTracks()[0].setMicrophoneMute(mute);
  }

  _finishCall() {
    if(_isFrontCamera){
      changeCamera();
    }
    if(_mute){
      setMicrophoneMute(false);
    }
    _incallManager?.stop();
    _him = null;
    _peer?.close();
    _peer = null;
    _requestId = null;
  }

  dispose() {
    _incallManager?.stop();
    _socket?.disconnect();
    _localStream?.dispose();
    _socket?.destroy();
    _socket = null;
    _peer?.close();
    _peer?.dispose();
  }
}