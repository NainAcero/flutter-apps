// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_face_detector/pages/splash_screen.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage(),
    );
  }
}