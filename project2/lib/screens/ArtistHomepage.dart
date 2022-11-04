import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project2/screens/ArtistProfilePage.dart';
import 'package:project2/screens/MainPage.dart';
import 'package:project2/screens/MapPage.dart';
import 'package:project2/screens/NotificationPage.dart';
import 'package:project2/screens/VenueMapPage.dart';
import 'package:project2/screens/VenuePrivatePage.dart';
import 'package:project2/screens/VenuePublicPage.dart';
import 'package:project2/screens/SearchPage.dart';
import 'package:project2/screens/UserProfilePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../storage_services.dart';
import '../getData.dart';
import '../local_data.dart';
import 'dummyProfile.dart';

class ArtistHomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  final accType;
  String mainAccType = "Venue";
  ArtistHomePage(this.accType);
  @override
  State<ArtistHomePage> createState() => _ArtistHomePageState();
}

class _ArtistHomePageState extends State<ArtistHomePage> {
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _userBio;
  String accTypeMain="";
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();

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
      print("INDEX VALUE "+index.toString());

      // if ((widget.accType
      //     == 'Venue')&&index==3) {
      //   print("THIS IS VENUE");
      //   _selectedIndex=index+1;
      //   print("SELECTED INDEX ON TAP"+_selectedIndex.toString());
      // }
      // else
        _selectedIndex = index;
      print("SELECTED INDEX ON TAP"+_selectedIndex.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(msg: "Login Successful");
    print("INIT STATE FOR HOMEPAGE");
    activateListner();
    // print("THIS IS ACC TYPE======================="+widget.accType);
    // print(FirebaseAuth.instance.currentUser?.uid.toString());
    // FirebaseFirestore.instance.collection("Venue")
    //     .doc(FirebaseAuth.instance.currentUser?.uid.toString()).get()
    //     .then((value) {
    //   if (value.exists){
    //     print("IF INIT==============");
    //     widget.mainAccType="Venue";
    //     print("WIDGET TYPE================="+widget.mainAccType);
    //     (widget.mainAccType== 'Venue')?print("VENUE HO"):print("ARTIST HO");
    //   }
    //   else{
    //     print("ELSE INIT");
    //   }
    //
    // });
    //checkAccountType();

    //widget.userName use gana ko lagi initialize garna parcha paila
    print("INIT IN HOME PAGE SCREEN");
    _screens = [
      MainPage(),
      MapPage(),
      //VenueMapPage(),
      NotificationPage(),
      SearchPage(),
      //DummyProfile(widget.accType),
      //widget.test
      ArtistProfilePage(),

      //(accTypeMain == "Venue")?VenuePrivatePage():ArtistProfilePage(),
      // VenuePrivatePage(),
      // UserProfilePage(),
    ];
  }
  void activateListner(){
    setState(() {
      print("LISTENER UID in HOMEPAGE: " + ExtractData.getUserUID());
      print(ExtractData.getUserUID().toString());
      FirebaseFirestore.instance.collection("Venue")
          .doc(FirebaseAuth.instance.currentUser?.uid.toString()).get()
          .then((value) {
        if (value.exists){
          print("IF INIT==============");
          widget.mainAccType="Venue";
          print("WIDGET TYPE================="+widget.mainAccType);
          (widget.mainAccType== 'Venue')?print("VENUE HO"):print("ARTIST HO");
        }
        else{
          print("ELSE INIT IN HOMEPAGE");
        }

      });
      _userBio = _database
          .child(extractData().getUserUID() + "/Account Type")
          .onValue
          .listen((event) {
        final String description = event.snapshot.value.toString();
        //print("LISTENER UID: " + ExtractData.getUserUID());
        print("LISTENER FOR ACC TYPE in HOMEPAGE: " + description);
        setState(() {
          accTypeMain = '$description';
        });
      });
    });

  }
  Future<void> checkAccountType() async {
   final prefs = await SharedPreferences.getInstance();
   final account = prefs.getString(widget.accType);
   print("Checkacctype Init");
   print("ACC TYPE"+widget.accType);
   print("Selectedindex"+_selectedIndex.toString());
   setState(() {
    if ((widget.accType
        == 'Venue')&&_selectedIndex==3) {
        print("THIS IS VENUE");
          _selectedIndex=_selectedIndex+1;
    }
   });
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
                icon: Icon(Icons.notifications_none),
                label: 'Notification',
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
