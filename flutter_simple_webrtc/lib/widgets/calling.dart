
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_webrtc/blocs/app_state.dart';
import 'package:flutter_simple_webrtc/blocs/app_state_bloc.dart';
import 'package:flutter_simple_webrtc/blocs/app_state_events.dart';

class Calling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStateBloc =  BlocProvider.of<AppStateBloc>(context);
    
    return BlocBuilder<AppStateBloc, AppState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                state.him!.avatar,
                width: 100,
              ),
            ),
            Text("calling"),
            SizedBox(height: 20,),
            FloatingActionButton(
              onPressed: (){
                appStateBloc.add(CancelRequestEvent());
              },
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.call_end),
            )
          ],
        );
      },
    );
  }
}