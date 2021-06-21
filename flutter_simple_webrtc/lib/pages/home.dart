import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_webrtc/blocs/bloc.dart';
import 'package:flutter_simple_webrtc/widgets/calling.dart';
import 'package:flutter_simple_webrtc/widgets/connected.dart';
import 'package:flutter_simple_webrtc/widgets/in_calling.dart';
import 'package:flutter_simple_webrtc/widgets/incomming.dart';
import 'package:flutter_simple_webrtc/widgets/show_picker.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    final appStateBloc =  BlocProvider.of<AppStateBloc>(context);
    
    return Scaffold(
      body: Center(
        child: BlocBuilder<AppStateBloc, AppState>(
          builder: (BuildContext context, AppState state) {

            switch (state.status) {
              case Status.loading :
                return CupertinoActivityIndicator(radius: 15,);
              case Status.showPicker : 
                return ShowPicker();
              case Status.connected :
                return Connected();
              case Status.calling:
                return Calling();
              case Status.inCalling:
                return InCalling();
              case Status.inComming:
                return InComming();
              default: 
                return Container();
            }
          },
        ),
      ),
    );
  }
}