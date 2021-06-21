import 'package:flutter/material.dart';
import 'package:flutter_design/pages/plant/components/icon_card.dart';
import 'package:flutter_design/utils/plant/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAndIcons extends StatelessWidget {

  final Size size;

  const ImageAndIcons({Key? key,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 2 ),
      child: SizedBox(
        height: size.height * 0.8,
        child: Row(children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 3),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    icon: SvgPicture.asset("assets/plant/back_arrow.svg"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Spacer(),
                IconCard(icon: "assets/plant/sun.svg"),
                IconCard(icon: "assets/plant/icon_2.svg"),
                IconCard(icon: "assets/plant/icon_3.svg"),
                IconCard(icon: "assets/plant/icon_4.svg"),
              ],
            ),
          ),),
          Container(
            height: size.height * 0.8,
            width: size.width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(63),
                bottomLeft: Radius.circular(63)
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 60,
                  color: kPrimaryColor.withOpacity(0.29),
                ),
              ],
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                fit: BoxFit.cover,
                image: AssetImage("assets/plant/img.png")
              )
            ),
          )
        ],),
      ),
    );
  }
}