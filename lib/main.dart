import 'package:flutter/material.dart';
import 'package:immediacart/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'ImmediaCart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _usernameText = new TextEditingController();
  TextEditingController _passwordText = new TextEditingController();

  void _openTopRightMenu() {
    setState(() {});
  }

  void _signIn() {
    setState(() {
      //_usernameText.text = "Hello, This is where";
      //_passwordText.text =  "Your login function would run";
    });
  }

  void _registerNewUser(){
    runApp(Register());
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child:
                 FlatButton(child:Text(
                  "Create An Account",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ), onPressed: _registerNewUser,),
              ),
            ),
            Divider(
              height: 25.0,
              color: Colors.transparent,
            ),
            Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    filled: true,
                  ),
                  autofocus: true,
                  controller: _usernameText,
                )),
            Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration:
                      InputDecoration(labelText: "Password", filled: true),
                  autofocus: true,
                  controller: _passwordText,
                )),
            Divider(
              height: 75.0,
              color: Colors.transparent,
            ),
            Container(
                height: 50.0,
                width: 300.0,
                child: RaisedButton(
                  color: Colors.red,
                  elevation: 10.0,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _signIn,
                )),
            Divider(
              height: 35.0,
              color: Colors.transparent,
            ),
            Container(
              child: Text(
                "Forgot User Name/Password?",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
