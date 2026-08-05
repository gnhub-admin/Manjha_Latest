import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/model/productresponse.dart';
import '../Screens/localconst.dart';
import '../model/getbrandresponse.dart';
import '../model/getcatogoriesresponse.dart';
import '../services/apiconst.dart';
import '../services/custom_api.dart';

class ProductListingController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  List<Categorys> listcategory = [];
  RxBool getcategoriesapi = false.obs;

  getcategories({required String categoryid}) async {
    // EasyLoading.show();

    final response = await webService.getRequest(
        url: "${webService.baseurl}/store_subcategory?test=1&id=$categoryid");
    response.fold(
      (l) {
        Getcategoriesresponse category =
            getcategoriesresponseFromJson(l.toString());
        // print(category);
        listcategory.addAll(category.data ?? []);
        getcategoriesapi.value = true;
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();

        // print(r.message);
      },
    );
  }

  List<Brands> listbrand = [];
  RxBool brandbool = false.obs;

  getbrand({required String categoryId}) async {
    // EasyLoading.show();

    final response = await webService.getRequest(
        url: "${webService.baseurl}/store_brand/$categoryId");
    response.fold(
      (l) {
        // EasyLoading.dismiss();
        Getbrandresponse brand = getbrandresponseFromJson(l.toString());
        // print(brand);
        listbrand = brand.data ?? [];
        brandbool.value = true;
      },
      (r) {
        // EasyLoading.dismiss();
        // print(r.message);
      },
    );
  }

  RxBool productapicall = false.obs;
  List<Productdetails> productlist = [];
  RxInt currentindex = 0.obs;
  productApiCall({
    String? categoryid,
    String? brandid,
    String? keyword,
    String? sortorder,
    String? sortby,
    String? filter,
    required int index,
  }) async {
    productapicall.value = false;
    Map<String, dynamic> para = {'test': '1'};
    if (brandid != null) {
      para.addAll({'brand_id': brandid});
    }
    if (categoryid != null) {
      para.addAll({'category_id': categoryid});
    }
    if (keyword != null) {
      para.addAll({'keyword': keyword});
    }
    if (sortby != null) {
      para.addAll({'sort_by': sortby});
    }
    if (sortorder != null) {
      para.addAll({'sort_order': sortorder});
    }
    if (filter != null) {
      if (filter != "All") para.addAll({'filter_by_size': filter});
    }

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product =
            packagessummaryresponseFromJson(l.toString());

        productlist = product.data ?? [];
        productapicall.value = true;
        currentindex.value = index;
      },
      (r) => print(r.message),
    );
  }

  RxList<Map<String, dynamic>> keywordList = <Map<String, dynamic>>[].obs;

  Future<void> fetchKeyword(String keyword) async {
    // String keyword = _searchController.text;

    // EasyLoading.show();

    final response = await webService.postFormRequest(
        url: "${mainlink}/api/store_keywords",
        formData: jsonEncode(<String, String>{'keyword': keyword}),
        header: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        });
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());
        keywordList.clear();
        keywordList.value = List<Map<String, dynamic>>.from(resBody["data"]);

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }
}
