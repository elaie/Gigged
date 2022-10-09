import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'constraints.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({Key? key}) : super(key: key);

  @override
  State<WhoAreYou> createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  @override
  Widget build(BuildContext context) {
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
                    print("user icon tapped");
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
                    print("venue icon tapped");
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
