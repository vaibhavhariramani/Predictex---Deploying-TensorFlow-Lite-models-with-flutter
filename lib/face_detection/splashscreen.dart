import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:predictex/face_detection/facemaskdetect.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:splashscreen/splashscreen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

// ignore: file_names
class MySplashPage extends StatefulWidget {
  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/splash.png"),
      title: Text(
        "Face Mask Detector App",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: FaceDetectPage(),
      durationInSeconds: 5,
    );
    // SplashScreen(
    //   seconds: 5,
    //   navigateAfterSeconds: FaceDetectPage(),
    //   title: const Text(
    //     'Face Mask Detector App',
    //     style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //       fontSize: 20,
    //       color: Colors.black,
    //       // ignore: file_names
    //     ),
    //   ),
    //   image: Image.asset("assets/splash.png"),
    //   photoSize: 130,
    //   backgroundColor: Colors.white,
    //   loaderColor: Colors.black,
    //   loadingText: const Text(
    //     'from Vaibhav Hariramani',
    //     style: TextStyle(
    //       color: Colors.black,
    //       fontSize: 16.0,
    //     ),
    //   ),
    // );
  }
}
