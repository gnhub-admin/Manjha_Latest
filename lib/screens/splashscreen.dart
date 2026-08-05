import 'dart:async';
import 'dart:convert';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:manjha/getxcontrollers/mixpanelcontroller.dart';
import 'package:manjha/shared_pref/shared_pref.dart';
import '../getxcontrollers/locationcontroller.dart';
import '../services/apiconst.dart';
import '../widget/common.dart';
import 'authscreens/login.dart';
import 'localconst.dart';
import 'mainscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  LocationController locationController = Get.put(LocationController());
  int speedFactor = 1;
  bool blnIsLoading = true;
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _initializeSplash();
  }

  Future<void> _initializeSplash() async {
    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000 * speedFactor),
      vsync: this,
    )..forward();

    // Start location determination
    Common.position = await _determinePosition();

    await Future.delayed(Duration(milliseconds: 1000 * speedFactor));

    // Handle user session and navigation
    if (saveUser() != null) {
      locationController.getSessionapi();
      var userItem = saveUser()?.data;
      if (userItem != null) {
        MixpanelController.initMixpanel(
          userItem.id.toString(),
          userItem.emailid ?? "Not-Set",
          userItem.mobileno ?? "Not-Set",
        );
      }
    }

    // Navigate based on user login status
    if (saveUser() == null) {
      Get.off(() => LoginScreen());
    } else {
      Get.off(() => MainScreens(initialIndex: 0));
    }
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // EasyLoading.show(status: 'Getting location...');

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      EasyLoading.dismiss();
      setState(() {
        blnIsLoading = false;
      });
      await _showLocationServiceDisabledDialog();
      return null;
    }

    // Check location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.dismiss();
        setState(() {
          blnIsLoading = false;
        });
        EasyLoading.showError('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      EasyLoading.dismiss();
      setState(() {
        blnIsLoading = false;
      });
      EasyLoading.showError(
          'Location permissions are permanently denied. Please enable them from settings.');
      await _showPermissionDeniedForeverDialog();
      return null;
    }

    // If permissions are granted, get the position.
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      EasyLoading.dismiss();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks.first;
      CustomLocation item = CustomLocation();
      item.place = placemark.subLocality;
      item.city = placemark.locality;
      item.state = placemark.administrativeArea;
      item.country = placemark.country;
      item.lat = position.latitude.toString();
      item.long = position.longitude.toString();
      SharedPref.save(value: jsonEncode(item), prefKey: PrefKey.location);
      Common.position = position;
      return position;
    } catch (e) {
      EasyLoading.dismiss();
      setState(() {
        blnIsLoading = false;
      });
      EasyLoading.showError('Error obtaining location: $e');
      return null;
    }
  }

  Future<void> _showLocationServiceDisabledDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Can't get current location"),
          content: const Text(
              'Please make sure you have GPS enabled and try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                final AndroidIntent intent = AndroidIntent(
                    action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                intent.launch();
              },
            ),
            TextButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                _determinePosition();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPermissionDeniedForeverDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission"),
          content: const Text(
              'Location permissions are permanently denied. Please enable them from app settings.'),
          actions: <Widget>[
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally, navigate to a different screen or close the app.
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: korange,
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/bg-1.png"),
        //     fit: BoxFit.contain,
        //     alignment: Alignment.topRight,
        //   ),
        // ),
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/bg-2.png"),
          //     fit: BoxFit.contain,
          //     alignment: Alignment.bottomRight,
          //   ),
          // ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Uncomment if you have header/footer animations
              // getHeader(context),
              // getFooter(context),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    // BoldText("Aight",35.0,kdarkBlue),
                    // Padding(
                    // padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    // child:
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeInOutCubic,
                      ),
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.contain,
                        width: 225,
                      ),
                    ),
                    // ),
                    SizedBox(height: 20),
                    // TypewriterAnimatedTextKit(
                    //   text: ["Loading...!"],
                    //   textStyle: TextStyle(
                    //       fontSize: 18.0,
                    //       color: Colors.black38,
                    //       // color: kwhite,
                    //       fontFamily: "nunito"),
                    //   speed: Duration(milliseconds: 100),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}
