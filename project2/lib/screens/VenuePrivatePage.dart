import 'package:flutter/material.dart';
import 'package:project2/screens/CreateEvent.dart';
import 'package:project2/screens/SeeAllArtist.dart';
import 'package:project2/screens/constraints.dart';
import 'welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'EditProfilePage.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import '../storage_services.dart';
import '../getData.dart';
import '../local_data.dart';

class VenuePrivatePage extends StatefulWidget {
  const VenuePrivatePage({Key? key}) : super(key: key);

  @override
  State<VenuePrivatePage> createState() => _VenuePrivatePage();
}

class _VenuePrivatePage extends State<VenuePrivatePage> {
  final _database = FirebaseDatabase.instance.reference();

  String displayBio = " ";
  late StreamSubscription _userBio;

  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();
  var _rating = 0;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    _userBio = _database
        .child(ExtractData.getUserUID() + "/BIO/Bio")
        .onValue
        .listen((event) {
      final String description = event.snapshot.value.toString();
      print("LISTENER: " + description);
      setState(() {
        displayBio = '$description';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hello there!",
                          style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: kPrimaryColor),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                            height: 255,
                            width: 400,
                            child: Stack(fit: StackFit.expand, children: [
                              GestureDetector(
                                  onTap: () {
                                    print('cover is pressed');
                                  },
                                  //coverpage
                                  child: Column(children: [
                                    Container(
                                        height: 170,
                                        width: 400,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://www.pngmart.com/files/4/Party-PNG-Pic.png')),
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ])),
                              Positioned(
                                bottom: 20.0,
                                left: 100.0,
                                child: GestureDetector(
                                  onTap: () {
                                    print('image is pressed');
                                  },
                                  //story
                                    child: FutureBuilder(
                                        future: storage.downloadURL(ExtractData.getUserUID()),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          // print(
                                          // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                                          extractData().getUserUID();
                                          if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                              snapshot.hasData) {
                                            //print("CONNECTION STATE IS STABLE");
                                            return Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100),
                                                ),
                                                //for circle outline on pp
                                                border: Border.all(
                                                  width: 3,
                                                  color: kPrimaryColor,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                  ),
                                                ],
                                              ),
                                              child: CircleAvatar(
                                                  radius: 70,
                                                  backgroundImage: NetworkImage(
                                                    snapshot.data!,
                                                  )),
                                            );
                                          }
                                          // print("CONNECTION STATE IS UN-STABLE");
                                          return Container();
                                        })
                                ),
                              )
                            ])),
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Text(
                                'About us',
                                style: TextStyle(
                                  color: kPrimaryDarkColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: kPrimaryColor,
                              ),
                              Text(
                                displayBio,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                              //Message button
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    child: Text(
                                      "Edit profile",
                                      style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        (kPrimaryColor),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) => EditProfilePage(),
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SeeAllArtist(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Hire Artists',
                                      style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        (kPrimaryColor),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                                  SizedBox(height: 15,),
                                  //create event button
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateEvent(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Create Event',
                                      style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        (kPrimaryColor),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                  ),
                              SizedBox(height: 20),
                              //ratings
                              Text(
                                "Average Ratings",
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: kPrimaryDarkColor),
                              ),
                              //Stars
                              AnimatedPositioned(
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      5,
                                      (index) => IconButton(
                                            icon: Icon(Icons.star, size: 32),
                                            color: Color.fromARGB(
                                                255, 204, 165, 249),
                                            onPressed: () {},
                                          )),
                                ),
                                duration: Duration(milliseconds: 300),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        (kPrimaryColor),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut().then((value) {
                                        print("Signed Out");
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(pageBuilder: (BuildContext context,
                                                Animation animation,
                                                Animation secondaryAnimation) {
                                              return WelcomeScreen();
                                            }, transitionsBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double> secondaryAnimation,
                                                Widget child) {
                                              return new SlideTransition(
                                                position: new Tween<Offset>(
                                                  begin: const Offset(1.0, 0.0),
                                                  end: Offset.zero,
                                                ).animate(animation),
                                                child: child,
                                              );
                                            }),
                                                (Route route) => false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ]))
                      ])),
            )));
  }

  @override
  void deactivate() {
    _userBio.cancel();
    super.deactivate();
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    const EditProfilePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

