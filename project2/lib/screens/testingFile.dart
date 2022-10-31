import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../storage_services.dart';
class testingFile extends StatefulWidget {
  const testingFile({Key? key}) : super(key: key);

  @override
  State<testingFile> createState() => _testingFileState();
}
class storeDATA{
  var data = "" as Map<String, dynamic>;
  storeDATA(var data){
    print("CONSTRUCTOR INIT");
  }
}
class _testingFileState extends State<testingFile> {
  String Uname = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  Storage storage = Storage();
  final Stream<QuerySnapshot> postsStream =
  FirebaseFirestore.instance.collection("Artist").snapshots();

  @override
    Widget build(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
          stream: postsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final List storedocs = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              storedocs.add(a);
              a['id'] = document.id;
            }).toList();
            print(storedocs);

            return Scaffold(

              body: SafeArea(

                child: Column(
                  children: [
                    Text("TRENDING ARTIST"),
                    SizedBox(height: 20,
                    )
                    ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for(var i = 0; i < storedocs.length; i++)...[
                          GestureDetector(
                            onTap: (){
                              print("Hello WOlrd");
                              print("STOREDOCSLASJDLKASJ:  "+storedocs[i]['UID']);
                              print("STORAGE: "+storage.downloadURL(storedocs[i]['UID']).toString());
                            },
                            child: Container(

                                child: Image.network('test/15w4czOLnmQzdY5ihPP1FuSYdif1'),
                            ),
                          )

                        ],
                        // CircleAvatar(
                        //   radius: 70,
                        //   backgroundColor: Colors.green,
                        // ),
                        // CircleAvatar(
                        //   radius: 70,
                        //   backgroundColor: Colors.green,
                        // ),
                        // CircleAvatar(
                        //   radius: 70,
                        //   backgroundColor: Colors.green,
                        // )
                      ],
                    ),

                  ],
                ),
              ),
            );
          },
    );
  }
}
