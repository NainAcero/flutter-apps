// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/app_theme_cubit.dart';
import 'package:flutter_clean_chat/dependencies.dart';
import 'package:flutter_clean_chat/ui/splash/splash_view.dart';
import 'package:flutter_clean_chat/ui/themes.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _streamChatClient = StreamChatClient('sf33qpvhuw4j');

  // void _fakeUser() async{
  //   await _streamChatClient.disconnect();
  //   _streamChatClient.connectUser(User(id: 'nain'), _streamChatClient.devToken('nain'));
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // _fakeUser();
    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: BlocProvider(
        create: (context) => AppThemeCubit(context.read())..init(),
        child: BlocBuilder<AppThemeCubit, bool>(
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'Flutter',
              debugShowCheckedModeBanner: false,
              home: SplashView(),
              theme: snapshot ? Themes.themeDark : Themes.themeLight,
              builder: (context, child) {
                return StreamChat(child: child, client: _streamChatClient,);
              },
            );
          }
        ),
      ),
    );
  }
}