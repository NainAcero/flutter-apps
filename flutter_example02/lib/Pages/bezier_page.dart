import 'package:flutter/material.dart';
import 'package:flutter_example02/widgets/movie_header.dart';

class BazierPage extends StatefulWidget {
  @override
  _BazierPageState createState() => _BazierPageState();
}

class _BazierPageState extends State<BazierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            MovieHeader(),
          ]
        )
      )
    );
  }
}