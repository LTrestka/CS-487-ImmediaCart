import 'package:flutter/material.dart';
import 'package:immediacart/checkoutPage.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/selectStore.dart';
import 'package:immediacart/storePage.dart';

class CartPage extends StatelessWidget {
  // This widget is the root of your application.
  List<Widget> cartItems;
  Store store;

  CartPage({this.store, this.cartItems});

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
      home: MyHomePage(store: this.store, cartItems: this.cartItems),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<Widget> cartItems;
  MyHomePage({Key key, this.store, this.cartItems}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Store store;

  @override
  _MyHomePageState createState() => _MyHomePageState(store: this.store);
}

class _MyHomePageState extends State<MyHomePage> {
  ListView items;
  Store store;

  double subtotal = 0.00;
  double total = 0;

  _MyHomePageState({this.store});

  void _openTopRightMenu() {
    setState(() {});
  }

  void _returnToStore() {
    runApp(StorePage(
      store: this.store,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _recalculateTotal();
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios), onPressed: _returnToStore),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _openTopRightMenu),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.green,
          height: 70.0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 3.0, color: Colors.greenAccent),
                      left: BorderSide(width: 3.0, color: Colors.greenAccent),
                      right: BorderSide(width: 3.0, color: Colors.greenAccent),
                      bottom: BorderSide(width: 3.0, color: Colors.greenAccent),
                    ),
                  ),
                  //color: Colors.white,
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text("Estimated Price\t" + r"$" + total.toStringAsFixed(2),textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(
                  height: 50,
                    width: 150,
                    child: RaisedButton(
                      elevation: 25,
                  color: Colors.red,
                  child: Center(
                    child: Text("Check Out",textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                      onPressed: (){runApp(PickTime(store: this.store));},
                )
                )
              ],
            ),
          ),
        ),
        body: ListView(children: [page1()]));
  }

  ListView page1() {
    List<Item> cartList = [];
    for (int i = 0; i < this.store.items.length; i++) {
      if (this.store.items[i].quantity != 0) {
        cartList.add(this.store.items[i]);
      }
    }
    _recalculateTotal();
    return _cartItems(cartList);

  }

  ListView _cartItems(List<Item> list) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            leading: Icon(
              Icons.fastfood,
              size: 50,
            ),
            title: Column(
              children: <Widget>[
                Divider(
                  height: 15,
                ),
                Center(
                  child: Text(list[index].name), // item name
                ),
                Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                Center(
                  child: Text(r"$" + list[index].price.toString()), // item price
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        _removeFromCart(list[index].listItem);
                      }, // add item to cart
                      color: Colors.red,
                    ),
                    Container(
                      width: 50,
                      child: Center(
                        child: Text(list[index].quantity.toString()),
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        _addToCart(list[index].listItem);
                      }, // add item to cart
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
  void _addToCart(int i) {
    setState(() {
      this.store.items[i].addToCart();
      _recalculateTotal();
    });
  }
  void _removeFromCart(int i) {
    setState(() {
      this.store.items[i].removeFromCart();
      _recalculateTotal();
    });
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
      this.total  = subtotal + (subtotal* 0.07);
    });
  }
}
