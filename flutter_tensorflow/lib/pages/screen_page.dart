import 'package:flutter/material.dart';
import 'package:flutter_tensorflow/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new HomePage(),
      title: Text(
        'Detector de Mascarilla',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black
        ),
      ),
      image: Image.asset('assets/coronavirus.gif'),
      photoSize: 170,
      backgroundColor: Colors.white,
      loaderColor: Colors.amber,
      loadingText: Text(
        'Nain Acero',
        style: TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}