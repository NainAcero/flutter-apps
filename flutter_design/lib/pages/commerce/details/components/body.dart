import 'package:flutter/material.dart';
import 'package:flutter_design/models/commerce/product.dart';
import 'package:flutter_design/pages/commerce/details/components/add_to_cart.dart';
import 'package:flutter_design/pages/commerce/details/components/color_and_size.dart';
import 'package:flutter_design/pages/commerce/details/components/counter_with_fav_btn.dart';
import 'package:flutter_design/pages/commerce/details/components/description.dart';
import 'package:flutter_design/pages/commerce/details/components/product_title_with_image.dart';
import 'package:flutter_design/utils/commerce/colors.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key,required this.product}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.33
                  ),
                  padding: EdgeInsets.only(
                    top: size.height * 0.13,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    )
                  ),
                  child: Column(
                    children: [
                      ColorAndSize(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      Description(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      CounterWithFavBtn(),
                      SizedBox(height: kDefaultPaddin / 2),
                      AddToCart(product: product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          ),
        ],
      ),
    );
  }
}