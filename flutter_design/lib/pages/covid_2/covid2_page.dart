import 'package:flutter/material.dart';
import 'package:flutter_design/pages/covid_2/detail_page.dart';
import 'package:flutter_design/utils/covid_2/colors.dart';
import 'package:flutter_design/utils/covid_2/constant.dart';
import 'package:flutter_design/widgets/card_status.dart';
import 'package:flutter_design/widgets/line_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Covid2Page extends StatefulWidget {
  static final routeName = 'covid2';

  @override
  _Covid2PageState createState() => _Covid2PageState();
}

class _Covid2PageState extends State<Covid2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: SvgPicture.asset(
                  "assets/covid2/burger_icon.svg",
                  width: 15,
                  height: 15,
                ),
              ),
              SizedBox(width: 20,),
              Text(
                "Covid19 Tracker App",
                style: appTitle,
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, DetailPage.routeName);
            },
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: -10,
                    child: Container(
                      height: 140,
                      child: Image.asset(
                        "assets/covid2/image_1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    left: 120,
                    top: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Take The Self Checkup!",
                            style: appSubTitle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                          "Contains several checklist question to check your phisical condition",
                            style: contentWhite,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transmission Update",
                    style: appSubTitle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Latest Update : 13 March 2020",
                    style: contentWhite,
                  )
                ],
              ),
              GestureDetector(
                onTap: (){},
                child: Icon(
                  Icons.refresh,
                  color: textWhite,
                )
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardStatus(
                iconName: Icons.people_alt_outlined,
                colorCard: warning,
                newCases: "+25",
                totalCases: "7,987",
                status: "Active",
              ),
              SizedBox(
                width: 20,
              ),
              CardStatus(
                iconName: Icons.favorite,
                colorCard: success,
                newCases: "+5",
                totalCases: "11,09",
                status: "Recovered",
              ),
              SizedBox(
                width: 20,
              ),
              CardStatus(
                iconName: Icons.close,
                colorCard: primary,
                newCases: "+25",
                totalCases: "335",
                status: "Deceased",
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Spread Trends",
                style: appSubTitle,
              ),
                SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: textWhite.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Active Cases",
                            style: TextStyle(color: warning, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Text(
                                "7,978",
                                style: TextStyle(
                                    color: warning,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "[+25]",
                                style: TextStyle(color: warning),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            "Weekly",
                            style: TextStyle(color: textWhite),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Monthly",
                            style: TextStyle(color: textWhite),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              width: 45,
                              height: 3,
                              decoration: BoxDecoration(
                                color: textWhite,
                                borderRadius: BorderRadius.circular(3)
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 2,
                              decoration: BoxDecoration(
                                color: textWhite.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(3)
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      chartWidget
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}