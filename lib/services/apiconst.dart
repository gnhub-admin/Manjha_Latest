import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:manjha/model/cart_screen_model.dart';
import 'package:manjha/model/getcategoryresponses.dart';
import 'package:manjha/model/getfourmdetailsresponse.dart';
import 'package:manjha/model/getloginresponse.dart';
import 'package:manjha/model/getseeddetailsresponse.dart';
import 'package:manjha/model/getvideoresponse.dart';
import 'package:manjha/shared_pref/shared_pref.dart';
import '../model/premium_seller_models/gallery_response_model.dart';
import '../model/hatchery_premium_model.dart';
import '../model/news_description_model.dart';
import '../model/premium_seller_models/hatcheryloginmodel.dart';
import '../model/premium_seller_models/premium_seed_crud_res_model.dart';
import '../model/premium_seller_models/premium_seed_response_model.dart';
import '../model/premium_seller_models/premium_user_details_model.dart';
import '../model/suraj_charcha_model.dart';
import '../screens/localconst.dart';
import 'custom_api.dart';

Map<String, String> headersdd = {};

// getCookie() {
//   if (headersdd.containsKey("cookie")) {
//     return headersdd["cookie"];
//   }
//   return "";
// }
final String mainlink = "https://manjha.in/public";
// final String mainlink = "http://192.168.29.199:8003";
String baseUrl = "$mainlink/api/v1/${languagecode()}";
String image_brand_url = "$mainlink/api/brand";
String local_image_gallery =
    "https://manjhaimages.s3.ap-south-1.amazonaws.com/hatchery/";
String local_image_seed =
    "https://manjhaimages.s3.ap-south-1.amazonaws.com/hatcheryseed/";
String test_url = "$baseUrl";
// String test_url = "http://192.168.29.248:8003/api";

Getloginresponse? saveUser() {
  Getloginresponse? saveuser = SharedPref.get(prefKey: PrefKey.loginDetails) !=
          null
      ? getloginresponseFromJson(SharedPref.get(prefKey: PrefKey.loginDetails)!)
      : null;
  return saveuser;
}

Hatcheryloginmodel? hatcherylogin() {
  Hatcheryloginmodel? hatcharylogin =
      SharedPref.get(prefKey: PrefKey.premiumseller) != null
          ? hatcheryloginmodelFromJson(
              SharedPref.get(prefKey: PrefKey.premiumseller)!)
          : null;
  return hatcharylogin;
}

WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

String? languagecode() {
  String? languagecode = SharedPref.get(prefKey: PrefKey.languagecode) ?? "en";
  return languagecode;
}

String? languagecountry() {
  String? languagecountry = SharedPref.get(prefKey: PrefKey.langcontry) ?? "US";
  return languagecountry;
}

String? rawcookies() {
  String? rawcoockie = SharedPref.get(prefKey: PrefKey.rawCookie) ?? "";
  return rawcoockie;
}

//******************************* Post **************************//

Future<Getseeddetails> getseeddetails({required String hatcheruid}) async {
  var url = Uri.parse("$baseUrl/hatchery_seed/$hatcheruid");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  // print('Response Body: ${response.body}');
  return getseeddetailsFromJson(response.body);
}

Future<Getfourmdetails> getfourmdetails({required String fourmid}) async {
  // var url = Uri.parse("$baseUrl/forums/$fourmid");
  var url = Uri.parse("${webService.baseurl}/forums/$fourmid");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  // print('Response Body: ${response.body}');
  return getfourmdetailsFromJson(response.body);
}

Future<Getloginresponse> LoginMobile({required var parameter}) async {
  var url = Uri.parse("$baseUrl/loginmobilebypass");
  // var url = Uri.parse("http://192.168.29.248:8003/api/loginmobilebypass");
  var response = await http.post(url,
      headers: <String, String>{
        "content-type": "application/x-www-form-urlencoded",
        'Cookie': Common.getCookie().toString()
        // 'Content-Type': 'application/json',
      },
      body: parameter);
  // SharedPref.save(value: response.headers['set-cookie'].toString(), prefKey: PrefKey.rawCookie);

  return getloginresponseFromJson(response.body);
}

Future<GetVideoResponse> videogate() async {
  var url = Uri.parse("$baseUrl/videos");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  // print('Response Body: ${response.body}');
  return getVideoResponseFromJson(response.body);
}

Future<GetcategoryResponse> categorygate() async {
  var url = Uri.parse("$baseUrl/newscategories");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  // print('Response Body: ${response.body}');
  return getcategoryResponseFromJson(response.body);
}

Future<GetNewsDescriptionResponse> newsdiscriptiongate(
    {required int category}) async {
  var url = Uri.parse("$baseUrl/news?news_category_id=$category");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  // print('Response Body: ${response.body}');
  return getNewsDescriptionResponseFromJson(response.body);
}

Future<CartScreenModel> getCart() async {
  var url = Uri.parse("$baseUrl/store_cart");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  print('Response Body: ${response.body}');
  return cartScreenModelFromJson(response.body);
}

