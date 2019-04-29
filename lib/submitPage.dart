import 'package:flutter/material.dart';
import 'package:immediacart/checkoutPage.dart';
import 'package:immediacart/finish.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/selectStore.dart';
import 'package:immediacart/storePage.dart';

class SubmitPage extends StatelessWidget {
  // This widget is the root of your application.
  List<Widget> cartItems;
  Store store;
  String deliveryDay;
  String deliveryWindow;
  int deliveryFee;

  SubmitPage({this.store, this.cartItems, this.deliveryDay,this.deliveryWindow, this.deliveryFee});

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
      home: MyHomePage(store: this.store, cartItems: this.cartItems, deliveryDay: this.deliveryDay,deliveryWindow: this.deliveryWindow, deliveryFee: this.deliveryFee),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<Widget> cartItems;
  MyHomePage({Key key, this.store, this.cartItems, this.deliveryDay,this.deliveryWindow, this.deliveryFee}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Store store;
  String deliveryDay;
  String deliveryWindow;
  int deliveryFee;

  @override
  _MyHomePageState createState() => _MyHomePageState(store: this.store, deliveryDay: this.deliveryDay,deliveryWindow: this.deliveryWindow, deliveryFee: this.deliveryFee);
}

class _MyHomePageState extends State<MyHomePage> {
  ListView items;
  Store store;
  String deliveryDay;
  String deliveryWindow;
  int deliveryFee;

  double subtotal = 0.00;
  double total = 0;

  _MyHomePageState({this.store, this.deliveryDay,this.deliveryWindow, this.deliveryFee});

  void _openTopRightMenu() {
    setState(() {});
  }

  void _returnToStore() {
    runApp(PickTime(
      store: this.store,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _recalculateTotal();
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Checkout"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios), onPressed: _returnToStore),
        ),
        bottomNavigationBar: Container(
          color: Colors.green,
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(child:Text("Delivery: \n"+ deliveryDay + "\n" + deliveryWindow,textAlign: TextAlign.left, style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
              )),
            ),
              Container(
                color: Colors.red,
                height: 50,
                width: 120,
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: (){runApp(FinishPage(store: this.store, deliveryDay: this.deliveryDay,deliveryWindow: this.deliveryWindow, deliveryFee: this.deliveryFee)
    );},
                  elevation: 15,
                  child: Text("Submit", style: TextStyle(color: Colors.white)),
                ),
              ),
      ]
          )),
        body: ListView(children: [page1()]));
  }

  Container page1() {
    List<Item> cartList = [];
    for (int i = 0; i < this.store.items.length; i++) {
      if (this.store.items[i].quantity != 0) {
        cartList.add(this.store.items[i]);
      }
    }
    _recalculateTotal();
    return _cartItems(cartList);

  }

  Container _cartItems(List<Item> list) {
    List<Widget> tileList = [];
    tileList.add(ListTile(
      title: Text("Grocery Items", style: TextStyle(
        fontSize: 21
      )),
    ));
    tileList.add(Divider(
      height: 2,
      color: Colors.black,
    ));
    for (int i=0; i<list.length; i++){
      tileList.add(ListTile(
        leading: Text(list[i].name + " ("+ list[i].quantity.toString() + r") x ($" + list[i].price.toStringAsFixed(2) + ")"),
        trailing: Text(r"$" + (list[i].price * list[i].quantity).toStringAsFixed(2)),
      ));
    }
    tileList.add(ListTile(
      title: Text("Service Charges", style: TextStyle(
          fontSize: 21
      )),
    ));
    tileList.add(Divider(
      height: 2,
      color: Colors.black,
    ));
    tileList.add(ListTile(
      leading: Text("App Service Fee"),
      trailing: Text(r"$5.00"),
      //trailing: ,
    ));
    tileList.add(ListTile(
      leading: Text("Delivery Fee"),
      trailing: Text(r"$" + deliveryFee.toStringAsFixed(2)),
    ));
    tileList.add(Divider(
      height: 10,
      color: Colors.black,
    ));
    tileList.add(ListTile(
      leading: Text("Subtotal"),
      trailing: Text(r"$" + (subtotal).toStringAsFixed(2)),
    ));
    tileList.add(ListTile(
      leading: Text("Cook County Tax (7%)"),
      trailing: Text(r"$" + (subtotal * 0.07).toStringAsFixed(2)),
    ));
    tileList.add(Divider(
      height: 1,
      color: Colors.black,
    ));
    tileList.add(ListTile(
      leading: Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      trailing: Text(r"$" + this.total.toStringAsFixed(2), style: TextStyle(
          fontSize: 18,
        fontWeight: FontWeight.bold
      )),
    ));
   return Container(
     child: Column(
       children: tileList
     )
   );
  }
  
  void _recalculateTotal(){
    setState(() {
      this.subtotal = 0.00;
      this.total = 0.00;
      for (int i = 0; i < this.store.items.length; i++){
        if (this.store.items[i].quantity != 0){
          this.subtotal += this.store.items[i].quantity * this.store.items[i].price;
        }
      }
      this.subtotal  = subtotal + 5 + deliveryFee;
      this.total = this.subtotal + (this.subtotal * 0.07);
    });
  }
}
