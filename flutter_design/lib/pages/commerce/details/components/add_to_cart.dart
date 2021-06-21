import 'package:flutter/material.dart';
import 'package:flutter_design/models/commerce/product.dart';
import 'package:flutter_design/utils/commerce/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddToCart extends StatelessWidget {
  final Product product;

  const AddToCart({Key? key,required this.product}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: product.color
              )
            ),
            child: IconButton(
              onPressed: (){},
              icon: SvgPicture.asset(
                "assets/commerce/add_to_cart.svg",
                color: product.color,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                color: product.color,
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}