
import 'package:flutter/material.dart';
import 'package:flutter_design/utils/travel_2/colors.dart';

class PrimaryText extends StatelessWidget {
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final String text;

  const PrimaryText({
    Key? key, this.color =AppColor.primaryColor, this.size = 16, this.fontWeight = FontWeight.w600, this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),);
  }
}