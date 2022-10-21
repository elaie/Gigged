import 'package:flutter/material.dart';
import 'package:project2/screens/BookingOrReg.dart';
import 'package:project2/screens/constraints.dart';

class EventDiscription extends StatefulWidget {
  const EventDiscription({Key? key}) : super(key: key);

  @override
  State<EventDiscription> createState() => _EventDiscriptionState();
}

class _EventDiscriptionState extends State<EventDiscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  'EVENT NAME',
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
                '*write about event here. just very long discription. explain about how great the event is. why are you hosting this event. i am just making this long ignore me*',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Comfortaa',
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 40,
              ),
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
              Text(
                '*write about event here. just very long discription. explain about how great the event is. why are you hosting this event. i am just making this long ignore me*',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Comfortaa',
                  color: Colors.black45,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset('assets/images/club.jpg')),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset('assets/images/club.jpg')),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset('assets/images/club.jpg')),
                  ],
                ),
              ),
              SizedBox(height: 30,),
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
                '*write about event here. just very long discription. explain about how great the event is. why are you hosting this event. i am just making this long ignore me*',
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
                          fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        (kPrimaryColor),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingOrReg(),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
