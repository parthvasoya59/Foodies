import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/home_page.dart';
import 'package:foodies/widgets/drawer_widget.dart';
import 'package:foodies/widgets/order_card.dart';


class CartPage extends StatefulWidget {

  final String email;
  
  
  CartPage({this.email});

  @override
  _CartPageState createState() => _CartPageState(email: email);
}

class _CartPageState extends State<CartPage> {

  final String email;

  _CartPageState({this.email});
  
  int total =0,count=0,item=1;


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBarorderplaced() {
    print("Snackbar....");
    final snackBar = new SnackBar(
      content: Container(
        height: 40.0,
        child: Center(child: Text("Your Order placed.", style: TextStyle(fontSize: 20.0),))
      ),
      duration: new Duration(seconds: 1,milliseconds: 300),
      backgroundColor: Colors.amber,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _showSnackBarnotorderplaced() {
    print("Snackbar....");
    final snackBar = new SnackBar(
      content: Container(
        height: 50.0,
        child: Center(child: Text("Your cart is empty or already this order is placed check status.", style: TextStyle(fontSize: 20.0),))
      ),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.amber,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  ScrollController _scrollController = new ScrollController();

  // String finaltotal;


  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      //  total = total;
      DocumentReference documentReferenceprice = Firestore.
      instance.collection("users").document("$email").collection("prices").document("price");

      documentReferenceprice.get().then((datasnapshot){
        total = int.parse(datasnapshot.data['price']);
      });

    });
  }

  @override
  void initState() {
    refreshList();
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
        appBar:AppBar(
          iconTheme: new IconThemeData(color: Colors.amber,size: 30.0),
          title: Text(" Shoping  ", style:  TextStyle(color: Colors.amber, fontSize: 30.0,fontWeight: FontWeight.bold),),
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
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              StreamBuilder(
                stream: Firestore.instance.collection("users").document(email).collection("cart").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot = snapshot.data.documents[index];

                        if(total==0 || count<snapshot.data.documents.length )
                        {
                          print("length...: ${snapshot.data.documents.length}");
                          // setState(() {
                            total  += int.parse(documentSnapshot["total"]); 
                            count++;  
                          // });
                        }
                        
                        return OrderCard(name: documentSnapshot["name"],price: documentSnapshot["price"],photo: documentSnapshot["photo"], category: documentSnapshot["category"],description: documentSnapshot["description"],email: email,item: documentSnapshot["item"],total: documentSnapshot["total"],);
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
              SizedBox(height: 20.0),
              _buildContainer(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildContainer(){
    return Container(
      height: 220.0,
      margin: EdgeInsets.only(top:20.0),
      padding: EdgeInsets.symmetric(horizontal:10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Card Total", style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
              // Text(returntotal() ?? '0',  style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: Colors.black),),
              Text("$total",  style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Discount", style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
              Text("-0.0",  style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Tax", style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: Colors.grey),),
              Text("+0.0",  style: TextStyle(fontSize:16.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ],
          ),
          Divider(height: 40.0,color: Color(0xFFD3D3D3),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Final Total", style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold, color: Colors.grey),),
              Text("Rs. $total",  style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ],
          ),
          SizedBox(height: 25.0,),
          GestureDetector(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context) => SignInPage()));
            },
            child: GestureDetector(
              onTap: checkoutincrease,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    "Proceed To Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0, 
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkoutincrease() {
    //For click
    print("Click on checkout...");
    String click;
    DocumentReference documentReferencecheckout = Firestore.
      instance.collection("users").document("$email").collection("checkout").document("id");
    documentReferencecheckout.get().then((datasnapshot)async{
      click=datasnapshot.data["click"];

      if(click == "0"){
      
      DocumentReference documentReferencecheckout = Firestore.
      instance.collection("users").document("$email").collection("checkout").document("id");

      documentReferencecheckout.get().then((dataSnapshot){
      
        String id = (int.parse(dataSnapshot.data["nooftimes"]) + 1).toString();
        
        Map<String,dynamic> nooftimes = {
          "nooftimes": id,
          "click": "1"
        };

        documentReferencecheckout.setData(nooftimes).whenComplete((){
          print("Checkout increase");
          _showSnackBarorderplaced();
        });
      
      });  

      //in status first = 1
      DocumentReference documentReference = Firestore.
      instance.collection("users").document("$email").collection("status").document("status");

        //Status all set zero
        Map<String,dynamic> status = {
          "first": "1",
          "second": "0",
          "third": "0"
        };

        documentReference.setData(status);



      //Data copy into in admin order

      QuerySnapshot querySnapshot = await Firestore.
      instance.collection("users").document("$email").collection("cart").getDocuments();

      for (int i = 0; i < querySnapshot.documents.length; i++) {
          var a = querySnapshot.documents[i];
          // print(a.documentID);

          DocumentReference documentReference = Firestore.
          instance.collection("users").document("$email").collection("cart").document("${a.documentID}");
          documentReference.get().then((dataSnapshot){

            DocumentReference documentReferencetry = Firestore.
            instance.collection("admin").document("$email");

            Map<String,dynamic> tryyy = {
              "justtry" : "0"
            };

            documentReferencetry.setData(tryyy).then((data){
              print("try set data");
            });

            DocumentReference documentReference1 = Firestore.
            instance.collection("admin").document("$email").collection("order").document("${a.documentID}");
            
            documentReference1.setData(dataSnapshot.data).whenComplete((){
            print("Complete.......");
            
          });

        });
        
        }
    }else{
      _showSnackBarnotorderplaced();
    }
    });
  }

}

// documentSnapshot["name"]