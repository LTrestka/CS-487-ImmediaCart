import 'package:flutter/material.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/selectStore.dart';
import 'package:immediacart/storePage.dart';

class FilteredPage extends StatelessWidget {
  // This widget is the root of your application.
  List<Widget> cartItems;
  int aisle;
  Store store;

  FilteredPage({this.store, this.aisle});

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
      home: MyHomePage(store: this.store, aisle: this.aisle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<Widget> cartItems;
  int aisle;
  MyHomePage({Key key, this.store, this.aisle}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Store store;

  @override
  _MyHomePageState createState() => _MyHomePageState(store: this.store, aisle: this.aisle);
}

class _MyHomePageState extends State<MyHomePage> {
  ListView items;
  Store store;
  int aisle;
  int currentIndex = 2;

  double subtotal = 0.00;
  double total = 0;

  _MyHomePageState({this.store, this.aisle});


  void _returnToStore() {
    runApp(StorePage(
      store: this.store,
    ));
  }

  void _pageChanged(int index) {
    setState(() {
      currentIndex = index;
      runApp(StorePage(store: this.store, index: this.currentIndex));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.store.aisles[aisle]),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios), onPressed: ()=>_pageChanged(2)),

        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.green,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.black,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          child: BottomNavigationBar(
            onTap: _pageChanged,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text(
                    "Search",
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text(
                    "Home",
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  title: Text(
                    "Aisles",
                  )),
            ],
            currentIndex: currentIndex,
          ),
        ),
        body: ListView(children: [page1()]));
  }

  GridView page1() {
    List<Item> filteredList = [];
    for (int i = 0; i < this.store.items.length; i++) {
      if (this.store.items[i].aisle == this.store.aisles[aisle]) {
        filteredList.add(this.store.items[i]);
      }
    }
    return _filteredItems(filteredList);

  }

  GridView _filteredItems(List<Item> list) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      shrinkWrap: true,
      // Generate 100 Widgets that display their index in the List
      children: List.generate(list.length, (index) {
        return GridTile(
          child: Center(child: _popularItems(index,list)),
        );
      }),
    );
  }



  void _addToCart(int i) {
    setState(() {
      this.store.items[i].addToCart();
    });
  }
  void _removeFromCart(int i) {
    setState(() {
      this.store.items[i].removeFromCart();
    });
  }


  Container _popularItems(int i, List<Item> list) {
    Item item = this.store.items[i];
    Container container = Container(
      height: 175,
      width: 150,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
          left: BorderSide(width: 1.0, color: Colors.grey),
          right: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: GridTile(
          child: Center(
            child: Text(list[i].name), // item name
          ),
          header: Column(
            children: <Widget>[
              Icon(
                Icons.fastfood,
                size: 50,
              ),
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
            ],
          ),
          footer: Column(children: <Widget>[
            Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Center(
              child: Text(r"$" + list[i].price.toString()), // item price
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Container(color: Colors.red, child: Icon(Icons.remove, color: Colors.white,),),
                  onPressed: () {
                    _removeFromCart(list[i].listItem);
                  }, // add item to cart
                  color: Colors.red,
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text(list[i].quantity.toString()),
                  ),
                ),
                IconButton(
                  icon: Container(color: Colors.red, child: Icon(Icons.add, color: Colors.white,),),
                  onPressed: () {
                    _addToCart(list[i].listItem);
                  }, // add item to cart
                  color: Colors.red,
                )
              ],
            )
          ])),
    );
    return container;
  }
}
