
import 'package:flutter/material.dart';

class InitialBackgroundView extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: -45,
          child: Image.asset(
            'assets/bottom-right.png',
            height: 200,
          ),
        )
      ],
    );
  }
}