import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rush/screens/add_product.dart';
import 'package:flutter_rush/screens/login.dart';
import 'package:flutter_rush/screens/profile.dart';
import 'package:flutter_rush/screens/add_art.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  SharedPreferences sharedPreferences;

  isArtist () async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isArtist') ?? false;
  }
  isBuyer () async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isBuyer') ?? false;
  }
  isGallery () async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isGallery') ?? false;
  }

  PageController pageController = PageController();
  int currentIndex = 0;
  List<Widget> currentTab;

  @override
  Widget build(BuildContext context) {
    // if (isArtist()) {
      currentTab = [
        AddArtWork(),
        Profile(),
      ];
    // } else if (isBuyer()) {
    //   currentTab = [
    //     AddArtWork(),
    //     Profile(),
    //   ];
    // } else if (isGallery()) {
    //   currentTab = [
    //     AddProduct(),
    //     Profile(),
    //   ];
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[50],
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: Colors.black
          ),
          actions: [
            IconButton(icon: Icon(Icons.logout), onPressed: () async {
              sharedPreferences = await SharedPreferences
                  .getInstance();
              await sharedPreferences.clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()));
            }, color: Colors.black,)

          ],
        ),
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
              // Icon(
              //     Icons.search_rounded,
              //     size: 30
              // ),
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