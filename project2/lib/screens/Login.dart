import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project2/screens/Homepage.dart';
import 'package:project2/screens/Signup.dart';
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
  bool _isPasswordHidden = true;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

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
          onPressed: () {
             showDialog(context: context,
                 barrierDismissible: false,
                 builder: (context) => Center(child: CircularProgressIndicator()));
            try{
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text)
                  .then((value) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(_emailTextController, _passwordTextController),
                    ));
              });
              //Navigator.of(context).pop();

              print("HELLO WORLD");
            } on FirebaseAuthException catch (e){
              print("ERROR LOGININ: "+e.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message.toString()),
                ),
              );

            }
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content: Text("ERROR SIGNING IN"),
               ),
             );

            //Navigator.of(context).pop();

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
}
