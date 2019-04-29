import 'package:flutter/material.dart';
import 'package:immediacart/checkoutPage.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/selectStore.dart';
import 'package:immediacart/storePage.dart';
import 'package:immediacart/submitPage.dart';

class FinishPage extends StatelessWidget {
  // This widget is the root of your application.
  List<Widget> cartItems;
  Store store;
  String deliveryDay;
  String deliveryWindow;
  int deliveryFee;

  FinishPage({this.store, this.cartItems, this.deliveryDay,this.deliveryWindow, this.deliveryFee});

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

  _MyHomePageState({this.store, this.deliveryDay,this.deliveryWindow, this.deliveryFee});

  void _openTopRightMenu() {
    setState(() {});
  }

  void _returnToStore() {
    runApp(SubmitPage(
        store: this.store, deliveryDay: this.deliveryDay,deliveryWindow: this.deliveryWindow, deliveryFee: this.deliveryFee)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Many Thanks!"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios), onPressed: _returnToStore),
        ),
        bottomNavigationBar: Container(
            color: Colors.green,
            height: 70.0
        ),
        body: ListView(children: [_finishingStatements()]));
  }

  Container _finishingStatements() {
    List<Widget> tileList = [];
    return Container(
      child: Column(
        children: <Widget>[
          Text("<(^_^)>", style: TextStyle(color:Colors.black, fontSize: 100, fontWeight: FontWeight.bold),),
          Text("We're done!", style: TextStyle(color:Colors.black, fontSize: 50, fontWeight: FontWeight.bold),),
          Text("The order will probably not be delivered to you and your money will probably not be taken", textAlign: TextAlign.center, style: TextStyle(color:Colors.black, fontSize: 20),),
          Divider(
            height: 25,
            color: Colors.black,
          ),
          Text("Things we still need:",textAlign: TextAlign.center, style: TextStyle(color:Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
          Text("• Map support", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
          Text("• A dedicated server", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
          Text("• Contracts with all the stores", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
          Text("• An application for drivers", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
          Text("• A real authentication system", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
          Text("• A payment processing system ", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
          Text("• And a life", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          Divider(
            height: 50,
          ),
          Text("Group Members: ", textAlign: TextAlign.left, style: TextStyle(color:Colors.black, fontSize: 40, fontWeight: FontWeight.bold)),
          Text("Lucas Trestka", textAlign: TextAlign.center, style: TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Jordan Kalfen",textAlign: TextAlign.center, style: TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Ishan Majumdar",textAlign: TextAlign.center, style: TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }


}
