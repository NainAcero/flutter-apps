import 'package:flutter/material.dart';
import 'package:flutter_detector_mask/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomePage(),
      title: Text(
        "Detector de Mascarilla",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black
        ),
      ),
      image: Image.asset("assets/nain.jpg"),
      photoSize: 170,
      backgroundColor: Colors.white,
      loaderColor: Colors.amber,
      loadingText: Text(
        "by Nain Acero",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}