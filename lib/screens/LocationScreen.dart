// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:android_intent/android_intent.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:device_info/device_info.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:manjha/Screens/Home.dart';
// import 'package:manjha/Screens/LoginMobile.dart';
// // import 'package:manjha/Screens/LocationScreen.dart';
// import 'package:manjha/Screens/LoginScreen.dart';
// import 'package:manjha/Screens/NewsPage.dart';
// import 'package:manjha/Screens/VideoPage.dart';
// import 'package:manjha/Screens/ForumPage.dart';
// import 'package:manjha/localization/common.dart';
// import 'package:manjha/localization/locale_constant.dart';
// import 'package:manjha/utils/Buttons.dart';
// import 'package:manjha/utils/TextStyles.dart';
// import 'package:manjha/utils/consts.dart';
// // import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:geolocator/geolocator.dart';
// // import 'package:mapbox_geocoding/model/reverse_geocoding.dart' hide Features;
// // import 'package:mapbox_geocoding/mapbox_geocoding.dart';
// // import 'package:mapbox_geocoding/model/forward_geocoding.dart' as newGEO;
// import 'package:mapbox_search/mapbox_search.dart';
// import 'package:requests/requests.dart';
// import 'package:http/http.dart' as http;
//
// import '../widget/common.dart';
//
// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   bool blnIsLoggedIn = false;
//   bool blnIsInternetAvailable = true;
//   MyConnectivity _connectivity = MyConnectivity.instance;
//   Map _source = {ConnectivityResult.none: false};
//   bool blnProcessing = false;
//   bool blnIsSuccess = false;
//
//   // _LocationScreenState() {}
//
//   @override
//   void initState() {
//     super.initState();
//     // Future.delayed(Duration(seconds: 4), () {
//     //   Navigator.push(context, MaterialPageRoute(builder: (_) {
//     //     return LandingPage();
//     //   }));
//     // });
//
//     _connectivity.initialise();
//     _connectivity.myStream.listen((source) {
//       if (mounted) setState(() => _source = source);
//     });
//     _fetchRequest();
//     // https://pub.dev/packages/firebase_analytics/versions/7.0.1/example
//     Common.analytics.logAppOpen();
//   }
//
//   void loadNotification() async {
//     RemoteMessage? initialMessage =
//     await FirebaseMessaging.instance.getInitialMessage();
//     print("Initial Message--->");
//     print(initialMessage);
//
//     if (initialMessage != null) {
//       print(initialMessage.data['screen']);
//       // EasyLoading.showToast(initialMessage?.data["title"] + "\n",
//       // duration: Duration(seconds: 3));
//       if (initialMessage.data['screen'] == 'news') {
//         // Navigator.pushNamed(context, '/news');
//         Navigator.push(context, MaterialPageRoute(builder: (_) {
//           return NewsPage();
//         }));
//       } else if (initialMessage.data['screen'] == 'video') {
//         Navigator.push(context, MaterialPageRoute(builder: (_) {
//           return VideoPage();
//         }));
//       } else if (initialMessage.data['screen'] == 'forum') {
//         Navigator.push(context, MaterialPageRoute(builder: (_) {
//           return ForumPage(ForumType.Forum);
//         }));
//       }
//     } else {
//       // this._onPress(); // AUTO PERFORM
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     late String string;
//     switch (_source.keys.toList()[0]) {
//       case ConnectivityResult.none:
//         string = "Offline";
//         break;
//       case ConnectivityResult.mobile:
//         string = "Mobile: Online";
//         break;
//       case ConnectivityResult.wifi:
//         string = "WiFi: Online";
//     }
//     blnIsInternetAvailable =
//     (_source.keys.toList()[0] != ConnectivityResult.none);
//     EasyLoading.showToast(string);
//     if (blnIsInternetAvailable) {
//       _fetchRequest();
//     }
//
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: kheader,
//     ));
//
//     return Scaffold(
//       // backgroundColor: korange,
//         body: Container(
//           // margin: EdgeInsets.only(top: 20.0),
//           // decoration: BoxDecoration(
//           //   image: DecorationImage(
//           //     image: AssetImage("assets/bg-1.png"),
//           //     fit: BoxFit.contain,
//           //     alignment: Alignment.topRight,
//           //   ),
//           // ),
//             child: Container(
//               // decoration: BoxDecoration(
//               //   image: DecorationImage(
//               //     image: AssetImage("assets/bg-2.png"),
//               //     fit: BoxFit.contain,
//               //     alignment: Alignment.bottomRight,
//               //   ),
//               // ),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // BoldText("Aight",35.0,kdarkBlue),
//                       // Padding(
//                       // padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
//                       // child:
//                       Image(
//                         image: AssetImage('assets/logo.png'),
//                         width: 175,
//                       ),
//                       //),
//                       SizedBox(height: 20),
//                       (!blnIsInternetAvailable)
//                           ? BoldText(Lang.get("You are offline."), 22, kblack)
//                           : SizedBox(
//                         width: 0,
//                       ),
//                       (!blnIsInternetAvailable)
//                           ? SizedBox(
//                         height: 10,
//                       )
//                           : SizedBox(
//                         height: 0,
//                       ),
//                       (!blnIsInternetAvailable)
//                           ? NormalText(
//                           Lang.get(
//                               "Please connect to the Internet to continue using the Manjha"),
//                           Colors.black38,
//                           16.0,
//                           textAlign: TextAlign.center)
//                           : (!blnIsLoading)
//                           ? NormalText(Lang.get("Please allow to Get current location"),
//                           Colors.black38, 16.0)
//                           : SizedBox(),
//                       SizedBox(height: 10),
//                       (!blnIsInternetAvailable)
//                           ? Padding(
//                         padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
//                         child: WideButton.bold(Lang.get("Try Again"), () async {
//                           this._fetchRequest();
//                         }, true),
//                       )
//                           : (!blnIsLoading)
//                           ? Padding(
//                         padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
//                         child: WideButton.bold(
//                             Lang.get("Get My Location"), _onPress, true),
//                       )
//                           : SizedBox(),
//                     ],
//                   ),
//                 ))));
//   }
//
//   bool blnIsLoading = true;
//   void _onPress() async {
//     blnIsLoading = true;
//     print('I am pressed');
//
//     Position? position = await _determinePosition();
//
//     EasyLoading.dismiss();
//     if (position == null) return;
//     print("My location is  ${position.latitude}  ${position.longitude}");
//     // Fluttertoast.showToast(msg: "My location is  ${position.latitude}  ${position.longitude}");
//
//     Session.setLatLng(position);
//
//     // var places = await getPlaces(position.latitude, position.longitude);
//     // print(places);
//
//     CustomLocation cityName =
//     await getCity(position.latitude, position.longitude);
//     print(cityName.place!);
//     EasyLoading.showToast(cityName.place!);
//     Session.setLocation(cityName);
//
//     // print(await getCoordinates("Surat, Gujarat"));
//     // await geoCoding(position.latitude, position.longitude);
//
//     // TODO: https://pub.dev/packages/mapbox_search/example
//
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
//       return (!blnIsLoggedIn) ? LoginMobilePage() : Home();
//     }));
//   }
//
//
//
//
//
//
//
//   // Future<List<MapBoxPlace>> getPlaces(double latitude, double longitude) async {
//   //   PlacesSearch placesService = PlacesSearch(
//   //     apiKey: kApiKey,
//   //     country: "IN",
//   //     limit: 5,
//   //   );
//   //   return await placesService.getPlaces('India',
//   //       location: Location(
//   //         lat: latitude, //48.8584, // this is eiffel tower position
//   //         lng: longitude, //2.2945
//   //       ));
//   // }
//
//   // Future geoCoding(double latitude, double longitude) async {
//   //   ReverseGeoCoding geoCodingService = ReverseGeoCoding(
//   //     apiKey: kApiKey,
//   //     country: "IN",
//   //     limit: 10,
//   //   );
//
//   //   var addresses = await geoCodingService.getAddress(Location(
//   //     lat: latitude, //48.8584, // this is eiffel tower position
//   //     lng: longitude, //2.2945
//   //   ));
//
//   //   print(addresses);
//   //   //  Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
//   // }
//
//   @override
//   void dispose() {
//     EasyLoading.dismiss();
//     // _connectivity.disposeStream();
//
//     super.dispose();
//   }
//
//   //~~ MapboxGeocoding geocoding = MapboxGeocoding(Common.CONST_MapBoxTokenKey);;
//   // ReverseGeoCoding geocoding = ReverseGeoCoding(apiKey: Common.CONST_MapBoxTokenKey, country: "IN");
//
//   getCity(double lat, double lng) async {
//     try {
//       var reverseModel = await geocoding.getAddress(Location(latitude: lat, longitude: lng, timestamp: DateTime.now()),);
//       // .reverseModel(lat, lng, types: "locality"); //,place (ARJUN)
//       print(reverseModel);
//
//       CustomLocation location = CustomLocation();
//       if (reverseModel!.reversed.length > 0) {
//         // print(reverseModel[0].placeName);
//
//         reverseModel[0].context!.forEach((element) {
//           // print(reverseModel.reversed.last.placeName);
//
//           if (element.id!.contains("locality")) {
//             location.place = element.text;
//             // break;
//           }
//           if (element.id!.contains("district")) {
//             location.city = element.text;
//             // break;
//           }
//           if (element.id!.contains("region")) {
//             // state
//             location.state = element.text;
//             // break;
//           }
//           if (element.id!.contains("country")) {
//             // country
//             location.country = element.text;
//             // break;
//           }
//         });
//         location.place = reverseModel[0].text;
//       }
//       else {
//         // TODO: NEED TO CHECK
//         // ReverseGeocoding reverseModel = await geocoding.reverseModel(lat, lng,
//         //     types: "place"); //,place (ARJUN)
//         //
//         // print(reverseModel.features[0].placeName);
//         // reverseModel.features[0].context.forEach((element) {
//         //   if (element.id.contains("locality")) {
//         //     location.place = element.text;
//         //     // break;
//         //   }
//         //   if (element.id.contains("district")) {
//         //     location.city = element.text;
//         //     // break;
//         //   }
//         //   if (element.id.contains("region")) {
//         //     // state
//         //     location.state = element.text;
//         //     // break;
//         //   }
//         //   if (element.id.contains("country")) {
//         //     // country
//         //     location.country = element.text;
//         //     // break;
//         //   }
//         // });
//         // location.place = reverseModel.features[0].text;
//       }
//       return location;
//     } catch (e) {
//       print(e);
//       EasyLoading.showError("Unable to get your location");
//       return 'Reverse Geocoding Error';
//     }
//   }
//
//   // getCoordinates(String city) async {
//   //   try {
//   //     ForwardGeocoding forwardModel = await geocoding.forwardModel(city);
//   //     return forwardModel.features[0].center;
//   //   } catch (Excepetion) {
//   //     return 'Forward Geocoding Error';
//   //   }
//   // }
//
//
//
//   // _fetchRequestxxx() async {
//   //   String strRawCookie = await Common.getRawCookie();
//
//   //   print('cookie:' + Common.getCookie());
//
//   //   String strDeviceID = await _getDeviceIdentity();
//   //   print(strDeviceID + "-" + _deviceModel);
//   //   String strToken = await FirebaseMessaging.instance.getToken();
//   //   print(strToken);
//   //   String strCustID = await Session.getCustomerId();
//   //   print(strCustID);
//   //   Codec<String, String> stringToBase64 = utf8.fuse(base64);
//   //   print(stringToBase64.encode(strCustID));
//
//   //   EasyLoading.show();
//
//   //   /// https://stackoverflow.com/questions/37001665/get-header-authorization-key-in-laravel-controller/37001867#:~:text=You%20can%20try%20install%20the,key%20in%20the%20header%20request.&text=I%20used%20token%20for%20example,name%20it%2C%20as%20you%20like.
//   //   /// https://stackoverflow.com/questions/16812747/how-can-i-get-the-session-id-in-laravel
//   //   var r = await Requests.post(api_url + "getSession",
//   //       bodyEncoding: RequestBodyEncoding.FormURLEncoded,
//   //       headers: <String, String>{
//   //         "content-type": "application/x-www-form-urlencoded",
//   //         // 'Content-Type': 'application/json; charset=UTF-8',
//   //         'X-CSRF-TOKEN': 'bgy2HenMU2It8vugIWv0bjYzNxOFClAxy8yE6FO9',
//   //         'cookie': strRawCookie, //+
//   //         'device': strDeviceID,
//   //         'model': _deviceModel,
//   //         // "manjha_session=sf8dpPsfpCBQ4NWMkbCa3MoSi0s3u9dVF0mQxG04",
//   //         // "content-type": "application/x-www-form-urlencoded",
//   //       },
//   //       body: <String, String>{
//   //         'device': strDeviceID,
//   //         'customer_id': stringToBase64.encode(strCustID),
//   //         'model': _deviceModel,
//   //         'device_type': 'android',
//   //         'firebase_token': strToken,
//   //       },
//   //       persistCookies: false);
//   //   EasyLoading.dismiss();
//   //   r.raiseForStatus();
//   //   String body = r.content();
//   //   print(body);
//   //   //Common.updateCookieRaw(r.headers['set-cookie'].toString());
//   //   if (r.statusCode == 200) {
//   //     final Map<String, dynamic> resBody = jsonDecode(body);
//   //     print('abcd');
//   //     // final parsed = resBody["data"].cast<Map<String, dynamic>>();
//   //     print(resBody['cookie']);
//   //     Common.updateCookieRaw(resBody['cookie']);
//
//   //     if (resBody['session'] != null && resBody['session'] as int > 0) {
//   //       Map<String, dynamic> custItem = resBody["data"];
//   //       print(custItem["id"].toString());
//   //       // var customerId = parsed["id"];
//   //       blnIsLoggedIn = true;
//   //       Session.loginUser(
//   //           custItem["mobileno"],
//   //           custItem["id"].toString(),
//   //           custItem["full_name"],
//   //           custItem["emailid"],
//   //           custItem["customer_photo"],
//   //           custItem["address"]);
//   //     }
//   //     return true;
//   //   } else {
//   //     EasyLoading.dismiss();
//   //     // throw Exception('Failed to load request');
//   //   }
//   //   // return false;
//   // }
//
//   // the mobile device unique identity
//   String _deviceIdentity = "";
//   String _deviceModel = "";
//   final DeviceInfoPlugin _deviceInfoPlugin = new DeviceInfoPlugin();
//   Future<String> _getDeviceIdentity() async {
//     if (_deviceIdentity == '') {
//       try {
//         if (Platform.isAndroid) {
//           AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;
//           // _deviceIdentity = "${info.device}-${info.androidId}"; //info.id
//           _deviceIdentity = info.androidId; //info.id
//           _deviceModel = info.device; //info.id
//         } else if (Platform.isIOS) {
//           IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;
//           _deviceIdentity = "${info.model}-${info.identifierForVendor}";
//         }
//       } on PlatformException {
//         _deviceIdentity = "unknown";
//       }
//     }
//
//     return _deviceIdentity;
//   }
// }
//
// class MyConnectivity {
//   MyConnectivity._internal();
//
//   static final MyConnectivity _instance = MyConnectivity._internal();
//
//   static MyConnectivity get instance => _instance;
//
//   Connectivity connectivity = Connectivity();
//
//   StreamController controller = StreamController.broadcast();
//
//   Stream get myStream => controller.stream;
//
//   void initialise() async {
//     ConnectivityResult result = await connectivity.checkConnectivity();
//     _checkStatus(result);
//     connectivity.onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }
//
//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         isOnline = true;
//       } else
//         isOnline = false;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     controller.sink.add({result: isOnline});
//   }
//
//   void disposeStream() => controller.close();
// }
