import 'package:chat/ui/screens/login_screen.dart';
import 'package:chat/ui/screens/signup_screen.dart';
import 'package:chat/ui/size_config.dart';
import 'package:chat/ui/style.dart';
import 'package:chat/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static final routeName = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Style.darkColor,
      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: Text(
                    'Flutter Chat',
                    style: Style.appNameTextStyle,
                  )),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PrimaryButton(
                      onTap: () => Navigator.of(context)
                          .pushNamed(LoginScreen.routeName),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    PrimaryButton(
                      onTap: () => Navigator.of(context)
                          .pushNamed(SignUpScreen.routeName),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                  ],
                )),
              ],
            ),
    );
  }
}