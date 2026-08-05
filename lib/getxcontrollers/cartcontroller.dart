import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import '../Screens/const.dart';
import '../model/cart_model.dart';
import '../model/coupenlistresponse.dart';
import '../screens/localconst.dart';
import '../services/apiconst.dart';
import '../services/custom_api.dart';

class CartController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxList<dynamic> cartList = [].obs;
  RxList<CartModel> cartListcheckout = <CartModel>[].obs;

  RxBool showcart = false.obs;

  RxInt cartcount = 0.obs;

  fetchCart() async {
    // showcart.value = false;

    final response =
        await http.get(Common.getURL("store_cart"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': Common.getCookie().toString()
      // "content-type": "application/x-www-form-urlencoded",
    });
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      final parsed = resBody["data"].cast<Map<String, dynamic>>();
      cartList.value =
          parsed.map<CartModel>((json) => CartModel.fromJson(json)).toList();
      cartcount.value = cartList.length;
      Common.cartCount = cartList.length;
      Common.cartTotal = resBody['payable'];
      if (cartList.isNotEmpty) {
        showcart.value = true;
      } else {
        showcart.value = false;
      }
    } else {
      throw Exception('Failed to load request');
    }
  }

  Future<void> fetchCartupdate(cartId, qty) async {
    // EasyLoading.show(status: '${translate('Updating from cart')}');
    final response = await http.post(Common.getURL("store_cartUpdate"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString(),
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'product_id': cartId.toString(),
          'quantity': qty.toString(),
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());
      // Fluttertoast.showToast(msg: resBody["message"].toString());
      await fetchCart();
      update();
    } else {
      throw Exception('Failed to load request');
    }
  }

  Future<void> fetchCartAddd(cartId, qty) async {
    final response = await http.post(Common.getURL("store_cartAdd"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'product_id': cartId.toString(),
          'quantity': qty.toString(),
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      if (resBody["success"] == false) logoutfuntion();
      EasyLoading.showToast(resBody["message"].toString());
      // Fluttertoast.showToast(msg: resBody["message"].toString());
      await fetchCart();
      update();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }

  RxList<CouponData> coupenlist = <CouponData>[].obs;
  CoupenListApiCall() async {
    // Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};
    // EasyLoading.show();
    final response = await webService.getRequest(
        url: "$baseUrl/scoupon_list");
    response.fold(
      (l) {
        CopenListResponse product = copenListResponseFromJson(l.toString());

        coupenlist.value = product.coupons ?? [];
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }
}
