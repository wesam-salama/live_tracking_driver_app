import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FbAuth {
  FbAuth._();
  static final FbAuth auth = FbAuth._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

///////////////////////////////////////////////////////////////////////////////////
// ***********************  Login with email and password *************************
  Future<User> loginUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        return authResult.user;
      }
    } catch (error) {
      Get.snackbar(
        'login faeild',
        '${error.toString().split("]")[1]}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
// ********************************************************************************

///////////////////////////////////////////////////////////////////////////////////
//*************************** Register ********************************************
  Future<User> registerUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (authResult.user != null) {
        return authResult.user;
      }
    } catch (error) {
      Get.snackbar(
        'register faeild',
        '${error.toString().split("]")[1]}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
// ********************************************************************************

///////////////////////////////////////////////////////////////////////////////////
//*************************** Sign Out ********************************************

  signOut() async {
    await firebaseAuth.signOut();
  }
// ********************************************************************************

}
