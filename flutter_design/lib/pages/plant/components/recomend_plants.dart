import 'package:flutter/material.dart';
import 'package:flutter_design/pages/plant/details_screen.dart';
import 'package:flutter_design/utils/plant/colors.dart';
import 'package:flutter_design/utils/plant/constant.dart';

class RecomendsPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plants.length,
        itemBuilder: (BuildContext context, int index) { 
          final plant = plants[index];
          return RecomendPlantCard(
            image: plant.image,
            title: plant.title,
            country: plant.country,
            index : index,
            price: plant.price,
            press: () {
              Navigator.pushNamed(context, DetailsScreen.routeName);
            },
          );
         },
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {

  final String image, title, country;
  final int price;
  final VoidCallback press;
  final int index;

  const RecomendPlantCard({Key? key, 
    required this.image, 
    required this.title, 
    required this.country, 
    required this.price, 
    required this.press,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: index == 0 ? kDefaultPadding : 0,
        right: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: [
          Image.asset(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(color: kPrimaryColor.withOpacity(0.5),),
                        )
                      ]
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context).textTheme.button!.copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}