// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:clean_arquitect01/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Architecture TDD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NumberTrivial()
    );
  }
}
