import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project2/screens/ArtistHomepage.dart';
import 'package:project2/screens/Login.dart';
import 'package:project2/screens/MainPage.dart';
import 'package:project2/screens/Signup.dart';
import 'package:project2/screens/WhoAreYou.dart';
import 'package:project2/screens/constraints.dart';
import '../storage_services.dart';
import '../getData.dart';
import '../local_data.dart';
import 'UserHomePage.dart';
import 'VenueHomePage.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String accType="";
  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _userBio;

  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();

  @override
  void initState() {
    super.initState();
    activateListner();
  }
  void activateListner(){
    setState(() {
      print("LISTENER UID: " + ExtractData.getUserUID());
      _userBio = _database
          .child(extractData().getUserUID() + "/Account Type")
          .onValue
          .listen((event) {
        final String description = event.snapshot.value.toString();
        //print("LISTENER UID: " + ExtractData.getUserUID());
        print("LISTENER FOR ACC TYPE: " + description);
        setState(() {
          accType = '$description';
        });
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    /* Widget TopImage = ClipRRect(
      child: Positioned(
        top: 0,
        left: 0,
        width: size.width * 0.3,
        child: Image.asset('assets/images/main_top.png'),
      ),
    );

    Widget LogoImage = ClipRRect(
      child: Container(
        child: Image.asset(
          'assets/images/Purple logo.jfif',
          width: 300,
          height: 200,
        ),
      ),
    );*/

    Widget PhraseText = Text(
      'Welcome to Gigged.',
      style: TextStyle(
        fontFamily: 'Comfortaa',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: kPrimaryDarkColor,
      ),
    );

    Widget PhraseText2 = Text(
      "Let's get you started!",
      style: TextStyle(
        fontFamily: 'Comfortaa',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: kPrimaryDarkColor,
      ),
    );

    Widget SignUpButton = Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignupPage(),
              ),
            );
          },
          child: const Text(
            'SignUp',
            style:
            TextStyle(fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
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
        ),
      ),
    );

    Widget OrText = Text(
      "OR",
      style: TextStyle(fontFamily: 'Comfortaa'),
    );

    Widget LoginButton = Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           Scaffold(
                          // body: StreamBuilder<User?>(
                          //     stream: FirebaseAuth.instance.authStateChanges(),
                          //     builder: (context, snapshot) {
                          //       print("SNAPSHOT DATA OF WELCOME PAGE=============");
                          //       print("UID FROM WELCOME PAGE===============================");
                          //       print(snapshot.data?.uid);
                          //       FirebaseFirestore.instance.collection("Artist")
                          //           .doc(snapshot.data?.uid.toString()).get()
                          //           .then((value) {
                          //         print("UID2===============================");
                          //         print(FirebaseAuth.instance.currentUser?.uid.toString());
                          //         if (value.exists){
                          //           accType="Venue";
                          //           if (snapshot.hasData) {
                          //             return ArtistHomePage(accType);
                          //           } else {
                          //             return LoginPage();
                          //           }
                          //           print("IF ACC TYPE=========================");
                          //         }
                          //         else{
                          //           print("ELSE ACC TYPE=========================");
                          //         }
                          //       });
                          //       FirebaseFirestore.instance.collection("User")
                          //           .doc(snapshot.data?.uid.toString()).get()
                          //           .then((value) {
                          //         print("UID2===============================");
                          //         print(FirebaseAuth.instance.currentUser?.uid.toString());
                          //         if (value.exists){
                          //           if (snapshot.hasData) {
                          //             return UserHomePage(accType);
                          //           } else {
                          //             return LoginPage();
                          //           }
                          //           accType="Venue";
                          //           print("IF ACC TYPE=========================");
                          //         }
                          //         else{
                          //           print("ELSE ACC TYPE=========================");
                          //         }
                          //       });
                          //       FirebaseFirestore.instance.collection("Venue")
                          //           .doc(snapshot.data?.uid.toString()).get()
                          //           .then((value) {
                          //         print("UID2===============================");
                          //         print(FirebaseAuth.instance.currentUser?.uid.toString());
                          //         if (value.exists){
                          //           if (snapshot.hasData) {
                          //             return VenueHomePage(accType);
                          //           } else {
                          //             return LoginPage();
                          //           }
                          //           accType="Venue";
                          //           print("IF ACC TYPE=========================");
                          //         }
                          //         else{
                          //           print("ELSE ACC TYPE=========================");
                          //         }
                          //       });
                          //       return Container();
                          //     })
          },
          child: const Text(
            'Login',
            style:
            TextStyle(fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
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
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/main_top.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 60,
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              height: 350,
                              child: Image.asset('assets/images/Gigged-1.png',
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    ),
                    PhraseText,
                    PhraseText2,
                    SizedBox(height: 60),
                    LoginButton,
                    SizedBox(height: 10),
                    OrText,
                    SizedBox(height: 10),
                    SignUpButton,
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void deactivate() {
    print("LISTENER UID WECLOME PROFILE DEACTIVATED");
    _userBio.cancel();
    super.deactivate();
  }
}
