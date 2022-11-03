import 'package:flutter/material.dart';
import 'package:project2/screens/SeeAllArtist.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'constraints.dart';

class CreateEvent extends StatelessWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Create an Event",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor),
                ),
                Divider(
                  thickness: 1,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllArtist(),
                          ),
                        );
                      },
                      child: const Text(
                        'Hire Artist',
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          (kPrimaryColor),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Row(
                    children: [
                      Text(
                        "Is this a free event?",
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: kPrimaryColor),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ToggleSwitch(
                        initialLabelIndex: 0,
                        totalSwitches: 2,
                        cornerRadius: 30,
                        activeBgColor: [kPrimaryColor],
                        inactiveBgColor: kPrimaryLightColor,
                        labels: [
                          'Yes',
                          'No',
                        ],
                        onToggle: (index) {
                          print('switched to: $index');
                        },
                      ),
                    ],
                  ),
                ),
                //name of event
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                        )),
                    labelStyle: TextStyle(color: kPrimaryDarkColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: kPrimaryLightColor),
                    ),
                    labelText: 'What is the name of your event?',
                    fillColor: kPrimaryLightColor,
                    filled: true,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
                //description od event
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                        )),
                    labelStyle: TextStyle(color: kPrimaryDarkColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: kPrimaryLightColor),
                    ),
                    labelText: 'What is your event about?',
                    fillColor: kPrimaryLightColor,
                    filled: true,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
                //venue
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                        )),
                    labelStyle: TextStyle(color: kPrimaryDarkColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: kPrimaryLightColor),
                    ),
                    labelText: 'Where is your event happening?',
                    fillColor: kPrimaryLightColor,
                    filled: true,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
                //venue discription
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                        )),
                    labelStyle: TextStyle(color: kPrimaryDarkColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: kPrimaryLightColor),
                    ),
                    labelText: 'Describe your venue',
                    fillColor: kPrimaryLightColor,
                    filled: true,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
                //special attractions
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                        )),
                    labelStyle: TextStyle(color: kPrimaryDarkColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: kPrimaryLightColor),
                    ),
                    labelText: 'Do you have special attractions?',
                    fillColor: kPrimaryLightColor,
                    filled: true,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
                //Button
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Create Event',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
