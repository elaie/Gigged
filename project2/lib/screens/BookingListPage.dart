import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/PublicArtistProfile.dart';
import '../storage_services.dart';
import 'package:project2/getData.dart';
class BookingListPage extends StatelessWidget {
  const BookingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final extractData ExtractData = extractData();
    final uid = extractData().getUserUID().toString();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance.collection('Venue').doc(uid).collection('Booking List').snapshots(),
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
                      //POP UP
                      showDialog(context: context, builder: (context)=> AlertDialog(
                        title: Text("Name: "+data['Name']),
                        //title: Text("Contact: "+data['Contact']),
                        //title: Text("Email Address: "+data['Email']),
                        //title: Text("No Of Attendees: "+data['No Of Attendees']),
                      ));
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
