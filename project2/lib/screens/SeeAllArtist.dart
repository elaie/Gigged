import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/PublicArtistProfile.dart';
import '../storage_services.dart';
import 'EventDiscriptionPage.dart';
import 'constraints.dart';
import 'package:project2/getData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../artistCollection.dart';
import 'package:firebase_database/firebase_database.dart';
import '../storage_services.dart';
import '../local_data.dart';
import 'dart:async';

class SeeAllArtist extends StatefulWidget {
  const SeeAllArtist({Key? key}) : super(key: key);

  @override
  State<SeeAllArtist> createState() => _SeeAllArtistState();
}

class _SeeAllArtistState extends State<SeeAllArtist> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('collection');
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  final local_data Local_data = local_data();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  String DisplayUid = " ";
  late StreamSubscription _userName;

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("All data printing: ");
    print(allData);
  }

  // void testData(){
  //   print("DATANASE: "+database.onValue.toString());
  //
  //   database.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     final DATA = event.snapshot.child("BIO").value.toString();
  //
  //     //final data2=event.snapshot.child(path)
  //     final setBio = database.orderByChild("/BIO");
  //
  //     print("DATANEW: "+data.toString());
  //     print("DATANEW22222: "+DATA.toString());
  //     //print("DATANEW3333333: "+setBio.toString());
  //   });
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  //   testData();
  // }

  @override
  void initState() {
    super.initState();
    //activateListeners();
  }

  void activateListeners(String result) {

    _userName =
        database.child(result + "/Name/Name").onValue.listen((event) {
          final String description1 = event.snapshot.value.toString();
          print("LISTENER: " + description1);
          setState(() {
            DisplayUid = '$description1';
          });

        });


  }

  // String name = "";
  // artistCollection ArtistCollection = artistCollection();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   print("ARTIST COL TEST");
  //   print(ArtistCollection.artistUID);
  //   ArtistCollection.getData();
  // }
  // void getData()
  // {
  //   ArtistCollection.getData();
  //   print("TEST ARTIST CLASS :");
  //   print(ArtistCollection.artistUID);
  // }
  //
  // @override

   Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //         title: Card(
  //       child: TextField(
  //         decoration: InputDecoration(
  //             prefixIcon: Icon(Icons.search), hintText: 'Search...'),
  //         onChanged: (val) {
  //           setState(() {
  //             //name = val;
  //           });
  //         },
  //       ),
  //     )),
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Expanded(
  //               child: FirebaseAnimatedList(query: database, itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){
  //                 return Text("TEST DATA");
  //               }),
  //             )
  //       //    ListTile(
  //       //   title: Text("test"),
  //       // ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  return Scaffold(
      appBar: AppBar(
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (val) {
                setState(() {
                  //name = val;
                });
              },
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Artist').snapshots(),
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
                getUID(data.toString());
                DisplayUid;
                //print(all)
                // if (name.isEmpty) {
                //   return ListTile(
                //     title: Text(
                //       data['name'],
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //       style: TextStyle(
                //           color: Colors.black54,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     subtitle: Text(
                //       data['email'],
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //       style: TextStyle(
                //           color: Colors.black54,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     leading: CircleAvatar(
                //       backgroundImage: NetworkImage(data['image']),
                //     ),
                //   );
                // }
                return ListTile( onTap: () {
                  print("Tapped ");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PublicArtistProfile(data['Name'].toString())));
                  print("nav pushed");
                },title: Text(data['Name'].toString()),);
                // if (data['UID']) {
                //   return ListTile(
                //     title: Text(
                //       data.toString(),
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //       style: TextStyle(
                //           color: Colors.black54,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     // subtitle: Text(
                //     //   data['email'],
                //     //   maxLines: 1,
                //     //   overflow: TextOverflow.ellipsis,
                //     //   style: TextStyle(
                //     //       color: Colors.black54,
                //     //       fontSize: 16,
                //     //       fontWeight: FontWeight.bold),
                //     // ),
                //     // leading: CircleAvatar(
                //     //   backgroundImage: NetworkImage(data['image']),
                //     // ),
                //   );
                // }
                return Container();
              });
        },
      )
  );
}
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     body: SafeArea(
// //       child: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             //first block
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => PublicArtistProfile(''),
// //                   ),
// //                 );
// //               },
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   border: Border(
// //                     bottom: BorderSide(
// //                       color: Colors.black12,
// //                       width: 1,
// //                     ),
// //                   ),
// //                 ),
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: 20,
// //                   vertical: 15,
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                       padding: EdgeInsets.all(2),
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.all(
// //                           Radius.circular(40),
// //                         ),
// //                         //for unread messages
// //                         border: Border.all(
// //                           width: 2,
// //                           color: kPrimaryColor,
// //                         ),
// //                         //shape: BoxShape.circle,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.grey.withOpacity(0.5),
// //                             spreadRadius: 2,
// //                             blurRadius: 5,
// //                           ),
// //                         ],
// //                       ),
// //                       child: CircleAvatar(
// //                         radius: 35,
// //                         backgroundImage:
// //                         AssetImage('assets/images/singerImage.jpg'),
// //                       ),
// //                     ),
// //                     Container(
// //                       width: MediaQuery.of(context).size.width * 0.65,
// //                       padding: EdgeInsets.only(left: 20),
// //                       child: Column(
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Container(
// //                                 constraints: BoxConstraints(maxWidth: 175),
// //                                 child: Text(
// //                                   'Khattra artist',
// //                                   style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontFamily: 'Comfortaa',
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           SizedBox(
// //                             height: 10,
// //                           ),
// //                           Container(
// //                             alignment: Alignment.topLeft,
// //                             child: Text(
// //                               'Kati bolchas k kaile kai ta chup lag kati text gareko block handinchu talai',
// //                               style: TextStyle(
// //                                 fontSize: 13,
// //                                 color: Colors.black54,
// //                               ),
// //                               overflow: TextOverflow.ellipsis,
// //                               maxLines: 2,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             //second message
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => PublicArtistProfile(''),
// //                   ),
// //                 );
// //               },
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   border: Border(
// //                     bottom: BorderSide(
// //                       color: Colors.black12,
// //                       width: 1,
// //                     ),
// //                   ),
// //                 ),
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: 20,
// //                   vertical: 15,
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                       padding: EdgeInsets.all(2),
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.all(
// //                           Radius.circular(40),
// //                         ),
// //                         //for unread messages
// //                         border: Border.all(
// //                           width: 2,
// //                           color: kPrimaryColor,
// //                         ),
// //                         //shape: BoxShape.circle,
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.grey.withOpacity(0.5),
// //                             spreadRadius: 2,
// //                             blurRadius: 5,
// //                           ),
// //                         ],
// //                       ),
// //                       child: CircleAvatar(
// //                         radius: 35,
// //                         backgroundImage:
// //                         AssetImage('assets/images/singerImage.jpg'),
// //                       ),
// //                     ),
// //                     Container(
// //                       width: MediaQuery.of(context).size.width * 0.65,
// //                       padding: EdgeInsets.only(left: 20),
// //                       child: Column(
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Container(
// //                                 constraints: BoxConstraints(maxWidth: 175),
// //                                 child: Text(
// //                                   'Arko Khattra Artist',
// //                                   style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontFamily: 'Comfortaa',
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           SizedBox(
// //                             height: 10,
// //                           ),
// //                           Container(
// //                             alignment: Alignment.topLeft,
// //                             child: Text(
// //                               'Kati bolchas k kaile kai ta chup lag kati text gareko block handinchu talai',
// //                               style: TextStyle(
// //                                 fontSize: 13,
// //                                 color: Colors.black54,
// //                               ),
// //                               overflow: TextOverflow.ellipsis,
// //                               maxLines: 2,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ),
// //   );
// // }
String getUID(String uid)
{
  String result="";
  String displayName="";
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
print("DISPLAY NAME: "+displayName);
  //activateListeners(result);
  return displayName;
}
}
