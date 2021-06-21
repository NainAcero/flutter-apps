
import 'package:flutter/material.dart';
import 'package:flutter_design/utils/plant/colors.dart';

class TitleAndPrice extends StatelessWidget {

  final String title, country;
  final int price;

  const TitleAndPrice({Key? key, 
    required this.title, 
    required this.country, 
    required this.price
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: kTextColor, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: country,
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ]
            ),
          ),
          Spacer(),
          Text(
            "\$$price",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: kPrimaryColor),
          )
        ],
      ),
    );
  }
}