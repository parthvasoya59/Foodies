// import 'package:circular_profile_avatar/circular_profile_avatar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/burger_page.dart';
import 'package:foodies/pages.dart/cart_page.dart';
import 'package:foodies/pages.dart/dessert_page.dart';
import 'package:foodies/pages.dart/pizza_page.dart';
import 'package:foodies/pages.dart/sandwich_page.dart';
import 'package:foodies/widgets/drawer_widget.dart';
import 'package:foodies/widgets/food_item_card_home.dart';
import 'package:foodies/widgets/home_bottom_card.dart';


class HomePage extends StatefulWidget {


  final String email;
  HomePage({this.email});
  @override
  _HomePageState createState() => _HomePageState(email:email);
}

class _HomePageState extends State<HomePage> {
  final String email;
  _HomePageState({this.email});
  @override
  Widget build(BuildContext context) {
    print("Home email : $email");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.amber,size: 30.0),
        title: Text("Foodies ", style:  TextStyle(color: Colors.amber, fontSize: 30.0,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
             child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage(email:email,)));
                },
                child: Icon(Icons.shopping_cart)
              ),
           )

        ],
      ),
      drawer: Drawer(      
        child: DrawerWidget(email: email),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical : 16.0, horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('What would', style:TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold,)),
                        Text('You like to eat?', style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FoodItemCardHome(email: email,category: "Pizza",photo: "images/pizza-4.jpeg",),
                  FoodItemCardHome(email: email,category: "Sandwich",photo: "images/sandwich-2.jpeg",),
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FoodItemCardHome(email: email,category: "Burger",photo: "images/burger-3.jpeg",),
                  FoodItemCardHome(email: email,category: "Dessert",photo: "images/dessert-4.jpeg",),
                ],
              ),
              SizedBox(height: 40.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Freaquently Boughted Foods?", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.orangeAccent),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => PizzaPage(email:email,)));
                    },
                    child: Text("More foods", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.amber),))
                ],
              ),
              SizedBox(height:50.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => PizzaPage(email:email,)));
                },
                child: HomeBottomCard(photo: "images/pizza-6.jpeg",price: "120.0",name: "Margarita",)),
              SizedBox(height:30.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SandwichPage(email:email,)));
                },
                child: HomeBottomCard(photo: "images/sandwich-7.jpeg",price: "100.0",name: "Sandwich",)),
              SizedBox(height:30.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => BurgerPage(email:email,)));
                },
                child: HomeBottomCard(photo: "images/burger-6.jpeg",price: "65.0",name: "Virginia",)),
              SizedBox(height:30.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => DessertPage(email:email,)));
                },
                child: HomeBottomCard(photo: "images/dessert-1.jpeg",price: "75.0",name: "Cannoli",)),
              SizedBox(height:30.0),
            ],
          ),
        ),
      ),
    );
  }
}

// HomeBottomCard(photo: "images/pizza-6.jpeg",price: "120.0",name: "Margarita",),