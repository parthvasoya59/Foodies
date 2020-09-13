import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/adminorderitem_page.dart';
import 'package:foodies/widgets/drawer_widget.dart';

class AdminOrderPage extends StatefulWidget {

  final String email;

  AdminOrderPage({this.email});
  @override
  _AdminOrderPageState createState() => _AdminOrderPageState();
}

class _AdminOrderPageState extends State<AdminOrderPage> {

  ScrollController _scrollController = new ScrollController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar:AppBar(
          iconTheme: new IconThemeData(color: Colors.amber,size: 30.0),
          title: Text(" Admin Order Page ", style:  TextStyle(color: Colors.amber, fontSize: 30.0,fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
              child: GestureDetector(
                  onTap: (){
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage(email: widget.email,)));
                  },
                  child: Icon(Icons.notifications)
                ),
            ),
          ],
        ),
        drawer: Drawer(      
          child: DrawerWidget(email: widget.email),
        ),
        body: Column(
          children: <Widget>[
            Text("All Order placed by Customers"),
            SizedBox(height: 30.0),
            StreamBuilder(
              stream: Firestore.instance.collection("admin").snapshots(),
              builder: (context,snapshot){
                if(snapshot.error != null){
                  return CircularProgressIndicator();
                }
                else if (!snapshot.hasData) {
                    print("Loading..............");
                    return Text('Loading');
                }
                else{
                  return Column(
                    children: <Widget>[
                      ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index){
                          print("In admin order page above datasnapshot...........................................");
                          DocumentSnapshot documentSnapshot =  snapshot.data.documents[index];
                          print("In admin order page in item count.....${snapshot.data.documents.length}");
                          print("In admin order page in index.....$index");
                          print("In admin order page in listview.....");
                          // print("In admin order page documentId ....:${documentSnapshot.documentID} ");
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => AdminOrderItemPage(email: documentSnapshot.documentID,)));
                            },
                            child: Column(
                              children: <Widget>[
                                Text("data"),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Email: ${documentSnapshot.documentID}"),
                                  ),
                                ),
                              ],
                            ),
                          );//AdminOrderPage(email:documentSnapshot.documentID);
                        }
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
    );
  }
}