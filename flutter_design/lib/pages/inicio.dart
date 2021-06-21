
import 'package:flutter/material.dart';
import 'package:flutter_design/pages/commerce/details/ecommers_detail_page.dart';
import 'package:flutter_design/pages/commerce/home/ecommers_page.dart';
import 'package:flutter_design/pages/covid/covid_page.dart';
import 'package:flutter_design/pages/covid_2/covid2_page.dart';
import 'package:flutter_design/pages/ebook/ebook_page.dart';
import 'package:flutter_design/pages/food/food_page.dart';
import 'package:flutter_design/pages/plant/plant_page.dart';
import 'package:flutter_design/pages/travel/travel_page.dart';
import 'package:flutter_design/pages/travel_2/travel2_page.dart';
import 'package:flutter_design/pages/ubereats/ubereats.dart';
import 'package:flutter_design/pages/zoom/zoom_page.dart';
import 'package:flutter_design/widgets/button.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fluuter Design'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Button(
              title: 'Design Travelv1',
              onPressed: (){
                Navigator.pushNamed(context, TravelPage.routeName);
              },
            ),

            Button(
              title: 'Design Travel_v2',
              onPressed: (){
                Navigator.pushNamed(context, Travel2_Page.routeName);
              },
            ),

            Button(
              title: 'Design Covid19',
              onPressed: (){
                Navigator.pushNamed(context, CovidPage.routeName);
              },
            ),

            Button(
              title: 'Design Covid19_v2',
              onPressed: (){
                Navigator.pushNamed(context, Covid2Page.routeName);
              },
            ),

            Button(
              title: 'Design Food Delivery',
              onPressed: (){
                Navigator.pushNamed(context, FoodPage.routeName);
              },
            ),

            Button(
              title: 'Design Zoom App',
              onPressed: (){
                Navigator.pushNamed(context, ZoomPage.routeName);
              },
            ),

            Button(
              title: 'Design Plant App',
              onPressed: (){
                Navigator.pushNamed(context, PlantPage.routeName);
              },
            ),

            Button(
              title: 'Design Ubereats App',
              onPressed: (){
                Navigator.pushNamed(context, UbereatsPage.routeName);
              },
            ),

            Button(
              title: 'Design Ecommers App',
              onPressed: (){
                Navigator.pushNamed(context, EcommersPage.routeName);
              },
            ),

            Button(
              title: 'Design EBook App',
              onPressed: (){
                Navigator.pushNamed(context, EBookPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}