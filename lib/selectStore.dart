import 'package:flutter/material.dart';
import 'package:immediacart/giveLocation.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/storePage.dart';



class SelectStore extends StatelessWidget {
  // This widget is the root of your application.
  Store store;
  SelectStore({this.store});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'ImmediaCart', store: this.store),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Store store;

  MyHomePage({Key key, this.title, this.store}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(store: this.store);
}

class _MyHomePageState extends State<MyHomePage> {

  Store store;
  _MyHomePageState({this.store});


  void _openCartMenu() {
    setState(() {});
  }

  void _returnToSetLocation() {
    runApp(LocationRegister());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: _returnToSetLocation),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: _openCartMenu),
        ],
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.green,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.black,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white))),
    child:BottomNavigationBar(

        items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home",)),
            BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Aisles",)),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Search",)),
          ],
        currentIndex: 0,
        ),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 350.0,
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Select Your Store",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: getStores())
          ],
        ),
      ),
    );
  }

  List<Widget> getStores(){
    List<Widget> list = [];
    Store s = new Store("Jewel Osco", "55 W. Kinzie St.");
    Container store = Container(color:Colors.green, padding: EdgeInsets.symmetric(vertical: 1),
        child: ListTile(
      leading: Text(s.name + "-" + s.address, style: TextStyle(fontSize: 18, color: Colors.white)),
      trailing: Icon(Icons.chevron_right),
      onTap: (){runApp(StorePage(store: s));},
    ));
    list.add(store);
    list.add(Divider(height: 2.0,));
    Store s2 = new Store("Whole Foods", "355 N. Jefferson St.");
    Container store2 = Container(color:Colors.green, padding: EdgeInsets.symmetric(vertical: 1.0),
        child: ListTile(
      leading: Text(s2.name + "-" + s2.address, style: TextStyle(fontSize: 18, color: Colors.white)),
      trailing: Icon(Icons.chevron_right),
          onTap: (){runApp(StorePage(store: s2));},
    ));
    list.add(store2);
    list.add(Divider(height: 2.0,));
    Store s3 = new Store("Mariano's", "425 N. Clinton St.");
    Container store3 = Container(color:Colors.green, padding: EdgeInsets.symmetric(vertical: 1),
        child: ListTile(
      leading: Text(s3.name + "-" + s3.address, style: TextStyle(fontSize: 18, color: Colors.white),),
      trailing: Icon(Icons.chevron_right),
          onTap: (){runApp(StorePage(store: s3));},
    ));
    list.add(store3);
    list.add(Divider(height: 2.0,));
    Store s4 = new Store("Alsi", "478 N. Clinton St.");
    Container store4 = Container(color:Colors.green, padding: EdgeInsets.symmetric(vertical: 1),
        child: ListTile(
      leading: Text(s4.name + "-" + s4.address, style: TextStyle(fontSize: 18, color: Colors.white)),
      trailing: Icon(Icons.chevron_right),
          onTap: (){runApp(StorePage(store: s4));},
    ));
    list.add(store4);

    return list;
  }

}

class Store{
  String name;
  String address;
  List<String> aisles;
  List<Item> items = [];
  List<Item> cart = [];

  Store(this.name, this.address){
    this.aisles = ["Baby Care", "Beverages", "Bread and Bakery", "Breakfast and Cereal",
    "Canned Goods and Soups", "Condiments and Spices", "Cooking Oils", "Dairy, Eggs, and Cheese",
    "Deli", "Flowers and Decor", "Frozen Foods", "Fruits and Vegetables", "Grains and Pastas", "Home Needs"];
  }

  // TODO: see if ishan or jordan want to make a bunch of data entries for this

}


class Item{
  int listItem;
  String name;
  double weight;
  double price;
  int quantity;
  String aisle;
  String ingredients;
  String details;
  String more;

  Item(this.listItem, this.name, this.weight, this.price, this.aisle, this.ingredients, this.details,
      this.more){
    quantity = 0;
  }

  void addToCart(){
    this.quantity++;
  }
  void removeFromCart() {
    if(this.quantity >0){
      this.quantity--;
    }
  }

}
