import 'package:flutter/material.dart';
import 'package:flutter_design/models/categoria.dart';
import 'package:flutter_design/models/food/food.dart';
import 'package:flutter_design/pages/food/food_detail.dart';
import 'package:flutter_design/pages/food/style.dart';
import 'package:flutter_design/utils/food/colors.dart';
import 'package:flutter_design/utils/food/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodPage extends StatefulWidget {
  static final routeName = 'food';

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  int selectedCategoryCard = 0;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/nain.jpg'),
          ),
        ),
        actions: [
          IconButton(onPressed: null, icon: SvgPicture.asset('assets/food/menu.svg')),
        ],
      ),

      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(text: 'Food',),
                PrimaryText(text: 'Delivery',size: 42,fontWeight: FontWeight.w600,height: 1.1,),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              const SizedBox(width: 20,),
              Icon(
                Icons.search,
                color: AppColors.secondary,
                size: 25,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGray),
                    ),
                    hintText: 'Search..',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGray,
                      fontSize: 18
                    )
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: PrimaryText(text: 'Categories', fontWeight: FontWeight.w800,size: 22,),
          ),

          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodCategoryList.length,
              itemBuilder: (BuildContext context, int index) { 
                  final Categoria categoria = foodCategoryList[index];
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                    child: FoodCategoryCard(categoria, index),
                  );
               },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: PrimaryText(
              text: 'Popuar',
              fontWeight: FontWeight.w800,
              size: 22,
            ),
          ),

          Column(
            children: List.generate(popularFoodList.length, (index) {
              final food = popularFoodList[index];
              return PopularFoodCard(size: size, food: food);
            }),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  Widget FoodCategoryCard(Categoria categoria , int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedCategoryCard = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 25, top: 20, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selectedCategoryCard == index ? AppColors.primary: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.lighterGray, blurRadius: 10
            ),
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(categoria.imagePath, width: 65,),
            PrimaryText(text: categoria.name,size: 16,fontWeight: FontWeight.w700,),
            RawMaterialButton(
              onPressed: null,
              fillColor: selectedCategoryCard == index ? AppColors.white : AppColors.tertiary,
              shape: CircleBorder(),
              child: Icon(
                Icons.chevron_right, 
                color: selectedCategoryCard == index ? AppColors.secondary: Colors.white,
                size: 20,),
            )
          ],
        ),
      ),
    );
  }
}

class PopularFoodCard extends StatelessWidget {

  final Food food;

  const PopularFoodCard({
    Key? key,
    required this.size,required this.food,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetail(
          food: food
        )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 25),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(color: AppColors.lightGray, blurRadius: 10),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 25),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: AppColors.primary,size: 15,),
                        SizedBox(width: 10,),
                        PrimaryText(
                          text: 'top of the week',
                          size: 16,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),

                  Container(
                    width: size.width / 2.1,
                    padding: EdgeInsets.only(left: 20.0, top: 20),
                    child: PrimaryText(
                      text: food.name,
                      fontWeight: FontWeight.w800,
                      size: 18,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 20),
                    child: PrimaryText(
                      text: food.weight,
                      size: 16,
                      color: AppColors.lightGray,
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          color: AppColors.primary,
                        ),
                        child: Icon(Icons.add, size: 20,),
                      ),

                      SizedBox(width: 25,),

                      Row(
                        children: [
                          Icon(Icons.star, size: 12,),
                          SizedBox(
                            width: 5,
                          ),
                          PrimaryText(
                            text: food.star.toString(),
                            fontWeight: FontWeight.w700,
                            size: 16,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),

            Container(
              transform: Matrix4.translationValues(15, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightGray,
                    blurRadius: 20
                  )
                ]
              ),
              child: Hero(
                tag: food.imagePath,
                child: Image.asset(food.imagePath,width: size.width / 2.9,)
              ),
            )
          ],
        ),
      ),
    );
  }
}

