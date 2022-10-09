import 'package:flutter/material.dart';
import 'package:project2/screens/ArtistProfilePage.dart';
import 'package:project2/screens/MainPage.dart';
import 'package:project2/screens/MapPage.dart';
import 'package:project2/screens/ProfilePage.dart';
import 'package:project2/screens/SearchPage.dart';
import 'package:project2/screens/UserProfilePage.dart';
import 'package:project2/screens/constraints.dart';

class HomePage extends StatefulWidget {
  String userName = 'pritisha';
  String password = '';

  HomePage(userName, password);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  var _screens = [];

  static const List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    MapPage(),
    SearchPage(),
    ArtistProfilePage(),
    //ProfilePage(widget.userName),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

 /* @override
  void initState() {
    //widget.userName use gana ko lagi initialize garna parcha paila
    super.initState();
    _screens = [
      MainPage(),
      MapPage(),
      SearchPage(),
      //UserProfilePage(),
      ArtistProfilePage(widget.userName),
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              trailing: Icon(Icons.accessibility_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //esma icons pani clickable huncha
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
              backgroundColor: kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: kPrimaryColor),
        ],
        selectedItemColor: kPrimaryDarkColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            print("=============");
            print(index);
            print("=============");
          });
        },
      ),
    );
  }*/
