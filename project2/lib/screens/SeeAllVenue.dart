import 'package:flutter/material.dart';
import 'package:project2/screens/VenuePublicPage.dart';

import 'EventDiscriptionPage.dart';
import 'constraints.dart';

import 'package:project2/screens/PublicArtistProfile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SeeAllVenue extends StatefulWidget {
  const SeeAllVenue({Key? key}) : super(key: key);

  @override
  State<SeeAllVenue> createState() => _SeeAllVenueState();
}

class _SeeAllVenueState extends State<SeeAllVenue> {
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
                  print("data printing");
                  print(data);
                  return ListTile(
                    onTap: () {
                      print("Tapped ");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VenuePublicPage()));
                      print("nav pushed");
                    },
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xff764abc),
                    ),
                    subtitle: Text('Venue'),
                    title: Text(data['Name'].toString()),
                  );
                });
      },
    ));
  }
}
