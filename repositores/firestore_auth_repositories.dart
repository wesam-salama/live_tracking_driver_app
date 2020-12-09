import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_auth_client.dart';

class FirebaseRepositoryAuth {
  FirebaseRepositoryAuth._();

  static FirebaseRepositoryAuth firebaseRepository = FirebaseRepositoryAuth._();

  setUserToFirestore(User driver, UserModel userModel) async {
    await FirestoreAuth.firestoreAuth
        .setUserToFirestore(driver, userModel.toJson());
  }

  setUserToRealTime(User driver, UserModel userModel) async {
    await FirestoreAuth.firestoreAuth
        .setUserToRealTime(driver, userModel.toJson());
  }

  // Future<UserModel> getUser(User driver) async {
  //   DocumentSnapshot documentSnapshot =
  //       await FirestoreAuth.firestoreAuth.getUser(driver);
  //   UserModel listQuerySnapshot = UserModel.formJson(documentSnapshot);

  //   return listQuerySnapshot;
  // }
}
