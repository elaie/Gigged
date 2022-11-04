import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/HireArtist.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../getData.dart';
import 'constraints.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  double _height = 0.0;
  String val1='';
  String val2='';
  double _width = 0.0;
  String aUID = " ";
  String _setTime = '';
  String _setDate = '';
  String _hour = '';
  String _minute = '';
  String dateTime = '';
  String _time = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

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
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Row(
                        children: [
                          ElevatedButton(
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

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                            //  _navigateAndDisplaySelection(context);
                              print("aUID====================" + aUID);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => SeeAllArtist(),
                              //   ),
                              // );
                            },
                            child: const Text(
                              'Upload Images',
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

                        ],
                      ),
                    ),
                  ],
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
                SizedBox(
                  height: 20,
                ),
                //date and time picker
                Container(
                  //decoration: BoxDecoration(color: Colors.green),
                  width: _width,
                  //height: _height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Choose date ',
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: kPrimaryColor),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              width: _width / 1.7,
                              height: _height / 9,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.transparent),
                              child: TextFormField(
                                style: TextStyle(fontSize: 40,color: kPrimaryDarkColor),
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _dateController,
                                onSaved: (val1) {
                                  _setDate = val1.toString();
                                },
                                decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.only(top: 0.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Choose time ',
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: kPrimaryColor),
                          ),
                          InkWell(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              width: _width / 1.7,
                              height: _height / 15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.transparent),
                              child: TextFormField(
                                style: TextStyle(fontSize: 40,color: kPrimaryDarkColor),
                                textAlign: TextAlign.center,
                                onSaved: (val2) {
                                  _setTime = val2.toString();
                                },
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _timeController,
                                decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //special attractions

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
                        'Date':_dateController.text,
                        'Time':_timeController.text,
                        'Special Attraction': _specialAttTextController.text,
                        'Event Type': eventType,
                        'Artist UID': aUID,
                        'Artist Verification': 'WAITING',
                      };
                      FirebaseFirestore.instance
                          .collection("Events")
                          .add(dataToSave)
                          .then((value) {
                        value.id.toString();
                        FirebaseFirestore.instance
                            .collection("Artist")
                            .doc(aUID)
                            .collection("Events")
                            .add({
                          'Event Name': _eventNameTextController.text,
                          'Event Type': eventType,
                          'Date':_dateController.text,
                          'Time':_timeController.text,
                          'Event UID': value.id.toString(),
                          'Venue UID': ExtractData.getUserUID().toString(),
                          'Artist Verification': 'WAITING',
                          'UPDATABLE': 'TRUE',
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