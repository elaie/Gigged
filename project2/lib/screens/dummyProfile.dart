import 'package:flutter/material.dart';
class DummyProfile extends StatefulWidget {
 // const DummyProfile({Key? key}) : super(key: key);
  final accType;
  DummyProfile(this.accType);

  @override
  State<DummyProfile> createState() => _DummyProfileState();
}

class _DummyProfileState extends State<DummyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Text("this is"+widget.accType),
    ),);
  }
}
