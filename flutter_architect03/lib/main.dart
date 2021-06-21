import 'package:flutter/material.dart';
import 'package:flutter_architect03/dependencies_provider.dart' as di;
import 'package:flutter_architect03/src/presentation/app.dart';


void main() {
  di.init();
  runApp(App());
}