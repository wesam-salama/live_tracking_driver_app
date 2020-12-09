import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/get/getx_state.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  **************** for on time location *****************************************
  static String uid;

  static getUID() {
    AuthGet authGet = Get.find();
    uid = authGet.uid;
  }

  storeDriverLocationInFirebase() {
    // StreamSubscription<Position> positionStream =
    print('on time location');
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best)
        .listen((Position position) async {
      // print({'location':  GeoPoint(position.latitude, position.longitude)});

      await FirebaseFirestore.instance.collection('Drivers').doc(uid).update(
          {'location': GeoPoint(position.latitude, position.longitude)});
    });
  }

  storeDriverLocationInRealTime() {
    // StreamSubscription<Position> positionStream =
    print('on time location');
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best)
        .listen((Position position) async {
      // print({'location': GeoPoint(position.latitude, position.longitude)});
      await FirebaseDatabase.instance
          .reference()
          .child('Drivers')
          .child(uid)
          .update({
        // 'location': GeoPoint(position.latitude, position.longitude),
        'latitude': position.latitude,
        'longitude': position.longitude,
        'accuracy': position.accuracy,
        'heading': position.heading,
      });
    });
  }
//***************************************************************************** */

  //  **************** for background location ************************************
  // static const fetchBackground = "fetchBackground";

  // static void callbackDispatcher() {
  //   Workmanager.executeTask((task, inputData) async {
  //     switch (task) {
  //       case fetchBackground:
  //         print('background location');
  //         Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best)
  //             .listen((Position position) async {
  //           await FirebaseFirestore.instance
  //               .collection('Drivers')
  //               .doc(uid)
  //               .update({
  //             'location': GeoPoint(position.latitude, position.longitude)
  //           });
  //         });
  //         break;
  //     }
  //     return Future.value(true);
  //   });
  // }

  // *****************************************************************************
  // bool _enabled = true;
  // int _status = 0;
  // List<DateTime> _events = [];
  @override
  void initState() {
    // initPlatformState();
    super.initState();
    getUID();
    // Workmanager.initialize(
    //   callbackDispatcher,
    //   isInDebugMode: true,
    // );

    // Workmanager.registerPeriodicTask(
    //   "1",
    //   fetchBackground,
    //   frequency: Duration(minutes: 15),
    // );
  }

  // Future<void> initPlatformState() async {
  //   // Configure BackgroundFetch.
  //   BackgroundFetch.configure(
  //       BackgroundFetchConfig(
  //           minimumFetchInterval: 15,
  //           stopOnTerminate: false,
  //           enableHeadless: false,
  //           requiresBatteryNotLow: false,
  //           requiresCharging: false,
  //           requiresStorageNotLow: false,
  //           requiresDeviceIdle: false,
  //           requiredNetworkType: NetworkType.NONE), (String taskId) async {
  //     // This is the fetch-event callback.
  //     print("[BackgroundFetch] Event received $taskId");
  //     setState(() {
  //       _events.insert(0, new DateTime.now());
  //     });
  //     // IMPORTANT:  You must signal completion of your task or the OS can punish your app
  //     // for taking too long in the background.
  //     BackgroundFetch.finish(taskId);
  //   }).then((int status) {
  //     print('[BackgroundFetch] configure success: $status');
  //     setState(() {
  //       _status = status;
  //     });
  //   }).catchError((e) {
  //     print('[BackgroundFetch] configure ERROR: $e');
  //     setState(() {
  //       _status = e;
  //     });
  //   });

  //   // Optionally query the current BackgroundFetch status.
  //   int status = await BackgroundFetch.status;
  //   setState(() {
  //     _status = status;
  //   });

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  // }
  // void _onClickEnable(enabled) {
  //   setState(() {
  //     _enabled = enabled;
  //   });
  //   if (enabled) {
  //     BackgroundFetch.start().then((int status) {
  //       print('[BackgroundFetch] start success: $status');
  //     }).catchError((e) {
  //       print('[BackgroundFetch] start FAILURE: $e');
  //     });
  //   } else {
  //     BackgroundFetch.stop().then((int status) {
  //       print('[BackgroundFetch] stop success: $status');
  //     });
  //   }
  // }

  // void _onClickStatus() async {
  //   int status = await BackgroundFetch.status;
  //   print('[BackgroundFetch] status: $status');
  //   setState(() {
  //     _status = status;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    storeDriverLocationInFirebase();
    storeDriverLocationInRealTime();
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
