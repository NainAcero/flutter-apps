import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {

  EdgeInsetsGeometry padding;
  IconData icon;
  VoidCallback onTap;

  IconWidget({Key? key, 
    required this.padding,
    required this.icon,
    required this.onTap
  }) : super(key: key );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: Icon(icon),
      ),
    );
  }
}