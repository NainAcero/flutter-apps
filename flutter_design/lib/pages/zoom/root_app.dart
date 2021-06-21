import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design/pages/zoom/participants_page.dart';
import 'package:flutter_design/utils/zoom/colors.dart';
import 'package:flutter_design/utils/zoom/constant.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootApp extends StatefulWidget {
  static final routeName = 'rootApp';

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: headerAndFooter,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Octicons.mute,
                  color: grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  AntDesign.camera,
                  color: grey,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.security_outlined,
                  color: green,
                  size: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Zoom",
                  style: TextStyle(
                      fontSize: 17, color: grey, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: grey,
                  size: 20,
                ),
              ],
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  color: red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 5, bottom: 5
                  ),
                  child: Text(
                    "Leave",
                    style: TextStyle(
                      fontSize: 15,
                      color: grey,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: getBody(),
      bottomNavigationBar: getFooter(),

    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              width: 120,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/nain.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/nain.jpg'),
                  fit: BoxFit.cover
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getFooter() {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: headerAndFooter,
        border: Border(
          top: BorderSide(
            width: 2,
            color: black.withOpacity(0.06)
          ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(bottomItems[index], size: sizedItems[index],color: colorItems[index],),
                    SizedBox(height: 5,),
                    Text(
                      textItems[index],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: colorItems[index]
                      ),
                    )
                  ],
                ),
              );
            })
          
        ),
      ),
    );
  }
  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });

    if(index == 3){
      Navigator.pushNamed(context, ParticipantsPage.routeName);
    }

    if (index == 4) {
      getBottomSheet();
    }
  }

  getBottomSheet() {
    showCupertinoModalPopup(
      context: context, 
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: List.generate(actionSheetItems.length, (index) {
          if (actionSheetItems[index] == "Disconnect Audio") {
            return Container(
              color: Colors.white.withOpacity(0.7),
              child: CupertinoActionSheetAction(
                child: Text(
                  actionSheetItems[index],
                  style: TextStyle(color: red),
                ),
                onPressed: (){
                  Navigator.pop(context, 'One');
                },
              ),
            );
          } else if (actionSheetItems[index] == "👏   👍   💔   🤣   😮   🎉") {
            return Container(
              color: Colors.white.withOpacity(0.7),
              child: CupertinoActionSheetAction(
                child: Text(
                  actionSheetItems[index],
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  Navigator.pop(context, 'One');
                },
              ),
            );
          }

          return Container(
            color: Colors.white.withOpacity(0.7),
            child: CupertinoActionSheetAction(
              child: Text(actionSheetItems[index]),
              onPressed: () {
                Navigator.pop(context, 'One');
              },
            ),
          );
        }),
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancel',
          ),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      )
    );
  }
}