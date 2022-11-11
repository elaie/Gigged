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
                    //messages
                    // Container(
                    //     child: IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => MessageListPage(),
                    //       ),
                    //     );
                    //   },
                    //   icon: Icon(
                    //     Icons.message_outlined,
                    //     color: kPrimaryDarkColor,
                    //   ),
                    // )),
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
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Events')
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
                                    data['ID'] = snapshots.data!.docs[index].id
                                        .toString();
                                    return (data['Artist Verification'] ==
                                            'ACCEPT')
                                        ? Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print("Tapped ");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventDiscription(
                                                                  data['ID'])));
                                                  print("nav pushed");
                                                },
                                                //radius vairacha somehow
                                                child: FutureBuilder(
                                                    future: storage.downloadURL(
                                                        data['Artist UID'].toString()+data['Date'].toString()),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<String>
                                                            snapshot) {
                                                      // print(
                                                      // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                                                      //extractData().getUserUID();
                                                      print(
                                                          "IMG================================");
                                                      if (snapshot.connectionState ==
                                                              ConnectionState
                                                                  .done &&
                                                          snapshot.hasData) {
                                                        print(
                                                            "IMG================================");
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                    Radius
                                                                        .circular(
                                                                            50),
                                                                  ),
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  snapshot
                                                                      .data!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              //username
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                data['Event Name']
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      kPrimaryDarkColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          20.0),
                                                              child: Image.asset(
                                                                  'assets/images/Concert.png'),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      // print("CONNECTION STATE IS UN-STABLE");
                                                      return Container();
                                                    }),
                                              )
                                            ],
                                          )
                                        : Container();
                                  }),
                            ),
                          ],
                        ),
                      );
                    },
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
                  //images for trending artists
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Artist')
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
                                                            data['UID']
                                                                .toString())));
                                            print("nav pushed");
                                          },

                                          //radius vairacha somehow
                                          child: FutureBuilder(
                                              future: storage.downloadURL(
                                                  data['UID'].toString()),
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
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 70,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              snapshot.data!,
                                                            )),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          data['Name']
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
                                                            30.0),
                                                    child: CircleAvatar(
                                                      radius: 50,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: Image.asset(
                                                          'assets/images/user.png'),
                                                    ),
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
                                  }),
                            ),
                          ],
                        ),
                      );
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
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Venue')
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
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print("Tapped ");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VenuePublicPage(data[
                                                                    'UID']
                                                                .toString())));
                                                print("nav pushed");
                                              },

                                              //radius vairacha somehow
                                              child: FutureBuilder(
                                                  future: storage.downloadURL(
                                                      data['UID'].toString()),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                    // print(
                                                    // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
                                                    //extractData().getUserUID();
                                                    print(
                                                        "IMG================================");
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .done &&
                                                        snapshot.hasData) {
                                                      print(
                                                          "IMG================================");
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
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
                                                                  Radius
                                                                      .circular(
                                                                          50),
                                                                ),
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                snapshot.data!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            //username
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              data['Name']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    kPrimaryDarkColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        20.0),
                                                            child: Image.asset(
                                                                'assets/images/Concert.png'),
                                                          ),
                                                        ),
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
                                      }),
                                ),
                              ],
                            ),
                          );
                        },
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
