import 'package:flutter/material.dart';
import 'package:flutter_design/pages/commerce/home/components/body.dart';
import 'package:flutter_design/utils/commerce/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EcommersPage extends StatelessWidget {
  static final routeName = 'home-ecommers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/commerce/back.svg",
          ),
          onPressed: (){},
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset(
              "assets/commerce/search.svg",
              color: kTextColor,
            ),
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset(
              "assets/commerce/cart.svg",
              color: kTextColor,
            ),
          ),
          SizedBox(
            width: kDefaultPaddin / 2,
          )
        ],
      ),
      body: Body(),
    );
  }
}