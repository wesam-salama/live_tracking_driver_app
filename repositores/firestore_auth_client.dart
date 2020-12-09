import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirestoreAuth {
  FirestoreAuth._();

  static FirestoreAuth firestoreAuth = FirestoreAuth._();

  setUserToFirestore(User driver, Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection('Drivers')
        .doc(driver.uid)
        .set(map);
  }

  setUserToRealTime(User driver, Map<String, dynamic> map) async {
    await FirebaseDatabase.instance
        .reference()
        .child('Drivers')
        .child(driver.uid)
        .set(map);
  }

  // Future<DocumentSnapshot> getUser(User driver) async {
  //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //       .collection('Drivers')
  //       .doc(driver.uid)
  //       .get();

  //   return documentSnapshot;
  // }
}
