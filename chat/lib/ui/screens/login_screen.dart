import 'package:chat/ui/style.dart';
import 'package:chat/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _key = GlobalKey<FormState>();

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Style.darkColor,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Center(
              child: Text(
            'Sign In',
            style: Style.appNameTextStyle,
          )),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: Style.inputDecoration('Email'),
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'input require';
                      } else if (!isEmail(v)) {
                        return 'email invalide';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: Style.inputDecoration('Password'),
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'input require';
                      } else if (v.trim().length < 6) {
                        return 'this password is too short';
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: PrimaryButton(
          onTap: () async {
            if (_key.currentState.validate()) {
              _key.currentState.save();
              print('is validate');
              
            } else
              print('is not validate');
          },
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21),
          ),
        )
      )
    );
  }
}