import 'package:flutter/material.dart';
import 'package:flutter_batman/widgets/batman_buttun.dart';
import 'package:flutter_batman/widgets/batman_city.dart';
import 'package:flutter_batman/widgets/batman_screan_buttons.dart';
import 'package:flutter_batman/widgets/batman_screen_sigup.dart';
import 'package:flutter_batman/widgets/batman_screen_title.dart';
import 'package:google_fonts/google_fonts.dart';

const _batmanVerticalMovement = 60.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animationLogoIn;
  late Animation<double> _animationLogoMovementUp;
  late Animation<double> _animationBatmanIn;
  late Animation<double> _animationButtonIn;
  
  late AnimationController _animationControllerSignOut;
  late Animation<double> _animationLogoOut;
  late Animation<double> _animationBatmanUp;
  late Animation<double> _animationBatmanCity;
  late Animation<double> _animationSignupIn;

  void _firstAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animationLogoIn = Tween(
      begin: 30.0,
      end: 1.0
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Interval(0.0, 0.25)
    ));
    
    _animationLogoMovementUp = CurvedAnimation(
      parent: _animationController, 
      curve: Interval(0.35, 0.60)
    );

    _animationBatmanIn = Tween(
      begin: 5.0,
      end: 1.0
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Interval(0.7, 1.0, curve: Curves.decelerate),
    ));

    _animationButtonIn = CurvedAnimation(
      parent: _animationController, 
      curve: Interval(0.7, 1.0)
    );

    _animationController.forward();
  }

  void _secondAnimation() {
    _animationControllerSignOut = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6)
    );

    _animationLogoOut = CurvedAnimation(
      parent: _animationControllerSignOut, 
      curve: Interval(0.0, 0.20)
    );

    _animationBatmanUp = CurvedAnimation(
      parent: _animationControllerSignOut, 
      curve: Interval(0.35, 0.55)
    );

    _animationBatmanCity = CurvedAnimation(
      parent: _animationControllerSignOut, 
      curve: Interval(0.65, 0.80)
    );

    _animationSignupIn = CurvedAnimation(
      parent: _animationControllerSignOut, 
      curve: Interval(0.85, 1.00, curve: Curves.easeIn),
    );
    
  }

  void _onSignUp() {
    _animationControllerSignOut.forward(from: 0.0);
  }

  @override
  void initState() {
    _firstAnimation();
    _secondAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerSignOut.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Theme(
      data: ThemeData.light().copyWith(
        textTheme: GoogleFonts.vidalokaTextTheme()
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _animationController,
          _animationControllerSignOut
        ]),
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Color(0xFF100F0B),
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/batman_background.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(0.0, _batmanVerticalMovement * _animationLogoOut.value + -_animationBatmanUp.value * _batmanVerticalMovement),
                    child: Transform.scale(
                      scale: _animationBatmanIn.value,
                      child: Image.asset(
                        'assets/batman_alone.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: size.height / 3.8,
                  left: 40,
                  right: 40,
                  child: BatmanCity(_animationBatmanCity)
                ),

                Positioned(
                  top: size.height / 1.8,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BatmanScreenSignUp(_animationSignupIn)
                ),

                Positioned(
                  top: size.height / 2,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0.0, _batmanVerticalMovement * _animationLogoOut.value),
                        child: Opacity(
                          opacity: (1 - _animationLogoOut.value),
                          child: BatmanScreenTitle(_animationLogoMovementUp)
                        ),
                      ),
                      SizedBox(height: 35,),
                      Transform.translate(
                        offset: Offset(0.0, _batmanVerticalMovement * _animationLogoOut.value),
                        child: Opacity(
                          opacity: (1 - _animationLogoOut.value),
                          child: BatmanScreenButtons(_animationButtonIn, _onSignUp)
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: size.height / 2.2 - 65 * _animationLogoMovementUp.value,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: (1 - _animationLogoOut.value),
                    child: Transform.scale(
                      scale: _animationLogoIn.value,
                      child: Image.asset(
                        'assets/batman_logo.png',
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}