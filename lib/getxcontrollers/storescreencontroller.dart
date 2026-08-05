import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/model/getbrandresponse.dart';
import 'package:manjha/model/getcatogoriesresponse.dart';
import 'package:manjha/model/getstorebannerresponse.dart';
import 'package:manjha/services/custom_api.dart';

class StoreScreenController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());
  List<Banner> listbanners = [];
  List<Brands> listbrand = [];
  List<Categorys> listcategory = [];
  RxBool getbannerapi = false.obs;
  RxBool getbarandapi = false.obs;
  RxBool getcategoriesapi = false.obs;

  getbanner() async {
    // getbannerapi.value = false;
    // EasyLoading.show();
    final response =
        await webService.getRequest(url: "${webService.baseurl}/store_banner");
    response.fold(
      (l) {
        getbrand();
        Getbannerresponse banner = getbannerresponseFromJson(l.toString());
        // print(banner);
        listbanners = banner.data ?? [];
        getbannerapi.value = true;
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();

        print(r.message);
      },
    );
  }

  getbrand() async {
    // EasyLoading.show();

    final response =
        await webService.getRequest(url: "${webService.baseurl}/store_brand");
    response.fold(
      (l) {
        EasyLoading.dismiss();

        getcategories();
        Getbrandresponse brand = getbrandresponseFromJson(l.toString());
        // print(brand);
        listbrand = brand.data ?? [];
        getbarandapi.value = true;
      },
      (r) {
        EasyLoading.dismiss();

        print(r.message);
      },
    );
  }

  getcategories() async {
    // EasyLoading.show();
    // getcategoriesapi.value = false;

    final response = await webService.getRequest(
        url: "${webService.baseurl}/store_category");
    response.fold(
      (l) {
        Getcategoriesresponse category =
            getcategoriesresponseFromJson(l.toString());
        // print(category);
        listcategory = category.data?.reversed.toList() ?? [];
        getcategoriesapi.value = true;
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();

        print(r.message);
      },
    );
  }
}
