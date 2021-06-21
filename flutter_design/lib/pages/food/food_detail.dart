
import 'package:flutter/material.dart';
import 'package:flutter_design/models/food/food.dart';
import 'package:flutter_design/models/food/ingredient.dart';
import 'package:flutter_design/pages/food/style.dart';
import 'package:flutter_design/utils/food/colors.dart';
import 'package:flutter_design/utils/food/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodDetail extends StatelessWidget {

  final Food food;

  const FoodDetail({Key? key,required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size.width - 30, minHeight: 56
        ),
        child: ElevatedButton(
          onPressed: (){},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryText(text: 'Place an order', fontWeight: FontWeight.w700, size: 18,),
              Icon(Icons.chevron_right, color: AppColors.secondary,)
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
        ),
      ),
      body: ListView(
        children: [
          CustomAppBar(),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(text: food.name, size: 40, fontWeight: FontWeight.w600,),
                SizedBox(height: 24,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/food/dollar.svg',
                      color: AppColors.tertiary, width: 15,),
                    PrimaryText(
                      text: '5.99',
                      size: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.tertiary,
                      height: 1,
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText(
                            text: 'Size',
                            size: 18,
                            color: AppColors.lightGray,
                            fontWeight: FontWeight.w500,
                          ),
                          PrimaryText(
                            text: 'Medium 14"',
                            size: 20,
                            fontWeight: FontWeight.w600,
                          ),
                           SizedBox(
                              height: 20,
                            ),
                            PrimaryText(
                              text: 'Crust',
                              color: AppColors.lightGray,
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PrimaryText(
                                text: 'Thin Crust',
                                fontWeight: FontWeight.w600),
                            SizedBox(
                              height: 20,
                            ),
                            PrimaryText(
                              text: 'Delivery in',
                              color: AppColors.lightGray,
                              size: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PrimaryText(
                                text: '30 min', fontWeight: FontWeight.w600),
                        ],
                      ),
                      Container(
                        height: 200,
                        width: size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightGray, blurRadius: 20
                            ),
                          ]
                        ),
                        child: Hero(
                          tag: food.imagePath,
                          child: Image.asset(food.imagePath, fit: BoxFit.contain,)
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 50,),
            child: PrimaryText(text: 'Ingredients', fontWeight: FontWeight.w700,size: 22,),
          ),

          SizedBox(
            height: 130,
            child: ListView.builder(
              itemCount: ingredients.length,
              scrollDirection: Axis.horizontal, 
              itemBuilder: (BuildContext context, int index) {
                final ingredient = ingredients[index];
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                  child: IngredientCard(ingredient: ingredient),
                );
              },
            ),
          ),

          SizedBox(height: 80,),
        ],
      ),
    );
  }
}

class IngredientCard extends StatelessWidget {

  final Ingredient ingredient;

  const IngredientCard({
    Key? key,required this.ingredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: EdgeInsets.only(right: 20, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: AppColors.lighterGray
          ),
        ]
      ),
      child: Image.asset(ingredient.imagePath, width: 90,),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightGray),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.chevron_left_rounded
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary
            ),
            child: Icon(Icons.star, color: AppColors.white,),
          )
        ],
      ),
    );
  }
}