import 'package:flutter/material.dart';
import 'package:immediacart/submitPage.dart';
import 'package:toast/toast.dart';
import 'package:immediacart/cartPage.dart';
import 'package:immediacart/selectStore.dart';

class PickTime extends StatefulWidget {
  Store store;
  PickTime({this.store});

  @override
  _MyAppState createState() => new _MyAppState(store: this.store);
}

class _MyAppState extends State<PickTime> {
  Store store;

  dateBox box1 = dateBox(target: 0);
  dateBox box2 = dateBox(target: 1);
  dateBox box3 = dateBox(target: 2);

  _MyAppState({this.store});

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  int timeSlot = -1;
  int _TimeSelector = -1;

  void _handleTimeSelector(int value) {
    setState(() {
      _TimeSelector = value;
      switch (_TimeSelector) {
        case 0:
          timeSlot = 0;
          break;
        case 1:
          timeSlot = 1;
          break;
        case 2:
          timeSlot = 2;
          break;
        case 3:
          timeSlot = 4;
          break;
        case 4:
          timeSlot = 4;
          break;
        case 5:
          timeSlot = 5;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Delivery Options'),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    runApp(CartPage(store: this.store));
                  }),
            ),
            body: new ListView(
                padding: EdgeInsets.all(8.0),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    child: Text("Choose Date and Time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    )),
                    padding: EdgeInsets.symmetric(vertical: 25),
                  ),
                  Container(

                    child: _getDateBoxes(),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: new Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Select 2 or 4 hour delivery option',
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),

                      new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Text(
                        r'2-Hour Delivery ($10 fee)',
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new Radio(
                                value: 0,
                                groupValue: _TimeSelector,
                                onChanged: _handleTimeSelector,
                              ),
                              new Text(
                                '8AM to 10AM',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Radio(
                                value: 1,
                                groupValue: _TimeSelector,
                                onChanged: _handleTimeSelector,
                              ),
                              new Text(
                                '10AM to 12AM',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Radio(
                                value: 2,
                                groupValue: _TimeSelector,
                                onChanged: _handleTimeSelector,
                              ),
                              new Text(
                                '12AM to 2PM',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Radio(
                                value: 3,
                                groupValue: _TimeSelector,
                                onChanged: _handleTimeSelector,
                              ),
                              new Text(
                                '2PM to 4PM',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Text(
                        r'4-Hour Delivery ($5 fee)',
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  new Radio(
                                    value: 4,
                                    groupValue: _TimeSelector,
                                    onChanged: _handleTimeSelector,
                                  ),
                                  new Text(
                                    '8AM to 12PM',
                                    style: new TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  new Radio(
                                    value: 5,
                                    groupValue: _TimeSelector,
                                    onChanged: _handleTimeSelector,
                                  ),
                                  new Text(
                                    "12PM to 4PM",
                                    style: new TextStyle(fontSize: 16.0),
                                  )
                                ],
                              )
                            ],
                          ),
                          new Divider(
                            height: 15.0,
                            color: Colors.black,
                          ),
                          new Container(
                              height: 50,
                              width: 150,
                              child: RaisedButton(
                                color: Colors.red,
                                child: Text(
                                  'CONTINUE',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                onPressed: () {
                                  _continuePressed(context);
                                },
                              )),
                        ],
                      ),
                    ],
                  ))
                ])));
  }

  void _continuePressed(BuildContext context) {
    print(timeSlot);
    String deliveryDay;
    String deliveryTime;
    int deliveryFee;
    if (_TimeSelector == -1) {
      return;
    } else {
      switch (timeSlot) {
        case 0:
          deliveryFee = 10;
          deliveryTime = "8AM-10AM";
          break;
        case 1:
          deliveryFee = 10;
          deliveryTime = "10AM-12PM";
          break;
        case 2:
          deliveryFee = 10;
          deliveryTime = "12PM-2PM";
          break;
        case 3:
          deliveryFee = 10;
          deliveryTime = "2PM-4PM";
          break;
        case 4:
          deliveryFee = 5;
          deliveryTime = "8AM-12PM";
          break;
        case 5:
          deliveryFee = 5;
          deliveryTime = "12PM-4PM";
          break;
      }
      if(this.box1.selected){
        deliveryDay = this.box1.dateToReturn;
      }
      else if( this.box2.selected){
        deliveryDay = this.box2.dateToReturn;
      }
      else if (this.box3.selected){
        deliveryDay = this.box3.dateToReturn;
      }
      else{
        print("Fail");
      }
      print(deliveryDay + "\t" + deliveryTime);
      runApp(SubmitPage(store: this.store, deliveryDay: deliveryDay, deliveryWindow: deliveryTime, deliveryFee: deliveryFee,));
    }
  }

  void _selected(dateBox box){
    setState(() {
      box.selected = true;
      box.font = Colors.white;
      box.background = Colors.red;
      switch(box.target){
        case 0:
          _deSelected(this.box2, this.box3);
          break;
        case 1:
          _deSelected(this.box1, this.box3);
          break;
        case 2:
          _deSelected(this.box1 ,this.box2);
      }
    });
  }

  void _deSelected(dateBox boxA, dateBox boxB){
    setState(() {
      boxA.selected = false;
      boxA.font = Colors.black;
      boxA.background = Colors.grey;
      boxB.selected = false;
      boxB.font = Colors.black;
      boxB.background = Colors.grey;
    });
  }

  Row _getDateBoxes(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
            height: 100,
            width: 120,
            color: this.box1.background,
            padding: EdgeInsets.all(5),
            child: Center(
              child: FlatButton(
                  onPressed: (){_selected(this.box1);},
                  child:Text(this.box1.dateToReturn,
                    style: TextStyle(
                        color: this.box1.font
                    ),
                  )),
            )),
        Container(
            height: 100,
            width: 120,
            color: this.box2.background,
            padding: EdgeInsets.all(5),
            child: Center(
              child: FlatButton(
                  onPressed: (){_selected(this.box2);},
                  child:Text(this.box2.dateToReturn,
                    style: TextStyle(
                        color: this.box2.font
                    ),
                  )),
            )),
        Container(
            height: 100,
            width: 120,
            color: this.box3.background,
            padding: EdgeInsets.all(5),
            child: Center(
              child: FlatButton(
                  onPressed: (){_selected(this.box3);},
                  child:Text(this.box3.dateToReturn,
                    style: TextStyle(
                        color: this.box3.font
                    ),
                  )),
            )),
      ],
    );
  }
}

class dateBox {
  bool selected;
  DateTime day;
  int target;
  Color font = Colors.black;
  Color background = Colors.grey;
  String dateToReturn;

  dateBox({int target}){
    this.target = target;
    switch(target){
      case 0:
        this.day = DateTime.now();
        break;
      case 1:
        this.day = DateTime.now().add(Duration(days: 1));
        break;
      case 2:
        this.day = DateTime.now().add(Duration(days: 2));
        break;
    }
    this.selected = false;
    String dayName;
    switch(this.day.weekday){
      case 1:
        dayName = "Monday";
        break;
      case 2:
        dayName = "Tuesday";
        break;
      case 3:
        dayName = "Wednesday";
        break;
      case 4:
        dayName = "Thursday";
        break;
      case 5:
        dayName = "Friday";
        break;
      case 6:
        dayName = "Saturday";
        break;
      case 7:
        dayName = "Sunday";
        break;
    }
    this.dateToReturn = dayName + " "+ this.day.month.toString() + "/" + this.day.day.toString();
  }

}
