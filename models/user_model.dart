import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // String id;
  String email;
  String firstName;
  String secondName;
  String phoneNumber;
  String carNumber;
  dynamic location;

  UserModel({
    this.email,
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.carNumber,
    this.location,
  });

  UserModel.formJson(DocumentSnapshot documentSnapshot) {
    this.email = documentSnapshot.data()['email'];
    this.firstName = documentSnapshot.data()['firstName'];
    this.secondName = documentSnapshot.data()['secondName'];
    this.phoneNumber = documentSnapshot.data()['phoneNumber'];
    this.carNumber = documentSnapshot.data()['carNumber'];
    this.location = documentSnapshot.data()['location'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': this.id,
      'email': this.email,
      'firstName': this.firstName,
      'secondName': this.secondName,
      'phoneNumber': this.phoneNumber,
      'carNumber': this.carNumber,
      'location': this.location,
    };
  }
}
