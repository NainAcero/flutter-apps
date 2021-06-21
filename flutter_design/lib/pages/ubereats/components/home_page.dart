import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design/models/ubereats/menu.dart';
import 'package:flutter_design/pages/ubereats/store_detail_page.dart';
import 'package:flutter_design/pages/ubereats/styles.dart';
import 'package:flutter_design/utils/ubereats/colors.dart';
import 'package:flutter_design/utils/ubereats/constant.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int activeMenu = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    final items = [
      "assets/ubereats/slide_1.jpg",
      "assets/ubereats/slide_2.jpg",
      "assets/ubereats/slide_3.jpg"
    ];

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(menu.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        activeMenu = index;
                      });
                    },
                    child: activeMenu == index 
                    ? ElasticIn(
                      child: Container(
                        decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 8
                          ),
                          child: Row(
                            children: [
                              Text(
                                menu[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 8,
                        ),
                        child: Row(
                          children: [
                            Text(
                              menu[index],
                              style: customContent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 15
                  ),
                  height: 45,
                  width: size.width - 70,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/ubereats/pin_icon.svg",
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("New York", style: customContent)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/ubereats/time_icon.svg",
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Now",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SvgPicture.asset("assets/ubereats/filter_icon.svg"),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1, 
                autoPlay: true,
                onPageChanged: (index, _) {
                  
                },
              ),
              items: List.generate(items.length, (index) {
                return Image.asset(items[index]);
              })
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(color: textFieldColor),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(color: white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Row(
                          children: List.generate(categories.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 35),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    categories[index].imagePath,
                                    width: 40,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    categories[index].name,
                                    style: customParagraph,
                                  )
                                ],
                              )
                            );
                          })
                        )
                      )
                    )
                  )
                )
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => StoreDetailPage(
                                      img: firstMenu[0].img,
                                )
                              ));
                          },
                          child: Container(
                            width: size.width,
                            height: 160,
                            child: Image(
                              image: NetworkImage(
                                firstMenu[0].img,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 15,
                          child: SvgPicture.asset(
                            firstMenu[0].is_liked
                              ? "assets/ubereats/loved_icon.svg"
                              : "assets/ubereats/love_icon.svg",
                            width: 20,
                            color: white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      firstMenu[0].name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Sponsored",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.info,
                          color: Colors.grey,
                          size: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          firstMenu[0].description,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: textFieldColor,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.hourglass_bottom,
                              color: primary,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textFieldColor,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              firstMenu[0].time,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: textFieldColor,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              firstMenu[0].delivery_fee,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: size.width,
              height: 10,
              decoration: BoxDecoration(color: textFieldColor),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "More to explore",
                    style: customTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(exploreMenu.length, (index) {
                        final Menu menu = exploreMenu[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => StoreDetailPage(
                                                img: menu.img,
                                          )
                                        ));
                                    },
                                    child: Container(
                                      width: size.width - 30,
                                      height: 160,
                                      child: Image(
                                        image: NetworkImage(
                                          menu.img
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    right: 15,
                                    child: SvgPicture.asset(
                                      menu.is_liked 
                                        ? "assets/ubereats/loved_icon.svg"
                                        : "assets/ubereats/love_icon.svg",
                                      width: 20,
                                      color: white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                menu.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Sponsored",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.info,
                                    color: Colors.grey,
                                    size: 15,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    menu.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textFieldColor,
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.hourglass_bottom,
                                        color: primary,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textFieldColor,
                                      borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        menu.time,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textFieldColor,
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            menu.rate.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: yellowStar,
                                            size: 17,
                                          ),
                                          Text(
                                            menu.rate_number.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      })
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: size.width,
              height: 10,
              decoration: BoxDecoration(color: textFieldColor),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Near You",
                    style: customTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(popluarNearYou.length, (index) {

                        final Menu popular = popluarNearYou[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => StoreDetailPage(
                                                img: popular.img,
                                          )
                                        ));
                                    },
                                    child: Container(
                                      width: size.width - 30,
                                      height: 160,
                                      child: Image(
                                        image: NetworkImage(
                                          popular.img,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    right: 15,
                                    child: SvgPicture.asset(
                                      popular.is_liked
                                        ? "assets/ubereats/loved_icon.svg"
                                        : "assets/ubereats/love_icon.svg",
                                      width: 20,
                                      color: white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                popular.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Sponsored",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.info,
                                    color: Colors.grey,
                                    size: 15,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    popular.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textFieldColor,
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.hourglass_bottom,
                                        color: primary,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: textFieldColor,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        popular.time,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textFieldColor,
                                      borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            popular.rate.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: yellowStar,
                                            size: 17,
                                          ),
                                          Text(
                                            popular.rate_number.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}