import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/welcome_screen.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  //final database = FirebaseDatabase.instance.reference();
  final user = FirebaseAuth.instance.currentUser;
  print(user) {
    // TODO: implement print
    throw UnimplementedError();
  }


  int _rating = 0;

  @override
  Widget build(BuildContext context) {
   // final ratings = database.child('ratings/');
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Hello there!",
              style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: kPrimaryColor),
            ),

            Text(
              "Username here",
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
              child: const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/profile2.webp'),
              ),
            ),
            //edit button and message buttons
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
                  onPressed: () {},
                ),
                // message me
                ElevatedButton(
                  child: Text(
                    "Message me",
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
                  onPressed: () {},
                ),
              ],
            ),

            //your tickets
            Text(
              "Your tickets",
              style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kPrimaryColor),
            ),
            //favroite venues and artists
            Text(
              "Your favourite venues ans artists",
              style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kPrimaryColor),
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
