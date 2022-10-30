import 'package:flutter/material.dart';
import 'package:project2/screens/SeeAllArtist.dart';
import 'package:project2/screens/constraints.dart';

import 'EditProfilePage.dart';

class VenuePrivatePage extends StatefulWidget {
  const VenuePrivatePage({Key? key}) : super(key: key);

  @override
  State<VenuePrivatePage> createState() => _VenuePrivatePage();
}

class _VenuePrivatePage extends State<VenuePrivatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                      Text(
                        "Hello there!",
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kPrimaryColor),
                      ),
                      SizedBox(height: 10.0),
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
                                child: const CircleAvatar(
                                  radius: 70,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 253, 253),
                                ),
                              ),
                            )
                          ])),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text(
                              'About us',
                              style: TextStyle(
                                color: kPrimaryDarkColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: kPrimaryColor,
                            ),
                            Text(
                              'something something place with something something description to be written and stuff',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            //Message button
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    "Edit profile",
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
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (context) => VenuePrivatePage(),
                                    );
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SeeAllArtist(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Hire Artists',
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
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            //ratings
                            Text(
                              "Average Ratings",
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
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    "Logout",
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
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (context) => VenuePrivatePage(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ]))
                    ]))));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
    const EditProfilePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

