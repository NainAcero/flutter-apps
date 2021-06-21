import 'package:flutter/material.dart';
import 'package:flutter_design/models/commerce/product.dart';
import 'package:flutter_design/pages/commerce/details/components/body.dart';
import 'package:flutter_design/utils/commerce/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EcommersDetail extends StatelessWidget {
  static final routeName = 'detail-ecommers';
  final Product product;

  const EcommersDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: product.color,
      appBar: AppBar(
        backgroundColor: product.color,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            "assets/commerce/back.svg",
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/commerce/search.svg"),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/commerce/cart.svg"),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: Body(
        product: product
      ),
    );
  }
}