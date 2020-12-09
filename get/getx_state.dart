import 'package:driver_app/auth/auth_firebase.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:driver_app/repositores/firestore_auth_repositories.dart';
import 'package:driver_app/ui/screens/login_success/login_success_screen.dart';
import 'package:driver_app/ui/screens/register_success/register_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGet extends GetxController {
  String email;
  String password;
  String firstName;
  String secondName;
  String phoneNumber;
  String carNumber;
  String uid;

  saveEmail(String value) {
    this.email = value;
    update();
  }

  savePaswword(String value) {
    this.password = value;
    update();
  }

  saveFirstName(String value) {
    this.firstName = value;
    update();
  }

  saveSecondName(String value) {
    this.secondName = value;
    update();
  }

  savePhoneNumber(String value) {
    this.phoneNumber = value;
    update();
  }

  saveCarNumber(String value) {
    this.carNumber = value;
    update();
  }

///////////////////////////////////////////////////////////////////////////////////
// ***********************  login with email and password *************************
  Future<User> loginUsingEmailAndPassword(BuildContext context) async {
    try {
      User user = await FbAuth.auth
          .loginUsingEmailAndPassword(this.email, this.password);
      if (user != null) {
        uid = user.uid;

        Get.off(LoginSuccessScreen());
      }
      update();
      return user;
    } catch (error) {
      print('ppppppppppppppp');
      print(error);
      Get.snackbar(
        'login faeild',
        '${error.toString().split("]")[1]}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
// ********************************************************************************

//////////////////////////////////////////////////////////////////////////////////
//*************************** Register *******************************************
  Future<User> registerUsingEmailAndPassword(BuildContext context) async {
    try {
      User user = await FbAuth.auth
          .registerUsingEmailAndPassword(this.email, this.password);
      if (user != null) {
        uid = user.uid;
        UserModel userModel = UserModel(
          email: this.email,
          firstName: this.firstName,
          secondName: this.secondName,
          phoneNumber: this.phoneNumber,
          carNumber: this.carNumber,
        );
        FirebaseRepositoryAuth.firebaseRepository
            .setUserToFirestore(user, userModel);

        FirebaseRepositoryAuth.firebaseRepository
            .setUserToRealTime(user, userModel);

        Get.to(RegisterSuccessScreen());
      }
      update();
      return user;
    } catch (error) {
      Get.snackbar(
        'register faeild',
        '${error.toString().split("]")[1]}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
// *******************************************************************************

//////////////////////////////////////////////////////////////////////////////////
//*************************** Sign Out *******************************************
  signOut() async {
    await FbAuth.auth.signOut();
  }
// *******************************************************************************

  onSubmitLogin(BuildContext context) async {
    await loginUsingEmailAndPassword(context);
    update();
  }

  onSubmitRegister(BuildContext context) async {
    await registerUsingEmailAndPassword(context);

    update();
  }

/*
// *********************** phone registeration *************************************
  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
  setPhoneNumber(String phone) {
    this.phoneNo = phone;
    update();
  }

  setVerificationId(String verId) {
    this.verificationId = verId;
    update();
  }

  setSmsCode(String sms) {
    this.smsCode = sms;
    update();
  }

  setCodeSent(bool send) {
    this.codeSent = send;
    update();
  }

  Future<void> verifyPhone() async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed = (var authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      setVerificationId(verId);
      setCodeSent(true);
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setVerificationId(verId);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  signIn(AuthCredential authCreds) async {
    UserCredential credential =
        await FirebaseAuth.instance.signInWithCredential(authCreds);
    if (credential.user == null) {
      print(credential.user.phoneNumber);
    } else {}
  }

  signInWithOTP() {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: this.smsCode);
    signIn(authCreds);
  }
  // *******************************************************************************
  */
}
