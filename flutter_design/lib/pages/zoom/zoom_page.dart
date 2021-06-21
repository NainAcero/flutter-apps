import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design/pages/zoom/join_meeting_page.dart';
import 'package:flutter_design/utils/zoom/colors.dart';
import 'package:flutter_design/utils/zoom/constant.dart';

class ZoomPage extends StatefulWidget {
  static final routeName = 'zoom';
  int activetab = 0;

  @override
  _ZoomPageState createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headerAndFooter,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: headerAndFooter,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.settings, color: grey,),
            Spacer(),
            Row(
              children:
                List.generate(4, (index){
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.activetab == index ? grey : grey.withOpacity(0.2),
                      ),
                    ),
                  );
                }),
            ),
            Spacer()
          ],
        ),
      ),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 200,
      decoration: BoxDecoration(
        color: headerAndFooter
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => JoinMeetingPage()
                ));
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text(
                    "Join a Meeting",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: grey
                    ),
                  ),
                ),
              ), 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: size.height, 
        viewportFraction: 0.99, 
        onPageChanged: (index, _) {
          setState(() {
            widget.activetab = index;
          });
        },
      ),
      items: List.generate(items.length, (index) {
        return Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    items[index]['title'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: grey
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    items[index]['description'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: grey
                    ),
                  ),
                ],
              ),
              items[index]['img'] == null 
                ? Container()
                : Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(items[index]['img'])
                    )
                  ),
                )
            ],
          ),
        );
      })
    );
  }
}