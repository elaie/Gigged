import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/welcome_screen.dart';
import 'package:flutter/src/rendering/stack.dart';
import '../storage_services.dart';
import 'EventDiscriptionPage.dart';

class VenuePublicPage extends StatefulWidget {
  final uid;

  VenuePublicPage(this.uid);

  //const VenuePublicPage({Key? key}) : super(key: key);

  @override
  State<VenuePublicPage> createState() => _VenuePublicPage();
}

class _VenuePublicPage extends State<VenuePublicPage> {
  final Storage storage = Storage();
  var _ratings=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Venue')
                .doc(widget.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {}
              var data = snapshot.data!.data();
              // var eventName = data!['Event Name'];
              print("UID IN EVENT===========" + widget.uid);
              var Bio = data!['Bio'].toString();
              var Latitude = data!['Latitude'].toString();
              var Longitude = data['Longitude'].toString();
              var Name = data['Name'].toString();
              //var artistUID = data['Artist UID'].toString();
              return SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/main_top.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 255,
                        width: 400,
                        child: Stack(fit: StackFit.expand, children: [
                          GestureDetector(
                              onTap: () {
                                print('cover is pressed');
                              },
                              //coverpage
                              child: Column(children: [
                                Container(
                                    height: 170,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://www.pngmart.com/files/4/Party-PNG-Pic.png')),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ])),
                          Positioned(
                            bottom: 20.0,
                            left: 100.0,
                            child: GestureDetector(
                              onTap: () {
                                print('image is pressed');
                              },
                              //story
                              child: FutureBuilder(
                                  future: storage.downloadURL(widget.uid),
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
                                    return CircleAvatar(
                                      radius: 70,
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 253, 253),
                                      backgroundImage: NetworkImage(
                                          'https://pngimg.com/uploads/party/party_PNG1.png'),
                                    );
                                  }),
                            ),
                          )
                        ]),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              'About us',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black38,
                            ),
                            Text(
                              Bio,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            //Message button
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              ],
                            ),
                            SizedBox(height: 20),
                            //ratings
                            Text(
                              "Rate us",
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: kPrimaryDarkColor),
                            ),
                            //Stars
                            AnimatedPositioned(
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    5,
                                    (index) => IconButton(
                                          icon: Icon(Icons.star, size: 32),
                                          color: Color.fromARGB(
                                              255, 204, 165, 249),
                                          onPressed: () {},
                                        )),
                              ),
                              duration: Duration(milliseconds: 300),
                            ),
                            //popular event

                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Popular events',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: kPrimaryDarkColor,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
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
                                        return (data['Venue UID'] ==
                                            widget.uid)
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
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
