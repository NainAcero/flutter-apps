import 'package:flutter/material.dart';
import 'package:flutter_example02/widgets/wave_header.dart';

class WavePage extends StatefulWidget {
  @override
  _WavePageState createState() => _WavePageState();
}

class _WavePageState extends State<WavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            WaveHeader()
          ],
        )
      )
    );
  }
}