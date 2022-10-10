import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../getData.dart';
class local_data{
  String Biography ="test";

  setBiography(String B){
    Biography = B;
    print("====================== Bio set in class: "+Biography);
  }

  Future<String> token() async{
    final extractData ExtractData = extractData();
    DatabaseReference ref =
    FirebaseDatabase.instance.ref(ExtractData.getUserUID() + "/BIO/Bio");
    DatabaseEvent event = await ref.once();
   // print("==============================================GET URL==================================");
    Biography = event.snapshot.value.toString();
    print("=============================================Bio set in class===========================");
    print(Biography);
    //print(extractData().getUserUID());
    return Biography;
  }

}