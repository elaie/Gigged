import 'package:flutter/material.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/welcome_screen.dart';
import 'package:flutter/src/rendering/stack.dart';

class VenuePublicPage extends StatefulWidget {
  final uid;
  VenuePublicPage(this.uid);
  //const VenuePublicPage({Key? key}) : super(key: key);

  @override
  State<VenuePublicPage> createState() => _VenuePublicPage();
}

class _VenuePublicPage extends State<VenuePublicPage> {
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
                        backgroundColor: Color.fromARGB(255, 255, 253, 253),
                        backgroundImage: NetworkImage(
                            'https://pngimg.com/uploads/party/party_PNG1.png'),
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      'Located in Kathmandu, great ambience',
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
                        ElevatedButton(
                          child: Text(
                            "Message us",
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
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => VenuePublicPage(widget.uid),
                            );
                          },
                        ),
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
                              color: Color.fromARGB(255, 204, 165, 249),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
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
                                    ],
                                  )),
                            )
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('first image pressed');
                              },
                              child: Image.network(
                                  'https://www.pngplay.com/wp-content/uploads/6/Party-Concert-Background-PNG-Image.png'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Arbitary Event',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Comfortaa',
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('first image pressed');
                              },
                              child: Image.network(
                                  'https://www.pngplay.com/wp-content/uploads/6/Party-Concert-Background-PNG-Image.png'),
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
                                    ],
                                  )),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}