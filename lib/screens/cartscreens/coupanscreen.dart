import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manjha/getxcontrollers/cartcontroller.dart';
import '../../languagetranslation/apptranslation.dart';
import '../../model/coupenlistresponse.dart';
import '../const.dart';
import '../localconst.dart';

class Coupon {
  final String code;
  final String description;
  final double discount;

  Coupon(
      {required this.code, required this.description, required this.discount});
}

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  CartController cartController = Get.put(CartController());
  TextEditingController _couponController = TextEditingController();
  final List<Coupon> coupons = [
    Coupon(
        code: 'SAVE50',
        description: 'Get 50% off on your first order!',
        discount: 50.0),
    Coupon(
        code: 'WELCOME10',
        description: 'Welcome offer: 10% off on your next order.',
        discount: 10.0),
    Coupon(
        code: 'FREESHIP',
        description: 'Free shipping on orders over \$100.',
        discount: 0.0),
  ];

  @override
  void initState() {
    cartController.CoupenListApiCall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgreyFill,
      appBar: AppBar(
        backgroundColor: kheader,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text("Apply Coupon"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: new TextField(
                      autofocus: true,
                      controller: _couponController,
                      keyboardType: TextInputType.name,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: kheader)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: kheader,
                              width: 1.5), // Border when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: kheader,
                              width: 2.0), // Border when focused
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.5), // Border when there is an error
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width:
                                  2.0), // Border when focused and error is present
                        ),
                        // labelText: 'Enter coupon',
                        hintText: '${translate("Enter coupon code here...!")}',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_couponController.text.length < 3) {
                        EasyLoading.showToast("Please enter min 3 character.");
                        return;
                      }
                      print(_couponController.text);
                      Navigator.pop(this.context);
                      couponUpdate();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Apply'),
                  ),
                  // TextButton(
                  //     style: ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.resolveWith(
                  //             (states) => themecolor.withOpacity(0.5))),
                  //     child: Text('Apply'.tr,
                  //         style: TextStyle(color: kColorButtonCart)),
                  //     onPressed: () {
                  //       if (_couponController.text.length < 3) {
                  //         EasyLoading.showToast("Please enter min 3 character.");
                  //         return;
                  //       }
                  //       print(_couponController.text);
                  //       Navigator.pop(this.context);
                  //       couponUpdate();
                  //       // CategoryModel category = new CategoryModel(
                  //       //     name: _searchController.text, isSearch: true);
                  //       // Common.pushPage(context, CategoryPage(category));
                  //
                  //       // EasyLoading.showToast("Thank you, your otp has been submitted.");
                  //     })
                ],
              ),
            ),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  itemCount: cartController.coupenlist.length,
                  itemBuilder: (context, index) {
                    CouponData coupon = cartController.coupenlist[index];
                    return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: kheader,
                                        radius: 13,
                                        child: Text("%",
                                            style: TextStyle(
                                                color: kwhite,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        coupon.code ?? "",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _couponController.text =
                                          coupon.code ?? "";
                                      couponUpdate();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // border: Border.all(
                                          //     width: 1.5, color: themecolor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: themecolor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                height: 30,
                                thickness: 1,
                              ),
                              Text(
                                coupon.message ?? "",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )

                        // ListTile(
                        //     title: Text(
                        //       coupon.code ?? "",
                        //       style: TextStyle(
                        //           fontSize: 18, fontWeight: FontWeight.bold),
                        //     ),
                        //     subtitle: Text(coupon.message ?? ""),
                        //     trailing: InkWell(
                        //       onTap: () {
                        //         _couponController.text = coupon.code ?? "";
                        //         couponUpdate();
                        //       },
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //             border:
                        //                 Border.all(width: 1.5, color: themecolor),
                        //             borderRadius: BorderRadius.circular(5)),
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 10, vertical: 5),
                        //         child: Text(
                        //           'Apply',
                        //           style: TextStyle(
                        //               fontSize: 16,
                        //               color: themecolor,
                        //               fontWeight: FontWeight.w600),
                        //         ),
                        //       ),
                        //     )
                        //     // ElevatedButton(
                        //     //   onPressed: () {
                        //     //     _couponController.text = coupon.code ?? "";
                        //     //     couponUpdate();
                        //     //   },
                        //     //   style: ElevatedButton.styleFrom(
                        //     //     // backgroundColor: themecolor,
                        //     //
                        //     //     shape: RoundedRectangleBorder(
                        //     //       borderRadius: BorderRadius.circular(10),
                        //     //     ),
                        //     //   ),
                        //     //   child: Text('Apply'),
                        //     // ),
                        //     ),
                        );
                  },
                )),
          ],
        ),
      ),
    );
  }

  void couponUpdate() async {
    // EasyLoading.show(status: translate('Checking coupon...'));
    final response = await http.post(Common.getURL("store_couponCheck"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(
            <String, String>{'coupon_code': _couponController.text}));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      setState(() {});
      if (resBody["success"]) Get.back(result: true);
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }
}
