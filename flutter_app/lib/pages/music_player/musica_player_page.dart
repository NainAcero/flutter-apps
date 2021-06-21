import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/music_player/bloc.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/pages/checkout_page.dart';
import 'package:flutter_app/pages/music_player/current_track_view.dart';
import 'package:flutter_app/pages/music_player/music_controls.dart';
import 'package:flutter_app/pages/music_player/music_progress.dart';
import 'package:flutter_app/widgets/rounded_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

double randomPrice() {
  final Random random = Random();
  return (random.nextInt(100) + 10).toDouble();
}

class MusicPlayerPage extends StatefulWidget {

  final Artist artist;

  const MusicPlayerPage({Key key, @required this.artist}) : 
    assert(artist != null) , super(key: key);

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {

  MusicPlayerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MusicPlayerBloc(widget.artist);
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final price = randomPrice();

    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(15),
          child: RoundedButton(
            label: "BUY PLAYLIST \$ ${price.toStringAsFixed(2)}",
            onPressed: () {
               final MaterialPageRoute route = MaterialPageRoute(
                builder: (_) => CheckOutPage(
                  price: price,
                ),
              );
              Navigator.push(context, route);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            top: false,
            child: Column(
              children: <Widget>[
                CurrentTrackView(),
                MusicControls(),
                MusicPlayerProgress(),
              ]
            )
          )
        )
      )
    );
  }
}