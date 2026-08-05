import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/model/productresponse.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/services/custom_api.dart';

class ProductController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxInt currantindex = 0.obs;
  RxInt currantfeedindex = 0.obs;

  RxBool testingproduct = false.obs;
  RxBool fishfeedproduct = false.obs;
  RxBool shrimpyfeedproduct = false.obs;
  RxBool equipmentproduct = false.obs;
  RxBool isloading = false.obs;


  RxList<Productdetails> helthproductlist = <Productdetails>[].obs;
  helthcareproductApiCall({required String categoryid}) async {
    // EasyLoading.show();
    isloading.value = true;

    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/store_product?lang=${languagecode()}", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product = packagessummaryresponseFromJson(l.toString());
        isloading.value = false;

        helthproductlist.value = product.data ?? [];
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }


  RxList<Productdetails> testingproductlist = <Productdetails>[].obs;
  testingproductApiCall({required String categoryid}) async {
    isloading.value = true;
    // EasyLoading.show();

    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};

    final response =
        await webService.postFormRequest(url: "${webService.baseurl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product = packagessummaryresponseFromJson(l.toString());

        testingproductlist.value = product.data ?? [];
        isloading.value = false;
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  RxList<Productdetails> fishproductlist = <Productdetails>[].obs;
  fishproductApiCall({required String categoryid}) async {
    // EasyLoading.show();
    isloading.value = true;
    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};

    final response =
        await webService.postFormRequest(url: "${webService.baseurl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        EasyLoading.dismiss();

        Packagessummaryresponse product = packagessummaryresponseFromJson(l.toString());

        fishproductlist.value = product.data ?? [];
        isloading.value = false;
      },
      (r) => print(r.message),
    );
  }


  RxList<Productdetails> shimpyproductlist = <Productdetails>[].obs;
  shimpyproductApiCall({required String categoryid}) async {
    // EasyLoading.show()
    isloading.value = true;

    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};

    final response =
        await webService.postFormRequest(url: "${webService.baseurl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product = packagessummaryresponseFromJson(l.toString());

        shimpyproductlist.value = product.data ?? [];
        isloading.value = false;

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }


  RxList<Productdetails> equipmentproductlist = <Productdetails>[].obs;
  equipmentproductApiCall({required String categoryid}) async {
    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};
    // EasyLoading.show();
    isloading.value = true;
    final response =
        await webService.postFormRequest(url: "${webService.baseurl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product = packagessummaryresponseFromJson(l.toString());

        equipmentproductlist.value = product.data ?? [];
        isloading.value = false;

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  // allproductsnull(){
  //   helthproductlist.clear();
  //   testingproductlist.clear();
  //   fishproductlist.clear();
  //   shimpyproductlist.clear();
  //   equipmentproductlist.clear();
  // }
}
