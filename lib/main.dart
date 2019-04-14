import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };
  runApp(CameraPage());
}

class CameraPage extends StatefulWidget {
  @override
  CameraPageState createState() {
    return CameraPageState();
  }
}

class CameraPageState extends State<CameraPage> {
  File image;

  openCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  openFileExplorer() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Picker'),
        ),
        body: Container(
          child: Center(
            child:
            image == null ? Text('No Image to Show ') : Image.file(image),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openCamera,
          child: Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  Future<void> _showImagePickingOptions() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose an option"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {

                          Navigator.pop(context);
                        },
                        child: Text(
                          "Camera",
                          style:
                          TextStyle(color: Colors.purple, fontSize: 20.0),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          openFileExplorer();
                          Navigator.pop(context);
                        },
                        child: Text("File Explorer",
                            style: TextStyle(
                                color: Colors.purple, fontSize: 20.0))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.purple, fontSize: 20.0))),
                  ),
                ],
              ),
            ),
          );
        });
  }
}