import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/cart_page.dart';
import 'package:foodies/pages.dart/home_page.dart';

class AdminOrderItemPage extends StatefulWidget {

  final String email; 

  AdminOrderItemPage({this.email});
  @override
  _AdminOrderItemState createState() => _AdminOrderItemState(email: email);
}

class _AdminOrderItemState extends State<AdminOrderItemPage> {

  final String email; 

  _AdminOrderItemState({this.email});

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        iconTheme: new IconThemeData(color: Colors.amber,size: 30.0),
        title: Text("$email Customer Order ", style:  TextStyle(color: Colors.amber, fontSize: 30.0,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: onpreparedclick,
                child: myButton("Prepared")
              ),
              GestureDetector(
                onTap: ondeliverclick,
                child: myButton("Deliver")
              ),
            ],
          ),
          StreamBuilder(
            stream: Firestore.instance.collection("admin").document("$email").collection("order").snapshots(),
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
                    print("pizza email : $email");
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            Text("Name: ${documentSnapshot.data["name"]}"),
                            SizedBox(height: 20.0),
                            Text("Item: ${documentSnapshot.data["item"]}"),
                            SizedBox(height: 20.0),
                          ]
                        ),
                      ),
                    );
                  }
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget myButton(String btnText){
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width/2.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.amber
      ),
      child: Center(
        child: Text(
          "$btnText",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }


  void onpreparedclick(){

    DocumentReference documentReference = Firestore.
      instance.collection("users").document("$email").collection("status").document("status");

    documentReference.get().then((dataSnapshot){
      // String first = dataSnapshot.data["first"];
      // String second = dataSnapshot.data["second"];
      // String third = dataSnapshot.data["third"];
      // if(second == "0"){
        Map<String,dynamic> status = {
          "first": "1",
          "second": "1",
          "third": "0"
        };

        documentReference.setData(status);
      // }
    }); 

  }

  void ondeliverclick() async {

    DocumentReference documentReference = Firestore.
      instance.collection("users").document("$email").collection("status").document("status");

        //Status all set zero
        Map<String,dynamic> status = {
          "first": "0",
          "second": "0",
          "third": "0"
        };

        documentReference.setData(status);
        
        String id;
        //for click to set zero
        DocumentReference documentReferencecheckout = Firestore.
        instance.collection("users").document("$email").collection("checkout").document("id");

        documentReferencecheckout.get().then((dataSnapshot)async {
          String nooftimes = dataSnapshot.data["nooftimes"];
          id = nooftimes;
          Map<String,dynamic> setclick = {
            "nooftimes": nooftimes,
            "click": "0" //Set click to Zero
          };

          documentReferencecheckout.setData(setclick).whenComplete((){
            print("Admin click on delivered and click set to 0.....");
          });

          //data move to past history
          QuerySnapshot querySnapshot = await Firestore.
          instance.collection("users").document("$email").collection("cart").getDocuments();

          for (int i = 0; i < querySnapshot.documents.length; i++) {
            var a = querySnapshot.documents[i];
            // print(a.documentID);

            DocumentReference documentReference = Firestore.
            instance.collection("users").document("$email").collection("cart").document("${a.documentID}");
            documentReference.get().then((dataSnapshot){
              
              DocumentReference documentReference1 = Firestore.
              instance.collection("pasthistory").document("$email").collection("$id").document("${a.documentID}");
              
              documentReference1.setData(dataSnapshot.data).whenComplete((){
              print("Complete.......");
              documentReference.delete().whenComplete((){
                print("Delete...");
              });
            });

          });
          
          }
        });

        //Delete all items in admin order
        Firestore.instance.collection("admin").document("$email").collection("order").getDocuments()
        .then((snapshot){
          for(DocumentSnapshot ds in snapshot.documents){
            ds.reference.delete();
          }
        });
        
        //Set price equal to zero 
        DocumentReference documentReferenceprice = Firestore.
        instance.collection("users").document("$email").collection("prices").document("price");

        Map<String,dynamic> totalprice = {
          "price":"0"
        };

        documentReferenceprice.setData(totalprice).whenComplete((){
          print("Price set zero after third click...");
        });

        //Delete items from admin
        DocumentReference documentReference1 = Firestore.
            instance.collection("admin").document("$email");
            documentReference1.delete().whenComplete((){
              print("Delete order items in admin when click on third.....");
            });



        // DocumentReference documentReferencecart = Firestore.
        // instance.collection("users").document("$email").collection("cart").document();

        // documentReferencecart.get().then((dataSnapshot){

        //   DocumentReference documentReferencepasthistory = Firestore.
        //   instance.collection("past history").document("$email").collection("$id").document();
        // });
       
  }

}