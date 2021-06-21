import 'package:flutter/material.dart';
import 'package:flutter_coffe/pages/coffe_bloc.dart';
import 'package:flutter_coffe/pages/coffee_concept_home.dart';
import 'package:flutter_coffe/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bloc = CoffeeBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CoffeeProvider(
        bloc: bloc,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CoffeeConcepHome(),
        )
      )
    );
  }
}