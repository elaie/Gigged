import 'package:flutter/material.dart';
import 'package:project2/getData.dart';
import 'package:project2/screens/constraints.dart';
import '../storage_services.dart';
class PublicArtistProfile extends StatefulWidget {
  const PublicArtistProfile({Key? key}) : super(key: key);

  @override
  State<PublicArtistProfile> createState() => _PublicArtistProfileState();

}

class _PublicArtistProfileState extends State<PublicArtistProfile> {
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  var _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_top.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Artist username here',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 20),
                //profile picture
                GestureDetector(
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
                      }),
                ),
                SizedBox(height: 20),
                //bio
                Text(
                  'About me',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                Container(
                  child:Text('*insert bio here*',),
                ),
                //buttons
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //message me button
                    ElevatedButton(
                      child: Text(
                        "Message me",
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
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //ratings
                Text(
                  "Ratings",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kPrimaryDarkColor),
                ),
                //stars
                AnimatedPositioned(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                            (index) => IconButton(
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
                SizedBox(height: 20),
                //upcoming gigs
                Text(
                  'Upcoming gigs',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                Container(
                  height: 170,
                  width: 300,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25)
                  ),

                  child: Text('*Content here\n fyi it is green just so we can see the size of container ik it looks weird*'),
                ),
                SizedBox(height: 20),
                //highlights
                Text(
                  'Highlights',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                Container(
                  height: 170,
                  width: 300,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)
                  ),

                  child: Text('*Content here\n are we adding highlights? idk lmk*'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
