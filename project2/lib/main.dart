import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project2/screens/ArtistProfilePage.dart';
import 'package:project2/screens/BookingListPage.dart';
import 'package:project2/screens/CreateEvent.dart';
import 'package:project2/screens/EventDiscriptionPage.dart';
import 'package:project2/screens/ArtistHomepage.dart';
import 'package:project2/screens/Login.dart';
import 'package:project2/screens/MainPage.dart';
import 'package:project2/screens/MessageListPage.dart';
import 'package:project2/screens/MessagePage.dart';
import 'package:project2/screens/UserHomePage.dart';
import 'package:project2/screens/UserProfilePage.dart';
import 'package:project2/screens/VenuePrivatePage.dart';
import 'package:project2/screens/VenuePublicPage.dart';
import 'package:project2/screens/PublicArtistProfile.dart';
import 'package:project2/screens/WhoAreYou.dart';
import 'package:project2/screens/constraints.dart';
import 'package:project2/screens/testingFile.dart';
import 'package:project2/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Welcome',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),

      home: BookingListPage(),//this page runs first

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text('hello world'),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
