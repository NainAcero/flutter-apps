
import 'package:flutter/material.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';

class DeliveryButton extends StatelessWidget {

  final VoidCallback onTap;
  final String text;
  final EdgeInsets padding;

  const DeliveryButton({Key? key, 
    required this.onTap, 
    required this.text, 
    this.padding = const EdgeInsets.all(14.0)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: deliveryGradients,
          ),
        ),
        child: Padding(
          padding: padding,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}