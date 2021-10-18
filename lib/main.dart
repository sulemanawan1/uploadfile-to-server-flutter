
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Upload File',
    home: Scaffold(appBar: AppBar(title: Text('Upload File'),
    ),body: Column(children: [
FlatButton(onPressed: getImage, child: Text('Get Image from gallery')),





    ],

    ),

    ),);
  }

  Future getImage() async {
  File _image;
    final picker = ImagePicker();

    var _pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500,  // <- reduce the image size
        maxWidth: 500);

  _image =  File(_pickedFile!.path);


    _upload(_image);

  }

  void _upload(File file) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();

    dio.post("http://172.19.224.1/fileupload/api/image/uploadfiles", data: data)
        .then((response) => print(response))
        .catchError((error) => print(error));
  }}