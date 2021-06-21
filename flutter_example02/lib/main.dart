import 'package:flutter/material.dart';
import 'package:flutter_example02/Pages/PersistentHeaderPage.dart';
import 'package:flutter_example02/Pages/arc_to_page.dart';
import 'package:flutter_example02/Pages/basic_page.dart';
import 'package:flutter_example02/Pages/bezier_page.dart';
import 'package:flutter_example02/Pages/cubic_to_page.dart';
import 'package:flutter_example02/Pages/home_page.dart';
import 'package:flutter_example02/Pages/sliver_appbar_page.dart';
import 'package:flutter_example02/Pages/wave_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CubicPage(),
    );
  }
}