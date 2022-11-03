import 'package:cloud_firestore/cloud_firestore.dart';

class User{
    String Bio=" ";
    double Latitude=0;
    double Longitude=0;
    String Name="";
    String UID="";

    User({
        this.Bio=" ",
        this.Latitude=0,
        this.Longitude=0,
        this.Name="",
        this.UID="",
});
  static User fromJson(Map<String, dynamic> json) => User(
      Bio: json['Bio'],
      Latitude: json['Bio'],
      Longitude: json['Bio'],
      Name:json['Bio'],
  );
  Map<String, dynamic> toJson() =>
      {
          'Bio': Bio,
          'Latitude': Latitude,
          'Longitude': Longitude,
          'Name':Name,
          'UID':UID,
      };
  User.fromSnapShot(snapshot)
    : Bio = snapshot.data()['Bio'],
          Latitude = snapshot.data()['Latitude'],
          Longitude = snapshot.data()['Longitude'],
          Name = snapshot.data()['Name'],
          UID = snapshot.data()['UID'];
}