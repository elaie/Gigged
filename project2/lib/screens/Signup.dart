import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project2/screens/Homepage.dart';
import 'package:project2/screens/Login.dart';
import 'package:project2/screens/constraints.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  var userNameController = TextEditingController();
  var userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
//Login text

    Widget TopText2 = Center(
      child: Text(
        "Looks like you're new here,",
        style: TextStyle(
            fontFamily: 'Comfortaa', fontWeight: FontWeight.bold, fontSize: 16, color: kPrimaryColor),
      ),
    );

    Widget TopText = Center(
      child: Text(
        'Lets sign you up!',
        style: TextStyle(
            fontFamily: 'Comfortaa', fontWeight: FontWeight.bold, fontSize: 30, color: kPrimaryColor),
      ),
    );

    Widget EmailOrUsername = TextFormField(
      keyboardType: TextInputType.name,
      controller: userNameController,
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
      controller: userPasswordController,
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
        fillColor: kPrimaryLightColor,
        filled: true,
        contentPadding: EdgeInsets.all(20.0),
      ),
    );
    Widget ConfirmPassword=Container(
      height: 70,
      width: 500,
      decoration: BoxDecoration(borderRadius:BorderRadius.circular(50)),
      child: TextFormField (
        controller: userPasswordController,
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
          labelText: 'Confirm your password',
          fillColor: kPrimaryLightColor,
          filled: true,
          contentPadding: EdgeInsets.all(20.0),
        ),
      ),
    );

    Widget LoginButton = Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              //to take input from user
              String userName = userNameController.text;
              String userPassword = userPasswordController.text;
              print(userName);
              print(userPassword);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage('null', 'null'),
                ),
              );
            }
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

    Widget bottomSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(" Already have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text(
            "Login",
            style: TextStyle(color: kPrimaryDarkColor),
          ),
        )
      ],
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
                  TopText2,
                  TopText,
                  Lottie.asset('assets/anim/105639-signup.json',
                      height: 270, width: 300),
                  SizedBox(height: 10),
                  EmailOrUsername,
                  SizedBox(height: 10),
                  Password,
                  SizedBox(height: 10),
                  ConfirmPassword,
                  SizedBox(height: 30),
                  LoginButton,
                  SizedBox(height: 10),
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
