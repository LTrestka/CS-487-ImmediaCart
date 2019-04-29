import 'package:flutter/material.dart';
import 'package:immediacart/cartPage.dart';
import 'package:immediacart/filteredPage.dart';
import 'package:immediacart/giveLocation.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/selectStore.dart';

class StorePage extends StatelessWidget {
  // This widget is the root of your application.
  Store store;
  int index;
  StorePage({this.store, this.index});

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
      home: storepage(
        title: 'ImmediaCart',
        store: this.store,
        index: this.index,
      ),
    );
  }
}

class storepage extends StatefulWidget {
  storepage({Key key, this.title, this.store, this.index}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  Store store;
  int index;

  @override
  _MyHomePageState createState() => _MyHomePageState(store: this.store, currentIndex: this.index);
}

class _MyHomePageState extends State<storepage> with AutomaticKeepAliveClientMixin<storepage>{
  Store store;
  int currentIndex;
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _searchBar;
  List<Item> names = []; // names we get from API
  List<Item> filteredNames = [];

  GridView gridView;

  PageController pageController;

@override
// TODO: implement wantKeepAlive
bool get wantKeepAlive => true;


List<Item> _generateItems() {
    List<Item> items = [];
    items.add(new Item(0, "Banana", 1.04, 2.50, "Fruits and Vegetables",
        "Banana", "Organic Bananas", "Other"));
    items.add(new Item(1, "Strawberries", 1.00, 3.60, "Fruits and Vegetables",
        "Strawberries", "Organic Bananas", "Other"));
    items.add(new Item(2, "Oranges", 1.00, 2.25, "Fruits and Vegetables",
        "Oranges", "Organic Oranges", "Other"));
    items.add(new Item(3, "Tomatoes", 1.00, 1.50, "Fruits and Vegetables",
        "Banana", "Organic Tomatoes", "Other"));
    items.add(new Item(4, "Parsley", 1.00, 1.99, "Condiments and Spices",
        "Parsley", "Parsley", "Other"));
    items.add(new Item(5, "Garlic", 0.25, 0.99, "Condiments and Spices",
        "Garlic", "Garlic Bulb", "Other"));
    items.add(new Item(6, "Bread", 2.00, 4.50, "Bread and Bakery",
        "Sugar, Milk, Eggs, Flour, Yeast", "White Bread", "Other"));
    items.add(new Item(7, "Olive Oil", 0.25, 12.25, "Cooking Oils",
        "Olive Oil, Salt, Pepper", "Extra Virgin Olive Oil", "Other"));
    items.add(new Item(8, "Cheerios", 1.00, 2.75, "Breakfast and Cereal",
        "Flour, Corn, Sugar", "Cheerios Breakfast Cereal", "Other"));
    items.add(new Item(9, "Mozzarella", 1.04, 4.50, "Dairy, Eggs, and Cheese",
        "Milk, Citric Acid, Salt", "Mozarella Cheese", "Other"));
    items.add(new Item(10, "Milk", 1.00, 3.50, "Dairy, Eggs, and Cheese",
        "Milk", "1 Gallon Milk, 2%", "Other"));
    items.add(new Item(11, "Eggs", 1.00, 2.50, "Dairy, Eggs, and Cheese",
        "Eggs", "Free Range Eggs", "Other"));
    items.add(new Item(12, "Butter", 0.5, 1.50, "Dairy, Eggs, and Cheese",
        "Heavy Cream, Salt", "Butter", "Other"));
    items.add(new Item(13, "Paper Towels", 1.00, 6.50, "Home Needs",
        "Paper Towels", "Paper Towels", "Other"));
    items.add(new Item(14, "Kethcup", 1.00, 3.50, "Condiments and Spices",
        "Tomatoes, Salt, Sugar", "Kethup", "Other"));
    items.add(new Item(15, "Mustard", 1.00, 2.50, "Condiments and Spices",
        "Mustard Seeds, Vinegar, Water", "Yellow Mustard", "Other"));
    items.add(new Item(
        16, "Salmon", 0.5, 6.99, "Deli", "Salmon", "Atlantic Salmon", "Other"));
    items.add(new Item(17, "Honey Turkey Breast", 1.00, 3.75, "Deli",
        "Turkey Breask, Honey", "Turkey Breast", "Other"));
    items.add(new Item(18, "Chicken Thighs", 1.00, 3.99, "Deli", "Chicken",
        "Organic Boneless Skinless Chicken Thighs", "Other"));
    items.add(new Item(19, "Bacon", 1.00, 5.50, "Deli",
        "Pork, Water, Salt, Sugar", "Thick Cut Bacon", "Other"));

    return items;
  }