Future<CharchaModel> getdetail({required String page}) async {
  var url = Uri.parse("$baseUrl/forums?page=$page&limit=20");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  // print('Response Body: ${response.body}');
  return charchaModelFromJson(response.body);
}

Future<HatcheryPremiumModel> getHatcheryPremium({required state}) async {
  var url = Uri.parse("${webService.baseurl}/hatchery_premium?state=$state");
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  print('Response Body: ${response.body}');
  return hatcheryPremiumModelFromJson(response.body);
}

// ====================================================================================

Future<PremiumUserDetailModel> getPremiumUserList(
    {required var parameter}) async {
  var url = Uri.parse("${test_url}/userlog");
  var response =
      await http.post(url, body: parameter, headers: <String, String>{
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  print('Response Body: ${response.body}');
  return premiumUserDetailModelFromJson(response.body);
}

Future<GalleryResponseModel> getGalleryList({required var parameter}) async {
  var url = Uri.parse("${test_url}/gallery");
  var response =
      await http.post(url, body: parameter, headers: <String, String>{
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  print('Response Body: ${response.body}');
  return galleryResponseModelFromJson(response.body);
}

Future<PremiumSeedCrudResponseModel> uploadImageAtGallery(
    {required var parameter}) async {
  var url = Uri.parse("${test_url}/galleryupload");
  var response =
      await http.post(url, body: parameter, headers: <String, String>{
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  print('Response Body: ${response.body}');
  return premiumSeedCrudResponseModelFromJson(response.body);
}

Future<PremiumSeedCrudResponseModel> deleteImageAtGallery(
    {required var id}) async {
  var url = Uri.parse("${test_url}/gallerydelete/$id");
  var response = await http.delete(url, headers: <String, String>{
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  print('Response Body: ${response.body}');
  return premiumSeedCrudResponseModelFromJson(response.body);
}

// ====================================================================================

Future<PremiumSeedGetResponseModel> getPremiumSeedList(
    {required var id}) async {
  var url = Uri.parse("${test_url}/hatchery_seed_show?id=$id");
  var response = await http.post(url, headers: <String, String>{
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': Common.getCookie().toString()
    // "content-type": "application/x-www-form-urlencoded",
  });
  print('Response Body: ${response.body}');
  return premiumSeedGetResponseModelFromJson(response.body);
}

Future<PremiumSeedCrudResponseModel> createPremiumSeed(
    {required Map<String, dynamic> para, var file}) async {
  var url = Uri.parse("${test_url}/hatcheryseed");
  print(url);

  // Create a new multipart request
  var request = http.MultipartRequest('POST', url);

  // Add form fields
  para.forEach((key, value) {
    request.fields[key] = value.toString();
  });
  if (file != null)
    request.files.add(await http.MultipartFile.fromPath(
      'seed_image', // field name for the image in the server
      file,
      // contentType: MediaType('image', 'jpeg'), // Adjust the content type as needed
    ));

  // Send the request
  var streamedResponse = await request.send();

  // Parse the response
  var response = await http.Response.fromStream(streamedResponse);
  print('Response Body: ${response.body}');
  return premiumSeedCrudResponseModelFromJson(response.body);
}

Future<PremiumSeedCrudResponseModel> updatePremiumSeed(
    {required Map<String, dynamic> para,
    var file,
    required String hatcherySeedId}) async {
  var url = Uri.parse("${test_url}/hatchery_seed_update/$hatcherySeedId");
  print(url);

  // Create a new multipart request
  var request = http.MultipartRequest('POST', url);

  // Add form fields
  para.forEach((key, value) {
    request.fields[key] = value.toString();
  });
  if (file != null)
    request.files.add(await http.MultipartFile.fromPath(
      'seed_image', // field name for the image in the server
      file,
      // contentType: MediaType('image', 'jpeg'), // Adjust the content type as needed
    ));

  // Send the request
  var streamedResponse = await request.send();

  // Parse the response
  var response = await http.Response.fromStream(streamedResponse);
  print('Response Body: ${response.body}');
  return premiumSeedCrudResponseModelFromJson(response.body);
}

// Future<PremiumSeedCrudResponseModel> createPremiumSeed(
//     {required var parameter}) async {
//   var url = Uri.parse("${test_url}/hatcheryseed");
//   var response = await http.post(url, body: parameter);
//   print('Response Body: ${response.body}');
//   return premiumSeedCrudResponseModelFromJson(response.body);
// }

// Future<PremiumSeedCrudResponseModel> updatePremiumSeed(
//     {required var parameter, required String hatcherySeedId}) async {
//   var url = Uri.parse("${test_url}/hatchery_seed_update/$hatcherySeedId");
//   var response = await http.post(url, body: parameter);
//   print('Response Body: ${response.body}');
//   return premiumSeedCrudResponseModelFromJson(response.body);
// }

Future<PremiumSeedCrudResponseModel> deletePremiumSeed(
    {required String hatcherySeedId}) async {
  var url = Uri.parse("${test_url}/hatchery_seed_delete/$hatcherySeedId");
  var response = await http.delete(url);
  print('Response Body: ${response.body}');
  return premiumSeedCrudResponseModelFromJson(response.body);
}
