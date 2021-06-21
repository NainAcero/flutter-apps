import 'package:flutter/material.dart';
import 'package:flutter_design/pages/commerce/details/ecommers_detail_page.dart';
import 'package:flutter_design/pages/commerce/home/components/categories.dart';
import 'package:flutter_design/pages/commerce/home/components/item_card.dart';
import 'package:flutter_design/utils/commerce/colors.dart';
import 'package:flutter_design/utils/commerce/constant.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin, vertical: 10),
          child: Text(
            "Women",
            style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 10),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPaddin,
                crossAxisSpacing: kDefaultPaddin,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (BuildContext context, int index) => ItemCard(
                product: products[index], 
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EcommersDetail(
                    product: products[index]
                  ))
                )
              ),
            ),
          ),
        )
      ],
    );
  }
}