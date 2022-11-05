import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/getData.dart';
import 'package:project2/screens/MessagePage.dart';
import 'package:project2/screens/constraints.dart';
import 'package:firebase_database/firebase_database.dart';
import '../storage_services.dart';
import '../local_data.dart';
import 'dart:async';

import 'EventDiscriptionPage.dart';

class PublicArtistProfile extends StatefulWidget {
  //const PublicArtistProfile({Key? key}) : super(key: key);
  String artistURL;

  PublicArtistProfile(this.artistURL);

  @override
  State<PublicArtistProfile> createState() => _PublicArtistProfileState();
}

class _PublicArtistProfileState extends State<PublicArtistProfile> {
  final _database = FirebaseDatabase.instance.reference();

  String displayBio = " ";
  String displayName = " ";
  late StreamSubscription _userBio;
  late StreamSubscription _userName;

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
    _userBio =
        _database.child(widget.artistURL + "/BIO/Bio").onValue.listen((event) {
      final String description = event.snapshot.value.toString();
      print("LISTENER: " + description);
      setState(() {
        displayBio = '$description';
      });
    });
    _userName = _database
        .child(widget.artistURL + "/Name/Name")
        .onValue
        .listen((event) {
      final String description1 = event.snapshot.value.toString();
      print("LISTENER: " + description1);
      setState(() {
        displayName = '$description1';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('Artist')
              .doc(widget.artistURL)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
            child: CircularProgressIndicator(),
            );
            }
            else{

            }
            var data = snapshot.data!.data();
            var Name = data!['Name'];
            var Bio = data['Bio'].toString();
            var artistUID = data['UID'].toString();
            return SafeArea(
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
                        Name,
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: kPrimaryColor,
                        ),
                      ),

                      SizedBox(height: 20),
                      //profile picture
                      GestureDetector(
                        child: FutureBuilder(
                            future: storage.downloadURL(artistUID),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              // print(
                              // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                              extractData().getUserUID();
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                //print("CONNECTION STATE IS STABLE");
                                return CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                      snapshot.data!,
                                    ));
                              }
                              print("artist: " + artistUID);
                              // print("CONNECTION STATE IS UN-STABLE");
                              return Container();
                            }),
                      ),
                      SizedBox(height: 20),
                      //bio
                      Text(
                        "BIO",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: kPrimaryColor,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: kPrimaryDarkColor,
                      ),
                      Container(
                        child: Text(Bio),
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
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Artist').doc(artistUID).collection("Events")
                            .snapshots(),
                        builder: (context, snapshots) {
                          print("*********about to return ");
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 200.0,
                                  child: ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.all(10),
                                      itemCount: snapshots.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var data = snapshots.data!.docs[index]
                                            .data() as Map<String, dynamic>;
                                        data['ID']=snapshots.data!.docs[index].id.toString();
                                        return ((data['Artist Verification']=='ACCEPT'))?Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print("Tapped ");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EventDiscription(data['Event UID'])));
                                                print("nav pushed");
                                              },
                                              //radius vairacha somehow
                                              child: FutureBuilder(
                                                  future: storage.downloadURL(
                                        data['Artist UID'].toString()+data['Date'].toString()),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<String>
                                                      snapshot) {
                                                    // print(
                                                    // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                                                    //extractData().getUserUID();
                                                    print(
                                                        "IMG================================");
                                                    if (snapshot.connectionState ==
                                                        ConnectionState.done &&
                                                        snapshot.hasData) {
                                                      print(
                                                          "IMG================================");
                                                      return Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 100,
                                                              width: 150,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                                  Radius.circular(
                                                                      50),
                                                                ),
                                                              ),
                                                              child: Image.network(
                                                                snapshot.data!,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                            //username
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              data['Event Name']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                kPrimaryDarkColor,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontFamily:
                                                                'Comfortaa',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      return Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                          //aaaaaaa child: CircleAvatar(
                                                          //   radius: 50,
                                                          //   backgroundColor:
                                                          //       Colors.transparent,
                                                          //   child: Image.asset(
                                                          //       'assets/images/user.png'),
                                                          // ),
                                                          child:Text(
                                                            data['Event Name']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: kPrimaryDarkColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Comfortaa',
                                                            ),
                                                          ));
                                                    }
                                                  }),
                                            )
                                          ],
                                        ): Container();
                                      }),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      //highlights
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _userBio.cancel();
    _userName.cancel();
    super.deactivate();
  }
}
