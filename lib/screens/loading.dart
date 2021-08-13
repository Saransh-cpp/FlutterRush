import 'package:flutter/material.dart';
import 'package:flutter_rush/screens/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nav_bar.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.pink[50],
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.pink[50],
          body: Container(
            child: Center(
                child: SpinKitPouringHourglass(
                  size: 50,
                  color: Colors.brown,
                )
            ),
          ),
        ),
      ),
    );
  }

  void isSignedIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool goToNavBar = sharedPreferences.getBool("isSignedIn") ?? false;
    if (goToNavBar) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NavBar()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginPage()));

    }
  }

}