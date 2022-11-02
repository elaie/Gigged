import 'package:flutter/material.dart';
import 'package:project2/screens/ArtistProfilePage.dart';
import 'package:project2/screens/MainPage.dart';
import 'package:project2/screens/MapPage.dart';
import 'package:project2/screens/VenuePrivatePage.dart';
import 'package:project2/screens/VenuePublicPage.dart';
import 'package:project2/screens/SearchPage.dart';
import 'package:project2/screens/UserProfilePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dummyProfile.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  final accType;
  HomePage(this.accType);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  var _screens = [];

 /* static const List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    MapPage(),
    SearchPage(),
<<<<<<< HEAD
   // ArtistProfilePage(),
    DummyProfile(widget.accType),
=======
    ArtistProfilePage(),
    //VenuePrivatePage(),
>>>>>>> 77cbbcf3dae167874aab4ca3b21fdc3bcebbdb68
    //ProfilePage(widget.userName),
  ];*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    checkAccountType();
    super.initState();
    //widget.userName use gana ko lagi initialize garna parcha paila
    super.initState();
    _screens = [
      MainPage(),
      MapPage(),
      SearchPage(),
      //DummyProfile(widget.accType),
      ArtistProfilePage(),
      VenuePrivatePage(),
      UserProfilePage()
    ];
  }

  Future<void> checkAccountType() async {
   final prefs = await SharedPreferences.getInstance();
   final account = prefs.getString(widget.accType);
    if ((account == 'Venue')&&_selectedIndex==3) {
      setState(() {
          _selectedIndex=_selectedIndex+13;
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
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
        ),
      ),
    );
  }
}

/*BottomNavigationBar(
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
      ),*/
//alternate method
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
