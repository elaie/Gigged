import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/welcome_screen.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: (){
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
            });
          },
        ),
      ),
    );
  }
}
