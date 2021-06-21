import 'package:flutter/material.dart';
import 'package:flutter_design/pages/commerce/details/components/cart_counter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CounterWithFavBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Color(0xFFFF6464),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset("assets/commerce/heart.svg"),
        )
      ],
    );
  }
}