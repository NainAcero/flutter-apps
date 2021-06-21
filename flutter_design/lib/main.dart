// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_design/pages/commerce/details/ecommers_detail_page.dart';
import 'package:flutter_design/pages/commerce/home/ecommers_page.dart';
import 'package:flutter_design/pages/covid/covid_page.dart';
import 'package:flutter_design/pages/covid_2/covid2_page.dart';
import 'package:flutter_design/pages/covid_2/detail_page.dart';
import 'package:flutter_design/pages/ebook/ebook_page.dart';
import 'package:flutter_design/pages/food/food_page.dart';
import 'package:flutter_design/pages/inicio.dart';
import 'package:flutter_design/pages/plant/details_screen.dart';
import 'package:flutter_design/pages/plant/plant_page.dart';
import 'package:flutter_design/pages/travel/travel_page.dart';
import 'package:flutter_design/pages/travel_2/travel2_page.dart';
import 'package:flutter_design/pages/ubereats/ubereats.dart';
import 'package:flutter_design/pages/zoom/participants_page.dart';
import 'package:flutter_design/pages/zoom/root_app.dart';
import 'package:flutter_design/pages/zoom/zoom_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Inicio(),
      routes: {
        TravelPage.routeName: (_) => TravelPage(),
        Travel2_Page.routeName: (_) => Travel2_Page(),
        CovidPage.routeName: (_) => CovidPage(),
        Covid2Page.routeName: (_) => Covid2Page(),
        DetailPage.routeName: (_) => DetailPage(),
        FoodPage.routeName: (_) => FoodPage(),
        ZoomPage.routeName: (_) => ZoomPage(),
        RootApp.routeName: (_) => RootApp(),
        ParticipantsPage.routeName: (_) => ParticipantsPage(),
        PlantPage.routeName: (_) => PlantPage(),
        DetailsScreen.routeName: (_) => DetailsScreen(),
        UbereatsPage.routeName: (_) => UbereatsPage(),
        EcommersPage.routeName: (_) => EcommersPage(),
        EcommersDetail.routeName: (_) => EcommersDetail(),
        EBookPage.routeName: (_) => EBookPage(),
      },
    );
  }
}
