import 'package:flutter/material.dart';

import 'batman_buttun.dart';

class BatmanScreenSignUp extends AnimatedWidget {
  BatmanScreenSignUp(Animation animation) : super(listenable: animation);

  Animation get _animationSignupIn => listenable as Animation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Opacity(
        opacity: _animationSignupIn.value,
        child: Transform.translate(
          offset: Offset(0.0, (100 * (1 - _animationSignupIn.value)).toDouble()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'GET ACCESS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 20,),
                _BatmanInput(
                  label: 'FULL NAME',
                ),
                _BatmanInput(
                  label: 'EMAIL ID',
                ),
                _BatmanInput(
                  label: 'PASSWORD',
                  password: true,
                ),
                const SizedBox(height: 20,),
                BatmanButton(
                  onTap: (){}, 
                  text: 'SIGNUP',
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BatmanInput extends StatelessWidget {

  final String label;
  final bool password;

  const _BatmanInput({Key? key,required this.label, this.password = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade800,
        width: 1.0
      )
    );
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            color: Colors.grey[800],
          ),
          enabledBorder: border,
          border: border,
          suffixIcon: password
          ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: UnconstrainedBox(
                child: Image.asset(
                  'assets/batman_logo.png',
                  height: 15,
                ),
              ),
            )
          : null 
        ),
      ),
    );
  }
}