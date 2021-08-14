import 'package:flutter/material.dart';
import 'package:flutter_rush/services/search_service.dart';
import 'package:flutter_rush/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(icon: Icon(Icons.logout), onPressed: () async {
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          await sharedPreferences.clear();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LoginPage()));
        }, color: Colors.black,)
        ,
        actions: [
          IconButton(icon: Icon(Icons.search_rounded), onPressed: () {
            showSearch(context: context, delegate: SearchService());
          },),
        ],
      ),
    );
  }
}
