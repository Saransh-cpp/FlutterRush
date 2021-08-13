import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rush/screens/search.dart';
import 'package:flutter_rush/screens/register.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }else {
      return Register(toggleView: toggleView);
    }

  }
}

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({
    this.toggleView
  });
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool loading = false;
  bool hidePass = true;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width / 1.1;
    return Scaffold(
        backgroundColor: Colors.indigo[600],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome back to\nFlutter Rush!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40
                          ),
                        ),
                        SizedBox(
                          height: 100,
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
                            controller: _usernameTextController,
                            decoration: InputDecoration(
                                hintText: "Enter username",
                                prefixIcon: Icon(Icons.person)),
                            validator: (val) =>
                            val.isEmpty ? 'Enter a username' : null,
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
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              http.Response res = await http.get(
                                Uri.parse(
                                    "http://40.83.89.182:8000/artistlogin?username=${_usernameTextController
                                        .text}&password=${_passwordTextController
                                        .text}"),
                              );
                              Map resMap = json.decode(res.body);
                              if (resMap.keys.toList()[0] == "100") {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => Search()));
                              } else if (resMap.keys.toList()[0] == "501") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "The username does not exists")));
                                return;
                              } else if (resMap.keys.toList()[0] == "101") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Entered password is wrong")));
                                return;
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12)),
                            ),
                            child: Text(
                              "Sign In",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'I am new here',
                            style: TextStyle(color: Colors.lightBlueAccent[100],
                                fontSize: 15),
                          ),
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
          ),
        )
    );
  }
}
