import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/libs/auth.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/login/widgets/circle_button.dart';
import 'package:flutter_app/pages/login/widgets/input_text_login.dart';
import 'package:flutter_app/utils/dialogs.dart';
import 'package:flutter_app/utils/extras.dart';
import 'package:flutter_app/utils/responsive.dart';
import 'package:flutter_app/widgets/rounded_button.dart';

class LoginForm extends StatefulWidget {
  final Alignment alignment;
  final VoidCallback onGoToResgister, onGoToForgotPassword;

  const LoginForm({
    Key key, 
    @required this.onGoToResgister, 
    @required this.onGoToForgotPassword, 
    this.alignment = Alignment.bottomCenter
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<InputTextLoginState> _emailKey = GlobalKey();
  final GlobalKey<InputTextLoginState> _passwordKey = GlobalKey();

  void _goTo(User user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print("login failed");
    }
  }

  Future<void> _submit() async {
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;

    final bool emailOk = _emailKey.currentState.isOk;
    final bool passwordOk = _passwordKey.currentState.isOk;

    if (emailOk && passwordOk) {
      final User user = await Auth.instance
          .loginByPassword(context, email: email, password: password);

      _goTo(user);
    }else {
      Dialogs.alert(context, description: "Some fields are invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Align(
      alignment: widget.alignment,
      child: SafeArea(
        top: false,
          child: Container(
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextLogin(
                key: _emailKey,
                iconPath: 'assets/pages/login/icons/email.svg', 
                placeholder: 'Email Address',
                validator: (text) => Extras.isValidEmail(text),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: responsive.ip(2)),
              InputTextLogin(
                key: _passwordKey,
                obscureText: true,
                iconPath: 'assets/pages/login/icons/password.svg', 
                placeholder: 'Password',
                validator: (text) {
                  return text.trim().length >= 6;
                },
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Forgot password",
                    style: TextStyle(
                      fontFamily: 'sans'
                    ),
                  ), 
                  onPressed: widget.onGoToForgotPassword,
                ),
              ),
              SizedBox(height: responsive.ip(2)),
              RoundedButton(
                onPressed: _submit, 
                label: "Sign In"
              ),
              SizedBox(height: responsive.ip(3.3)),
              Text("Or continue with"),
              SizedBox(height: responsive.ip(1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    size: 55,
                    iconPath: 'assets/pages/login/icons/facebook.svg',
                    backgroundColor: Color(0xff448AFF),
                    onPressed: () async{
                      final user = await Auth.instance.facebook(context);
                      _goTo(user);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleButton(
                    iconPath: 'assets/pages/login/icons/google.svg',
                    backgroundColor: Color(0xffFF1744),
                    size: 55,
                    onPressed: () async{
                      final user = await Auth.instance.google(context);
                      _goTo(user);
                    },
                  )
                ],
              ),
              SizedBox(
                height: responsive.ip(2.7)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?"),
                  CupertinoButton(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: 'sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: widget.onGoToResgister,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}