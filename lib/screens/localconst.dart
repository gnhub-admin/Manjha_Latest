import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/shared_pref/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import '../getxcontrollers/mixpanelcontroller.dart';
import '../model/AddressModel.dart';
import '../widget/common.dart';
import '../widget/textstyle.dart';
import 'cartscreens/StoreCheckoutPage.dart';
import 'const.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String sessionCookie = "COOKIE";

class Common {
  static const CONST_MapBoxTokenKey =
      'pk.eyJ1IjoiZGl2eWFtZ2wyNyIsImEiOiJja2pzNmxsNjYyZms1MzBtancyaHh6OHYzIn0.jAm9YQFTmfCus68C1HtvHw';
  static const PAYTM_MID =
      "EJpcwX73628126041744"; //EJpcwX73628126041744 // LbYfaI85555014779522
  // static const PAYTM_MID = "LbYfaI85555014779522";
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final isIOS = Platform.isIOS;
  static Position? position;
  static Uri getURL(methodName) {
    String requestUrl = "$baseUrl/" + methodName;
    print(requestUrl);
    return Uri.parse(requestUrl);
  }

  static Map<String, String> headers = {};
  static getCookie() {
    return rawcookies();
  }

  static void updateCookieRaw(String rawCookie) {
    SharedPref.deleteSpecific(prefKey: PrefKey.rawCookie);
    // String rawCookie = response.headers['set-cookie'];
    if (rawCookie.isNotEmpty) {
      int index = -1; //rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);

      SharedPref.save(value: rawCookie, prefKey: PrefKey.rawCookie);
    }
  }

  static String? getRawCookie() {
    return rawcookies();
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      if (value == null) return 0.0;
      return value * 1.0;
    }
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static Color getHaxColor(color) {
    var hexColor = color.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Colors.transparent;
  }

  static String getWhtapAppMessage(String name, String location) {
    //  नमस्ते जी, मैं Divyam हूँ- Jind से। आपकी ये गाय मैंने Animall पर देखी और मुझे पसंद आई। क्या ये अभी बिकाऊ है?
    // नमस्ते जी, मैं Divyam हूँ- Jind से। आपकी ये मछली मैंने Manjha पर देखी और मुझे पसंद आई। क्या ये अभी बिकाऊ है?
    // Hello sir, I am Divyam - from Jind. I saw your fish on Manjha and I liked it. Is it for sale now?

    return Lang.get(" \n" +
                "नमस्ते जी, मैं \$name हूँ- \$location से। आपकी ये मछली मैंने Manjha पर देखी और मुझे पसंद आई। क्या ये अभी बिकाऊ है?")
            .replaceFirst('\$name', name)
            .replaceFirst('\$location', location) +
        "\n\n" +
        Lang.get(
            "सुरक्षा सूचना - Manjha ऐप द्वारा एडवांस पेमेंट की सख्त मनाही है। पेटीएम्, फ़ोन-पे, गूगल-पे से धोखा (फ्रॉड) हो जाता है।");

    // return Lang.get(
    //             "Hello sir, I am \$name - from \$location. I saw your fish on Manjha and I liked it. Is it for sale now?")
    //         .replaceFirst('\$name', name)
    //         .replaceFirst('\$location', location) +
    //     "\n\n" +
    //     Lang.get(
    //         "Notice - Advance Payment is strictly forbidden by Manjha app. Paytm, phone-pay, Google-pay gets cheated (fraud).");
  }

  static Future<String> getSession(String key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  static Future<bool> setSession(String key, String value) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(key, value);
  }

  static Future<bool> clearSession(String key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    return prefs.remove(key);
  }

  /* ----------------------------------------------------------- */
  static var textFormFieldRegular = TextStyle(
      fontSize: 16,
      fontFamily: "Helvetica",
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static var textFormFieldLight =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

  static var textFormFieldMedium =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

  static var textFormFieldSemiBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

  static var textFormFieldBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

  static var textFormFieldBlack =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);

  static FadeInImage fadeImage(imageUrl, {double? height, double? width}) {
    return FadeInImage.assetNetwork(
        placeholder: 'assets/no-photo.png',
        height: height,
        width: width,
        fadeInDuration: Duration(milliseconds: 100),
        image: imageUrl);
  }

