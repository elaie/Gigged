import 'package:flutter/material.dart';
import 'package:project2/screens/VenuePrivatePage.dart';
import 'package:project2/screens/VenuePublicPage.dart';

import 'EventDiscriptionPage.dart';
import 'constraints.dart';
import '../storage_services.dart';
import 'package:project2/screens/PublicArtistProfile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SeeAllVenue extends StatefulWidget {
  const SeeAllVenue({Key? key}) : super(key: key);

  @override
  State<SeeAllVenue> createState() => _SeeAllVenueState();
}

class _SeeAllVenueState extends State<SeeAllVenue> {
  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Venue').snapshots(),
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
                return GestureDetector(
                    onTap: () {
                      print("Tapped ");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VenuePublicPage(
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
}
