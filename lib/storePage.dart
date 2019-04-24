import 'package:flutter/material.dart';
import 'package:immediacart/giveLocation.dart';
import 'package:immediacart/main.dart';
import 'package:immediacart/phoneRegister.dart';
import 'package:immediacart/register.dart';
import 'package:immediacart/selectStore.dart';

class StorePage extends StatelessWidget {
  // This widget is the root of your application.
  Store store;
  StorePage({this.store});

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
      home: MyHomePage(
        title: 'ImmediaCart',
        store: this.store,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.store}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  Store store;

  @override
  _MyHomePageState createState() => _MyHomePageState(store: this.store);
}

class _MyHomePageState extends State<MyHomePage> {
  Store store;
  int currentIndex = 1;
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _searchBar;
  List names = new List(); // names we get from API
  List filteredNames = new List();

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  _MyHomePageState({this.store}){
    _searchBar = new Text(this.store.name);
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          //filteredNames = logic.availablePokemon;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _openCartMenu() {
    setState(() {});
  }

  void _returnToSetLocation() {
    runApp(LocationRegister());
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
              prefixIcon: new Icon(Icons.search),
              hintText: 'Start typing'
          ),
        );
      } else {
        pageController.jumpToPage(1);
        currentIndex = 1;
        this._searchIcon = new Icon(Icons.search);
        this._searchBar = new Text(this.store.name, textAlign: TextAlign.right,);
        filteredNames = names;
        _filter.clear();
      }
    });
  }
  

  @override
  Container search (BuildContext context) {
    return 
        Container(child: _buildList());
  }

  _closeSearch(String item){
    setState(() {
      this._searchIcon = new Icon(Icons.location_searching);
      this._searchBar = new Text(item, textAlign: TextAlign.right,); // TODO: Add alert dialog to determine if pokemon was caught.
      filteredNames = names;
      _filter.clear();
    });
  }


  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List<String> tempList = [];
      for (int i = 0; i < this.store.aisles.length; i++) {
        if (this.store.aisles[i].toLowerCase().contains(
            _searchText.toLowerCase())) {
          tempList.add(this.store.aisles[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index], textAlign: TextAlign.center,),
          onTap: ()=>_closeSearch(filteredNames[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _searchBar,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: _returnToSetLocation),
          actions: <Widget>[IconButton(
              icon: _searchIcon, onPressed: _searchPressed
          ),
            IconButton(
                icon: Icon(Icons.shopping_cart), onPressed: _openCartMenu
            ),
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
            children: [_buildList(),page1(), page2()]));
  }

  void _pageChanged(int index) {
    setState(() {
      currentIndex = index;
      pageController.jumpToPage(index);
      this._searchIcon = new Icon(Icons.search);
      this._searchBar = new Text(this.store.name, textAlign: TextAlign.right,);
      filteredNames = names;
      _filter.clear();
    });
  }

  Container _popularItems() {
    return Container(
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
            child: Text("Bananas"),
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
          footer: Column(
            children: <Widget>[
              Divider(
                height: 5,
                color: Colors.transparent,
              ),
              Center(
                child: Text("0.24 /Each"),
              ),
              FlatButton(
                child: Container(
                  width: 100,
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                ),
                onPressed: () {},
                color: Colors.red,
              )
            ],
          )),
    );
  }

  GridView page1() {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      shrinkWrap: true,
      // Generate 100 Widgets that display their index in the List
      children: List.generate(20, (index) {
        return Center(child: Center(child: _popularItems()));
      }),
    );
  }

  ListView page2() {
    List<Widget> aisles = [];
    for (int i = 0; i < this.store.aisles.length; i++) {
      aisles.add(ListTile(
          leading: Text(this.store.aisles[i]),
          trailing: Icon(Icons.keyboard_arrow_right)));
    }
    ListView listView = ListView(
      children: aisles,
    );
    return listView;
  }
}
