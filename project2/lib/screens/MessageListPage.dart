import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/MessagePage.dart';
import 'package:project2/screens/constraints.dart';
import '../getData.dart';
import '../storage_services.dart';
import 'package:firebase_database/firebase_database.dart';
import '../storage_services.dart';
import '../local_data.dart';
import 'PublicArtistProfile.dart';


class MessageListPage extends StatefulWidget {
  const MessageListPage({Key? key}) : super(key: key);

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  String DisplayUid = " ";


  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Artist').snapshots(),
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
                getUID(data.toString());
                DisplayUid;
                return GestureDetector(
                    onTap: () {
                      print("Tapped ");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessagePage()));
                      print("nav pushed");
                    },

                    //radius vairacha somehow
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        height: 100,
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
                      ),
                    ));
                // return ListTile(
                //   onTap: () {
                //     print("Tapped ");
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => PublicArtistProfile(
                //                 data['Name'].toString())));
                //     print("nav pushed");
                //   },
                //   leading: CircleAvatar(
                //     backgroundColor: const Color(0xff764abc),
                //   ),
                //   subtitle: Text('Artist'),
                //   title: Text(data['Name'].toString()),
                // );
              });
        },
      ),
      // appBar: AppBar(
      //   backgroundColor: kPrimaryColor,
      //   elevation: 8,
      //   /*leading: IconButton(
      //     onPressed: () {},
      //     icon: Icon(Icons.menu),
      //     color: Colors.white,
      //   ),*/
      //   title: Text(
      //     'Inbox',
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       //First message
      //       StreamBuilder<QuerySnapshot>(
      //         stream: FirebaseFirestore.instance.collection('Artist').snapshots(),
      //         builder: (context, snapshots) {
      //           return (snapshots.connectionState == ConnectionState.waiting)
      //               ? Center(
      //             child: CircularProgressIndicator(),
      //           )
      //               : ListView.separated(
      //               separatorBuilder: (context, index) {
      //                 return Divider();
      //               },
      //               itemCount: snapshots.data!.docs.length,
      //               itemBuilder: (context, index) {
      //                 var data = snapshots.data!.docs[index].data()
      //                 as Map<String, dynamic>;
      //                 print("data printing");
      //                 print(data);
      //                 //getUID(data.toString());
      //                 DisplayUid;
      //                 return GestureDetector(
      //                     onTap: () {
      //                       print("Tapped ");
      //                       Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                               builder: (context) => PublicArtistProfile(
      //                                   data['UID'].toString())));
      //                       print("nav pushed");
      //                     },
      //
      //                     //radius vairacha somehow
      //                     child: Card(
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         children: [
      //                           FutureBuilder(
      //                               future: storage
      //                                   .downloadURL(data['UID'].toString()),
      //                               builder: (BuildContext context,
      //                                   AsyncSnapshot<String> snapshot) {
      //                                 // print(
      //                                 // "===================FUTURE BUILDER LIST FILE INITIALIZED=======================");
      //                                 //extractData().getUserUID();
      //                                 print(
      //                                     "IMG================================");
      //                                 if (snapshot.connectionState ==
      //                                     ConnectionState.done &&
      //                                     snapshot.hasData) {
      //                                   print(
      //                                       "IMG================================");
      //                                   return CircleAvatar(
      //                                       radius: 40,
      //                                       backgroundImage: NetworkImage(
      //                                         snapshot.data!,
      //                                       ));
      //                                 } else {
      //                                   return CircleAvatar(
      //                                     radius: 40,
      //                                     child: Image.asset(
      //                                         'assets/images/profile2.webp'),
      //                                   );
      //                                 }
      //                               }),
      //                           SizedBox(
      //                             width: 20,
      //                           ),
      //                           Text(data['Name'].toString()),
      //                         ],
      //                       ),
      //                     ));
      //
      //               });
      //         },
      //       ),
      //       // GestureDetector(
      //       //   onTap: () {
      //       //     Navigator.push(
      //       //       context,
      //       //       MaterialPageRoute(
      //       //         builder: (context) => MessagePage(),
      //       //       ),
      //       //     );
      //       //   },
      //       //   child: Container(
      //       //     decoration: BoxDecoration(
      //       //       border: Border(
      //       //         bottom: BorderSide(
      //       //           color: Colors.black12,
      //       //           width: 1,
      //       //         ),
      //       //       ),
      //       //     ),
      //       //     padding: EdgeInsets.symmetric(
      //       //       horizontal: 20,
      //       //       vertical: 15,
      //       //     ),
      //       //     child: Row(
      //       //       children: [
      //       //         Container(
      //       //           padding: EdgeInsets.all(2),
      //       //           decoration: BoxDecoration(
      //       //             borderRadius: BorderRadius.all(
      //       //               Radius.circular(40),
      //       //             ),
      //       //             //for unread messages
      //       //             border: Border.all(
      //       //               width: 2,
      //       //               color: kPrimaryColor,
      //       //             ),
      //       //             //shape: BoxShape.circle,
      //       //             boxShadow: [
      //       //               BoxShadow(
      //       //                 color: Colors.grey.withOpacity(0.5),
      //       //                 spreadRadius: 2,
      //       //                 blurRadius: 5,
      //       //               ),
      //       //             ],
      //       //           ),
      //       //           child: CircleAvatar(
      //       //             radius: 35,
      //       //             backgroundImage:
      //       //                 AssetImage('assets/images/singerImage.jpg'),
      //       //           ),
      //       //         ),
      //       //         Container(
      //       //           width: MediaQuery.of(context).size.width * 0.65,
      //       //           padding: EdgeInsets.only(left: 20),
      //       //           child: Column(
      //       //             children: [
      //       //               Row(
      //       //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       //                 children: [
      //       //                   Container(
      //       //                     constraints: BoxConstraints(maxWidth: 175),
      //       //                     child: Text(
      //       //                       'Jhon Doe',
      //       //                       style: TextStyle(
      //       //                         fontSize: 16,
      //       //                         fontWeight: FontWeight.bold,
      //       //                         fontFamily: 'Comfortaa',
      //       //                       ),
      //       //                     ),
      //       //                   ),
      //       //                   Text(
      //       //                     '12:30pm',
      //       //                     style: TextStyle(
      //       //                       fontSize: 15,
      //       //                       fontWeight: FontWeight.w300,
      //       //                       color: Colors.black54,
      //       //                     ),
      //       //                   ),
      //       //                 ],
      //       //               ),
      //       //               SizedBox(
      //       //                 height: 10,
      //       //               ),
      //       //               Container(
      //       //                 alignment: Alignment.topLeft,
      //       //                 child: Text(
      //       //                   'hey!',
      //       //                   style: TextStyle(
      //       //                     fontSize: 13,
      //       //                     color: Colors.black54,
      //       //                   ),
      //       //                   overflow: TextOverflow.ellipsis,
      //       //                   maxLines: 2,
      //       //                 ),
      //       //               ),
      //       //             ],
      //       //           ),
      //       //         ),
      //       //       ],
      //       //     ),
      //       //   ),
      //       // ),
      //       //Second message
      //       Container(
      //         decoration: BoxDecoration(
      //           border: Border(
      //             bottom: BorderSide(
      //               color: Colors.black12,
      //               width: 1,
      //             ),
      //           ),
      //         ),
      //         padding: EdgeInsets.symmetric(
      //           horizontal: 20,
      //           vertical: 15,
      //         ),
      //         child: Row(
      //           children: [
      //             Container(
      //               padding: EdgeInsets.all(2),
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(40),
      //                 ),
      //                 //for unread messages
      //                 border: Border.all(
      //                   width: 2,
      //                   color: kPrimaryColor,
      //                 ),
      //                 //shape: BoxShape.circle,
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.grey.withOpacity(0.5),
      //                     spreadRadius: 2,
      //                     blurRadius: 5,
      //                   ),
      //                 ],
      //               ),
      //               child: CircleAvatar(
      //                 radius: 35,
      //                 backgroundImage:
      //                     AssetImage('assets/images/singerImage.jpg'),
      //               ),
      //             ),
      //             Container(
      //               width: MediaQuery.of(context).size.width * 0.65,
      //               padding: EdgeInsets.only(left: 20),
      //               child: Column(
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Container(
      //                         constraints: BoxConstraints(maxWidth: 175),
      //                         child: Text(
      //                           'Jane Doe',
      //                           style: TextStyle(
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.bold,
      //                             fontFamily: 'Comfortaa',
      //                           ),
      //                         ),
      //                       ),
      //                       Text(
      //                         '12:30pm',
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           fontWeight: FontWeight.w300,
      //                           color: Colors.black54,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Container(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       'Whars up?',
      //                       style: TextStyle(
      //                         fontSize: 13,
      //                         color: Colors.black54,
      //                       ),
      //                       overflow: TextOverflow.ellipsis,
      //                       maxLines: 2,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //
      //       Container(
      //         child: Text('**'),
      //       ),
      //     ],
      //   ),
      // ),

    );

  }
  String getUID(String uid) {
    String result = "";
    String displayName = "";
    result = uid.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    result = result.substring(3);
    print("results: " + result);

    // _userName =
    //     database.child(result + "/Name/Name").onValue.listen((event) {
    //       final String description1 = event.snapshot.value.toString();
    //       print("LISTENER: " + description1);
    //         displayName = '$description1';
    //
    //     });
    print("DISPLAY NAME: " + displayName);
    //activateListeners(result);
    return displayName;
  }
}
