import 'package:flutter/material.dart';
import 'package:flutter_delivery/presentation/splash/splash_controller.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:get/get.dart';

class SplashScreen extends GetWidget<SplashController> {
  final splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: deliveryGradients
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: DeliveryColors.white,
              radius: 50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/delivery.png',
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              "DeliveryApp",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
                color: DeliveryColors.white
              ),
            )
          ],
        ),
      )
    );
  }
}