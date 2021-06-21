import 'package:flutter/material.dart';
import 'package:flutter_delivery/presentation/main_binding.dart';
import 'package:flutter_delivery/presentation/routes/delivery_navigation.dart';
import 'package:flutter_delivery/presentation/splash/splash_screen.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lighTheme,
      initialRoute: DeliveryRoutes.splash,
      getPages: DeliveryPages.pages,
      initialBinding: MainBinding(),
    );
  }
}