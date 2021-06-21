import 'package:flutter/material.dart';
import 'package:flutter_face_detector/pages/home_page.dart';
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
        "\n DETECCION DE ROSTROS",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
      image: Image.asset("assets/nain.jpg"),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        'Nain Acero',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16
        ),
      ),
    );
  }
}