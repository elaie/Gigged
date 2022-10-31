import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project2/screens/ArtistProfilePage.dart';
import 'package:project2/screens/EventDiscriptionPage.dart';
import 'package:project2/screens/MessageListPage.dart';
import 'package:project2/screens/PublicArtistProfile.dart';
import 'package:project2/screens/SeeAllVenue.dart';
import '../storage_services.dart';
import 'SeeAllArtist.dart';
import 'SeeAllPageEvent.dart';
import 'VenuePublicPage.dart';
import 'constraints.dart';
import 'package:project2/getData.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  String artistUID = "";
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('Artist');
  CollectionReference users = FirebaseFirestore.instance.collection('Artist');

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    //QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("UID").get();

    // Get data from docs and convert map to List

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("COLLECTION DATA: ");
    print(allData[0]);
    String dummy = allData[0].toString();
    print("DUMMY: " + dummy);
    artistUID = dummy.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    setState(() {
      artistUID = artistUID.substring(3, 31);
    });

    print("results: " + artistUID);
  }

  @override
  Widget build(BuildContext context) {
    //storage.listFiles();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_top.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            // padding: EdgeInsets.symmetric(vertical: 30.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //logo
                    Container(
                        alignment: Alignment.center,
                        height: 130,
                        child: Image.asset('assets/images/Gigged-1.png',
                            fit: BoxFit.fill)),
                    Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessageListPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.message_outlined,
                            color: kPrimaryDarkColor,
                          ),
                        )),
                  ],
                ),
              ),
              //upcoming events
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Upcoming Events',
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: kPrimaryDarkColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeAllPageEvent(),
                                  ),
                                );
                              },
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ])),
                  SizedBox(
                    height: 20,
                  ),
                  //images for upcoming events
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //event 1
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 150,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EventDiscription(),
                                      ),
                                    );
                                    print('first image pressed');
                                  },
                                  child: Image.network(
                                    'https://www.pngplay.com/wp-content/uploads/6/Party-Concert-Background-PNG-Image.png',
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Arbitary Event',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Comfortaa',
                                          ),
                                        ),
                                        Text(
                                          'From 9 oct-10 oct          '
                                              'Venue - LOD club',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Comfortaa',
                                          ),
                                        ),
                                      ],
                                    ),),
                                )
                              ]),
                        ),
                        //event 2
                        Container(
                          height: 150,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print('image pressed');
                                  },
                                  child: Image.network(
                                    'https://www.pngplay.com/wp-content/uploads/6/Party-Concert-Background-PNG-Image.png',
                                  ),
                                ),
                                //texts for upcoming events
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ABCD Event',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Comfortaa',
                                            ),
                                          ),
                                          Text(
                                            'From 11 oct-15 oct         '
                                                'Venue - dorsia Club',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Comfortaa',
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //trending artist
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Trending Artist',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: kPrimaryDarkColor,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeAllArtist(),
                                  ),
                                );
                                print('see all pressed');
                              },
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                            ),
                          ])),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Artist')
                        .snapshots(),
                    builder: (context, snapshots) {
                      print("*********about to return ");
                      return ListView.builder(
                        //scrollDirection: Axis.horizontal,
                        //   padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("Tapped ");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PublicArtistProfile(
                                                    data['UID'].toString())));
                                    print("nav pushed");
                                  },

                                  //radius vairacha somehow
                                  child: FutureBuilder(
                                      future: storage.downloadURL(data['UID'].toString()),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        // print(
                                        // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                                        //extractData().getUserUID();
                                        print("IMG================================");
                                        if (snapshot.connectionState == ConnectionState.done &&
                                            snapshot.hasData) {
                                          print("IMG================================");
                                          return CircleAvatar(
                                              radius: 70,
                                              backgroundImage: NetworkImage(
                                                snapshot.data!,
                                              ));

                                        }
                                        else {
                                          return CircleAvatar(
                                            radius: 70,
                                            child: Image.asset('assets/images/profile2.webp'),
                                          );
                                        }
                                        // print("CONNECTION STATE IS UN-STABLE");
                                        return Container();
                                      }),
                                  // child: CircleAvatar(
                                  //   backgroundImage: NetworkImage(snapshots.data!),
                                  //   child: Text(data['Name'].toString()),
                                  //   radius: 50,
                                  // ),
                                )
                              ],
                            );
                            // return ListTile(
                            //
                            //   onTap: () {
                            //     print("Tapped ");
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 PublicArtistProfile(
                            //                     data['UID'].toString())));
                            //     print("nav pushed");
                            //   },
                            //
                            //   //radius vairacha somehow
                            //   visualDensity: VisualDensity(vertical: 4),
                            //   leading: CircleAvatar(
                            //
                            //     //backgroundImage: NetworkImage(),
                            //     child: Text(data['Name'].toString()),
                            //     radius: 50,
                            //
                            //   ),
                            // );
                          });
                    },
                  ),

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       //artist 1
                  //       Padding(
                  //         padding: const EdgeInsets.only(
                  //             left: 10.0, right: 10, top: 7),
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         PublicArtistProfile(artistUID)));
                  //             print('artist1 image pressed');
                  //           },
                  //           child: FutureBuilder(
                  //               future: storage.downloadURL(artistUID),
                  //               builder: (BuildContext context,
                  //                   AsyncSnapshot<String> snapshot) {
                  //                 print("ARTIST UID: " + artistUID);
                  //                 if (snapshot.connectionState ==
                  //                     ConnectionState.done &&
                  //                     snapshot.hasData) {
                  //                   print("CONNECTION STATE IS STABLE");
                  //                   return CircleAvatar(
                  //                       radius: 70,
                  //                       backgroundImage: NetworkImage(
                  //                         snapshot.data!,
                  //                       ));
                  //                 }
                  //                 print("CONNECTION STATE IS UN-STABLE");
                  //                 return CircleAvatar(
                  //                   radius: 70,
                  //                   //FIX THIS
                  //                   // backgroundImage: Image.asset("assets/images/profile2.webp"),
                  //                 );
                  //               }),
                  //         ),
                  //       ),
                  //       //artist 2
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) =>
                  //                       PublicArtistProfile(artistUID)));
                  //           print('artist 2 image pressed');
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 10, right: 10, top: 10),
                  //           child: const CircleAvatar(
                  //             radius: 60,
                  //             backgroundImage:
                  //             AssetImage('assets/images/singerImage.jpg'),
                  //             backgroundColor: Colors.transparent,
                  //           ),
                  //         ),
                  //       ),
                  //       //artist 3
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) =>
                  //                       PublicArtistProfile(artistUID)));
                  //           print('artist 3 image pressed');
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 10, right: 10, top: 10),
                  //           child: const CircleAvatar(
                  //             radius: 60,
                  //             backgroundImage:
                  //             AssetImage('assets/images/singerImage.jpg'),
                  //             backgroundColor: Colors.transparent,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 30.0),
                  //trending venues
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Trending venues',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontFamily: 'Comfortaa',
                                color: kPrimaryDarkColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeAllVenue(),
                                  ),
                                );
                              },
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //images and discription for venues
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //first venue
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      print('image pressed');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VenuePublicPage(),
                                        ),
                                      );
                                    },
                                    child:
                                    Image.asset('assets/images/club.jpg'),
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              'LOD Club',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Comfortaa',
                                              ),
                                            ),
                                            Text(
                                              'opening hours- 9pm to 2am      ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Comfortaa',
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                            //second venue
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      print('image pressed');
                                    },
                                    child:
                                    Image.asset('assets/images/club.jpg'),
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              'LOD Club',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Comfortaa',
                                              ),
                                            ),
                                            Text(
                                              'opening hours- 9pm to 2am      ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Comfortaa',
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                            //third venue
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      print('image pressed');
                                    },
                                    child: Image.asset(
                                      'assets/images/club.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              'LOD Club',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Comfortaa',
                                              ),
                                            ),
                                            Text(
                                              'opening hours- 9pm to 2am      ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Comfortaa',
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