  _MyHomePageState({this.store, this.currentIndex}) {
  if(this.currentIndex == null){
    currentIndex = 1;
  }
    pageController = PageController(
    initialPage: currentIndex,
    keepPage: true,
    );
    _searchBar = new Text(this.store.name);
    if (this.store.items.length == 0) {
      this.store.items = _generateItems();
    }
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          //filteredNames = this.store.items;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _openCartMenu() {
    setState(() {
      runApp(CartPage(store: this.store));
    });
  }

  void _returnToSetLocation() {
    if (currentIndex != 0) {
      runApp(SelectStore(store: this.store));
    } else {
      _pageChanged(1);
    }
  }

  _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        pageController.jumpToPage(0);
        currentIndex = 0;
        this._searchIcon = new Icon(Icons.close);
        this._searchBar = new TextField(
          autofocus: true,
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Start typing'),
        );
      } else {
        pageController.jumpToPage(1);
        currentIndex = 1;
        this._searchIcon = new Icon(Icons.search);
        this._searchBar = new Text(
          this.store.name,
          textAlign: TextAlign.right,
        );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  ListTile _closeSearch(String item, BuildContext context) {
    setState(() {
      this._searchIcon = new Icon(Icons.location_searching);
      this._searchBar = new Text(
        item,
        textAlign: TextAlign.right,
      );
      filteredNames = names;
      _filter.clear();
      /*Item _item;
    for (int i = 0; i < this.store.items.length; i++){
      if (this.store.items[i].name == item){
        _item = this.store.items[i];
        print(item);
        _buildList(item: _item);
      }
    }*/
    });
  }

  Widget _buildList({Item item}) {
    if (!(_searchText.isEmpty) && item == null) {
      List<Item> tempList = [];
      for (int i = 0; i < this.store.items.length; i++) {
        if (this
            .store
            .items[i]
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(this.store.items[i]);
        }
      }
      filteredNames = tempList;
    }
      return ListView.builder(
          shrinkWrap: true,
          itemCount: filteredNames.length,
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
                    child: Text(filteredNames[index].name), // item name
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
                    child: Text(
                        r"$" + filteredNames[index].price.toString()), // item price
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Container(color: Colors.red, child: Icon(Icons.remove, color: Colors.white,),),
                        onPressed: () {
                          _removeFromCart(filteredNames[index].listItem);
                        }, // add item to cart
                        color: Colors.red,
                      ),
                      Container(
                        width: 50,
                        child: Center(
                          child: Text(filteredNames[index].quantity.toString()),
                        ),
                      ),
                      IconButton(
                        icon: Container(color: Colors.red, child: Icon(Icons.add, color: Colors.white,),),
                        onPressed: () {
                          _addToCart(filteredNames[index].listItem);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _searchBar,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: _returnToSetLocation),
          actions: <Widget>[
            IconButton(icon: _searchIcon, onPressed: _searchPressed),
            IconButton(
                icon: Icon(Icons.shopping_cart), onPressed: _openCartMenu),
          ],
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
        body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              _pageChanged(index);
            },

            children: [_buildList(), page1(), page2()]));
  }

  void _pageChanged(int index) {
    setState(() {
      currentIndex = index;
      pageController.jumpToPage(index);
      this._searchIcon = new Icon(Icons.search);
      this._searchBar = new Text(
        this.store.name,
        textAlign: TextAlign.right,
      );
      filteredNames = names;
      _filter.clear();
    });
  }

  Container _popularItems(int i) {
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
            child: Text(item.name), // item name
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
              child: Text(r"$" + item.price.toString()), // item price
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Container(color: Colors.red, child: Icon(Icons.remove, color: Colors.white,),),
                  onPressed: () {
                    _removeFromCart(i);
                  }, // add item to cart
                  color: Colors.red,
                ),
                Container(
                  width: 50,
                  child: Center(
                    child: Text(this.store.items[i].quantity.toString()),
                  ),
                ),
                IconButton(
                  icon: Container(color: Colors.red, child: Icon(Icons.add, color: Colors.white,),),
                  onPressed: () {
                    _addToCart(i);
                  }, // add item to cart
                  color: Colors.red,
                )
              ],
            )
          ])),
    );
    return container;
  }

  int _checkCart(int i){
    setState(() {
    return this.store.items[i].quantity;
    });
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

  GridView page1() {
    this.gridView = GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      shrinkWrap: true,
      // Generate 100 Widgets that display their index in the List
      children: List.generate(20, (index) {
        return GridTile(
          child: Center(child: _popularItems(index)),
        );
      }),
    );
    return this.gridView;
  }

  ListView page2() {
    List<Widget> aisles = [];
    for (int i = 0; i < this.store.aisles.length; i++) {
      aisles.add(ListTile(
          leading: Text(this.store.aisles[i]),
          trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right)),
        onTap: (){runApp(FilteredPage(store: this.store, aisle: i));}) );
    }
    ListView listView = ListView(
      children: aisles,
    );
    return listView;
  }
}
