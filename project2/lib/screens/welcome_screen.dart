import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project2/screens/Homepage.dart';
import 'package:project2/screens/Login.dart';
import 'package:project2/screens/MainPage.dart';
import 'package:project2/screens/Signup.dart';
import 'package:project2/screens/WhoAreYou.dart';
import 'package:project2/screens/constraints.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                      body: StreamBuilder<User?>(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return HomePage("");
                            } else {
                              return LoginPage();
                            }
                          }))),
            );
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
}
