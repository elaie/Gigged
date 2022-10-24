import 'package:firebase_auth/firebase_auth.dart';

class extractData{
  String getUserUID() {
    final user = FirebaseAuth.instance.currentUser;
    String UID = " ";
    if (user != null) {
      UID = user.uid.toString();
      print("=======================================UID OF USER: "+UID);
      return (UID);
    }
    return UID;
  }
  String getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    String email = " ";
    if (user != null) {
      email = user.email.toString();
      return (email);
    }
    return email;
  }
  String getUserName() {
    final user = FirebaseAuth.instance.currentUser;
    String name = " ";
    if (user != null) {
      name = user.displayName.toString();
      return (name);
    }
    return name;
  }

}