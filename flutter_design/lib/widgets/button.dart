import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;

  const Button({Key? key,required this.title,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(vertical: 6,),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Center(child: 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              this.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}