import 'dart:convert';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:manjha/getxcontrollers/mixpanelcontroller.dart';
import 'package:manjha/screens/authscreens/loginscreen.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/shared_pref/shared_pref.dart';
import 'package:path/path.dart';
import '../Screens/localconst.dart';
import '../screens/languagescreen.dart';
import '../widget/common.dart';
import 'locationcontroller.dart';

class LoginController extends GetxController {
  LocationController locationController = Get.put(LocationController());

  LoginApiCall({required String mobilenumber}) async {
    EasyLoading.show();
    Map<String, dynamic> para = {"mobileno": mobilenumber};

    await LoginMobile(parameter: para).then((value) async {
      // _fetchRequest();
      Fluttertoast.showToast(msg: value.message ?? "");

      if (value.data != null) {
        SharedPref.save(
            value: jsonEncode(value.toJson()), prefKey: PrefKey.loginDetails);
        await locationController.getSessionapi();
        _determinePosition();
        var userItem = saveUser()?.data;
        if (userItem != null) {
          MixpanelController.initMixpanel(
            userItem.id.toString(),
            userItem.emailid ?? "Not-Set",
            userItem.mobileno ?? "Not-Set",
          );
        }
        EasyLoading.dismiss();
        Get.offAll(() => LanguageScreen());
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print("error....$error");
    });
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // EasyLoading.show(status: 'Getting location...');

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      EasyLoading.dismiss();

      await _showLocationServiceDisabledDialog(context);
      return null;
    }

    // Check location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.dismiss();

        EasyLoading.showError('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      EasyLoading.dismiss();

      EasyLoading.showError(
          'Location permissions are permanently denied. Please enable them from settings.');
      await _showPermissionDeniedForeverDialog(context);
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

      EasyLoading.showError('Error obtaining location: $e');
      return null;
    }
  }

  Future<void> _showLocationServiceDisabledDialog(context) async {
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

  Future<void> _showPermissionDeniedForeverDialog(context) async {
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

  LogoutApiCall() async {
    SharedPref.deleteAll();
    Get.delete();
    Get.offAll(LoginMobilePage());
  }

  // String _deviceIdentity = "";
  String deviceModel = "";

  // Future<String> _getDeviceIdentity() async {
  //   if (_deviceIdentity == '') {
  //     try {
  //       if (Platform.isAndroid) {
  //         AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
  //         // _deviceIdentity = "${info.device}-${info.androidId}"; //info.id
  //         _deviceIdentity = info.androidId; //info.id
  //         deviceModel = info.device; //info.id
  //       } else if (Platform.isIOS) {
  //         IosDeviceInfo info = await DeviceInfoPlugin().iosInfo;
  //         _deviceIdentity = "${info.model}-${info.identifierForVendor}";
  //       }
  //     } on PlatformException {
  //       _deviceIdentity = "unknown";
  //     }
  //   }
  //
  //   return _deviceIdentity;
  // }
}
