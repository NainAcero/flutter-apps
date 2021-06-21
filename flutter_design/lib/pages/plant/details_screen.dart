import 'package:flutter/material.dart';
import 'package:flutter_design/pages/plant/components/image_and_icon.dart';
import 'package:flutter_design/pages/plant/components/title_and_price.dart';
import 'package:flutter_design/utils/plant/colors.dart';

class DetailsScreen extends StatelessWidget {
  static final routeName = 'plant-detail';
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageAndIcons(
              size: size
            ),
            TitleAndPrice(title: "Angelica", country: "Russia", price: 440),
            SizedBox(height: kDefaultPadding),
            Row(
              children: [
                SizedBox(
                  width: size.width / 2,
                  height: 84,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20)
                      )
                    ),
                    color: kPrimaryColor,
                    onPressed: (){},
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("Description"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}