import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new MaterialApp(
    title: "Drowsiness-Detector",
    debugShowCheckedModeBanner: false,
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _picker = ImagePicker();
  File imageFile;
  _openGallery(BuildContext context) async {
    PickedFile picture = await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    PickedFile picture = await _picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No Image Selected");
    } else {
      return Image.file(
        imageFile,
        width: 400,
        height: 400,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drowsiness-Detector"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _decideImageView(),
              IconButton(
                icon: Icon(Icons.camera),
                iconSize: 50,
                onPressed: () {
                  _showChoiceDialog(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
