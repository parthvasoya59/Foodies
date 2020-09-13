import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/admin_order_page.dart';
import 'package:foodies/pages.dart/firstpage.dart';
import 'package:foodies/pages.dart/pasthistory_page.dart';
import 'package:foodies/pages.dart/status_page.dart';
// import 'package:foodies/pages.dart/home_page.dart';
// import 'package:foodies/widgets/profile_page.dart';
// import 'package:foodies/widgets/food_item_card_home.dart';
// import 'package:foodies/pages.dart/signin_page.dart';
// import 'package:foodies/pages.dart/cart_page.dart';
// import 'package:foodies/pages.dart/random.dart';
// import 'package:foodies/pages.dart/welcome.dart';
// import 'package:foodies/pages.dart/admin_page.dart';
// import 'package:foodies/pages.dart/adminimage_page.dart';
// import 'package:foodies/pages.dart/pizza_page.dart';
// import 'package:foodies/pages.dart/signin.dart';
// import 'package:foodies/pages.dart/welcome.dart';
// import 'package:foodies/pages.dart/pizza_page.dart';
// import 'package:foodies/pages.dart/admin_page.dart';
// import 'package:foodies/pages.dart/product_page.dart';
// import 'package:foodies/pages.dart/signin_page.dart';
// import 'package:foodies/pages.dart/signup_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food App",
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(),
      // home: AdminPage(),
      // home: PizzaPage(),
      // home: AdminnPage(),
      // home: WelcomePage(),
      // home: CartPage(email: "poxvox134@gmail.com"),
      // home: SignInPage(),
      // home:HomePage(),
      // home: FoodItemCardHome(),
      // home: ProfilePage(),
      home: FirstPage(),
      // home: StatusPage(),
      // home: AdminOrderPage(email: "poxvox134@gmail.com",)
      // home: PastHistoryPage(email: "poxvox59@gmail.com"),
    );
  }
}