import 'dart:convert';

import 'package:flutter_rush/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rush/screens/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({
    this.toggleView
  });
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _numberTextController = TextEditingController();
  TextEditingController _bioTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();


  String email = '';
  String password = '';
  String error = '';
  String name = '';
  bool hidePass = true;
  bool confirmPass = true;
  String userImageUrl = '';
  String userType = '';
  String selectedUserType = '';
  bool isArtist = true;
  bool isBuyer = false;
  bool isGallery = false;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    selectedUserType = 'artist';
    super.initState();
  }

  void setUserType(String val) {
    setState(() {
      selectedUserType = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width / 1.1;
    double _screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.indigo[600],
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  'Welcome to\nFlutter Rush!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: 70,
                        width: _screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(0),
                        child: TextFormField(
                          controller: _userNameTextController,
                          decoration: InputDecoration(
                              hintText: "Enter User Name",
                              prefixIcon: Icon(Icons.person)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a user name' : null,
                          textAlignVertical: TextAlignVertical.bottom,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: _screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(0),
                        child: TextFormField(
                          controller: _nameTextController,
                          decoration: InputDecoration(
                              hintText: "Enter Name",
                              prefixIcon: Icon(Icons.person)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a name' : null,
                          textAlignVertical: TextAlignVertical.bottom,
                        ),
                      ),
                      Visibility(
                        visible: !isBuyer,
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      Visibility(
                        visible: isArtist || isGallery,
                        child: Container(
                          height: 70,
                          width: _screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(0),
                          child: TextFormField(
                            controller: _numberTextController,
                            decoration: InputDecoration(
                                hintText: "Enter number",
                                prefixIcon: Icon(Icons.phone)),
                            validator: (val) =>
                            val.isEmpty ? 'Enter a number' : null,
                            textAlignVertical: TextAlignVertical.bottom,
                            // net ninja
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isGallery,
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      Visibility(
                        visible: isGallery,
                        child: Container(
                          height: 70,
                          width: _screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(0),
                          child: TextFormField(
                            minLines: 1,
                            maxLines: 5,
                            controller: _bioTextController,
                            decoration: InputDecoration(
                                hintText: "Tell us about your gallery",
                                prefixIcon: Icon(Icons.museum_rounded)),
                            validator: (val) =>
                            val.isEmpty ? 'Enter a bio' : null,
                            textAlignVertical: TextAlignVertical.bottom,
                            // net ninja
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: _screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(0),
                        child: TextFormField(
                          controller: _emailTextController,
                          decoration: InputDecoration(
                              hintText: "Enter email",
                              prefixIcon: Icon(Icons.email)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter an email' : null,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: _screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(0),
                        child: ListTile(
                          leading: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  hidePass = !hidePass;
                                });
                              }),
                          title: TextFormField(
                            obscureText: hidePass,
                            controller: _passwordTextController,
                            decoration: InputDecoration(
                              hintText: "Enter password",
                            ),
                            validator: (val) =>
                            val.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: _screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(0),
                        child: ListTile(
                          leading: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  confirmPass = !confirmPass;
                                });
                              }),
                          title: TextFormField(
                            obscureText: confirmPass,
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: "Confirm password",
                            ),
                            validator: (val) =>
                            val.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Theme(
                        data: ThemeData(
                          //here change to your color
                          unselectedWidgetColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              activeColor: Colors.white,
                              value: 'artist',
                              groupValue: selectedUserType,
                              onChanged: (value) {
                                setUserType(value);
                                setState(() {
                                  userType = value;
                                  isArtist = true;
                                  isGallery = false;
                                  isBuyer = false;
                                });
                              },
                            ),
                            Text(
                              'Artist', style: TextStyle(color: Colors.white),),
                            Radio(
                              activeColor: Colors.white,
                              value: 'buyer',
                              groupValue: selectedUserType,
                              onChanged: (value) {
                                setUserType(value);
                                setState(() {
                                  userType = value;
                                  isArtist = false;
                                  isGallery = false;
                                  isBuyer = true;
                                });
                              },
                            ),
                            Text(
                                'Buyer', style: TextStyle(color: Colors.white)),
                            Radio(
                              activeColor: Colors.white,
                              value: 'gallery',
                              groupValue: selectedUserType,
                              onChanged: (value) {
                                setUserType(value);
                                setState(() {
                                  userType = value;
                                  isGallery = true;
                                  isArtist = false;
                                  isBuyer = false;
                                });
                              },
                            ),
                            Text('Gallery',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            http.Response res = await http.get(Uri.parse(
                                "http://40.83.89.182:8000/check_username?username=${_userNameTextController
                                    .text}"));
                            Map resMap = json.decode(res.body);
                            if (resMap.keys.toList()[0] == "501") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "The username already exists")));
                              return;
                            }
                            var body;
                            if (isBuyer) {
                              body = jsonEncode({
                                'username': _userNameTextController.text,
                                "name": _nameTextController.text,
                                "email": _emailTextController.text,
                                "password": _passwordTextController.text,
                                "user_type": userType
                              });
                            }
                            else if (isGallery) {
                              body = jsonEncode({
                                'username': _userNameTextController.text,
                                "name": _nameTextController.text,
                                "email": _emailTextController.text,
                                "phone": _numberTextController.text,
                                "password": _passwordTextController.text,
                                "bio": _bioTextController.text
                              });
                            }
                            else {
                              body = jsonEncode({
                                'username': _userNameTextController.text,
                                "name": _nameTextController.text,
                                "email": _emailTextController.text,
                                "phone": _numberTextController.text,
                                "password": _passwordTextController.text,
                                "user_type": userType
                              });
                            }
                            http.Response resPost = await http.post(
                                Uri.parse("http://40.83.89.182:8000/$userType"),
                                headers: {"Content-Type": "application/json"},
                                body: body
                            );
                            try {
                              Map resPostMap = json.decode(resPost.body);
                              if (resPostMap.keys.toList()[0] == "300" ||
                                  resPostMap.keys.toList()[0] == "700" ||
                                  resPostMap.keys.toList()[0] == "800") {
                                sharedPreferences.setBool("isSignedIn", true);
                                sharedPreferences.setString("username", _userNameTextController.text);
                                if (userType == 'artist') {
                                  sharedPreferences.setBool('isArtist', true);
                                } else if (userType == 'buyer') {
                                  sharedPreferences.setBool('isBuyer', true);
                                } if (userType == 'gallery') {
                                  sharedPreferences.setBool('isGallery', true);
                                }
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => NavBar()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Oops, something went wrong. Please try again.")));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Oops, something went wrong. Please try again.")));
                            }
                          }
                        },
                        child: Container(
                          width: _screenWidth,
                          height: 50,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2),
                          // 15
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            "Sign Up",
                            style: Theme
                                .of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          widget.toggleView();
                        },
                        child: Text(
                          'I already have an account',
                          style: TextStyle(
                              color: Colors.lightBlueAccent[100], fontSize: 15),
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.lightBlueAccent[100],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}