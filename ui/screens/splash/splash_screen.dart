import 'package:driver_app/constants.dart';
import 'package:driver_app/get/getx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLocationServicesInDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    AuthGet authGet = Get.put(AuthGet());
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            // Spacer(),
            SizedBox(
              height: 30,
            ),
            Text(
              "مكتب الشامل",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(36),
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: Body(),
            ),
          ],
        ),
      ),
    );
  }

  bool isLocationServiceEnabled;
  LocationPermission permission;
  // LocationPermission _permissionGranted;

  Future<void> checkLocationServicesInDevice() async {
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always) {
      } else {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.always) {
          print('user allowed');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      permission = await Geolocator.requestPermission();
      if (isLocationServiceEnabled) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.always) {
          print('user allowed before');
        } else {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.always) {
            print('user allowed');
          } else {
            SystemNavigator.pop();
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
  }
}
