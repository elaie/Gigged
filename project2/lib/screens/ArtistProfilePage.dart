import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/EditProfilePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/welcome_screen.dart';
import '../storage_services.dart';
import '../getData.dart';
import '../local_data.dart';

class ArtistProfilePage extends StatefulWidget {
  const ArtistProfilePage({Key? key}) : super(key: key);

  @override
  State<ArtistProfilePage> createState() => _ArtistProfilePageState();


}

class _ArtistProfilePageState extends State<ArtistProfilePage> {
  final _database = FirebaseDatabase.instance.reference();

  String displayBio = " ";
  late StreamSubscription _userBio;

  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();
  var _rating = 0;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    _userBio = _database
        .child(ExtractData.getUserUID() + "/BIO/Bio")
        .onValue
        .listen((event) {
      final String description = event.snapshot.value.toString();
      print("LISTENER: " + description);
      setState(() {
        displayBio = '$description';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_top.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 30,),
            Text(
            "Hello there!",
            style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kPrimaryColor),
          ),
              SizedBox(height: 20,),
          Text(
            extractData().getUserName(),
            style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kPrimaryColor),
          ),
              SizedBox(height: 10,),
          //profile picture
          GestureDetector(
              onTap: () {
                print('image pressed');
              },
              child: FutureBuilder(
                  future: storage.downloadURL(ExtractData.getUserUID()),
                  builder: (BuildContext context,
                      AsyncSnapshot<String> snapshot) {
                    // print(
                    // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                    extractData().getUserUID();
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      //print("CONNECTION STATE IS STABLE");
                      return CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            snapshot.data!,
                          ));
                    }
                    // print("CONNECTION STATE IS UN-STABLE");
                    return Container();
                  })),
              SizedBox(height: 20,),
          //bio
              Container(
                child: Column(
                  children: [
                    Text(
                      'About me',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Comfortaa',

                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: kPrimaryDarkColor,),
                    Text(displayBio,
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 16,
                          color: Colors.black45),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
          //edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text(
                  "Edit Profile",
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
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => EditProfilePage(),
                  );
                },
              ),
            ],
          ),
              SizedBox(height: 30,),
          //ratings
          Text(
            "Ratings",
            style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kPrimaryColor),
          ),
          //stars
          AnimatedPositioned(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) =>
                      IconButton(
                        icon: index < _rating
                            ? Icon(Icons.star, size: 32)
                            : Icon(Icons.star_border, size: 32),
                        color: kPrimaryColor,
                        onPressed: () {
                          setState(
                                () {
                              _rating = index + 1;
                            },
                          );
                        },
                      ),
                )),
            duration: Duration(milliseconds: 300),
          ),
              SizedBox(height: 30,),
        //logout button
        ElevatedButton(
          child: Text("Logout"),
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
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation animation,
                          Animation secondaryAnimation) {
                        return WelcomeScreen();
                      },
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation, Widget child) {
                        return new SlideTransition(
                          position: new Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      }),
                      (Route route) => false);
            });
          },
        ),
        ],
      ),
    ),)
    ,
    );

  }

  @override
  void deactivate() {
    _userBio.cancel();
    super.deactivate();
  }

}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    const EditProfilePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

