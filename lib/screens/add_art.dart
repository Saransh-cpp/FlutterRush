import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rush/utils/image_converter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddArtWork extends StatefulWidget {
  @override
  _AddArtWorkState createState() => _AddArtWorkState();
}

class _AddArtWorkState extends State<AddArtWork> {

  File artWork;
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;
  final picker = ImagePicker();
  TextEditingController _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: artWork != null ? Center(
              child: Container(height: MediaQuery
                  .of(context)
                  .size
                  .height / 3.5,
                  // width: MediaQuery.of(context).size.width / 2,
                  child: Image.file(
                    artWork, fit: BoxFit.fill,)),
            ) : Center(
              child: Icon(
                Icons.add_a_photo, color: Colors.grey, size: 100,),
            ),
            onTap: () async {
              final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery);
              setState(() {
                if (pickedFile != null) {
                  artWork = File(pickedFile.path);
                }
              });
            },
          ),
          Form(
            key: _formKey,
            child: Container(
              height: 70,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.1,
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
                    hintText: "Enter a name for the art",
                    prefixIcon: Icon(Icons.person)),
                validator: (val) =>
                val.isEmpty ? 'Enter a name for the art' : null,
                textAlignVertical: TextAlignVertical.bottom,
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  if (artWork != null) {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    final imageString = ImageConverter.base64StringFromImage(
                        artWork.readAsBytesSync());
                    var body = jsonEncode({
                      "username": sharedPreferences.getString("username"),
                      "name": _nameTextController.text,
                      "artwork": imageString
                    });
                    print(body);
                    http.Response resPost = await http.post(
                        Uri.parse("http://40.83.89.182:8000/artwork"),
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
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
