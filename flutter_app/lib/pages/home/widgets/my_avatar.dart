import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/libs/auth.dart';

class MyAvatar extends StatelessWidget {
  final VoidCallback  onPressed;

  MyAvatar({Key key, @required this.onPressed}) : super(key: key);

  final user = Auth.instance.user;

  @override
  Widget build(BuildContext context) {

    Widget _getAlias(String displayName) {
      final List<String> tmp = displayName.split(" ");

      String alias = "";
      if (tmp.length > 0) {
        alias = tmp[0][0];
        if (tmp.length == 2) {
          alias += tmp[1][0];
        }
      }

      return Center(
        child: Text(
          alias,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xfff50057),
        child: user.photoURL != null
          ? ClipOval(
              child: Image.network(
                user.photoURL,
                width: 58,
                height: 58,
                fit: BoxFit.contain,
              ),
            )
          : _getAlias(user.displayName),
      ),
    );
  }
}