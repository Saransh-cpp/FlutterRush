import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _weightTextController = TextEditingController();
  TextEditingController _breadthTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _artistNameTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _genreTextController = TextEditingController();
  TextEditingController _lengthTextController = TextEditingController();
  TextEditingController _priceTextController = TextEditingController();

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
      backgroundColor: Colors.pink[50],
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Enter a\nProduct',
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
                          controller: _nameTextController,
                          decoration: InputDecoration(
                              hintText: "Enter Name",
                              prefixIcon: Icon(Icons.drive_file_rename_outline)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a name' : null,
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
                          controller: _artistNameTextController,
                          decoration: InputDecoration(
                              hintText: "Enter artist name",
                              prefixIcon: Icon(Icons.person)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter an artist\'s name' : null,
                          textAlignVertical: TextAlignVertical.bottom,
                        ),
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
                                hintText: "Enter artist username",
                                prefixIcon: Icon(Icons.drive_file_rename_outline)),
                            validator: (val) =>
                            val.isEmpty ? 'Enter an artist\'s username' : null,
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
                          controller: _genreTextController,
                          decoration: InputDecoration(
                              hintText: "Enter genre",
                              prefixIcon: Icon(Icons.category_rounded)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a genre' : null,
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
                          keyboardType: TextInputType.number,
                          controller: _weightTextController,
                          decoration: InputDecoration(
                              hintText: "Enter weight",
                              prefixIcon: Icon(Icons.line_weight)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a weight' : null,
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
                          keyboardType: TextInputType.number,
                          controller: _lengthTextController,
                          decoration: InputDecoration(
                              hintText: "Enter length",
                              prefixIcon: Icon(Icons.height_rounded)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a length' : null,
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
                          keyboardType: TextInputType.number,
                          controller: _breadthTextController,
                          decoration: InputDecoration(
                              hintText: "Enter breadth",
                              prefixIcon: Icon(Icons.height_rounded)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a breadth' : null,
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
                          keyboardType: TextInputType.number,
                          controller: _priceTextController,
                          decoration: InputDecoration(
                              hintText: "Enter price",
                              prefixIcon: Icon(Icons.attach_money_rounded)),
                          validator: (val) =>
                          val.isEmpty ? 'Enter a price' : null,
                          textAlignVertical: TextAlignVertical.bottom,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          var uuid = Uuid();
                          var productId = uuid.v1();
                          if (_formKey.currentState.validate()) {
                            var body = jsonEncode({
                              "product_id": productId,
                              "name": _nameTextController,
                              'artist_username': _userNameTextController.text,
                              "artist_name": _artistNameTextController.text,
                              "genre": _genreTextController.text,
                              "length": double.parse(_lengthTextController.text),
                              "breadth": double.parse(_breadthTextController.text),
                              "price": double.parse(_priceTextController.text),
                              "weight": double.parse(_weightTextController.text),
                            });
                            http.Response resPost = await http.post(
                                Uri.parse("http://40.83.89.182:8000/product"),
                                headers: {"Content-Type": "application/json"},
                                body: body
                            );
                            try {
                              Map resPostMap = json.decode(resPost.body);
                              if (resPostMap.keys.toList()[0] == "400") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Product added!")));
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
