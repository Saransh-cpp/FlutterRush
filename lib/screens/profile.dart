import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rush/utils/image_converter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  File profilePic;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: profilePic != null ? Center(
                  child: Container(height: MediaQuery
                      .of(context)
                      .size
                      .height / 3.5,
                      // width: MediaQuery.of(context).size.width / 2,
                      child: Image.file(
                        profilePic, fit: BoxFit.fill,)),
                ) : Center(
                  child: Icon(
                    Icons.add_a_photo, color: Colors.grey, size: 100,),
                ),
                onTap: () async {
                  final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery);
                  setState(() {
                    if (pickedFile != null) {
                      profilePic = File(pickedFile.path);
                    }
                  });
                },
              ),
              TextButton(
                  onPressed: () async {
                    if (profilePic != null) {
                      SharedPreferences sharedPreferences = await SharedPreferences
                          .getInstance();
                      final imageString = ImageConverter.base64StringFromImage(
                          profilePic.readAsBytesSync());
                      var body = jsonEncode({
                        "username": sharedPreferences.getString("username"),
                        "dp": imageString
                      });
                      print(body);
                      http.Response resPost = await http.post(
                          Uri.parse("http://40.83.89.182:8000/profilepic"),
                          headers: {"Content-Type": "application/json"},
                          body: body
                      );
                      print(resPost.body);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please select an image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0
                      );
                    }
                  },
                  child: Text("Submit"))

            ]
        )
    );
  }
}
