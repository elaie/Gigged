import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('collection');
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  String DisplayUid = " ";
  late StreamSubscription _userName;
  FirebaseAuth _auth = FirebaseAuth.instance;

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
        stream: FirebaseFirestore.instance
            .collection('Artist')
            .doc(_auth.currentUser!.uid)
            .collection("Events")
            .snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    data['ID'] = snapshots.data!.docs[index].id;
                    print("data printing" + data['ID']);
                    print(data);
                    // getUID(data.toString());
                    // DisplayUid;
                    return GestureDetector(
                        onTap: () {
                          print("Tapped ");

                          print("nav pushed");
                        },

                        //radius vairacha somehow
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(data['Event Name'].toString()),
                              SizedBox(width: 200),
                              (data['UPDATABLE']=='TRUE') ?
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("Events")
                                            .doc(data['Venue UID'])
                                            .collection('Events')
                                            .doc(data['Event UID'])
                                            .update({
                                          'Artist Verification': "REJECT",
                                        }).then((value) {
                                          FirebaseFirestore.instance
                                              .collection("Artist")
                                              .doc(_auth.currentUser!.uid)
                                              .collection('Events')
                                              .doc(data['ID'])
                                              .update({
                                            'Artist Verification': "REJECT",
                                            'UPDATABLE':'FALSE',
                                          });
                                        });
                                      },
                                      icon: Icon(Icons.crop_square_sharp)),
                                  IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("Events")
                                            .doc(data['Event UID'])
                                            .update({
                                          'Artist Verification': "ACCEPT",
                                        }).then((value) {
                                          FirebaseFirestore.instance
                                              .collection("Artist")
                                              .doc(_auth.currentUser!.uid)
                                              .collection('Events')
                                              .doc(data['ID'])
                                              .update({
                                            'Artist Verification': "ACCEPT",
                                            'UPDATABLE':'FALSE',
                                          });
                                        });
                                      },
                                      icon: Icon(Icons.check)),
                                ],
                              ):Text(data['Artist Verification'])
                            ],
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
