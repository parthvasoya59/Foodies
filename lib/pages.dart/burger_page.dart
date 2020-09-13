import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/home_page.dart';
import 'package:foodies/widgets/drawer_widget.dart';
import 'package:foodies/widgets/food_item_card.dart';
import 'package:foodies/widgets/product_top_info.dart';

import 'cart_page.dart';

class BurgerPage extends StatefulWidget {

  final String email;

  BurgerPage({this.email});

  @override
  _BurgerPageState createState() => _BurgerPageState(email: email);
}

class _BurgerPageState extends State<BurgerPage> {

  final String email;

  _BurgerPageState({this.email});
  
  // int count;

  

  ScrollController _scrollController = new ScrollController();

  // void returncount(){
  //   Stream _fire =  Firestore.instance.collection("burger").snapshots();
  //   count = _fire.length;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   returncount();
  // }

  @override
  Widget build(BuildContext context) {
    print("Burger 2 page email : $email");
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
          // controller: _scrollController,
          // shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            ProductTopInfo(txt1: "Big Burger",txt2: "Best Burger",email: email),
            StreamBuilder(
              
              stream: Firestore.instance.collection("burger").snapshots(),
              builder: (context,snapshot){
                if(snapshot.error != null){
                  return CircularProgressIndicator();
                }
                else if (!snapshot.hasData) {
                    return Text('Loading');
                }
                else{
                  return ListView.builder(
                    controller: _scrollController,
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
          ],
        ),
      ),
    );
  }
}