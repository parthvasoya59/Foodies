import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/cart_page.dart';
import 'package:foodies/widgets/drawer_widget.dart';

class PastHistoryPage extends StatefulWidget {
  
  final String email;
  PastHistoryPage({this.email});
  
  @override
  _PastHistoryPageState createState() => _PastHistoryPageState(email: email);
}

class _PastHistoryPageState extends State<PastHistoryPage> {

  final String email;
  _PastHistoryPageState({this.email});

  ScrollController _scrollController = new ScrollController();

  String id,first,second,third,fourth,fifth;
  

  @override
  void initState() {
    DocumentReference documentReferenceid = Firestore.
    instance.collection("users").document("$email").collection("checkout").document("id");

    documentReferenceid.get().then((datasnapshot){
      setState(() {
        id = datasnapshot.data["nooftimes"];
        print("id....:$id");
        first = (int.parse(id)-0).toString();
        second = (int.parse(id)-1).toString();
        third = (int.parse(id)-2).toString();
        fourth = (int.parse(id)-3).toString();
        fifth = (int.parse(id)-4).toString();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.amber,size: 30.0),
        title: Text("Past Orders ", style:  TextStyle(color: Colors.amber, fontSize: 30.0,fontWeight: FontWeight.bold),),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text("Last 5 Orders",style: TextStyle(fontSize:30),),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.only(left: 30.0,right: 30.0,bottom: 30.0),
              child: Column(
                children: <Widget>[
                  Card(child: fetch(first),elevation: 5,),
                  SizedBox(height: 20.0,),
                  Card(child: fetch(second),elevation: 5,),
                  SizedBox(height: 20.0,),
                  Card(child: fetch(third),elevation: 5,),
                  SizedBox(height: 20.0,),
                  Card(child: fetch(fourth),elevation: 5.0,),
                  SizedBox(height: 20.0,),
                  Card(child: fetch(fifth),elevation: 5.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder fetch(String id){
    return StreamBuilder(
      stream: Firestore.instance.collection("pasthistory").document("$email").collection("$id").snapshots(),
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
              print("Item add in list in pasthistory page");

              return Container(
                // width: MediaQuery.of(context).size.width/2,
                // margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text("Name : ${documentSnapshot["name"]}"),
                    SizedBox(height:10.0),
                    Text("Item : ${documentSnapshot["item"]}")
                  ],
                ),
              );
            }
          );
        }
      },
    );
  }
}