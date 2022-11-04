import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/BookingOrReg.dart';
import 'package:project2/screens/PublicArtistProfile.dart';
import 'package:project2/screens/constraints.dart';
import '../storage_services.dart';

class EventDiscription extends StatefulWidget {
  final uid;

  EventDiscription(this.uid);

  //const EventDiscription({Key? key}) : super(key: key);

  @override
  State<EventDiscription> createState() => _EventDiscriptionState();
}

class _EventDiscriptionState extends State<EventDiscription> {
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Events')
                .doc(widget.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {}
              var data = snapshot.data!.data();
              var eventName = data!['Event Name'];
              print("UID IN EVENT===========" + widget.uid);
              var eventDescription = data['Event Description'].toString();
              var specialAttraction = data['Special Attraction'].toString();
              var date = data['Date'].toString();
              var time = data['Time'].toString();
              var venueUID = data['Venue UID'].toString();
              var artistUID = data['Artist UID'].toString();
              var eventType = data['Event Type'].toString();
              return SafeArea(
                child: Container(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Event name
                      Center(
                        child: Text(
                          eventName,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Comfortaa',
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        'Time',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          color: Colors.black45,
                        ),
                      ),
                      //discription
                      Text(
                        'Discription',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        eventDescription,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // Text(
                      //   'Event Type',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontFamily: 'Comfortaa',
                      //     color: kPrimaryColor,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   eventType,
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontFamily: 'Comfortaa',
                      //     color: Colors.black45,
                      //   ),
                      // ),
                      //Venue
                      Text(
                        'Venue',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: storage.downloadURL(artistUID+date),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done &&
                                snapshot.hasData) {
                              return CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                    snapshot.data!,
                                  ));
                            }
                            return Container();
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      //artist disc
                      Text(
                        'Who is performing',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PublicArtistProfile(artistUID)));
                        },
                        child: FutureBuilder(
                            future: storage.downloadURL(artistUID),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                      snapshot.data!,
                                    ));
                              }
                              return Container();
                            }),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Special Attractions',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        specialAttraction,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                            child: Text(
                              "I want to go",
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                (kPrimaryColor),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookingOrReg(venueUID.toString()),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
