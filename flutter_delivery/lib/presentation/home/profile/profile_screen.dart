
import 'package:flutter/material.dart';
import 'package:flutter_delivery/data/datasource/local_storage_impl.dart';
import 'package:flutter_delivery/presentation/home/home_controller.dart';
import 'package:flutter_delivery/presentation/routes/delivery_navigation.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {

  final controller = Get.find<HomeController>();

  Future<void> _logout() async{
    await controller.logOut();
    Get.offAllNamed(DeliveryRoutes.splash);
  }

  void onThemeUpdated(bool isDark) {
    controller.updateTheme(isDark);
    Get.changeTheme(isDark ? darkTheme : lighTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final user = controller.user.value;

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: user.image != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: DeliveryColors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage(user.image!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(user.name, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor
                    ),),

                  ],
                )
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20,),
                              Text(
                                user.username,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor
                                ),
                              ),
                              Row(
                                children: [
                                  Text('Dark Mode'),
                                  Spacer(),
                                  Obx(
                                    () => Switch(
                                      value: controller.darkTheme.value, 
                                      onChanged: onThemeUpdated,
                                      activeColor: DeliveryColors.purple,
                                    )
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: DeliveryColors.purple,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              color: DeliveryColors.white
                            ),
                          ),
                        ),
                        onPressed: _logout, 
                      ),
                    )
                  ],
                )
              )
            ],
          )
          : const SizedBox.shrink()
        );
      }
    );
  }
}