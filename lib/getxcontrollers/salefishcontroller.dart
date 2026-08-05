import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:manjha/Screens/const.dart';
import 'package:manjha/model/fishmasterresponse.dart';
import 'package:manjha/services/custom_api.dart';

import '../Screens/localconst.dart';

class SaleFishController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxBool getfishbool = false.obs;

  RxList<Fishcategory> listfishcategories = <Fishcategory>[].obs;
  RxList<Fishsize> listfishsizes = <Fishsize>[].obs;
  RxList<Fishtype> listfishtype = <Fishtype>[].obs;

  getfishmaster() async {
    final response =
        await webService.getRequest(url: "${webService.baseurl}/fishmaster");
    response.fold(
      (l) {
        Fishmasterresponse banner = fishmasterresponseFromJson(l.toString());
        print(banner);
        listfishcategories.value = banner.data?.fishcategories ?? [];
        listfishsizes.value = banner.data?.fishsizes ?? [];
        listfishtype.value = banner.data?.fishtypes ?? [];
        print(listfishtype.value);

        getfishbool.value = true;
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();
        print(r.message);
      },
    );
  }

  List<Map> toBase64(List<File> fileList) {
    List<Map> s = [];
    if (fileList.isNotEmpty) {
      for (var element in fileList) {
        Map a = {
          'fileName': element.path,
          'encoded': base64Encode(element.readAsBytesSync())
        };
        s.add(a);
      }
    }

    return s;
  }

  TextEditingController sellerNameController = TextEditingController();
  TextEditingController sellerphonenumber = TextEditingController();
  TextEditingController selleradress = TextEditingController();
  TextEditingController citynamecontroller = TextEditingController();
  TextEditingController addressoffishfarming = TextEditingController();
  TextEditingController fishTypeController = TextEditingController();
  TextEditingController weightPerPcsController = TextEditingController();
  TextEditingController fishpricecontroller = TextEditingController();
  Fishtype? selectedFishType;
  Fishsize? selectedFishSize;

  getbecomeseller(
    int isSelected,
    List<File> fileList,
  ) async {
    try {
      // Show loading indicator
      EasyLoading.show();

      // Prepare MultipartFile list for images
      List<MultipartFile> imageFiles = [];
      for (var file in fileList) {
        String fileName = file.path.split('/').last; // Extract file name
        imageFiles.add(
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        );
      }

      // Create FormData with all required fields and images
      FormData formData = FormData.fromMap({
        // "id": id,
        "seller_name": sellerNameController.text,
        "contactno": sellerphonenumber.text,
        "address": selleradress.text,
        "cityname": citynamecontroller.text,
        "farm_address": addressoffishfarming.text,
        "latitude": "21.1430431",
        "longitude": "72.7896692",
        "fish_category_id": selectedFishType?.id.toString(),
        "fish_category_name": fishTypeController.text,
        "fish_type_id": selectedFishType?.id.toString(),
        "fish_type_name": fishTypeController.text, //selectedFishType.name,
        "weight_per_pcs": weightPerPcsController.text,
        "price": fishpricecontroller.text,
        "price_unit": (isSelected == 0 ? "Kg" : "Pcs"),
        "fish_size_type": selectedFishSize?.fishSizeTypeName,
        "fish_image": imageFiles,
        // "fish_image_old":fisholdimage
      });

      // Send the request using Dio
      var dio = Dio();
      Response response = await dio.post(
        "${webService.baseurl}/becomesellersave",
        data: formData, // Pass the FormData directly
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Cookie': Common.getCookie().toString()
            // "content-type": "application/x-www-form-urlencoded",
          },
        ),
      );

      // Handle the response
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data["success"] == true) {
          Fluttertoast.showToast(msg: data["message"]);
          Get.back();
        } else {
          Fluttertoast.showToast(msg: data["message"][0]);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong! ${response.statusMessage}");
      }
    } catch (e) {
      // Handle errors
      EasyLoading.dismiss();
      print("Error: $e");
      Fluttertoast.showToast(msg: "Error occurred: $e");
    }
  }

  updatebecomeseller(int isSelected, List<File> fileList, id) async {
    try {
      // Show loading indicator
      EasyLoading.show();

      // Prepare MultipartFile list for images
      List<MultipartFile> imageFiles = [];
      for (var file in fileList) {
        String fileName = file.path.split('/').last; // Extract file name
        imageFiles.add(
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        );
      }

      // Create FormData with all required fields and images
      FormData formData = FormData.fromMap({
        "id": id,
        "seller_name": sellerNameController.text,
        "contactno": sellerphonenumber.text,
        "address": selleradress.text,
        "cityname": citynamecontroller.text,
        "farm_address": addressoffishfarming.text,
        "latitude": "21.1430431",
        "longitude": "72.7896692",
        "fish_category_id": selectedFishType?.id.toString(),
        "fish_category_name": fishTypeController.text,
        "fish_type_id": selectedFishType?.id.toString(),
        "fish_type_name": fishTypeController.text, //selectedFishType.name,
        "weight_per_pcs": weightPerPcsController.text,
        "price": fishpricecontroller.text,
        "price_unit": (isSelected == 0 ? "Kg" : "Pcs"),
        "fish_size_type": selectedFishSize?.fishSizeTypeName,
        "fish_image": imageFiles,
        // "fish_image_old":fisholdimage
      });

      // Send the request using Dio
      var dio = Dio();
      Response response = await dio.post(
        "${webService.baseurl}/becomesellerupdate",
        data: formData, // Pass the FormData directly
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Cookie': Common.getCookie().toString()
            // "content-type": "application/x-www-form-urlencoded",
          },
        ),
      );

      // Handle the response
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (data["success"] == true) {
          Fluttertoast.showToast(msg: data["message"]);
          Get.back();
        } else {
          Fluttertoast.showToast(msg: data["message"][0]);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong! ${response.statusMessage}");
      }
    } catch (e) {
      // Handle errors
      EasyLoading.dismiss();
      print("Error: $e");
      Fluttertoast.showToast(msg: "Error occurred: $e");
    }
  }


  clearcontroller() {
    sellerNameController.clear();
    sellerphonenumber.clear();
    selleradress.clear();
    citynamecontroller.clear();
    addressoffishfarming.clear();
    fishTypeController.clear();
    weightPerPcsController.clear();
    fishpricecontroller.clear();
  }
}
