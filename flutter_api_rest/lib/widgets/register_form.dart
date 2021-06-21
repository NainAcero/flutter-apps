import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username;
  Logger _logger = Logger();

  Future<void> _submit() async{
    final isOk = _formKey.currentState.validate();
    if(isOk){
      ProgressDialog.show(context);
      final authenticationAPI = GetIt.instance<AuthenticationAPI>();
      final response = await authenticationAPI.register(
        username: _username,
        email: _email,
        password: _password,
      );
      ProgressDialog.dismiss(context);
      if(response.data != null){
        _logger.i("register ok");
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false);
      } else {
        _logger.e("register error status code ${response.error.statusCode}");
        _logger.e("register error message ${response.error.message}");
        _logger.e("register error data ${response.error.data}");
        String message = response.error.message;
        if (response.error.statusCode == -1){
          message = "Bad network";
        } else if(response.error.statusCode == 409){
          message = "Duplicated user ${jsonEncode(response.error.data['duplicatedFields'])}";
        }

        Dialogs.alert(
          context, 
          title: "ERROR", 
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : responsive.wp(90),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                label: "USERNAME",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 2),
                onChange: (text) {
                  _username = text;
                },
                validator: (text) {
                  if(text.trim().length < 5){
                    return "Invalid username";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 2),
                onChange: (text) {
                  _email = text;
                },
                validator: (text) {
                  if(!text.contains("@")){
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                label: "PASSWORD",
                obscureText: true,
                borderEnabled: false,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 2),
                onChange: (text) {
                  _password = text;
                },
                validator: (text) {
                  if(text.trim().length < 6){
                    return "Invalid password";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(2)
                      ),
                  ),
                  onPressed: this._submit,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: responsive.dp(2))
                  ),
                  FlatButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.pinkAccent, fontSize: responsive.dp(2))
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              SizedBox(height: responsive.dp(3))
            ],
          ),
        ),
      ),
    );
  }
}