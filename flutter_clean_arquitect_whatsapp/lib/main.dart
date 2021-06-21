// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/comunication/comunication_cubit.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/get_device_number/get_device_numbers_cubit.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/user/user_cubit.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/user/user_state.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/screens/home_screen.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/screens/welcome_screen.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/widgets/theme/style.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (_) => di.sl<PhoneAuthCubit>()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()..getAllUsers()),
        BlocProvider<GetDeviceNumbersCubit>(create: (_) => di.sl<GetDeviceNumbersCubit>(),),
        BlocProvider<CommunicationCubit>(create: (_) => di.sl<CommunicationCubit>(),),
        BlocProvider<MyChatCubit>(create: (_) => di.sl<MyChatCubit>(),)
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter WhatsApp Clone',
        theme: ThemeData(primaryColor: primaryColor),
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return BlocBuilder<UserCubit, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        final currentUserInfo = userState.users.firstWhere(
                          (user) => user.uid == authState.uid,
                        );
                        return HomeScreen(
                          userInfo: currentUserInfo,
                        );
                      }
                      return Container();
                    }
                  );
                }
                if (authState is UnAuthenticated) {
                  return WelcomeScreen();
                }
                return Container();
              }
            );
          }
        },

      )
    );

  }
}