// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_maps/pages/home_page.dart';
import 'package:flutter_maps/pages/request_permission_page.dart';
import 'package:flutter_maps/pages/splash_page.dart';

void main() {
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
      home: SplashPage(),
      routes: {
        HomePage.routeName: (_) => HomePage(),
        RequestPermissionPage.routeName: (_) => RequestPermissionPage(),
      },
    );
  }
}