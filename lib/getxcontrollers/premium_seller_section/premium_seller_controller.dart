import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/model/premium_seller_models/premium_user_details_model.dart';
import 'package:manjha/shared_pref/shared_pref.dart';
import '../../model/premium_seller_models/gallery_upload_model.dart';
import '../../model/premium_seller_models/hatcheryloginmodel.dart';
import '../../model/premium_seller_models/premium_seed_response_model.dart';
import '../../services/apiconst.dart';
import '../../model/premium_seller_models/gallery_response_model.dart';
import 'package:http/http.dart' as http;

import '../../services/custom_api.dart';

class PremiumSellerController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxBool loginbool = false.obs;
  Rx<Hatchery> hatcherydetail = Hatchery().obs;

  Future<void> gethatcharylogin({required String mobileno}) async {
    loginbool.value = false;

    // EasyLoading.show();
    Map<String, dynamic> para = {
      'mobileno': mobileno == "" ? '9813489000' : mobileno,
    };

    final response = await webService.postFormRequest(
        url: "$baseUrl/hatchery_login", formData: jsonEncode(para));
    response.fold(
      (l) {
        Hatcheryloginmodel hatchery = hatcheryloginmodelFromJson(l.toString());

        Fluttertoast.showToast(msg: hatchery.message ?? "");
        hatcherydetail.value = hatchery.hatchery ?? Hatchery();
        loginbool.value = true;
        EasyLoading.dismiss();
      },
      (r) {
        loginbool.value = true;
        print(r.message);
      },
    );
  }

  RxBool loading = false.obs;
  Rx<PremiumUserData?> premiumUser = Rx<PremiumUserData?>(null);
  RxList<PreUserDataList> userDataList = <PreUserDataList>[].obs;
  RxList<UserDetailsLink> userDataLinks = <UserDetailsLink>[].obs;

  Future<void> fetchPremiumUserList() async {
    loading.value = true;
    // EasyLoading.show();

    Map<String, dynamic> data = {
      "type": hatcherydetail.value.hatcheryTypeId.toString(),
      "hatchery_id": hatcherydetail.value.id.toString(),
    };

    try {
      await getPremiumUserList(parameter: data).then((value) {
        if (value.success == true) {
          premiumUser.value = value.premiumUserData ?? PremiumUserData();
          userDataList.value = value.premiumUserData?.data ?? [];
          userDataLinks.value = value.premiumUserData?.links ?? [];
        } else {
          Get.snackbar('Error', 'Failed to fetch data');
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      EasyLoading.dismiss();
    } catch (e) {
      loading.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: '${e.toString()}');
    } finally {
      loading.value = false;
      EasyLoading.dismiss();
    }
    // await getPremiumUserList(parameter: data).then((value) {
    //   if (value.success == true) {
    //     var response = premiumUser;
    //
    //   }
    //   loading.value = false;
    // }).onError((error, stackTrace) {
    //   print(error);
    //   loading.value = false;
    // });
  }

  RxBool galleryLoader = false.obs;
  // Rx<GalleryResponseData?> galleryData = Rx<GalleryResponseData?>(null);
  RxList<GalleryDataList> galleryDataList = <GalleryDataList>[].obs;
  // RxList<GalleryLinks> galleryDataLinks = <GalleryLinks>[].obs;

  Future<void> fetchGalleryList() async {
    galleryLoader.value = true;
    // EasyLoading.show();

    Map<String, dynamic> data = {
      'hatchery_id': hatcherydetail.value.id.toString(),
    };

    try {
      await getGalleryList(parameter: data).then((value) {
        if (value.success == true) {
          // galleryData.value = value.data ?? GalleryResponseData();
          galleryDataList.value = value.data ?? [];
          // galleryDataLinks.value = value.data?.links ?? [];
        } else {
          Get.snackbar('Error', 'Failed to fetch data');
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      EasyLoading.dismiss();
    } catch (e) {
      galleryLoader.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: '${e.toString()}');
    } finally {
      galleryLoader.value = false;
      EasyLoading.dismiss();
    }
  }

  RxBool galleryDeleteLoad = false.obs;

  Future<void> deleteGalleryImage({required int? galleryMediaId}) async {
    galleryDeleteLoad.value = true;
    // EasyLoading.show();

    // Map<String, dynamic> data = {
    //   "hatchery_media_id": "$galleryMediaId",
    // };

    try {
      await deleteImageAtGallery(id: galleryMediaId).then((value) {
        if (value.success == true) {
          Fluttertoast.showToast(msg: value.message ?? "");
          fetchGalleryList();
        } else {
          Fluttertoast.showToast(msg: value.message ?? "");
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      EasyLoading.dismiss();
    } catch (e) {
      galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: '${e.toString()}');
    } finally {
      galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
    }
  }

  // Future<void> uploadGalleryImages({
  //   required String hatcheryId,
  //   required String mediaTitle,
  //   required String imageData,
  // }) async {
  //   galleryUploadLoad.value = true;
  //
  //   Map<String, dynamic> data = {
  //     "hatchery_id": hatcheryId,
  //     "media_title": mediaTitle,
  //     "gallery_image": imageData,
  //   };
  //
  //   await uploadImageAtGallery(parameter: data).then((value) {
  //     if (value.success == true) {
  //       Fluttertoast.showToast(msg: value.message ?? "");
  //       fetchGalleryList();
  //     }
  //     galleryUploadLoad.value = false;
  //   }).onError((error, stackTrace) {
  //     print(error);
  //     galleryUploadLoad.value = false;
  //   });
  // }
  //
  // List<String> selectedImageBase64List = [];
  //
  // Future<void> uploadAllImages({
  //   required String hatcheryId,
  //   required String mediaTitle,
  //   required List<String> imageList,
  // }) async {
  //   for (String imageData in imageList) {
  //     await uploadGalleryImages(
  //       hatcheryId: hatcheryId,
  //       mediaTitle: mediaTitle,
  //       imageData: imageData,
  //     );
  //   }
  // }

  RxBool galleryUploadLoad = false.obs;
  RxString selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickFile(ImageSource source) async {
    final pickedGallery =
        await _picker.pickImage(source: source, imageQuality: 100);

    if (pickedGallery != null) {
      selectedImagePath.value = pickedGallery.path;
      await uploadGalleryImage(imagePath: selectedImagePath.value);
    } else {
      print('No Image Selected');
    }
  }

  Future<void> uploadGalleryImage(
      {String? hatcheryId, String? mediaTitle, String? imagePath}) async {
    galleryUploadLoad.value = true;
    // EasyLoading.show();

    var request =
        http.MultipartRequest('POST', Uri.parse('${test_url}/galleryupload'));

    request.fields['hatchery_id'] = hatcherydetail.value.id.toString();
    request.fields['media_title'] = mediaTitle ?? 'Hello World';
    // request.fields['gallery_image'] = imagePath ?? '';

    if (imagePath != null && imagePath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('gallery_image', imagePath));
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var galleryUploadModel = galleryUploadModelFromJson(response.body);

        if (galleryUploadModel.success == true) {
          galleryUploadLoad.value = false;
          EasyLoading.dismiss();
          Fluttertoast.showToast(
              msg: galleryUploadModel.message ?? 'Photo Uploaded successfully');
          fetchGalleryList();
        } else {
          galleryUploadLoad.value = false;
          throw Exception(galleryUploadModel.message);
        }
      } else {
        galleryUploadLoad.value = false;
        throw Exception('Failed to create category');
      }
    } catch (error) {
      galleryUploadLoad.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: error.toString());
      if (kDebugMode) {
        print(error);
      }
    }
  }

  clearUploadController() {
    selectedImagePath.value = '';
  }

  //====================================================================

  RxBool premiumSeedLoader = false.obs;
  // Rx<GetPremiumSeed?> premiumSeedList = Rx<GetPremiumSeed?>(null);
  RxList<PremiumSeedData> premiumSeedData = <PremiumSeedData>[].obs;
  // RxList<PremiumSeedLinks> premiumSeedLinks = <PremiumSeedLinks>[].obs;

  Future<void> fetchPremiumSeedList({required String hatcheryId}) async {
    premiumSeedLoader.value = true;
    // EasyLoading.show();

    // Map<String, dynamic> data = {
    //   "id": hatcherydetail.value.id.toString(),
    // };

    try {
      await getPremiumSeedList(id: hatcheryId).then((value) {
        if (value.success == true) {
          // premiumSeedList.value = value.premiumSeed ?? GetPremiumSeed();
          premiumSeedData.value = value.data ?? [];
          // premiumSeedLinks.value = value.premiumSeed?.links ?? [];
        } else {
          Get.snackbar('Error', 'Failed to fetch data');
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      EasyLoading.dismiss();
    } catch (e) {
      premiumSeedLoader.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: '${e.toString()}');
    } finally {
      premiumSeedLoader.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> deletePremiumSeedData({required String premiumSeedId}) async {
    // galleryDeleteLoad.value = true;
    // EasyLoading.show();

    try {
      await deletePremiumSeed(hatcherySeedId: premiumSeedId).then((value) {
        if (value.success == true) {
          Fluttertoast.showToast(msg: value.message ?? "");
          fetchPremiumSeedList(hatcheryId: 13.toString());
        } else {
          Fluttertoast.showToast(msg: value.message ?? "");
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      EasyLoading.dismiss();
    } catch (e) {
      // galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: '${e.toString()}');
    } finally {
      // galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
    }
  }

  TextEditingController seedname = TextEditingController();
  TextEditingController seedweight = TextEditingController();
  TextEditingController seedsize = TextEditingController();
  TextEditingController seedprice = TextEditingController();
  TextEditingController seedbonus = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController sortorder = TextEditingController();
  RxBool isrtpcrtrsted = true.obs;
  RxBool isactive = true.obs;

  clearfunction() {
    seedname.clear();
    seedweight.clear();
    seedsize.clear();
    seedprice.clear();
    seedbonus.clear();
    description.clear();
    sortorder.clear();
    isrtpcrtrsted.value = true;
    isactive.value = true;
  }

  Future<void> createPremiumSeedapifunction({
    String? image,
  }) async {
    // EasyLoading.show();

    Map<String, dynamic> parameter = {
      'hatchery_id': hatcherydetail.value.id.toString(),
      'seed_name': seedname.text,
      'seed_weight': seedweight.text,
      'seed_size': seedsize.text,
      'seed_price': seedprice.text,
      'seed_bonus': seedbonus.text,
      'is_rtpcr_tested': isrtpcrtrsted == true ? '1' : '0',
      'seed_video': '',
      'description': description.text,
      'sort_order': sortorder.text,
      'is_active': isactive == true ? '1' : '0',
      'is_deleted': '0'
    };

    try {
      await createPremiumSeed(para: parameter, file: image).then((value) {
        if (value.success == true) {
          Fluttertoast.showToast(msg: value.message ?? "");
          fetchPremiumSeedList(hatcheryId: 13.toString());
          clearfunction();
          Get.back();
        } else {
          Fluttertoast.showToast(msg: value.message ?? "");
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      EasyLoading.dismiss();
    } catch (e) {
      // galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: '${e.toString()}');
    } finally {
      // galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> EditPremiumSeedapifunction(
      {String? image, required String hetcheryseedid}) async {
    // EasyLoading.show();

    Map<String, dynamic> parameter = {
      'hatchery_id': hatcherydetail.value.id.toString(),
      'seed_name': seedname.text,
      'seed_weight': seedweight.text,
      'seed_size': seedsize.text,
      'seed_price': seedprice.text,
      'seed_bonus': seedbonus.text,
      'is_rtpcr_tested': isrtpcrtrsted == true ? '1' : '0',
      'seed_video': '',
      'description': description.text,
      'sort_order': sortorder.text,
      'is_active': isactive == true ? '1' : '0',
      'is_deleted': '0'
    };

    try {
      await updatePremiumSeed(
              para: parameter, file: image, hatcherySeedId: hetcheryseedid)
          .then((value) {
        if (value.success == true) {
          Fluttertoast.showToast(msg: value.message ?? "");
          fetchPremiumSeedList(hatcheryId: 13.toString());
          clearfunction();
          Get.back();
        } else {
          Fluttertoast.showToast(msg: value.message ?? "");
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      EasyLoading.dismiss();
    } catch (e) {
      // galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: '${e.toString()}');
    } finally {
      // galleryDeleteLoad.value = false;
      EasyLoading.dismiss();
    }
  }
}
