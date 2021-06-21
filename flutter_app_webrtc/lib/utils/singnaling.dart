
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

typedef OnLocalStream(MediaStream stream);
typedef OnRemoteStream(MediaStream stream);
typedef OnJoined(bool isOk);

class Signaling {
  IO.Socket? _socket;
  late OnLocalStream onLocalStream;
  late OnRemoteStream onRemoteStream;
  late OnJoined onJoined;
  late RTCPeerConnection _peer;

  String? _him;

  MediaStream? _localStream;

  init() async{
    MediaStream stream = await MediaDevices.getUserMedia({
      "audio": true,
      "video": {
        "mandatory": {
          "minWidth": '480',
          "minHeight": '640',
          "minFrameRate": '30',
        },
        "facingMode": "user",
        "optional": [],
      }
    });

    _localStream = stream;
    onLocalStream(stream);

    _connect();
  }

  _createPeer() async {
    this._peer = await createPeerConnection({
      "iceServers": [
        {
          "urls": [
            "stun:stun1.l.google.com:19302",
          ]
        },
      ]
    }, {});

    await _peer.addStream(_localStream!);

    _peer.onIceCandidate = (RTCIceCandidate? candidate) {
      if(candidate == null) return ;

      // send the iceCandidate
      emit('candidate', {"username": _him, "cantidate": candidate.toMap()});
    };

    _peer.onAddStream = (MediaStream remoteStream) {
      onRemoteStream(remoteStream);
    };
  }

  _connect(){
    _socket = IO.io('https://app-flutter-webrtc.herokuapp.com', <String, dynamic>{
      'transports': ['websocket'],
    });

    _socket!.on('on-join', (isOk) {
      print("on-join $isOk");
      onJoined(isOk);
    });

    _socket!.on('on-call', (data) async{
      print("on-call $data");
      await _createPeer();
      final String username = data['username'];
      _him = username;
      final offer = data['offer'];

      final RTCSessionDescription desc = RTCSessionDescription(offer["sdp"], offer["type"]);

      _peer.setRemoteDescription(desc);

      final sdpConstraints = {
        "mandatory": {
          "OfferToReceiveAudio": true,
          "OfferToReceiveVideo": true,
        },
        "optional": [],
      };

      final RTCSessionDescription answer = await _peer.createOffer(sdpConstraints);
      await _peer.setLocalDescription(answer);

      emit('answer', {"username": _him, "answer": answer.toMap()});
    });

    _socket!.on('on-answer', (answer) {
      print("on-answer $answer");
      final RTCSessionDescription desc = RTCSessionDescription(answer["sdp"], answer["type"]);
      _peer.setRemoteDescription(desc);
    });

    _socket!.on('on-candidate', (data) async {
      print("on-candidate $data");
      RTCIceCandidate candidate = new RTCIceCandidate(
          data['candidate'], data['sdpMid'], data['sdpMLineIndex']);
      await _peer.addCandidate(candidate);
    });
  }

  emit(String eventName, dynamic data) {
    _socket?.emit(eventName, data);
  }

  call(String username) async {
    _him = username;
    await _createPeer();
    final sdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };
    final RTCSessionDescription offer = await _peer.createOffer(sdpConstraints);
    _peer.setLocalDescription(offer);

    emit('call', {"username": username, "offer": offer.toMap()});
  }

  dispose() {
    _socket?.disconnect();
  }
}