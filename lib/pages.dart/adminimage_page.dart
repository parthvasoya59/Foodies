import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File _imageFile;
  bool _uploaded = false;
  String _downloadUrl;
  StorageReference _reference = FirebaseStorage.instance.ref().child('myimage.jpg');

  Future getImage (bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imageFile = image;
    });
  }

  Future uploadImage() async {
    StorageUploadTask uploadTask = _reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      _uploaded = true;
    });
  }

  Future downloadImage() async {
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downloadUrl = downloadAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Image"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Camera"),
                onPressed: (){
                  getImage(true);
                }
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text("Gallery"),
                onPressed: (){
                  getImage(false);
                }
              ),
              _imageFile == null ? Container() : Image.file(_imageFile, height: 300.0,width:300.0),
              _imageFile == null ? Container() : RaisedButton(
                child: Text("Upload to storage"),
                onPressed: (){
                  uploadImage();
                }
              ),
              _uploaded == false ? Container() : RaisedButton(
                child: Text("Download Image"),
                onPressed: (){
                  downloadImage();
                }
              ),
              _downloadUrl == null ? Container() : Image.network(_downloadUrl),
            ],
          ),
        ),
      ),
    );
  }
}