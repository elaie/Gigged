import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/screens/ArtistProfilePage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../storage_services.dart';
import 'constraints.dart';
import '../getData.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final database = FirebaseDatabase.instance.reference();
  TextEditingController _nameTextController = TextEditingController();

  get path => null;

  @override

  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final extractData ExtractData = extractData();

    String getUserUID() {
      final user = FirebaseAuth.instance.currentUser;
      String UID = " ";
      if (user != null) {
        UID = user.uid.toString();
        print("=======================================UID OF USER: "+UID);
        return (UID);

      }
      return UID;
    }


    FutureBuilder(future: storage.listFiles(),
        builder: (BuildContext context,
            AsyncSnapshot<firebase_storage.ListResult> snapshot) {
          print("===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Container();
        });
    child : FutureBuilder(future: storage.downloadURL("IMG_20221008_012520_386.jpg"),
        builder: (BuildContext context,
            AsyncSnapshot<String> snapshot) {
          print("===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            print("CONNECTION STATE IS STABLE");
            return Container(width: 300,
                height: 250,
                child: Image.network(snapshot.data!,
                    fit:BoxFit.cover));
          }
          print("CONNECTION STATE IS UN-STABLE");
          return Container();
        });

    Widget ProfilePic = GestureDetector(
        onTap: () async {
          print('image pressed');
          final results = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['png', 'jpg'],
          );
          if (results == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No File Selected"),
              ),
            );
            return null;
          }

          final path = results.files.single.path!;
          //final fileName = results.files.single.name;

          storage
              .uploadFile(path, getUserUID())
              .then((value) => print("profile picture uploaded   FILENAME:"+path));

          print("PATH" + path);
          print("FILENAME: " + ExtractData.getUserEmail());
        },
        // TO INITIALIZE THE PROFILE PICTURE
        child : FutureBuilder(future: storage.downloadURL(ExtractData.getUserUID()),
            builder: (BuildContext context,
                AsyncSnapshot<String> snapshot) {

              print("===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
              getUserUID();
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                print("CONNECTION STATE IS STABLE");
                return Container(width: 300,
                    height: 250,
                    child: Image.network(snapshot.data!,
                        fit:BoxFit.cover));
              }
              print("CONNECTION STATE IS UN-STABLE");
              return Container();
            })
    );

    Widget ChangeProfilePic = GestureDetector(
        onTap: () async {

          print('image pressed');
          final results = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['png', 'jpg'],
          );
          if (results == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No File Selected"),
              ),
            );
            return null;
          }

          final path = results.files.single.path!;
          //final fileName = results.files.single.name;

          storage
              .uploadFile(path, getUserUID())
              .then((value) => print("profile picture uploaded   FILENAME:"+path));

          print("PATH" + path);
          print("FILENAME: " + ExtractData.getUserEmail());
        },
        child: Text(
          'Change Profile Picture',
          style: TextStyle(color: kPrimaryDarkColor),

        ));

    Widget FullName = TextFormField(
      keyboardType: TextInputType.name,
      controller: _nameTextController,
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

    Widget SaveButton = ElevatedButton(
      child: Text(
        "Save Changes",
        style: TextStyle(fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
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
        //final userInformation = database.child('USERS'+getUserEmail()+"/");
        FirebaseAuth.instance.currentUser
            ?.updateDisplayName(_nameTextController.text);
        print(_nameTextController.text + "is printed");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArtistProfilePage()),
        );
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Toptext,
                SizedBox(
                  height: 20,
                ),
                ProfilePic,
                SizedBox(
                  height: 20,
                ),
                ChangeProfilePic,
                SizedBox(
                  height: 20,
                ),
                FullName,
                SizedBox(
                  height: 20,
                ),
                AboutMe,
                SizedBox(
                  height: 20,
                ),
                SaveButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}