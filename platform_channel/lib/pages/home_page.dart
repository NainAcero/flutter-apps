import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_channel/controllers/home_controller.dart';
import 'package:platform_channel/native/geolaction.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(Geolocation.instance.location.value),
              ),
              FlatButton(
                onPressed: () {
                  if (_.traking) {
                    _.stopTracking();
                  } else {
                    _.startTracking();
                  }
                },
                child: GetBuilder<HomeController>(
                  id: 'tracking',
                  builder: (_) =>
                      Text("${_.traking ? "STOP" : "START"} TRACKING"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}