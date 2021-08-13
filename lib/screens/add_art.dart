import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddArtWork extends StatefulWidget {
  @override
  _AddArtWorkState createState() => _AddArtWorkState();
}

class _AddArtWorkState extends State<AddArtWork> {

  File artWork;
  bool isSelected = false;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          InkWell(
            child: CircleAvatar(
              backgroundImage: isSelected ? artWork : Icon(Icons.add_a_photo),
            ),
            onTap: () async {
              File pickedFile = await picker.pickImage(
                  source: ImageSource.gallery) as File;
              setState(() {
                if (pickedFile != null) {
                  artWork = pickedFile;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
