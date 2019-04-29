import 'package:flutter/material.dart';
import 'package:immediacart/User.dart';
import 'package:immediacart/giveLocation.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/register.dart';


class PhoneRegister extends StatelessWidget {
  User user;
  PhoneRegister({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'ImmediaCart', user: this.user,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  User user;

  @override
  _MyHomePageState createState() => _MyHomePageState(user);
}

class _MyHomePageState extends State<MyHomePage> {

  User user;
  TextEditingController _phoneText = new TextEditingController();


  _MyHomePageState(this.user);

  void _openTopRightMenu() {
    setState(() {
      _phoneText.text = "(757)-677-6621";
    });
  }

  void _returnToRegister(User user) {
    runApp(Register(user: user));
  }

  void _continueClicked() {
    setState(() {
      this.user.addPhoneNumber(_phoneText.text);
      // TODO: Send this information to firebase to generate new user, text phone with username and password

      runApp(Main(user:this.user));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: ()=>_returnToRegister(this.user)),
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
                  "Enter the mobile phone \nnumber on your account",
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
            Center(
              child: Container(
                width: 350.0,
                child: Text(
                  "We'll send an automated text message to \nthis phone number with your username \nand temporary password.",
                  style: TextStyle(color: Colors.grey, fontSize: 18.0),
                ),
              ),
            ),
            Divider(
              height: 10.0,
              color: Colors.transparent,
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
                      labelText: "(###) - ### - ####", filled: true),
                  autofocus: true,
                  controller: _phoneText,
                  keyboardType: TextInputType.number,
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
                          "Continue",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: _continueClicked,
                      )),
                  Divider(
                    height: 10,
                  ),
                  Container(
                      height: 50.0,
                      width: 150.0,
                      color: Colors.transparent,
                      child: FlatButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: ()=>_returnToRegister(this.user),
                      )),
                ])
          ],
        ),
      ),
    );
  }
}
