// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodies/widgets/drawer_widget.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';


class AdminPage extends StatefulWidget {

  final String email;

  AdminPage({this.email});
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  String name,category,price,photo,description,lowercasecategory;

  // _HomePageState({this.name,this.category,this.price,this.photo,this.description});

 /* File _imageFile;
  bool _uploaded = false;
  String _downloadUrl;
  

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
    StorageReference _reference = FirebaseStorage.instance.ref().child('$photo');
    StorageUploadTask uploadTask = _reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      _uploaded = true;
    });
  }

  Future downloadImage() async {
    StorageReference _reference = FirebaseStorage.instance.ref().child('$photo');
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downloadUrl = downloadAddress;
    });
  }
*/
  getName(name){
    this.name= name;
    // this.photo=name+'.jpg';
  }
  getCategory(category){
    this.category = category;
    lowercasecategory = category.toLowerCase();
  }
  getPrice(price){
    this.price= price;
  }
  getPhoto(photo){
    this.photo= photo;
  }
  getDescription(description){
    this.description= description;
  }

  createData() {
    
    print("created");
    String lowercasecategory = category.toLowerCase();

    DocumentReference documentReference = Firestore.
    instance.collection("$lowercasecategory").document(name);  //name means in firebase document name 
    
    Map<String,dynamic> products = {
      "name": name,
      "category": category,
      "price": price,
      "photo": photo,
      "description": description
    };

    documentReference.setData(products).whenComplete((){
      print("$products added");
    });
    
  }
  
  readData() {
    print("read");

    DocumentReference documentReference = Firestore.
    instance.collection("$lowercasecategory").document(name);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data["name"]);
      print(datasnapshot.data["category"]);
      print(datasnapshot.data["price"]);
      print(datasnapshot.data["photo"]);
      print(datasnapshot.data["description"]);
    });

  }

  updateData(){
    print("update");

    DocumentReference documentReference = Firestore.
    instance.collection("$lowercasecategory").document(name);  //name means in firebase document name 

    Map<String,dynamic> products ={
      "name": name,
      "category": category,
      "price": price,
      "photo": photo,
      "description": description
    };

    documentReference.setData(products).whenComplete((){
      print("$products added");
    });
  }
  deleteData(){
    print("delete");
    DocumentReference documentReference = Firestore.
    instance.collection("$lowercasecategory").document(name);

    documentReference.delete().whenComplete((){
      print("name deleted");
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage",style:TextStyle(color:Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      drawer: DrawerWidget(email: widget.email),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              // Text("Food Name"),
              // Text("Food Category"),
              // Text("Food Price"),
              // Text("Food Photo"),
              // Text("Food Description"),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Food Name"
                ),
                onChanged: (String name){
                  getName(name);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Food Category"
                ),
                onChanged: (String category){
                  getCategory(category);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Food Price"
                ),
                onChanged: (String price){
                  getPrice(price);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Food Photo"
                ),
                onChanged: (String photo){
                  getPhoto(photo);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Food Description"
                ),
                onChanged: (String description){
                  getDescription(description);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){
                      createData();
                    },
                    child: Text("Create"),
                  ),
                  RaisedButton(
                    onPressed: (){
                      readData();
                    },
                    child: Text("Read"),
                  ),
                  RaisedButton(
                    onPressed: (){
                      updateData();
                    },
                    child: Text("Update"),
                  ),
                  RaisedButton(
                    onPressed: (){
                      deleteData();
                    },
                    child: Text("Delete"),
                  ),
                ],
              ),
              StreamBuilder(
                stream: Firestore.instance.collection("pizza").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot = snapshot.data.documents[index];

                        return Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Expanded(
                              child: Text(documentSnapshot["name"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["category"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["price"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["photo"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["description"]),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else{
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
              /*SingleChildScrollView(
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
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}