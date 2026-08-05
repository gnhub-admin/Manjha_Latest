import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/services/apiconst.dart';

import '../model/getsession.dart';
import '../screens/localconst.dart';
import '../services/custom_api.dart';

class LocationController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  String _deviceIdentity = "";
  String _deviceModel = "";

  Future<String> _getDeviceIdentity() async {
    if (_deviceIdentity == '') {
      try {
        if (Platform.isAndroid) {
          AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
          // _deviceIdentity = "${info.device}-${info.androidId}"; //info.id
          _deviceIdentity = info.androidId; //info.id
          _deviceModel = info.device; //info.id
        } else if (Platform.isIOS) {
          IosDeviceInfo info = await DeviceInfoPlugin().iosInfo;
          _deviceIdentity = "${info.model}-${info.identifierForVendor}";
        }
      } on PlatformException {
        _deviceIdentity = "unknown";
      }
    }

    return _deviceIdentity;
  }

  getSessionapi() async {
    String strDeviceID = await _getDeviceIdentity();
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String? strRawCookie = await Common.getRawCookie();

    Map<String, dynamic> para = {
      'device': strDeviceID,
      'customer_id':
          stringToBase64.encode(saveUser()?.data?.id?.toString() ?? ""),
      'model': _deviceModel,
      'device_type': 'android',
      'firebase_token': "",
    };

    final response = await webService.postFormRequest(header: <String, String>{
      "content-type": "application/x-www-form-urlencoded",
      'X-CSRF-TOKEN': 'bgy2HenMU2It8vugIWv0bjYzNxOFClAxy8yE6FO9',
      'cookie': strRawCookie ?? "",
      'device': strDeviceID,
      'model': _deviceModel,
    }, url: "${webService.baseurl}/getSession", formData: jsonEncode(para));
    response.fold(
      (l) {
        print(jsonEncode(l.toString()));
        var session = getsessionFromJson(l.toString());
        print(l.statusMessage);
        Common.updateCookieRaw(session.cookie ?? "");
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }
}
