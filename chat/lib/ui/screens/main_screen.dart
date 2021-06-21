import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:chat/ui/screens/conversations_screen.dart';
import 'package:chat/ui/style.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static final routeName = 'main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          ConversationsScreen(),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        backgroundColor: Style.darkColor,
        onTap: (i) {
          setState(() {
            currentIndex = i;
            _pageController.animateToPage(i,
                duration: kTabScrollDuration, curve: Curves.easeIn);
          });
        },
        elevation: 8,
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Style.primaryColor,
            icon: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
          )),
          BubbleBottomBarItem(
            backgroundColor: Style.primaryColor,
            icon: Icon(
              Icons.people_outline,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.people_outline,
              color: Colors.white,
            ),
            title: Text(
              "Friends",
              style: TextStyle(color: Colors.white),
          )),
          BubbleBottomBarItem(
            backgroundColor: Style.primaryColor,
            icon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            activeIcon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
          )),
        ]
      )
    );
  }
}