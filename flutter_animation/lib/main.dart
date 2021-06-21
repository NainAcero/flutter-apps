import 'package:flutter/material.dart';
import 'package:flutter_animation/pages/animated_widget.dart';
import 'package:flutter_animation/pages/circular_menu.dart';
import 'package:flutter_animation/pages/rotate_animation.dart';
import 'package:flutter_animation/pages/scale_animation.dart';
import 'package:flutter_animation/pages/translate_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CircularMenuPage(),
    );
  }
}
