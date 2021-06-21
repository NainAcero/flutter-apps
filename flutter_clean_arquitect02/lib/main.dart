// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_provider/notifiers/home_notifier.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_state_notifier/state/home_state_notifier.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/main_page.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'layers/domain/usecases/get_all_characters.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_state_notifier/state/home_state.dart' as stateNotifier;

void main() async {
  // Plug in stetho
  if (kDebugMode) Stetho.initialize();

  // Initialize the injection container
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeNotifier>(
          create: (_) => di.sl<HomeNotifier>(),
        ),
        StateNotifierProvider<HomeStateNotifier, stateNotifier.HomeState>(
          create: (_) => HomeStateNotifier(getAllCharacters: di.sl<GetAllCharacters>()),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainPage()),
    );
  }
}
