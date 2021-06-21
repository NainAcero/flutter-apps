import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/libs/auth.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  static final routeName = 'splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin{

  @override
  void afterFirstLayout(BuildContext context) {
    // este metodo para utilizar el contexto a diferencia del init 
    final user = Auth.instance.user;
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}