import 'package:flutter/material.dart';
import 'package:immediacart/User.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';

class Register extends StatelessWidget {
  User user;
  Register({this.user});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: RegisterPage(title: 'ImmediaCart',user: this.user),
    );
  }
}

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  User user;

  @override
  _MyHomePageState createState() => _MyHomePageState(user: this.user);
}

class _MyHomePageState extends State<RegisterPage> {

  User user;
  TextEditingController _nameText = new TextEditingController();
  TextEditingController _addressText = new TextEditingController();
  TextEditingController _cityText = new TextEditingController();
  TextEditingController _stateText = new TextEditingController();
  TextEditingController _cardNumberText = new TextEditingController();
  TextEditingController _cardTypeText = new TextEditingController();
  TextEditingController _cardExpText = new TextEditingController();


  _MyHomePageState({this.user});


  void _fillIfNecessary(){
    setState(() {
      if(this.user != null){
        _nameText.text = user.name;
        _addressText.text = user.address;
        _cityText.text = user.city;
        _stateText.text = user.state;
        _cardNumberText.text = user.cardNumber;
        _cardTypeText.text = user.cardType;
        _cardExpText.text = user.cardExpire;
      }
    });
  }




  void _openTopRightMenu() {
    // just using this for quick fill since its not used otherwise
    setState(() {
      _nameText.text = "Lucas Trestka";
      _addressText.text = "3105 South Dearborn";
      _cityText.text = "Chicago";
      _stateText.text = "IL";
      _cardNumberText.text = "1234-5678-9101-1213";
      _cardTypeText.text = "Visa";
      _cardExpText.text = "05/2019";
    });
  }

  void _register() {
    setState(() {
      user = new User(_nameText.text, _addressText.text, _cityText.text, _stateText.text,
          _cardNumberText.text, _cardTypeText.text, _cardExpText.text);
      runApp(PhoneRegister(user:user));
    });
  }

  void _returnToLogin(){
    runApp(MyApp());
  }



  @override
  Widget build(BuildContext context) {
    _fillIfNecessary();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: _returnToLogin),
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
            Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    filled: true,
                  ),
                  autofocus: true,
                  controller: _nameText,
                )),
            Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration:
                  InputDecoration(
                      labelText: "Address",
                      filled: true
                  ),
                  autofocus: true,
                  controller: _addressText,
                )),
            Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "City",
                    filled: true,
                  ),
                  autofocus: true,
                  controller: _cityText,
                )),
            Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration:
                  InputDecoration(
                      labelText: "State",
                      filled: true
                  ),
                  autofocus: true,
                  controller: _stateText,
                )),
            Container(
                width: 350.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Credit Card Number",
                    filled: true,
                  ),
                  autofocus: true,
                  controller: _cardNumberText,
                  keyboardType: TextInputType.number,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Container(
                width: 175.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration:
                  InputDecoration(
                      labelText: "Card Type",
                      helperText: "Visa/Mastercard",
                      filled: true
                  ),
                  autofocus: true,
                  controller: _cardTypeText,
                  keyboardType: TextInputType.text,
                )),Container(
                width: 175.0,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Exp Date",
                    helperText: "MM/YYYY",
                    filled: true,
                  ),
                  autofocus: true,
                  controller: _cardExpText,
                  keyboardType:  TextInputType.number,
                )),]),
            Divider(
              height: 75.0,
              color: Colors.transparent,
            ),
            Container(
                height: 50.0,
                width: 300.0,
                child: RaisedButton(
                  color: Colors.green,
                  elevation: 10.0,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _register,
                )),
          ],
        ),
      ),
    );
  }


}
