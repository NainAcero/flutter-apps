import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_webrtc/utils/singnaling.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  Signaling _signaling = Signaling();
  String? _me;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    _signaling.init();
    _signaling.onLocalStream = (MediaStream stream){
      _localRenderer.srcObject = stream;
    };

    _signaling.onRemoteStream = (MediaStream stream){
      _remoteRenderer.srcObject = stream;
    };

    _signaling.onJoined = (bool isOk){
      if(isOk){
        setState(() {
          _me = _username;
        });
      }
    };

  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  _inputCall() {
    var username = '';

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: CupertinoTextField(
            placeholder: "call to",
            onChanged: (text) => username = text,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                _signaling.call(username);
                Navigator.pop(context);
              },
              child: Text("CALL")
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: _me == null 
          ? Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoTextField(
                  placeholder: "your username",
                  textAlign: TextAlign.center,
                  onChanged: (text) => _username = text,
                ),
                SizedBox(height: 20,),
                CupertinoButton(
                  child: Text('JOIN'),
                  color: Colors.blue, 
                  onPressed: (){
                    if(_username.trim().length == 0) {
                      return;
                    }
                    
                    _signaling.emit('join', _username);
                  }
                )
              ],
            ),
          )
          : Stack(
          children: [
            Positioned.fill(
              child: RTCVideoView(_remoteRenderer, mirror: true,),
            ),
            Positioned(
              left: 20,
              bottom: 40,
              child: Transform.scale(
                scale: 0.3,
                alignment: Alignment.bottomLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 480,
                    height: 640,
                    color: Colors.black12,
                    child: RTCVideoView(_localRenderer, mirror: true,),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 40,
              child: CupertinoButton(
                color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("CALL"), 
                onPressed: _inputCall
              ),
            )
          ],
        ), 
      ),
    );
  }
}