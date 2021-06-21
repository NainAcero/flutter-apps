import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CovidPage extends StatelessWidget {
  static final routeName = 'covid';

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff25727A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Berlin, Germany', style: textStyle(
              18, Colors.white, FontWeight.w600
            ),),
            Icon(Icons.arrow_drop_down_outlined)
          ],
        ),
        leading: Image.asset('assets/covid/menu.png', width: 25,),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: null, 
                icon: Image.asset('assets/covid/bell.png', width: 25,)
              ),
              Positioned(
                right: 5,
                top: 1,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.black87,
                  child: Text('2'),
                ),
              )
            ],
          )
        ],
      ),

      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/covid/covid-bg.png'
                ),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Container(
                    padding: EdgeInsets.only(right: 50),
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('6738', style: textStyle(50, Colors.white, FontWeight.w900),),
                        Text('Total Cases', style: textStyle(18, Colors.white, FontWeight.w700),),
                      ]
                    ),
                  ),
                ),

                Container(
                  height: size.height - 200,
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight:Radius.circular(50) ),
                  ),
                  child: ListView(
                    children: [
                      SymptomsCheckerCard(size: size,),
                      SizedBox(height: 40,),
                      Column(
                        children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featureCard('assets/covid/map.svg', 'Map'),
                            featureCard(
                                'assets/covid/virus.svg', 'Risk of\n infection'),
                            featureCard('assets/covid/upload.svg', 'Upload\n Data'),
                          ]),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              featureCard('assets/covid/trend.svg', 'Statistics'),
                              featureCard('assets/covid/facemask.svg', 'Protection'),
                              featureCard('assets/covid/phone.svg', 'Contacts'),
                          ]),
                          SizedBox(height: 60,)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container featureCard(String iconName, String labelName) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 20
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset.zero, color: Colors.grey.shade300, blurRadius: 15
                )
              ]
            ),
            child: SvgPicture.asset(
              iconName, width: 45,
            ),
          ),
          SizedBox(height: 10,),
          Text(labelName, textAlign: TextAlign.center, style: textStyle(20, Colors.black, FontWeight.w600),)
        ],
      ),
    );
  }
}

TextStyle textStyle(
    double fontSize, Color colorName, FontWeight fontWeight
) => TextStyle(
  color: colorName,
  fontSize: fontSize,
  fontFamily: 'QuickSand',
  fontWeight: fontWeight
);

class SymptomsCheckerCard extends StatelessWidget {

  final Size size;
  
  const SymptomsCheckerCard({
    Key? key,required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero, color: Colors.grey.shade300,
            blurRadius: 15
          )
        ]
      ),
      child: Row(
        children: [
          SizedBox(
            height: 150,
            width: (size.width - 80) / 2,
            child: Image.asset('assets/covid/doctor.png'),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Symptoms \nChecker',
                style: textStyle(24, Colors.black, FontWeight.w800, )),
              SizedBox(height: 16),
              Text('Based on common \nsymptoms',
                  style: textStyle(16, Colors.grey.shade600, FontWeight.w800, ))
              ],
            ),
          )
        ],
      ),
    );
  }
}