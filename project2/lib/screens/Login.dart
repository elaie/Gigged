import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:project2/main.dart';
import 'package:project2/screens/ArtistHomepage.dart';
import 'package:project2/screens/Signup.dart';
import 'package:project2/screens/UserHomePage.dart';
import 'package:project2/screens/VenueHomePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:email_validator/email_validator.dart';

import 'ForgotPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isPasswordHidden = true;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//Login text

    Widget TopText = Center(
      child: Text(
        'Find your faverouite gigs here',
        style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kPrimaryColor),
      ),
    );

    Widget TopText2 = Center(
      child: Text(
        'Login to get started!',
        style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kPrimaryColor),
      ),
    );

    Widget EmailOrUsername = TextFormField(
      keyboardType: TextInputType.name,
      controller: _emailTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0),),
            borderSide: BorderSide(color: kPrimaryLightColor,)
        ),
        labelStyle: TextStyle(color: kPrimaryDarkColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: kPrimaryLightColor),
        ),
        labelText: 'Enter your email or username',
        filled: true,
        fillColor: kPrimaryLightColor,
        contentPadding: EdgeInsets.all(20.0),
      ),
    );

    Widget Password = TextFormField(
      controller: _passwordTextController,
      obscureText: _isPasswordHidden,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your password';
        }

        if (value.length < 6) {
          return 'Password must be more than 6';
        }
        return null; //flutter ma condition satisfy bhayo bhane null return garnai parcha
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0),),
            borderSide: BorderSide(color: kPrimaryLightColor,)
        ),
        labelStyle: TextStyle(color: kPrimaryDarkColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: kPrimaryLightColor),
        ),
        labelText: 'Enter your password',
        filled: true,
        fillColor: kPrimaryLightColor,
        contentPadding: EdgeInsets.all(20.0),
      ),
    );

    Widget forgotPassword = Align(
      child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotPassword(),
              ),
            );
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: kPrimaryDarkColor),
          )),
      alignment: Alignment.centerRight,
    );

    Widget bottomSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(" Don't have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: kPrimaryDarkColor),
          ),
        )
      ],
    );

    Widget LoginButton = Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: (){
            signIn(_emailTextController.text,_passwordTextController.text);
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
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  TopText,
                  SizedBox(height: 5),
                  TopText2,
                  Lottie.asset('assets/anim/BandGuitar.json',
                      height: 300, width: 300),
                  SizedBox(height: 10),
                  EmailOrUsername,
                  SizedBox(height: 10),
                  Password,
                  SizedBox(height: 10),
                  forgotPassword,
                  SizedBox(height: 30),
                  LoginButton,
                  SizedBox(height: 30),
                  bottomSection,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn2() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
    }
    Navigator.of(context).pop();
  }
  void signIn(String email, String password) async {
    print("SIGN IN INIT");
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          print("**************LOGIN SUCESS");
          FirebaseFirestore.instance
              .collection('User')
              .doc(_auth.currentUser!.uid)
              .get()
              .then((uid) {
                print("UID CHECK IN FIRST==============="+uid.toString());
            if (uid.exists) {
              print('***********************USER Exist');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserHomePage("accType")));
              // Navigator.of(context).pushReplacement(
              //  MaterialPageRoute(builder: (context) => const dashboard()));
            } else {
              FirebaseFirestore.instance
                  .collection('Artist')
                  .doc(_auth.currentUser!.uid)
                  .get()
                  .then((uid) {
                if (uid.exists) {
                  print('***********************ARTIST Exist');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          ArtistHomePage("accType")));
                  // Navigator.of(context).pushReplacement(
                  //  MaterialPageRoute(builder: (context) => const dashboard()));
                }
                else {
                  print('***********************VENUE Exist');
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                      VenueHomePage("accType")));
                }
              }).onError((error, stackTrace) {
                print('***********************does not Exist');
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => UserHomePage("accType")));
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const serviceDashboard()));
              });
              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ArtistHomePage("accType")));
              //Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => const serviceDashboard()));
            });
          }).onError((error, stackTrace) {
            print('***********************does not Exist');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserHomePage("accType")));
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (context) => const serviceDashboard()));
          });
        // .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful");
        print(_auth.currentUser!.uid);
        print('#############################S');

        //if(_auth.currentUser!.uid)

      } on FirebaseAuthException catch (error) {
        var errorMessage;
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
