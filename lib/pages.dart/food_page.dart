import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodies/pages.dart/cart_page.dart';
import 'package:foodies/widgets/button.dart';


class FoodPage extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String category;
  final String photo;
  final String email;

  FoodPage({this.name,this.description,this.price,this.category,this.photo,this.email});

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  
  String _downloadUrl;

  Future downloadImage() async {
    String downloadAddress;
    StorageReference _reference;  FirebaseStorage.instance.ref().child('${widget.photo}');
    try{
      _reference =   FirebaseStorage.instance.ref().child('${widget.photo}');
      downloadAddress = await _reference.getDownloadURL();
    }catch(e){
      _reference =  FirebaseStorage.instance.ref().child("no-image.jpeg");
      downloadAddress = await _reference.getDownloadURL();
    }
    setState(() {
      _downloadUrl = downloadAddress;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadImage();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBarfirsrtadd() {
    print("Snackbar....");
    final snackBar = new SnackBar(
      content: Container(
        height: 40.0,
        child: Center(child: Text("Item added into cart.", style: TextStyle(fontSize: 20.0),))
      ),
      duration: new Duration(seconds: 1,milliseconds: 300),
      backgroundColor: Colors.amber,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _showSnackBaralreadyadd() {
    print("Snackbar....");
    final snackBar = new SnackBar(
      content: Container(
        height: 40.0,
        child: Center(child: Text("Item already added into cart.", style: TextStyle(fontSize: 20.0),))
      ),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.amber,
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    print("My email : ${widget.email}");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart), 
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage(email: widget.email,)));
            },
          )
        ],
        iconTheme: IconThemeData(color:Colors.amber),
        title: Text("${widget.category}", style: TextStyle(color: Colors.amber,fontSize: 30.0),),
        centerTitle: true,
        backgroundColor: Colors.white12,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text("${widget.name}",style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,color: Colors.amber),),
                SizedBox(height: 20.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: _downloadUrl == null ? Image.asset("images/no-image.jpeg") : Image.network(_downloadUrl),
                    // child: Image.network("https://image.shutterstock.com/image-photo/white-transparent-leaf-on-mirror-260nw-1029171697.jpg"),
                  ),
                ),
                SizedBox(height: 30.0),
                Text("Description : ",style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,color: Colors.amber),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                  child: Text("${widget.description}",style: TextStyle(fontSize:18.0),),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Text("Price : ",style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,color: Colors.amber),),
                    SizedBox(width: 15.0),
                    Text("${widget.price} Rs. ",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.amber),),
                  ],
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                  // onTap: (){
                  //   // Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage(name: name,category: category,description: description,photo: photo,price: price)));
                    
                  // },
                  onTap: (){
                    createData();
                  },
                  child: Button(btnText: "Add To Cart")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createData() async {

    // Map<String,dynamic> totalprice;
    // int calprice,fetchprice;
    int flag = 0;
    print("created");
    // String lowercasecategory = category.toLowerCase();

      //name means in firebase document name 

    print("${widget.email}");

    CollectionReference collectionReference = Firestore.
    instance.collection("users").document("${widget.email}").collection("cart");  //name means in firebase document name 

    collectionReference.getDocuments().then((dataSnapshot){
      List<DocumentSnapshot> nammee =dataSnapshot.documents;
      
      if(nammee.length == 0){

        print("list not contains data ....");
        
        DocumentReference documentReference = Firestore.
        instance.collection("users").document("${widget.email}").collection("cart").document(widget.name);

        documentReference.get().then((dataSnapshot){
      
          Map<String,dynamic> products = {
              "name": widget.name,
              "category": widget.category,
              "price": widget.price,
              "photo": widget.photo,
              "description": widget.description,
              "item":"1",
              "total":widget.price
            };

            documentReference.setData(products).whenComplete((){
              print("$products added by food_page");
              _showSnackBarfirsrtadd();
            });
          
        });

        DocumentReference documentReferenceprice = Firestore.
        instance.collection("users").document("${widget.email}").collection("prices").document("price");

        

        documentReferenceprice.get().then((datasnapshot) {

          documentReference.get().then((dataSnapshot){
             
              print("In price refrence...");
                int calprice;
                
                if(datasnapshot.data['price'] == '0'){
                  calprice = int.parse(widget.price);
                  print("In price refrence null calprice ... : $calprice");
                }
                else{
                  calprice = int.parse(datasnapshot.data['price'])+int.parse(widget.price);
                  print("In price refrence calprice ... : $calprice");
                }

                Map<String,dynamic> totalprice = {
                  "price":calprice.toString()
                };

                documentReferenceprice.setData(totalprice).whenComplete((){});
              
          });
          
        });
      }
      else{
        nammee.forEach((element){

        String nm = element.data['name'];

        if(nm == '${widget.name}'){
          print("Already exist");
          flag=1;
          _showSnackBaralreadyadd();
        }
      }); 

      if(flag == 0){

        print("In else list contain data but not this .....");

        DocumentReference documentReference = Firestore.
        instance.collection("users").document("${widget.email}").collection("cart").document(widget.name);

        documentReference.get().then((dataSnapshot){
      
          Map<String,dynamic> products = {
              "name": widget.name,
              "category": widget.category,
              "price": widget.price,
              "photo": widget.photo,
              "description": widget.description,
              "item":"1",
              "total":widget.price
            };

            documentReference.setData(products).whenComplete((){
              print("$products added by food_page");
              _showSnackBarfirsrtadd();
            });
          
        });

        DocumentReference documentReferenceprice = Firestore.
        instance.collection("users").document("${widget.email}").collection("prices").document("price");

        

        documentReferenceprice.get().then((datasnapshot) {

          documentReference.get().then((dataSnapshot){
             
              print("In price refrence...");
                int calprice;
                
                if(datasnapshot.data['price'] == '0'){
                  calprice = int.parse(widget.price);
                  print("In price refrence null calprice ... : $calprice");
                }
                else{
                  calprice = int.parse(datasnapshot.data['price'])+int.parse(widget.price);
                  print("In price refrence calprice ... : $calprice");
                }

                Map<String,dynamic> totalprice = {
                  "price":calprice.toString()
                };

                documentReferenceprice.setData(totalprice).whenComplete((){});
              
          });
          
        });
        
      }
      else{
        flag = 0;
        print("Set flag = 0");
      }

      }
    }
  );
    
  }

}
