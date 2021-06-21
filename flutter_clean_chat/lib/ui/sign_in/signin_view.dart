import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/navigator_utils.dart';
import 'package:flutter_clean_chat/ui/home/home_view.dart';
import 'package:flutter_clean_chat/ui/profile_verify/profile_verify_view.dart';
import 'package:flutter_clean_chat/ui/sign_in/sign_in_cubit.dart';
import 'package:flutter_clean_chat/ui/splash/initial_background_view.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(context.read()),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, snapshot) {
          if(snapshot == SignInState.none) {
            pushAndReplaceToPage(context, ProfileVerifyView());
          }else {
            pushAndReplaceToPage(context, HomeView());
          }
        },
        builder: (context, snapshot){
          return Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            body: Stack(
              children: [
                InitialBackgroundView(),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 150,),
                      Hero(
                        tag: 'logo_hero',
                        child: Image.asset(
                          'assets/messenger.png',
                          height: 50,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Text('Welcome to\n FluChat',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 40.0),
                        child: Text('A platform ti chat with users very easily and friendly',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                          ),
                        ),
                      ),
                      Material(
                        elevation: 2,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                        child: InkWell(
                          onTap: (){
                            context.read<SignInCubit>().signIn();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/google.png', height: 24,),
                                const SizedBox(width: 15,),
                                Text('Login with Google')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '"in the modern world the\nquality of life is the quality\nnof comunication',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }
}