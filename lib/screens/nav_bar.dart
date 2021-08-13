import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rush/screens/search.dart';
import 'package:flutter_rush/screens/profile.dart';
import 'package:flutter_rush/screens/add_art.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  PageController pageController = PageController();
  int currentIndex = 0;
  var currentTab = [
    Search(),
    AddArtWork(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: PageView(
          children: currentTab,
          controller: pageController,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
            height: 60.0,


            backgroundColor: Colors.pink[50],
            items: <Widget>[
              Icon(
                  Icons.search_rounded,
                  size: 30
              ),
              Icon(
                  Icons.my_library_add_rounded,
                  size: 30
              ),
              Icon(
                  Icons.person,
                  size: 30
              ),

            ],
            index: currentIndex,
            animationCurve: Curves.easeInToLinear,

            animationDuration: Duration(
                milliseconds: 500
            ),

            onTap: (int index) {
              setState(() {
                currentIndex = index;
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              });
            }
        ),
      ),
    );
  }
}