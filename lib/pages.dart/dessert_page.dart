import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/cart_page.dart';
import 'package:foodies/widgets/drawer_widget.dart';
import 'package:foodies/widgets/food_item_card.dart';
import 'package:foodies/widgets/product_top_info.dart';

import 'home_page.dart';

class DessertPage extends StatefulWidget {

  final String email;

  DessertPage({this.email});

  @override
  _DessertPageState createState() => _DessertPageState(email: email);
}

class _DessertPageState extends State<DessertPage> {

  final String email;

  _DessertPageState({this.email});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          iconTheme: new IconThemeData(color: Colors.amber,size: 30.0),
          title: Text(" Products ", style:  TextStyle(color: Colors.amber, fontSize: 30.0,fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 6.0),
              child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(email: email,)));
                      },
                      child: Icon(Icons.home,size: 30.0,color: Colors.amber,)
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
              child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage(email: email,)));
                  },
                  child: Icon(Icons.shopping_cart)
                ),
            )
          ],
        ),
        drawer: Drawer(      
          child: DrawerWidget(email: email),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            ProductTopInfo(txt1: "Big Dessert",txt2: "Best Dessert",email: email),
            SingleChildScrollView(
              child: StreamBuilder(
                stream: Firestore.instance.collection("dessert").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.error != null){
                    return CircularProgressIndicator();
                  }
                  else if (!snapshot.hasData) {
                      return Text('Loading');
                  }
                  else{
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                        return FoodItemCard(name: documentSnapshot["name"],description: documentSnapshot["description"],price: documentSnapshot["price"],category:documentSnapshot["category"],photo: documentSnapshot["photo"],email: email,);
                      }
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}