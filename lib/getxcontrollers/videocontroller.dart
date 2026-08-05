import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/model/getcategoryresponses.dart';
import 'package:manjha/model/getvideoresponse.dart';
import 'package:manjha/model/news_description_model.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:http/http.dart' as http;
import '../Screens/localconst.dart';

class VideoController extends GetxController {
  RxBool show = false.obs;
  List<Datum>? video = [];
  videoApiCall() async {
    show.value = false;
    // EasyLoading.show();
    await videogate().then((value) {
      video = value.data;
      // Fluttertoast.showToast(msg: value.message ?? "");
      show.value = true;
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print("error....$error");
    });
  }

  RxBool showcategory = false.obs;
  List<DatumCategory>? category = [];
  CategoryApiCall() async {
    showcategory.value = false;
    // EasyLoading.show();
    await categorygate().then((value) {
      category = value.data;
      // Fluttertoast.showToast(msg: value.message ?? "");
      showcategory.value = true;
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print("error....$error");
    });
  }

  RxBool shownews = false.obs;
  RxList<NewsDescriptionModel> newsdiscription = <NewsDescriptionModel>[].obs;

  newsApiCall({required int categoryid}) async {
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Common.getCookie().toString()
        // "content-type": "application/x-www-form-urlencoded",
      };

      // Create the request
      var request = http.MultipartRequest(
        'GET',
        Uri.parse('$baseUrl/news?news_category_id=$categoryid'),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        GetNewsDescriptionResponse product =
            getNewsDescriptionResponseFromJson(responseBody);
        print(product.data?.length);
        newsdiscription.value = product.data ?? [];
        shownews.value = true;
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      // Dismiss the loading indicator
      EasyLoading.dismiss();
    }
  }
}
