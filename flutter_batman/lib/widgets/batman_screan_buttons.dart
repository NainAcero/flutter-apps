import 'package:flutter/material.dart';

import 'batman_buttun.dart';

class BatmanScreenButtons extends AnimatedWidget {
  BatmanScreenButtons(Animation animation,  this.onTap) : super(listenable: animation);

  Animation get _animationButtonIn => listenable as Animation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Opacity(
        opacity: _animationButtonIn.value,
        child: Transform.translate(
          offset: Offset(0.0, (100 * (1 - _animationButtonIn.value)).toDouble()),
          child: Column(
            children: [
              BatmanButton(
                onTap: (){}, 
                text: 'LOGIN',
                left: false,
              ),
              SizedBox(height: 15,),
              BatmanButton(
                onTap: onTap, 
                text: 'SIGNUP',
              ),
            ],
          ),
        ),
      ),
    );
  }
}