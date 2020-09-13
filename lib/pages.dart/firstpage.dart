import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/home_page.dart';
import 'package:foodies/pages.dart/signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     void sharedata () async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        print(sharedPreferences.getKeys());
        if(sharedPreferences.getKeys().contains("signin")){
          print("contain sign in value");
          if(sharedPreferences.getString("signin") == "true"){
            String email = sharedPreferences.getString("email");
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(email: email,)));
          }
          else{
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignInPage()));
          }
        }
        else{
          print("not contain sign in value");
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignInPage()));
        }
      }

    Future.delayed(const Duration(seconds: 1), () {

      setState(()  {
        print("In first page In setstate after 1 seconds....");

        sharedata();
        // Navigator.push(context,MaterialPageRoute(builder: (context) => SignInPage()));
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/4,),
              Image(image: AssetImage("images/whitelogo1.png")),
              Text(
                "Foodies",
                style: TextStyle(fontSize: 50.0,color: Colors.white70,fontWeight: FontWeight.bold),
              ),
            ],
          )
        ),
      ),
    );
  }
}