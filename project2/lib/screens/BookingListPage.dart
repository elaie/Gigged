import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/PublicArtistProfile.dart';
import 'package:project2/screens/constraints.dart';
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
        stream: FirebaseFirestore.instance
            .collection('Venue')
            .doc(uid)
            .collection('Booking List')
            .snapshots(),
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
                    return GestureDetector(
                        onTap: () {
                          print("Tapped ");
                          //POP UP
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: kPrimaryLightColor,
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text("Event Name: " +
                                              data['Event Name'], style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          SizedBox(height: 10,),
                                          Text("Name: " + data['Name'],style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                          ),),
                                          SizedBox(height: 3,),
                                          Text("Contact: " + data['Contact'],style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                          ),),
                                          SizedBox(height: 3,),
                                          Text("Email: " + data['Email'],style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                          ),),
                                          SizedBox(height: 3,),
                                          Text("No. of atendees: " +
                                              data['No Of Attendees'],style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                          ),),
                                        ],
                                      ),
                                    ),
                                    // title: Text("Name: " + data['Name']),
                                    // title: Text("Contact: "+data['Contact']),
                                    // title: Text("Email Address: "+data['Email']),
                                    // title: Text("No Of Attendees: "+data['No Of Attendees']),
                                  ));
                          print("nav pushed");
                        },

                        //radius vairacha somehow
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['Event Name'].toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Comfortaa',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        data['Name'].toString(),
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                        ),
                                      ),
                                    ],
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
