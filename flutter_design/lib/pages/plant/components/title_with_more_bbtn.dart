import 'package:flutter/material.dart';
import 'package:flutter_design/utils/plant/colors.dart';

class TitleWithMoreBtn extends StatelessWidget {

  final String title;
  final Function press;

  const TitleWithMoreBtn({Key? key,required this.title,required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          Container(
            height: 24,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 4),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(right: kDefaultPadding / 4),
                    height: 7,
                    color: kPrimaryColor.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            color: kPrimaryColor,
            onPressed: (){},
            child: Text(
              "More",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
