import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_webrtc/blocs/app_state.dart';
import 'package:flutter_simple_webrtc/blocs/app_state_bloc.dart';
import 'package:flutter_simple_webrtc/blocs/app_state_events.dart';

class InComming extends StatelessWidget {
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
            SizedBox(height: 10,),
            Text('Llamada Entrante'),
            Text(state.him!.name),
            SizedBox(height: 80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: (){
                    appStateBloc.add(AcceptOrDeclineEvent(true));
                  },
                  child: Icon(Icons.call),
                ),
                SizedBox(width: 80,),
                FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: (){
                    appStateBloc.add(AcceptOrDeclineEvent(false));
                  },
                  child: Icon(Icons.call_end),
                )
              ],
            )
          ],
        );
      },
    );
  }
}