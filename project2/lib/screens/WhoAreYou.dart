import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project2/screens/EditProfilePageSignin.dart';
import '../getData.dart';
import 'constraints.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WhoAreYou extends StatefulWidget {

  //WhoAreYou(this.value);
  //WhoAreYou({super.key, required this.value});

  final value;
  WhoAreYou(this.value);

  @override
  State<WhoAreYou> createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {

  final _database = FirebaseDatabase.instance.reference();
  final extractData ExtractData = extractData();
  @override
  Widget build(BuildContext context) {
    final setAccType = _database.child(ExtractData.getUserUID()+'/');
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_top.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Who Are You?',
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: kPrimaryColor),
                ),
                //artist icon
                GestureDetector(
                  onTap: () {
                    print("Artist icon tapped");
                    print("value: "+widget.value);
                    FirebaseFirestore.instance.collection('Artist').doc(widget.value).set({"UID":widget.value});
                    setAccType.set({'Account Type':'Artist'});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePageSignin(),
                      ),
                    );
                  },
                  child: Lottie.asset(
                      'assets/anim/118914-woman-singer-in-recording-studio.json',
                      height: 200,
                      width: 200),
                ),
                Text(
                  'I am an artist/band',
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kPrimaryColor),
                ),
                //user icon
                GestureDetector(
                  onTap: (){
                    setAccType.set({'Account Type':'User'});
                    print("user icon tapped");
                    FirebaseFirestore.instance.collection('User').doc(widget.value).set({"UID":widget.value});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePageSignin(),
                      ),
                    );
                  },
                  child: Lottie.asset('assets/anim/71367-person.json',
                      height: 200, width: 200),
                ),
                Text(
                  'I am a user',
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kPrimaryColor),
                ),
                //venue icon
                GestureDetector(
                  onTap: (){
                    setAccType.set({'Account Type':'Venue'});
                    print("venue icon tapped");
                    FirebaseFirestore.instance.collection('Venue').doc(widget.value).set({"UID":widget.value});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePageSignin(),
                      ),
                    );
                  },
                  child: Lottie.asset(
                      'assets/anim/22446-house-cafe-restouran-building-maison-005-mocca-animation.json',
                      height: 200,
                      width: 200),
                ),
                Text(
                  'I have a venue',
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kPrimaryColor),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
