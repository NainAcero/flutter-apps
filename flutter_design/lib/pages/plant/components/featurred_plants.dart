import 'package:flutter/material.dart';
import 'package:flutter_design/utils/plant/colors.dart';

class FeaturedPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FeaturePlantCard(
            image: "assets/plant/bottom_img_1.png",
            press: () {},
          ),
          FeaturePlantCard(
            image: "assets/plant/bottom_img_2.png",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class FeaturePlantCard extends StatelessWidget {

  final String image;
  final VoidCallback press;

  const FeaturePlantCard({Key? key,
    required this.image, 
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image)
          ),
        ),
      ),
    );
  }
}