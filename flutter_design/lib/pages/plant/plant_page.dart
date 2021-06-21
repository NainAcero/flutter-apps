import 'package:flutter/material.dart';
import 'package:flutter_design/pages/plant/components/featurred_plants.dart';
import 'package:flutter_design/pages/plant/components/header_with_seachbox.dart';
import 'package:flutter_design/pages/plant/components/recomend_plants.dart';
import 'package:flutter_design/pages/plant/components/title_with_more_bbtn.dart';
import 'package:flutter_design/utils/plant/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantPage extends StatelessWidget {
  static final routeName = 'plant';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/plant/menu.svg"),
          onPressed: (){},
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWithSearchBox(size: size),
              TitleWithMoreBtn(title: "Recomended", press: () {}),
              RecomendsPlants(),
              TitleWithMoreBtn(title: "Featured Plants", press: () {}),
              FeaturedPlants(),
            ],
          ),
        ),
      ),
    );
  }
}