import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/cart_page.dart';
import 'package:foodies/pages.dart/home_page.dart';
import 'package:foodies/widgets/drawer_widget.dart';
import 'package:foodies/widgets/food_item_card.dart';
import 'package:foodies/widgets/product_top_info.dart';

class PizzaPage extends StatefulWidget {

  final String email;

  PizzaPage({this.email});

  @override
  _PizzaPageState createState() => _PizzaPageState(email: email);
}

class _PizzaPageState extends State<PizzaPage> {

  final String email;

  _PizzaPageState({this.email});

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    print("Pizza 1 email: $email");
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
            ),
          ],
        ),
        drawer: Drawer(      
          child: DrawerWidget(email: email),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            ProductTopInfo(txt1: "Big Pizza",txt2: "Best Pizza",email: email,),
            // FoodItemCard(name: "Margarita",description: "It's too hot",price: "120",category:"Pizza",photo: "images/breakfast.jpeg"),

            StreamBuilder(
              stream: Firestore.instance.collection("pizza").snapshots(),
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
                    // scrollDirection: Axis.vertical,
                    // physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                      print("pizza email : $email");
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
