import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/PublicArtistProfile.dart';
import '../storage_services.dart';
import 'EventDiscriptionPage.dart';
import 'constraints.dart';
import 'package:project2/getData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../artistCollection.dart';
import 'package:firebase_database/firebase_database.dart';
import '../storage_services.dart';
import '../local_data.dart';
import 'dart:async';

class SeeAllArtist extends StatefulWidget {
  const SeeAllArtist({Key? key}) : super(key: key);

  @override
  State<SeeAllArtist> createState() => _SeeAllArtistState();
}

class _SeeAllArtistState extends State<SeeAllArtist> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('collection');
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  String DisplayUid = " ";
  late StreamSubscription _userName;

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("All data printing: ");
    print(allData);
  }

  @override
  void initState() {
    super.initState();
    //activateListeners();
  }

  void activateListeners(String result) {
    _userName = database.child(result + "/Name/Name").onValue.listen((event) {
      final String description1 = event.snapshot.value.toString();
      print("LISTENER: " + description1);
      setState(() {
        DisplayUid = '$description1';
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Artist').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(

                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    print("data printing");
                    print(data);
                    getUID(data.toString());
                    DisplayUid;
                    return GestureDetector(
                        onTap: () {
                          print("Tapped ");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PublicArtistProfile(
                                      data['UID'].toString())));
                          print("nav pushed");
                        },

                        //radius vairacha somehow
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                    future:
                                        storage.downloadURL(data['UID'].toString()),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      // print(
                                      // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                                      //extractData().getUserUID();
                                      print("IMG================================");
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        print(
                                            "IMG================================");
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: NetworkImage(
                                                snapshot.data!,
                                              )),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: CircleAvatar(
                                            radius: 40,
                                            child:Image.asset (
                                                'assets/images/user.png',),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        );
                                      }
                                    }),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  data['Name'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    color: kPrimaryDarkColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  });
        },
      ),
    );
  }

  String getUID(String uid) {
    String result = "";
    String displayName = "";
    result = uid.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    result = result.substring(3);
    print("results: " + result);
    print("DISPLAY NAME: " + displayName);
    return displayName;
  }
}
