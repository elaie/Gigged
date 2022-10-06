import 'package:flutter/material.dart';
import 'package:project2/screens/ArtistProfilePage.dart';

import 'constraints.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {

    Widget ProfilePic = GestureDetector(
      onTap: () {
        print('image pressed');
      },
      child: const CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage('assets/images/profile2.webp'),
      ),
    );

    Widget ChangeProfilePic = GestureDetector(
        onTap: () {},
        child: Text(
          'Change Profile Picture',
          style: TextStyle(color: kPrimaryDarkColor),
        ));

    Widget UserName = TextFormField(
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
        labelText: 'Username',
        filled: true,
        fillColor: kPrimaryLightColor,
        contentPadding: EdgeInsets.all(20.0),
      ),
    );

    Widget FullName = TextFormField(
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
        labelText: 'Name',
        filled: true,
        fillColor: kPrimaryLightColor,
        contentPadding: EdgeInsets.all(20.0),
      ),
    );

    Widget AboutMe = TextFormField(
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
        labelText: 'Bio',
        filled: true,
        fillColor: kPrimaryLightColor,
        contentPadding: EdgeInsets.all(20.0),
      ),
    );

    Widget Toptext = Text(
      "Edit your profile",
      style: TextStyle(
          fontFamily: 'Comfortaa',
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: kPrimaryColor),
    );
    
    Widget SaveButton=  ElevatedButton(
      child: Text(
        "Save Changes",
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArtistProfilePage('')),
        );
      },
    );
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Toptext,
              SizedBox(height: 20,),
              ProfilePic,
              SizedBox(height: 20,),
              ChangeProfilePic,
              SizedBox(height: 20,),
              FullName,
              SizedBox(height: 20,),
              UserName,
              SizedBox(height: 20,),
              AboutMe,
              SizedBox(height: 20,),
              SaveButton,
            ],
          ),
        ),
      ),
    );
  }
}
