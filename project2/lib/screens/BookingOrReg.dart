import 'package:flutter/material.dart';

import 'constraints.dart';

class BookingOrReg extends StatefulWidget {
  const BookingOrReg({Key? key}) : super(key: key);

  @override
  State<BookingOrReg> createState() => _BookingOrRegState();
}

class _BookingOrRegState extends State<BookingOrReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50, bottom: 50, left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'EVENT NAME',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Comfortaa',
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                  height: 20,
                ),
                Text(
                  'Venue: ' + '*enter venue here*',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                    color: kPrimaryColor,
                  ),
                ),
                Text(
                  'Time: ' + '*enter time here*',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                    color: kPrimaryColor,
                  ),
                ),
                Text(
                  'Price of ticket: ' + '*enter price here*',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0),),
                          borderSide: BorderSide(color: kPrimaryLightColor,)
                      ),
                      labelStyle: TextStyle(color: kPrimaryDarkColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: kPrimaryLightColor),
                      ),
                      labelText: "Email",

                      hintText: "Enter your email",
                      filled: true,
                      contentPadding: EdgeInsets.all(20.0),
                      fillColor: kPrimaryLightColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0),),
                          borderSide: BorderSide(color: kPrimaryLightColor,)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: kPrimaryLightColor),
                      ),
                      labelText: "Name",
                      labelStyle: TextStyle(color: kPrimaryDarkColor),
                      hintText: "Enter your name",
                      filled: true,
                      contentPadding: EdgeInsets.all(20.0),
                      fillColor: kPrimaryLightColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0),),
                          borderSide: BorderSide(color: kPrimaryLightColor,)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: kPrimaryLightColor),
                      ),
                      labelText: "No. of attendees",
                      labelStyle: TextStyle(color: kPrimaryDarkColor),
                      hintText: "Enter number of attendees",
                      filled: true,
                      contentPadding: EdgeInsets.all(20.0),
                      fillColor: kPrimaryLightColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0),),
                          borderSide: BorderSide(color: kPrimaryLightColor,)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: kPrimaryLightColor),
                      ),
                      labelText: "Contact number",
                      labelStyle: TextStyle(color: kPrimaryDarkColor),
                      hintText: "Ener your contact number",
                      filled: true,
                      contentPadding: EdgeInsets.all(20.0),
                      fillColor: kPrimaryLightColor,
                    ),
                  ),
                ),
                /*TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0),),
                      borderSide: BorderSide(color: kPrimaryLightColor,)
                    ),
                  ),
                ),*/
                SizedBox(height: 20,),
                SizedBox(
                  height: 50, //height of button
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Register',
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
