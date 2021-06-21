import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/navigator_utils.dart';
import 'package:flutter_clean_chat/ui/home/home_view.dart';
import 'package:flutter_clean_chat/ui/profile_verify/profile_verify_view.dart';
import 'package:flutter_clean_chat/ui/sign_in/signin_view.dart';
import 'package:flutter_clean_chat/ui/splash/initial_background_view.dart';
import 'package:flutter_clean_chat/ui/splash/splash_cubit.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context.read())..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if(snapshot == SplashState.none) {
            pushAndReplaceToPage(context, SignInView());
          }else if(snapshot == SplashState.existing_user) {
            pushAndReplaceToPage(context, HomeView());
          }else {
            pushAndReplaceToPage(context, ProfileVerifyView());
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              InitialBackgroundView(),
              Center(
                child: Hero(
                  tag: 'logo_hero',
                  child: Image.asset(
                    'assets/messenger.png',
                    height: 100,
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
