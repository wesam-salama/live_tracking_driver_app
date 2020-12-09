// import 'package:background_fetch/background_fetch.dart';
// import 'package:driver_app/ui/screens/home_page/home_page.dart';
// import 'package:driver_app/ui/screens/testingpincode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'providrs/auth_provider.dart';
// import 'routes.dart';
import 'theme.dart';
import 'ui/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  // BackgroundFetch.registerHeadlessTask(
  //       HomePage.storeDriverLocationInFirebase);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider<AuthProvider>(
        //       create: (context) => AuthProvider(),
        //     ),
        //     // ChangeNotifierProvider<MapProvider>(
        //     //   create: (context) => MapProvider(),
        //     // ),
        //   ],
        //   child:
        GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: SplashScreen.routeName,
      home: SplashScreen(),
      // routes: routes,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // ),
    );
  }
}
