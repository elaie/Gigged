import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:project2/screens/constraints.dart';

import 'PublicArtistProfile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
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

                  if (name.isEmpty) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PublicArtistProfile(
                                        data['UID'].toString())));
                      },
                      title: Text(
                        data['Name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  if (data['Name']
                      .toString()
                      .toLowerCase()
                      .startsWith(name.toLowerCase())) {
                    return ListTile(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PublicArtistProfile(
                                        data['UID'].toString())));
                      },
                      title: Text(
                        data['Name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Container();
                });
          },
        ));
  }
  // String name = "a";
  // String val= "b";
  // @override
  // Widget build(BuildContext context) {
  //   Widget Logo = GestureDetector(
  //     onTap: () {
  //       print('image pressed');
  //     },
  //     child: const CircleAvatar(
  //       radius: 100,
  //       backgroundImage: AssetImage('assets/images/Gigged-1.png'),
  //       backgroundColor: Colors.transparent,
  //     ),
  //   );
  //
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: Container(
  //       decoration: const BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage('assets/images/main_top.png'),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       child: Stack(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(top: 20),
  //             child: Container(
  //               alignment: Alignment.topCenter,
  //               child: Logo,
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 250),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(30),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(
  //               top: 300,
  //             ),
  //             child: Container(
  //               alignment: Alignment.topCenter,
  //               child: Text('*Add history here*'),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 135, left: 20, right: 20),
  //             child: Container(
  //               alignment: Alignment.topCenter,
  //               child: searchBarUI(),
  //             ),
  //           ),
  //           // StreamBuilder<QuerySnapshot>(
  //           //   stream:
  //           //       FirebaseFirestore.instance.collection('Artist').snapshots(),
  //           //   builder: (context, snapshots) {
  //           //     return (snapshots.connectionState == ConnectionState.waiting)
  //           //         ? Center(
  //           //             child: CircularProgressIndicator(),
  //           //           )
  //           //         : ListView.builder(
  //           //             itemCount: snapshots.data!.docs.length,
  //           //             itemBuilder: (context, index) {
  //           //               var data = snapshots.data!.docs[index].data()
  //           //                   as Map<String, dynamic>;
  //           //               if (name.isEmpty) {
  //           //                 return ListTile(
  //           //                   title: Text(
  //           //                     data['name'],
  //           //                     maxLines: 1,
  //           //                     overflow: TextOverflow.ellipsis,
  //           //                     style: TextStyle(),
  //           //                   ),
  //           //                 );
  //           //               }
  //           //               if (data['name']
  //           //                   .toString()
  //           //                   .toLowerCase()
  //           //                   .startsWith(name.toLowerCase())) {
  //           //                 return ListTile(
  //           //                   title: Text(
  //           //                     data['name'],
  //           //                     maxLines: 1,
  //           //                     overflow: TextOverflow.ellipsis,
  //           //                     style: TextStyle(),
  //           //                   ),
  //           //                 );
  //           //               }
  //           //               return Container();
  //           //             });
  //           //   },
  //           // )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget searchBarUI() {
  //   return FloatingSearchBar(
  //     hint: 'Search.....',
  //     //openAxisAlignment: 0.0,
  //     //openWidth: 600,
  //     //axisAlignment: 0.0,
  //     //scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
  //     elevation: 4.0,
  //     physics: BouncingScrollPhysics(),
  //     borderRadius: BorderRadius.circular(25.0),
  //     onQueryChanged: (query) {
  //       //methods will be here
  //       setState(() {
  //         name = val;
  //       });
  //     },
  //     //showDrawerHamburger: false,
  //     transitionCurve: Curves.easeInOut,
  //     transitionDuration: Duration(milliseconds: 500),
  //     transition: CircularFloatingSearchBarTransition(),
  //     debounceDelay: Duration(milliseconds: 500),
  //     actions: [
  //       FloatingSearchBarAction(
  //         showIfOpened: false,
  //         child: CircularButton(
  //           icon: Icon(Icons.search),
  //           onPressed: () {
  //             print('Search icon pressed');
  //           },
  //         ),
  //       ),
  //       FloatingSearchBarAction.searchToClear(
  //         showIfClosed: false,
  //       ),
  //     ],
  //     builder: (context, transition) {
  //       return ClipRRect(
  //         borderRadius: BorderRadius.circular(8.0),
  //         child: Material(
  //           child: Container(
  //             height: 200.0,
  //             color: kPrimaryLightColor,
  //             child: Column(
  //               children: [
  //                 ListTile(
  //                   title: Text('Fav artist'),
  //                   subtitle: Text('more info here........'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
