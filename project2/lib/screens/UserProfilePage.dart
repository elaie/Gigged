import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/screens/EditProfilePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/welcome_screen.dart';
import '../getData.dart';
import '../storage_services.dart';
import '../local_data.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  //final database = FirebaseDatabase.instance.reference();
  final user = FirebaseAuth.instance.currentUser;

  final Storage storage = Storage();
  final extractData ExtractData = extractData();

  String imageUrl = " ";

  void LoadImage() async {
    final ref = FirebaseStorage.instance.ref().child('profilepic.jpg');
    await ref.getDownloadURL();

// no need of the file extension, the name will do fine.
    var url = await ref.getDownloadURL();
    print(url);
  }

  int _rating = 0;


  @override
  Widget build(BuildContext context) {
    LoadImage();
    // final ratings = database.child('ratings/');
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('User')
            .doc(ExtractData.getUserUID())
            .get(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {}
          var data = snapshot.data!.data();
          var Name = data!['Name'];
          var Bio = data['Bio'].toString();
          var userUID = data['UID'].toString();
          return SafeArea(
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
                  Name,
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kPrimaryColor),
                ),
                //profile picture
                FutureBuilder(
                    future: storage.downloadURL(data['UID']),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
                      print(
                          "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        print("CONNECTION STATE IS STABLE");

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
                      print("CONNECTION STATE IS UN-STABLE");
                      return Container
                      (
                      );
                    }),
                // GestureDetector(
                //   onTap: () {
                //     print('image pressed');
                //     LoadImage();
                //     print(imageUrl);
                //   },
                //   child: imageUrl == " "
                //       ? Icon(Icons.person)
                //       : Image.network(imageUrl),
                // ),
                //edit button and message buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          (kPrimaryColor),
                        ),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
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
          );
        },
      ),
    );
  }
}
