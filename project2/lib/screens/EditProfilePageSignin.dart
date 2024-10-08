import 'package:flutter/material.dart';
import 'package:project2/screens/ArtistHomepage.dart';
import 'dart:io';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../storage_services.dart';
import 'UserHomePage.dart';
import 'VenueHomePage.dart';
import 'constraints.dart';
import '../getData.dart';
import 'ArtistProfilePage.dart';
import 'constraints.dart';

class EditProfilePageSignin extends StatefulWidget {
  final value;
  final accType;

  EditProfilePageSignin(this.value, this.accType);

  @override
  State<EditProfilePageSignin> createState() => _EditProfilePageSigninState();
}

class _EditProfilePageSigninState extends State<EditProfilePageSignin> {
  final _database = FirebaseDatabase.instance.reference();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _bioTextController = TextEditingController();

  get path => null;

  String displayBio = "test";
  late StreamSubscription _userBio;

  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();
  var _rating = 0;

  @override
  // void initState() {
  //   super.initState();
  //   activateListeners();
  //   //_nameTextController.text = extractData().getUserName();
  //   //_bioTextController.text=displayBio;
  // }
  //
  // void activateListeners() {
  //   _userBio = _database
  //       .child(ExtractData.getUserUID() + "/BIO/Bio")
  //       .onValue
  //       .listen((event) {
  //     final String description = event.snapshot.value.toString();
  //     print("LISTENER: " + description);
  //     setState(() {
  //       _bioTextController.text='$description';
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final extractData ExtractData = extractData();
    final setName = _database.child(ExtractData.getUserUID() + '/Name/');
    final setBio = _database.child(ExtractData.getUserUID() + '/BIO/');
    FutureBuilder(
        future: storage.listFiles(),
        builder: (BuildContext context,
            AsyncSnapshot<firebase_storage.ListResult> snapshot) {
          print(
              "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
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
    child:
    FutureBuilder(
        future: storage.downloadURL("IMG_20221008_012520_386.jpg"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          print(
              "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            print("CONNECTION STATE IS STABLE");
            return Container(
                width: 300,
                height: 250,
                child: Image.network(snapshot.data!, fit: BoxFit.cover));
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

          storage.uploadFile(path, ExtractData.getUserUID()).then(
              (value) => print("profile picture uploaded   FILENAME:" + path));
        },
        // TO INITIALIZE THE PROFILE PICTURE
        child: FutureBuilder(
            future: storage.downloadURL(ExtractData.getUserUID()),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              print(
                  "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
              ExtractData.getUserUID();
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                print("CONNECTION STATE IS STABLE");
                return Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    //for circle outline on pp
                    border: Border.all(
                      width: 3,
                      color: kPrimaryColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(snapshot.data!),
                    //child: Image.network(snapshot.data!, fit: BoxFit.cover)
                  ),
                );
              }
              print("CONNECTION STATE IS UN-STABLE");
              return CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/user.png'),
              );
            }));
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

          storage.uploadFile(path, ExtractData.getUserUID()).then(
              (value) => print("profile picture uploaded   FILENAME:" + path));

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
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(
              color: kPrimaryLightColor,
            )),
        labelStyle: TextStyle(color: kPrimaryDarkColor),
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
      controller: _bioTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(
              color: kPrimaryLightColor,
            )),
        labelStyle: TextStyle(color: kPrimaryDarkColor),
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
        setBio.set({'Bio': _bioTextController.text});
        setName.set({'Name': _nameTextController.text});
        FirebaseAuth.instance.currentUser
            ?.updateDisplayName(_nameTextController.text);
        Map<String, String> dataToSave = {
          'UID': widget.value,
          'Name': _nameTextController.text,
          'Bio': _bioTextController.text,
          'Latitude': " ",
          'Longitude': " ",
        };
        FirebaseFirestore.instance
            .collection(widget.accType.toString())
            .doc(widget.value)
            .set(dataToSave);
        //FirebaseFirestore.instance.collection('Artist').doc().set({"Name":_nameTextController.text});
        //FirebaseFirestore.instance.collection('Artist').doc().set({"UID":});
        print("USER UID================" + widget.value);
        if (widget.accType == "Artist") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtistHomePage(widget.accType),
            ),
          );
        } else if (widget.accType == "User") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserHomePage(widget.accType),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VenueHomePage(widget.accType),
            ),
          );
        }
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
