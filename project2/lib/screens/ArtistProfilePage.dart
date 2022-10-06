import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/EditProfilePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/welcome_screen.dart';

class ArtistProfilePage extends StatefulWidget {
  String userName;

  ArtistProfilePage(this.userName);

  @override
  State<ArtistProfilePage> createState() => _ArtistProfilePageState();
}

class _ArtistProfilePageState extends State<ArtistProfilePage> {
  var _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Hello there!\n" + widget.userName,
              style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: kPrimaryColor),
            ),
            //profile picture
            GestureDetector(
              onTap: () {
                print('image pressed');
              },
              child: const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/profile2.webp'),
              ),
            ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfilePage()),
                    );
                  },
                ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
