import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/model/gethitcheryresponse.dart';
import 'package:manjha/model/searchfishresponse.dart';
import 'package:manjha/services/apiconst.dart';

import '../Screens/localconst.dart';
import '../model/fishmasterresponse.dart';
import '../services/custom_api.dart';
import '../shared_pref/shared_pref.dart';
import '../widget/common.dart';

class HomePageController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxBool seedloading = false.obs;
  List<Fish> fishseed = [];
  List<Fish> shrimpyseed = [];

  gethitcheryCall() async {
    // charChaCall.value = false;
    // EasyLoading.show();

    final response = await webService.getRequest(
      url: "${webService.baseurl}/hatchery_premium?state=vesu",
    );
    response.fold(
      (l) {
        Gethitcheryresponse hitchery =
            gethitcheryresponseFromJson(l.toString());

        fishseed = hitchery.fish ?? [];
        shrimpyseed = hitchery.shrimp ?? [];
        // fishseed.addAll(hitchery.shrimp ?? []);
        seedloading.value = true;
        // print(l.data);
        print(fishseed);
        for (var fish in fishseed) {
          print('Fish: ${fish.toString()}');
        }
        update();
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  List<Fishes> fishlist = [];
  RxBool fidhloading = false.obs;
  RxBool isRemove = false.obs;
  getsalefishCall({String? fishtypeid, CustomLocation? location}) async {
    Map<String, dynamic> para = {
      "fishtypes": fishtypeid,
      "lat": location?.lat,
      "lng": location?.long,
      // "cityname": location.city,
      "limit": "50",
      "current_page": "",
      "page": "1",
      "customer_id": "",
      "updateLocation": "0",
      "last_cityname": location?.city,
      "last_statename": location?.state,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/searchfish", formData: jsonEncode(para));
    response.fold(
      (l) {
        Searchfishresponse fish = searchfishresponseFromJson(l.toString());

        fishlist = fish.data?.data ?? [];
        // productapicall.value = true;
        fidhloading.value = true;
        update();
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  RxList<Fishes> fishlisttypewise = <Fishes>[].obs;
  RxBool fidhloadingtyp = false.obs;

  getsalefishCalltype({String? fishtypeid}) async {
    Map<String, dynamic> item =
        jsonDecode(SharedPref.get(prefKey: PrefKey.location) ?? '');
    CustomLocation location = CustomLocation.fromJson(item);
    // EasyLoading.show();
    fidhloadingtyp.value = false;
    // EasyLoading.show();
    Map<String, dynamic> para = {
      "fishtypes": fishtypeid,
      "lat": location.lat,
      "lng": location.long,
      // "cityname": location.city,
      "limit": "50",
      "current_page": "",
      "page": "1",
      "customer_id": "",
      "updateLocation": "0",
      "last_cityname": location.city,
      "last_statename": location.state,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/searchfish", formData: jsonEncode(para));
    response.fold(
      (l) {
        Searchfishresponse fish = searchfishresponseFromJson(l.toString());

        fishlisttypewise.value = fish.data?.data ?? [];
        // productapicall.value = true;
        fidhloadingtyp.value = true;
        update();
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  RxList<Fishtype> fishtypelist = <Fishtype>[].obs;

  fishtype() async {
    // EasyLoading.show();

    final response =
        await webService.getRequest(url: "${webService.baseurl}/fishmaster");
    response.fold(
      (l) {
        Fishmasterresponse fish = fishmasterresponseFromJson(l.toString());

        fishtypelist.value = fish.data?.fishtypes ?? [];
        // productapicall.value = true;
        fidhloading.value = true;
        update();
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  myFavoriteAdd(saleItemId, {bool isRemove = false}) async {
    // setState(() {
    // isLoading = true;
    // });
    // EasyLoading.show();

    final response = await http.post(
        Uri.parse(baseUrl + "${isRemove ? '/favoriteRemove' : '/favoriteAdd'}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          "rawid": saleItemId.toString(),
          "customer_id": saveUser()?.data?.id.toString() ?? "",
        }));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      // final Map<String, dynamic> resBody =
      jsonDecode(response.body);
      // Fluttertoast.showToast(msg: resBody["message"]);
    } else {
      EasyLoading.showError('Failed to load request');
      throw Exception('Failed to load request');
    }
  }

  final String ACTION_CALL = 'call';
  final String ACTION_WHATSAPP = 'whatsapp';
  final String ACTION_SHARE = 'share';

  hatcheryLog(hatcheryId, action) async {
    // setState(() {
    //   isLoading = true;
    // });
    // EasyLoading.show();

    final response = await http.post(Common.getURL("hatchery_log"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "content-type": "application/x-www-form-urlencoded",
          'Cookie': Common.getCookie().toString()
        },
        body: jsonEncode(<String, dynamic>{
          'hatchery_id': hatcheryId,
          'hatchery_seed_id': 0,
          'action': action,
        }));
    EasyLoading.dismiss();
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      print(resBody);
      // EasyLoading.showToast(resBody["message"]);

      // list = parsed.map<ForumItem>((json) => ForumItem.fromJson(json)).toList();
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      // EasyLoading.showError('Failed to load request');
      // throw Exception('Failed to load request');
    }
  }

  saleitemLog(sellerId, action) async {
    // setState(() {
    //   isLoading = true;
    // });
    // EasyLoading.show();

    final response = await http.post(Uri.parse(baseUrl + "/saleitem_log"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "content-type": "application/x-www-form-urlencoded",
          'Cookie': Common.getCookie().toString()
        },
        body: jsonEncode(<String, dynamic>{
          'seller_id': sellerId,
          'action': action,
        }));
    EasyLoading.dismiss();
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      print(resBody);
      // EasyLoading.showToast(resBody["message"]);

      // list = parsed.map<ForumItem>((json) => ForumItem.fromJson(json)).toList();
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      // EasyLoading.showError('Failed to load request');
      // throw Exception('Failed to load request');
    }
  }
}
