// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_detector_mask/pages/splash_screen_page.dart';
import 'package:camera/camera.dart';

List<CameraDescription> camera;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  camera = await availableCameras();
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