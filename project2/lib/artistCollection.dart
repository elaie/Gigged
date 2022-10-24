import 'package:project2/getData.dart';
import '../storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class artistCollection{
  String artistUID="";
  String name = "";
  final Storage storage = Storage();
  final extractData ExtractData = extractData();
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Artist');
  //CollectionReference users = FirebaseFirestore.instance.collection('Artist');

  Future<void> getData() async {
    print("OBJECT.getData initialized");
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    //QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("UID").get();

    // Get data from docs and convert map to List

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("COLLECTION DATA: ");
    print(allData);
    String dummy = allData.toString();
    print("DUMMY: " + dummy);
    artistUID = dummy.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    artistUID = artistUID.substring(3);
    print("results: " + artistUID);
  }
  artistCollection(){
    print("ARTIST COLLECTION OBJECT CREATED!");
    Future<void> getData() async {
      print("OBJECT.getData initialized");
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();
      //QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("UID").get();

      // Get data from docs and convert map to List

      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      print("COLLECTION DATA: ");
      print(allData);
      String dummy = allData.toString();
      print("DUMMY: " + dummy);
      artistUID = dummy.replaceAll(RegExp('[^A-Za-z0-9]'), '');
      artistUID = artistUID.substring(3);
      print("results: " + artistUID);
    }
  }
}