import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/HireArtist.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../getData.dart';
import 'constraints.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  String aUID = " ";

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const hireArtist()),
    );

    aUID = '$result';
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
    print("UID FROM ANOTHER PAGE" + aUID);
  }

  final extractData ExtractData = extractData();

  String eventType = "0";
  TextEditingController _eventNameTextController = TextEditingController();
  TextEditingController _DescriptionTextController = TextEditingController();
  TextEditingController _venueDescriptionTextController =
  TextEditingController();
  TextEditingController _specialAttTextController = TextEditingController();

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
                        _navigateAndDisplaySelection(context);
                        print("aUID====================" + aUID);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SeeAllArtist(),
                        //   ),
                        // );
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
                          if (index == 0) {
                            eventType = "Yes";
                          } else
                            eventType = "No";
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
                  controller: _eventNameTextController,
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
                  controller: _DescriptionTextController,
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
                  controller: _venueDescriptionTextController,
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
                  controller: _specialAttTextController,
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
                    onPressed: () {
                      Map<String, String> dataToSave = {
                        'Venue UID': ExtractData.getUserUID().toString(),
                        'Event Name': _eventNameTextController.text,
                        'Event Description': _DescriptionTextController.text,
                        'Venue Description':
                        _venueDescriptionTextController.text,
                        'Special Attraction': _specialAttTextController.text,
                        'Event Type': eventType,
                        'Artist UID': aUID,
                        'Artist Verification': 'WAITING',
                      };
                      FirebaseFirestore.instance
                          .collection("Events")
                          .add(dataToSave).then((value) {
                        value.id.toString();
                        FirebaseFirestore.instance
                            .collection("Artist")
                            .doc(aUID)
                            .collection("Events")
                            .add({
                          'Event Name': _eventNameTextController.text,
                          'Event Type': eventType,
                          'Event UID': value.id.toString(),
                          'Venue UID': ExtractData.getUserUID().toString(),
                          'Artist Verification': 'WAITING',
                          'UPDATABLE':'TRUE',
                        });
                      });

                      //SEND NOTIFICATION TO USER
                      Navigator.pop(context);
                    },
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
