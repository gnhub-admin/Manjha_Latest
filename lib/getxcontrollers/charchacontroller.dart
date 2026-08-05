import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../Screens/localconst.dart';
import '../languagetranslation/apptranslation.dart';
import '../model/my_forum_response_model.dart';
import '../model/suraj_charcha_model.dart';
import '../services/apiconst.dart';
import '../services/custom_api.dart';

class CharchaController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());
  RxBool charChaCall = false.obs;
  List<Forumdd> forumList = [];
  List<MyForum> myForumList = [];
  int currentPage = 1;

  // getcharchaApiCall({int page = 1}) async {
  //   Map<String, dynamic> para = {
  //     'charchacall': "0",
  //     'page': page.toString(),
  //     'limit': "20"
  //   };
  //
  //   final response = await webService.postFormRequest(
  //     url: "https://manjha.in/public/api/forums?page=${page}&limit=20",
  //     formData: jsonEncode(para),
  //   );
  //   response.fold(
  //         (l) {
  //       Charcharesponse forum = charcharesponseFromJson(l.toString());
  //       if (page == 1) {
  //         forumList = forum.data ?? [];
  //       } else {
  //         forumList.addAll(forum.data ?? []);
  //       }
  //       charChaCall.value = true;
  //       charCha.currentPage = page;
  //       update();
  //       EasyLoading.dismiss();
  //     },
  //         (r) => print(r.message),
  //   );
  // }

  getcharchaApiCall({required int page}) async {
    // charChaCall.value = false;
    // EasyLoading.show();
    // Map<String, dynamic> para = {'charchacall': "0"};

    // if (charChaCall.value) return;

    // EasyLoading.show();

    // Map<String, dynamic> para = {'charchacall': "0", 'page': page.toString(), 'limit': "20"};

    await getdetail(page: '$page').then((value) {
      forumList.addAll(value.data?.data ?? []);
      currentPage = currentPage + 1;
      charChaCall.value = true;
      update();
    }).onError((error, stackTrace) {
      print(error);
    });

    // final response = await webService.getRequest(
    //     // url: "${webService.baseUrl}/forums", formData: jsonEncode(para));
    //     url: "http://192.168.29.248:8003/api/forums?page=${page.toString()}&limit=20",
    //    );
    // response.fold(
    //   (l) {
    //     CharchaModel forum = charchaModelFromJson(l.toString());
    //     // forumList = forum.data ?? [];
    //     if (forum.data != null) {
    //
    //     }
    //
    //
    //     EasyLoading.dismiss();
    //   },
    //   (r) => print(r.message),
    // );
  }

  getMyForumApiCall() async {
    // charChaCall.value = false;
    // EasyLoading.show();
    Map<String, dynamic> para = {'charchacall': "0"};

    final response = await webService.postFormRequest(
        // url: "${webService.baseUrl}/forums", formData: jsonEncode(para));
        url: "${webService.baseurl}/forumsMy",
        formData: jsonEncode(para),
        header: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        });
    response.fold(
      (l) {
        MyForumResponse myForum = myForumResponseFromJson(l.toString());
        print(jsonEncode(myForum));
        myForumList = myForum.data ?? [];
        charChaCall.value = true;
        update();
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  getlikedislike({required String questionsid}) async {
    // EasyLoading.show();
    Map<String, dynamic> para = {'forum_question_id': questionsid};

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/forumQuestionLike",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());

        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        // print(resBody);
        EasyLoading.showToast(resBody["message"]);
        // getcharchaApiCall(page: 1);
        // getMyForumApiCall();

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  getreportreason({
    required String questionsid,
    required String reason,
  }) async {
    EasyLoading.show(status: '${translate('Reporting...')}');
    Map<String, dynamic> para = {
      'forum_question_id': questionsid,
      'report': reason,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/forum_reportAdd",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());

        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        // print(resBody);
        EasyLoading.showToast(resBody["message"]);
        // getcharchaApiCall();

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  getblock({required String customerid}) async {
    EasyLoading.show(status: '${translate('Blocking...')}');
    Map<String, dynamic> para = {
      'blocked_id': customerid,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/forum_blockedAdd",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());
        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        // print(resBody);
        EasyLoading.showToast(resBody["message"]);
        // getcharchaApiCall(page: 1);
        // getMyForumApiCall();

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  getforumAnswerAdd(
      {required String questionid, required String answer}) async {
    // EasyLoading.show();
    Map<String, dynamic> para = {'question_id': questionid, 'answer': answer};

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/forumAnswerAdd",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());
        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        // print(resBody);
        EasyLoading.showToast(resBody["message"]);
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();

        print(r.message);
      },
    );
  }

  getforumAnswerdelete({required String questionid}) async {
    // EasyLoading.show();
    Map<String, dynamic> para = {
      'id': questionid,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/forumAnswerDelete",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());
        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        // print(resBody);
        EasyLoading.showToast(resBody["message"]);
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();

        print(r.message);
      },
    );
  }

  getforumQuestionsdelete({required String questionid}) async {
    // EasyLoading.show();
    Map<String, dynamic> para = {
      'forum_question_id': questionid,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseurl}/forumQuestionDelete",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());
        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        // print(resBody);
        EasyLoading.showToast(resBody["message"]);
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();
        print(r.message);
      },
    );
  }
}
