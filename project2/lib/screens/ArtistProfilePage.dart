import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/EditProfilePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/welcome_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../storage_services.dart';
import '../getData.dart';

class ArtistProfilePage extends StatefulWidget {
  String userName;

  ArtistProfilePage(this.userName);

  @override
  State<ArtistProfilePage> createState() => _ArtistProfilePageState();
}

class _ArtistProfilePageState extends State<ArtistProfilePage> {
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  String imageUrl = " ";

  var _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Hello there!",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor),
              ),
              Text(
                ExtractData.getUserName(),
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor),
              ),

              //profile picture
              GestureDetector(
                  onTap: () {
                    print('image pressed');
                  },
                  child: FutureBuilder(
                      future: storage.downloadURL(ExtractData.getUserUID()),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(
                            "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          print("CONNECTION STATE IS STABLE");
                          return Container(
                              width: 300,
                              height: 250,
                              child: Image.network(snapshot.data!,
                                  fit: BoxFit.cover));
                        }
                        print("CONNECTION STATE IS UN-STABLE");
                        return Container();
                      })),
              //edit button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                          fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        (kPrimaryColor),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
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

                  /*onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfilePage()),
                    );
                  },*/
                ],
              ),

              //ratings
              Text(
                "Ratings",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kPrimaryDarkColor),
              ),
              //stars
              AnimatedPositioned(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: index < _rating
                            ? Icon(Icons.star, size: 32)
                            : Icon(Icons.star_border, size: 32),
                        color: kPrimaryColor,
                        onPressed: () {
                          setState(
                            () {
                              _rating = index + 1;
                            },
                          );
                        },
                      ),
                    )),
                duration: Duration(milliseconds: 300),
              ),
              //overview
              Text(
                "About Me",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kPrimaryDarkColor),
              ),
              Text(
                "*insert bio here*",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kPrimaryDarkColor),
              ),

              //logout button
              ElevatedButton(
                child: Text("Logout"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    (kPrimaryColor),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
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
