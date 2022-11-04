import 'package:flutter/material.dart';
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
              : ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs[index].data()
                as Map<String, dynamic>;
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
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: storage
                                  .downloadURL(data['UID'].toString()),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
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
                                  return CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        snapshot.data!,
                                      ));
                                } else {
                                  return CircleAvatar(
                                    radius: 40,
                                    child: Image.asset(
                                        'assets/images/profile2.webp'),
                                  );
                                }
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          Text(data['Name'].toString()),
                        ],
                      ),
                    ));
              });
        },
      ),
    );
  }
}
