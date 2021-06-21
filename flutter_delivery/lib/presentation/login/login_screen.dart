
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_delivery/presentation/home/home_screen.dart';
import 'package:flutter_delivery/presentation/login/login_controller.dart';
import 'package:flutter_delivery/presentation/routes/delivery_navigation.dart';
import 'package:flutter_delivery/presentation/theme.dart.dart';
import 'package:flutter_delivery/presentation/widgets/delivery_button.dart';
import 'package:get/get.dart';

const logoSize = 45.0;

class LoginScreen extends GetWidget<LoginController>{

  void login() async {
    final result = await controller.login();
    if(result) {
      Get.offAllNamed(DeliveryRoutes.home);
    }else {
      Get.snackbar('Error', 'Login incorrect');
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final moreSize = 50.0;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: logoSize,
                      left: -moreSize/2,
                      right: -moreSize/2,
                      height: width + moreSize,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.5,
                              1.0
                            ],
                            colors: deliveryGradients,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(200)
                          )
                        ),
                      ), 
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).canvasColor,
                        radius: logoSize,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset("assets/developer.png", 
                          color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ),

              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 30,),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4,),
                        Text(
                          'Username',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
                          ),
                        ),
                        TextField(
                          controller: controller.usernameTextController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            hintText: 'username'
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Password',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          controller: controller.passwordTextController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            hintText: '********'
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),

              Padding(
                padding: const EdgeInsets.all(25),
                child: DeliveryButton(
                  onTap: login,
                  text: 'Login',
                )
              )
            ],
          ),
          Positioned(
            child: Obx(() {
              if(controller.loginState.value == LoginState.loading) {
                return Container(
                  color: Colors.black38,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }else {
                return const SizedBox.shrink();
              }
            }),
          )
        ],
      )
    );
  }
}