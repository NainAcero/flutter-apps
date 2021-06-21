import 'package:flutter/material.dart';
import 'package:flutter_design/pages/ubereats/components/home_page.dart';
import 'package:flutter_design/utils/ubereats/colors.dart';
import 'package:flutter_design/utils/zoom/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UbereatsPage extends StatefulWidget {
  static final routeName = 'ubereats';

  @override
  _UbereatsPageState createState() => _UbereatsPageState();
}

class _UbereatsPageState extends State<UbereatsPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {

    List<Widget> pages = [
      HomePage(),
      Center(
        child: Text(
          "Search Page",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: black
          ),
        ),
      ),
      Center(
        child: Text(
          "Grocery Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: black),
        ),
      ),
      Center(
        child: Text(
          "Orders Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: black),
        ),
      ),
      Center(
        child: Text(
          "Account Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: black),
        ),
      )
    ];

    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List bottomItems = [
      "assets/ubereats/home_icon.svg",
      "assets/ubereats/search_icon.svg",
      "assets/ubereats/grocery_icon.svg",
      "assets/ubereats/order_icon.svg",
      "assets/ubereats/account_icon.svg"
    ];
    List textItems = ["Home", "Search", "Grocery", "Orders", "Account"];
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: white,
        border: Border(
          top: BorderSide(width: 2, color: black.withOpacity(0.06)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(textItems.length, (index) {
            return InkWell(
              onTap: (){
                selectedTab(index);
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    bottomItems[index],
                    width: 22,
                    color: pageIndex == index ? black : Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    textItems[index],
                    style: TextStyle(
                        fontSize: 10,
                        color: pageIndex == index
                            ? black
                            : black.withOpacity(0.5)),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}