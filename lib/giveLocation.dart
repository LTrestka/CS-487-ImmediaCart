import 'package:flutter/material.dart';
import 'package:immediacart/User.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/selectStore.dart';

void main() => runApp(LocationRegister());

class LocationRegister extends StatelessWidget {
  User user;
  // This widget is the root of your application.
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
      home: MyHomePage(title: 'ImmediaCart', user: this.user,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  User user;
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User user;

  TextEditingController _emailText = new TextEditingController();
  TextEditingController _locationText = new TextEditingController();

  _MyHomePageState({this.user});

  void _openTopRightMenu() {
    setState(() {
      this._locationText.text = "3105 South Dearborn St. Chicago, IL 60616";
    });
  }

  void _returnToRegister() {
    runApp(Main(user: this.user));
  }

  void _continueClicked() {
    runApp(SelectStore());
  }

  void _registerNewUser() {
    runApp(Register());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: _returnToRegister),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _openTopRightMenu),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        height: 70.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Divider(
              height: 30,
            ),
            Center(
              child: Container(
                width: 350.0,
                child: Text(
                  "Enter Location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(
              height: 15.0,
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2.0, color: Colors.green),
                    left: BorderSide(width: 2.0, color: Colors.green),
                    right: BorderSide(width: 2.0, color: Colors.green),
                    bottom: BorderSide(width: 2.0, color: Colors.green),
                  ),
                ),
                width: 350,
                //padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Current Location", filled: true),
                  autofocus: true,
                  controller: _locationText,
                )),
            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50.0,
                      width: 150.0,
                      //color: Colors.green,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: RaisedButton(
                        color: Colors.green,
                        elevation: 10.0,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: _continueClicked,
                      )),
                ])
          ],
        ),
      ),
    );
  }
}
