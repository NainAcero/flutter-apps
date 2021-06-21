import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/db/app_theme.dart';
import 'package:flutter_app/db/db.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/login/login_page.dart';
import 'package:flutter_app/pages/splash/splash_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await MyAppTheme.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
       future: _initialization,
       builder: (context, snapshot) {

        if (snapshot.hasError) {
            return Center(child: Text("Firebase error"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return OverlaySupport(
            child: ChangeNotifierProvider.value(
              value: MyAppTheme.instance,
              child: Consumer<MyAppTheme>(
                builder: (_, __, ___) {
                  return MaterialApp(
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    theme: MyAppTheme.instance.theme,
                    home: SplashPage(),
                    routes: {
                      HomePage.routeName: (_) => HomePage(),
                      SplashPage.routeName: (_) => SplashPage(),
                      LoginPage.routeName: (_) => LoginPage(),
                    },
                  );
                }
              )
            )
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );

       }
     );
  }
}