  static DecorationImage containerImage(imageUrl) {
    return DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
        imageUrl,
      ),
    );
  }

  static Widget containerNoDataFound(String message) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: NormalText(message, kblack, 16.0),
          ),
        ));
  }

  // static String profile_url =
  //     "https://cdn1.iconfinder.com/data/icons/user-pictures/100/boy-128.png";
  static var cartCount = 0;
  static var cartTotal = 0;
  // static Future<Void> setCartCount(int total) {
  //   cartCount = total;
  //   setState
  // }

  static Widget getCartButton(BuildContext context,
      {int countpage = 1,
      Color color = Colors.white,
      Function()? refreshCallback,
      bool? fromProductListingPage}) {
    return new FutureBuilder(
        future: Future.value(cartCount),
        builder: (context, snapshot) {
          return IconButton(
              icon: Stack(children: [
                Container(
                    // margin: EdgeInsets.only(right: 8),
                    // decoration: BoxDecoration(
                    //   color: kColorAppDefault,
                    //   borderRadius: BorderRadius.circular(100),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       blurRadius: 2.0,
                    //       color: Colors.black,
                    //     )
                    //   ],
                    // ),
                    padding: EdgeInsets.only(top: 8, right: 8),
                    child: Icon(Icons.shopping_cart, color: color)),
                Visibility(
                  visible: (Common.cartCount > 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(Common.cartCount.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                    ),
                  ),
                ),
              ]),
              onPressed: () async {
                MixpanelController.logScreen(
                  MixpanelController.PageCart,
                );
                dynamic result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoreCheckoutPage(
                            fromProductListingPage: fromProductListingPage,
                          )),
                );
                // print('helloworld...');
                // if (refreshCallback != null && result != null && result == true) refreshCallback.call();
             //    if (refreshCallback != null &&
             //        result != null &&
             //        result == true) {
             // ;
             //    }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  refreshCallback?.call();
                });
                // print('helloworld...2');
              });
        });
  }

  static Widget getCartButton2(BuildContext context,
      {int countpage = 1,
      Color color = Colors.white,
      Function()? refreshCallback,
      bool? fromProductListingPage}) {
    return new FutureBuilder(
        future: Future.value(cartCount),
        builder: (context, snapshot) {
          return IconButton(
              icon: Icon(Icons.shopping_cart, color: color),
              onPressed: () async {
                dynamic result;
                result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoreCheckoutPage(
                          fromProductListingPage: fromProductListingPage)),
                );
                // if (countpage == 1) {
                //
                // } else if (countpage == 2) {
                //   result = await Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(builder: (context) => StoreCheckoutPage()),
                //   );
                // }
                // print('helloworld...');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  refreshCallback?.call();
                });
                // if (refreshCallback != null && result != null && result == true) refreshCallback.call();
                // print('helloworld...2');
              });
        });
  }

  static Widget getSupportButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.call),
        onPressed: () {
          // this._login();
          // ignore: deprecated_member_use
          launch("tel:+917071270718");
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return StoreProfilePage();
          // }));
        });
  }

  /* ----------------------------------------------------------- */

  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: analytics);

  /* ----------------------------------------------------------- */

  static List<FishTypeItem>? fishList;
  static Future<List<FishTypeItem>> loadFishType() async {
    if (fishList != null && fishList!.length > 0) {
      return Future.value(fishList);
    }
    fishList = [];
    // List<FishTypeItem> fishList = new List();
    // setState(() {
    //   isLoading = true;
    // });
    final response = await http.get(Common.getURL('fishtypes'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();
      print(parsed);

      fishList = parsed
          .map<FishTypeItem>((json) => FishTypeItem.fromJson(json))
          .toList();

      // print(response.body);
      // list = jsonDecode(response.body) as List;
      // setState(() {
      //   isLoading = false;
      // });
      // retrun fishList;
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      EasyLoading.showError("Failed to load request. Please try again.");
      // throw Exception('Failed to load request');
    }
    return Future.value(fishList);
  }

  static List<FishCategoryItem>? fishCategoryList;
  static Future<List<FishCategoryItem>> loadFishCategory() async {
    if (fishCategoryList != null && fishCategoryList!.length > 0) {
      return fishCategoryList!;
    }
    fishCategoryList = [];
    // setState(() {
    //   isLoading = true;
    // });
    final response = await http.get(Common.getURL('fishcategories'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();
      print(parsed);

      fishCategoryList = parsed
          .map<FishCategoryItem>((json) => FishCategoryItem.fromJson(json))
          .toList();

      // print(response.body);
      // list = jsonDecode(response.body) as List;
      // setState(() {
      //   isLoading = false;
      // });
      // retrun fishCategoryList;
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      EasyLoading.showError("Failed to load request. Please try again.");
      // throw Exception('Failed to load request');
    }
    return fishCategoryList!;
  }

  static List<FishSizeItem>? fishSizeList;
  static Future<List<FishSizeItem>> loadFishSize() async {
    if (fishSizeList != null && fishSizeList!.length > 0) {
      return fishSizeList!;
    }

    fishSizeList = [];
    // setState(() {
    //   isLoading = true;
    // });
    final response = await http.get(Common.getURL('fishsizes'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();
      print(parsed);

      fishSizeList = parsed
          .map<FishSizeItem>((json) => FishSizeItem.fromJson(json))
          .toList();
      // print(response.body);
      // list = jsonDecode(response.body) as List;
      // setState(() {
      //   isLoading = false;
      // });
      // retrun fishSizeList;
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      EasyLoading.showError("Failed to load request. Please try again.");
      // throw Exception('Failed to load request');
    }
    return fishSizeList!;
  }

  static Future<void> loadFishMaster() async {
    fishList = [];
    fishCategoryList = [];
    fishSizeList = [];

    final response = await http.get(Common.getURL('fishmaster'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsedfishtypes =
          resBody["data"]["fishtypes"].cast<Map<String, dynamic>>();
      final parsedfishcategories =
          resBody["data"]["fishcategories"].cast<Map<String, dynamic>>();
      final parsedfishsizes =
          resBody["data"]["fishsizes"].cast<Map<String, dynamic>>();
      print(resBody);

      fishList = parsedfishtypes
          .map<FishTypeItem>((json) => FishTypeItem.fromJson(json))
          .toList();

      fishCategoryList = parsedfishcategories
          .map<FishCategoryItem>((json) => FishCategoryItem.fromJson(json))
          .toList();

      fishSizeList = parsedfishsizes
          .map<FishSizeItem>((json) => FishSizeItem.fromJson(json))
          .toList();

      // print(response.body);
      // list = jsonDecode(response.body) as List;
      // setState(() {
      //   isLoading = false;
      // });
      // retrun fishList;
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      EasyLoading.showError("Failed to load request. Please try again.");
      // throw Exception('Failed to load request');
    }
  }
}

class Session {
  // static logout() {
  //   Common.clearSession(prefSelectedLanguageCode);
  //
  //   Common.clearSession("City");
  //   Common.clearSession("mobileno");
  //   Common.clearSession("customerId");
  //   Common.clearSession("customerName");
  //   Common.clearSession("emailId");
  //   Common.clearSession("customer_photo");
  //   Common.clearSession("address");
  //   Common.clearSession("lat");
  //   Common.clearSession("lng");
  //
  //   Common.clearSession("is_disclaimer_seen");
  //
  //   Common.clearSession(sessionCookie);
  // }
  //
  // static Future<bool> isDisclaimerSeen() async {
  //   String strDisclimerSeen = await Common.getSession("is_disclaimer_seen");
  //   return Future.value(strDisclimerSeen.isNotEmpty && strDisclimerSeen == "1");
  // }
  //
  // static disclaimerSeenNow() {
  //   return Common.setSession("is_disclaimer_seen", "1");
  // }
  //
  static Future<bool> isShippingPopupSeen() async {
    String strDisclimerSeen = await Common.getSession("is_shipping_popup_seen");
    return Future.value(strDisclimerSeen.isNotEmpty && strDisclimerSeen == "1");
  }

  static shippingPopupSeenNow() {
    return Common.setSession("is_shipping_popup_seen", "0");
  }
  //
  // static setCity(String value) {
  //   Common.setSession("City", value);
  // }
  //
  // static CustomLocation? _location;
  // static setLocation(CustomLocation? value) {
  //   _location = value;
  //   // Common.setSession("City", value);
  // }
  //
  // static Future<CustomLocation> getLocation() {
  //   return Future.value(_location);
  // }
  //
  // static getCity() {
  //   return Common.getSession("City");
  // }
  //
  // static bool isLocationServiceEnable = true;
  //
  // static setLatLng(Position position) {
  //   isLocationServiceEnable = true;
  //   Common.setSession("lat", position.latitude.toString());
  //   Common.setSession("lng", position.longitude.toString());
  // }
  //
  // static setDefaultLatLng() {
  //   isLocationServiceEnable = false;
  //   Common.setSession("lat", "29.149187");
  //   Common.setSession("lng", "75.721657");
  // }
  //
  // static Future<Position?> getLatLng() async {
  //   String strLat = await Common.getSession("lat");
  //   String strLng = await Common.getSession("lng");
  //
  //   if (strLat != '' && strLat != '') {
  //     return
  //         // Position(
  //         //   latitude: double.tryParse(strLat)!,
  //         //   longitude: double.tryParse(strLng)!,);
  //         Position(
  //             latitude: double.tryParse(strLat)!,
  //             longitude: double.tryParse(strLng)!,
  //             timestamp: DateTime.now(),
  //             accuracy: 12,
  //             altitude: 10,
  //             heading: 1,
  //             speed: 1,
  //             speedAccuracy: 1,
  //             altitudeAccuracy: double.tryParse(strLat) ?? 0,
  //             headingAccuracy: double.tryParse(strLat) ?? 0);
  //   }
  //
  //   return null;
  // }
  //
  // static loginUser(String mobileno, String id, String customerName,
  //     String emailId, String customerPhoto, String address) {
  //   Common.setSession("mobileno", mobileno);
  //   Common.setSession("customerId", id);
  //   Common.setSession("customerName", customerName);
  //   Common.setSession("emailId", emailId);
  //   Common.setSession("customerPhoto", customerPhoto);
  //   Common.setSession("address", address);
  //   _customerId = int.tryParse(id)!;
  // }

  static updateUser(String id, String customerName, String emailId,
      String customerPhoto, String address) {
    // Common.setSession("mobileno", mobileno);
    Common.setSession("customerId", id);
    Common.setSession("customerName", customerName);
    Common.setSession("emailId", emailId);
    Common.setSession("customerPhoto", customerPhoto);
    Common.setSession("address", address);
    saveUser()?.data?.id = int.tryParse(id)!;
  }

  // static updatePhoto(String customerPhoto) {
  //   Common.setSession("customerPhoto", customerPhoto);
  // }
  //
  // static setMobileNo(String mobileno) {
  //   Common.setSession("mobileno", mobileno);
  // }

  // static int _customerId = 0;
  // static int getCustId() {
  //   return _customerId;
  // }

  // static Future<String> getCustomerId() {
  //   return Common.getSession("customerId");
  // }
  //
  // static Future<String> getMobileNo() {
  //   return Common.getSession("mobileno");
  // }
  //
  // static Future<String> getCustomerName() {
  //   return Common.getSession("customerName");
  // }
  //
  // static Future<String> getCustomerPhoto() {
  //   return Common.getSession("customerPhoto");
  // }
  //
  // static Future<String> getCustomerPhotoUrl() async {
  //   String strPhoto = await Common.getSession("customerPhoto");
  //
  //   return image_customer_url +
  //       (strPhoto.isNotEmpty && strPhoto.isNotEmpty ? strPhoto : "no-user.jpg");
  // }

  //-----------------------------------------------//
  static setPaymentAddress(
      String firstName,
      String lastName,
      String address1,
      String address2,
      String city,
      String postCode,
      String zone,
      String country) {
    Common.setSession('payment_firstname', firstName);
    Common.setSession('payment_lastName', lastName);
    Common.setSession('payment_address1', address1);
    Common.setSession('payment_address2', address2);
    Common.setSession('payment_city', city);
    Common.setSession('payment_postCode', postCode);
    Common.setSession('payment_zone', zone);
    Common.setSession('payment_country', country);
  }

  static setPaymentAddressModel(AddressModel address) {
    Common.setSession('payment_addressId', address.id.toString());
    setPaymentAddress(
        address.firstname,
        address.lastname,
        address.address1,
        address.address2,
        address.city,
        address.postcode,
        address.zone,
        address.country);
  }

  static getPaymentName() async {
    List combined =
        await Future.wait([getPaymentFirstName(), getPaymentLastName()]);
    return combined.join(' ');
  }

  static getAddress() async {
    List combined = await Future.wait([
      getPaymentAddress1(),
      Future.value(', '),
      getPaymentAddress2(),
      Future.value('\n'),
      getPaymentCity(),
      Future.value(', '),
      getPaymentPostCode()
    ]);
    return combined.join('');
  }

  static getPaymentAddressId() {
    return Common.getSession('payment_addressId');
  }

  static getPaymentFirstName() {
    return Common.getSession('payment_firstname');
  }

  static getPaymentLastName() {
    return Common.getSession('payment_lastName');
  }

  static getPaymentAddress1() {
    return Common.getSession('payment_address1');
  }

  static getPaymentAddress2() {
    return Common.getSession('payment_address2');
  }

  static getPaymentCity() {
    return Common.getSession('payment_city');
  }

  static getPaymentPostCode() {
    return Common.getSession('payment_postCode');
  }

  static getPaymentZone() {
    return Common.getSession('payment_zone');
  }

  static getPaymentCountry() {
    return Common.getSession('payment_country');
  }
}

class Lang {
  static String? currLanguage = languagecode();

  static String get(String text) {
    return translate(text);
  }
}
