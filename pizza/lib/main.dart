
import 'package:flutter/material.dart';
import 'package:pizza/pages/pizza.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: Pizza(),
      );
  }

}
