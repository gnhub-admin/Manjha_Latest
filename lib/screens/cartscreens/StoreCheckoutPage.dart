import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manjha/screens/cartscreens/thankyoupage.dart';
import 'package:manjha/screens/profile_screens/profile.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import '../../getxcontrollers/cartcontroller.dart';
import '../../getxcontrollers/mixpanelcontroller.dart';
import '../../getxcontrollers/productlistingcontroller.dart';
import '../../languagetranslation/apptranslation.dart';
import '../../model/AddressModel.dart';
import '../../model/cart_model.dart';
import '../../widget/textfieldscreen.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../localconst.dart';
import '../profile_screens/StoreAddressPage.dart';
import 'package:quiver/iterables.dart';

import 'coupanscreen.dart';

// ignore: must_be_immutable
class StoreCheckoutPage extends StatefulWidget {
  final VoidCallback? onPagePop;
  bool? fromProductListingPage;
  final String? categoryid;
  final String? brandid;
  final int? status;
  StoreCheckoutPage({
    this.onPagePop,
    this.fromProductListingPage = false,
    this.categoryid,
    this.brandid,
    this.status,
  });

  @override
  _StoreCheckoutPageState createState() => _StoreCheckoutPageState();
}

class _StoreCheckoutPageState extends State<StoreCheckoutPage> {
  List<Map<String, dynamic>> totalList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CartController c = Get.put(CartController());
  //tring countryCode;
  //String cntryid;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  // final _productIdController = TextEditingController();
  List<AddressModel> addressList = [];
  int intSelectedAddressIndex = 0;
  String total = "0";
  String warning = "";
  double weight = 0.0;
  isWarning() {
    return warning.isNotEmpty && warning.isNotEmpty;
  }

  getTotal() {
    if (total.isNotEmpty) {
      return "${translate("Rs")}." + total + "/-";
    }
    return "${translate("Rs")}.0/-";
  }

  void initState() {
    super.initState();
    print("isFromProductListingPage: ${widget.fromProductListingPage}");
    // UserDetailModel userItem = new UserDetailModel();
    // CountryList();
    this.loadPaymentDefault();
    this._fetchAddress();

    // if (userItem.country == null && userItem.country.isEmpty)
    //   userItem.country = 'United Kingdom';

    // print(_countryController.text);
  }

  refreshCart() {
    this._fetchCart();
  }

  bool _loading = true;
  bool show = true;

  loadPaymentDefault() async {
    // await Common.analytics.setCurrentScreen(screenName: 'CheckoutScreen');

    _nameController.text = await Session.getPaymentName();
    _addressController.text = await Session.getAddress();
    setState(() {
      if (cartList.length > 0) {}

      _loading = false;
    });
  }

  Future<void> deleteCartItem(int cartId) async {
    // cartUpdate();

    print(cartId);
    EasyLoading.show(status: translate('Removing from cart'));
    final response = await http.post(Common.getURL("store_cartRemove"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'cart_id': cartId.toString(),
        }));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      setState(() {});
      _fetchCart();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }

  List<CartModel> cartList = [];
  String couponApplied = "";
  bool postcodeApplied = false;
  bool postcodeDeliverable = true;
  String postcodeMessage = "Pincode is undeliverable.";
  bool cartChanged = false;

  cartUpdate() {
    cartChanged = true;
  }

  // List<String> qtyList = <String>['1', '2', '3', '4', '5', '6', '7', '8'];
  List<int> qtyList = <int>[
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50
  ];

  CartController cartController = Get.put(CartController());
  ProductListingController prductlist = Get.put(ProductListingController());
  // ProductController _productController = Get.put(ProductController());
  String selectedPaymentOption = 'Paytm';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.fromProductListingPage == true) {
          prductlist.productApiCall(
              index: 0, categoryid: widget.categoryid, brandid: widget.brandid);
          // if (widget.status == 1) {
          //   prductlist.productApiCall(index: 0, categoryid: widget.categoryid, brandid: widget.brandid);
          //   _productController.fishproductApiCall(
          //     categoryid: "5",
          //   );
          // } else if (widget.status == 2) {
          //   _productController.shimpyproductApiCall(
          //     categoryid: "6",
          //   );
          // } else if (widget.status == 3) {
          //   _productController.helthcareproductApiCall(
          //     categoryid: "2",
          //   );
          // } else if (widget.status == 4) {
          //   _productController.testingproductApiCall(
          //     categoryid: "3",
          //   );
          // } else if (widget.status == 5) {
          //   _productController.equipmentproductApiCall(
          //     categoryid: "4",
          //   );
          // }
        }
        // if (widget.onPagePop != null) {
        //   widget.onPagePop!();
        // }
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xffF1F0F5),
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kblack),
          // backgroundColor: Colors.transparent,
          backgroundColor: Color(0xffF1F0F5),
          elevation: 0,
          title: Text(
            "My Cart".tr,
            style: TextStyle(color: kblack),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color(0xffF1F0F5),
                  // border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(200))),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  if (widget.fromProductListingPage == true) {
                    prductlist.productApiCall(
                        categoryid: widget.categoryid,
                        index: 0,
                        brandid: widget.brandid);
                    cartController.fetchCart();
                  }
                  Navigator.of(context).pop();
                  // if (widget.onPagePop != null) {
                  //   widget.onPagePop!();
                  // }
                  // Get.back();
                },
                child: Icon(
                  Icons.chevron_left_sharp,
                  color: kblack,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: cartList.length == 0
            ? SizedBox()
            : show == true
                ? SizedBox()
                : Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(
                                0, -2), // Offset for upper side elevation
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    // height: screenheight(context, dividedby: 6),
                    child: _loading == true
                        ? Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: kheader),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    selectedPaymentOption == "COD"
                                        ? SizedBox(
                                            height: 45,
                                            width: 15,
                                          )
                                        : Image.asset(
                                            height: 45,
                                            width: 45,
                                            "assets/download.png"),
                                    SizedBox(
                                      width: 0,
                                    ),
                                    selectedPaymentOption == "COD"
                                        ? Row(
                                            children: [
                                              Text(
                                                "Cash on Delivery ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "(COD)".tr,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                "${translate('Pay With')} ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "Paytm".tr,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                                // ListView.builder(
                                //   shrinkWrap: true,
                                //   padding: EdgeInsets.all(8),
                                //   physics: NeverScrollableScrollPhysics(),
                                //   itemCount: totalList.length,
                                //   itemBuilder: (context, index) {
                                //     return Column(
                                //       children: [
                                //         Row(
                                //           children: [
                                //             Container(
                                //                 width: 210,
                                //                 padding: EdgeInsets.symmetric(
                                //                     horizontal: 8, vertical: 4),
                                //                 child: Text(
                                //                   totalList[index]['title'],
                                //                   style: TextStyle(
                                //                       fontSize: 16,
                                //                       color: kgreyDark,
                                //                       fontWeight:
                                //                           FontWeight.w400),
                                //                 )),
                                //             Spacer(),
                                //             Container(
                                //               padding: EdgeInsets.symmetric(
                                //                   horizontal: 8, vertical: 4),
                                //               child: Text(
                                //                   '${translate("Rs")}.' +
                                //                       totalList[index]['text']
                                //                           .toString(),
                                //                   style: TextStyle(
                                //                       fontSize: 16,
                                //                       fontWeight:
                                //                           FontWeight.bold)),
                                //             ),
                                //           ],
                                //         ),
                                //         index + 1 == totalList.length
                                //             ? SizedBox()
                                //             : Divider()
                                //       ],
                                //     );
                                //   },
                                // ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //     height: 80,
                                      //     width: 80,
                                      //     "assets/download.png"),
                                      Expanded(
                                        child: MaterialButton(
                                            disabledColor: Colors.grey,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            onPressed: !isWarning()
                                                ? () async {
                                                    print('~~~~~~~~~~~~~~~~');
                                                    // initPlatformState(total);
                                                    MixpanelController
                                                        .logScreen(
                                                            MixpanelController
                                                                .PageCheckout,
                                                            properties: {
                                                          "Event": "Payment",
                                                          "Amount": "${total}"
                                                        });

                                                    this.addOrder();
                                                    // prepareRequest('17', '600');
                                                    // initPaymentPayment(total);

                                                    // EasyLoading.showToast(
                                                    //     'We will take order soon. Thanks for your interest.');
                                                  }
                                                : null,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // "${translate('Pay Amount')} ${getTotal()}",
                                                      "Rs.$total",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      // "${translate('Pay Amount')} ${getTotal()}",
                                                      "Total Amount",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  // "${translate('Pay Amount')} ${getTotal()}",
                                                  "${translate('Place Order')}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: 50,
                                            color: kColorButtonCart),
                                      ),
                                    ],
                                  ),
                                )
                                // Row(children: [
                                //   Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Text('Payable'),
                                //   ),
                                //   Padding(
                                //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                //     child: Text(getTotal(),
                                //         style: TextStyle(
                                //             fontSize: 22, fontWeight: FontWeight.bold)),
                                //   ),
                                //   Spacer(),
                                //   Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: MaterialButton(
                                //         disabledColor: Colors.grey,
                                //         onPressed: isWarning()
                                //             ? null
                                //             : () async {
                                //                 print('~~~~~~~~~~~~~~~~');
                                //                 // initPlatformState(total);
                                //                 this.addOrder();
                                //                 // prepareRequest('17', '600');
                                //                 // initPaymentPayment(total);
                                //
                                //                 // EasyLoading.showToast(
                                //                 //     'We will take order soon. Thanks for your interest.');
                                //               },
                                //         child: Text(
                                //           "Place Order",
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: 16,
                                //               color: Colors.white),
                                //         ),
                                //         minWidth: MediaQuery.of(context).size.width / 3,
                                //         height: 45,
                                //         color: kColorButtonCart),
                                //   )
                                // ]),
                              ],
                            ),
                          ),
                  ),
        body: Builder(
          builder: (context) => show == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: kheader,
                        strokeWidth: 2,
                      ),
                    ),
                  ],
                )
              : cartList.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/only-empty-cart.png",
                              height: 150),
                          Text("Your Cart is Empty.",
                              style: TextStyle(
                                color: kheader,
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                              )),
                          // SizedBox(height: 10,),
                        ],
                      ),
                    )
                  : ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Visibility(
                                    visible: isWarning(),
                                    child: Container(
                                        // color: Colors.red,
                                        margin: EdgeInsets.only(bottom: 15),
                                        width: double.infinity,
                                        child: Card(
                                            elevation: 0,
                                            color: Colors.red[200],
                                            child: Padding(
                                                padding: EdgeInsets.all(12),
                                                child: BoldText(
                                                    warning, 16.0, kblack)))),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text("Your Order Summary".tr,
                                        style: Common.textFormFieldBold)),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 00.0),
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            height: 0,
                                            thickness: 1,
                                            endIndent: 20,
                                            indent: 20,
                                          );
                                        },
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: cartList.length <= 0
                                            ? 0
                                            : cartList.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Row(
                                            children: [
                                              Container(
                                                constraints:
                                                    BoxConstraints.tightFor(
                                                        width: 80.0,
                                                        height: 90.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  12)),
                                                  // color: kheader.withOpacity(0.1),
                                                  color: Colors.transparent,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                      cartList[index]
                                                          .getImageUrl(),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            flex: 4,
                                                            child: Container(
                                                              child: Text(
                                                                cartList[index]
                                                                    .getName(),
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                softWrap: false,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          // Flexible(
                                                          //   flex: 1,
                                                          //   child: IconButton(
                                                          //     onPressed: () {
                                                          //       deleteCartItem(cartList[index].id!);
                                                          //     },
                                                          //     icon: Icon(
                                                          //       Icons.delete,
                                                          //       color: kdeletecolor,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              // flex: 4,
                                                              child: Container(
                                                                child: Text(
                                                                  "Code: ${cartList[index].productCode ?? ""}",
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .grey),
                                                                  softWrap:
                                                                      false,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  getQuantityContainer(
                                                                      cartList[
                                                                          index]),
                                                                  Expanded(
                                                                      child:
                                                                          SizedBox()),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${translate("Rs")}." +
                                                                        cartList[index]
                                                                            .price
                                                                            .toString() ==
                                                                    ''
                                                                ? "N.A."
                                                                : cartList[
                                                                        index]
                                                                    .price
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.grey,
                                                              decoration: cartList[
                                                                              index]
                                                                          .price
                                                                          .toString() !=
                                                                      ''
                                                                  ? TextDecoration
                                                                      .lineThrough
                                                                  : TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "${translate("Rs")}." +
                                                                        cartList[index]
                                                                            .specialPrice
                                                                            .toString() ==
                                                                    ''
                                                                ? "N.A."
                                                                : cartList[
                                                                        index]
                                                                    .specialPrice
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                      // Text(
                                                      //   cartList[index].getPriceText(),
                                                      //   style: TextStyle(color: kgreyDark, fontSize: 16),
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text("Offers And Benifits".tr,
                                        style: Common.textFormFieldBold)),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: couponApplied != ""
                                        ? ListTile(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            onTap: () {
                                              // _showCouponDialog();
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor: kheader,
                                              radius: 13,
                                              child: Text("%",
                                                  style: TextStyle(
                                                      color: kwhite,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            title: Text(
                                              "${couponApplied} ${translate("coupon applied!")}",
                                              style: TextStyle(
                                                  color: kColorPrice,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(Icons.cancel,
                                                  color: kheader),
                                              onPressed: () {
                                                _couponController.text = '';
                                                couponUpdate();
                                                // setState(() {
                                                //   couponApplied = !couponApplied;
                                                // });
                                                // EasyLoading.showToast('Removed');
                                              },
                                            ),
                                          )
                                        : ListTile(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            onTap: () {
                                              // _showCouponDialog();
                                              Get.to(CouponScreen())
                                                  ?.then((value) {
                                                if (value == true) {
                                                  _fetchCart();
                                                }
                                              });
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor: kheader,
                                              radius: 13,
                                              child: Text("%",
                                                  style: TextStyle(
                                                      color: kwhite,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            title: Text(
                                              "Apply coupon".tr,
                                              style: TextStyle(color: kblack),
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 18,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                Get.to(CouponScreen())
                                                    ?.then((value) {
                                                  if (value == true) {
                                                    _fetchCart();
                                                  }
                                                });
                                                // _showCouponDialog();
                                                // couponUpdate();

                                                // setState(() {
                                                //   couponApplied = !couponApplied;
                                                // });
                                                // EasyLoading.showToast('Applied');
                                                // _showCouponDialog();
                                              },
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            // itemcart(),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text("Delivery Address".tr,
                                    style: Common.textFormFieldBold)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Theme(
                                    data: ThemeData(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                    ),
                                    child: ListTile(
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      selectedColor: Colors.transparent,
                                      selectedTileColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      tileColor: Colors.transparent,
                                      onTap: () {
                                        showcheckoutbottomsheet(
                                            context, addressList);
                                        // _showAddressDialog(context, addressList);
                                      },
                                      // contentPadding: EdgeInsets.all(8),
                                      title: TextCustom(
                                          _nameController.text, kblack, 16.0,
                                          fonntweight: FontWeight.w600),
                                      subtitle: Text(_addressController.text),
                                      trailing: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text("Bill Details".tr,
                                    style: Common.textFormFieldBold)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(8),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: totalList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 210,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                child: Text(
                                                  totalList[index]['title'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: kgreyDark,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: Text(
                                                  '${translate("Rs")}.' +
                                                      totalList[index]['text']
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          totalList.length ==
                                                                  index + 1
                                                              ? 15
                                                              : 14,
                                                      fontWeight: totalList
                                                                  .length ==
                                                              index + 1
                                                          ? FontWeight.bold
                                                          : FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                        index + 1 == totalList.length
                                            ? SizedBox()
                                            : Divider()
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text("Payment Method".tr,
                                    style: Common.textFormFieldBold)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      RadioListTile<String>(
                                        title: Text('Cash on Delivery (COD)'),
                                        value: 'COD',
                                        groupValue: selectedPaymentOption,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedPaymentOption = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        title: Text('Paytm'),
                                        value: 'Paytm',
                                        groupValue: selectedPaymentOption,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedPaymentOption = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            // Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 10),
                            //     child: Text("Product".tr,
                            //         style: Common.textFormFieldBold)),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 10),
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(12.0),
                            //     ),
                            //     child: ListView.builder(
                            //         shrinkWrap: true,
                            //         physics: NeverScrollableScrollPhysics(),
                            //         itemCount: cartList.length,
                            //         itemBuilder: (BuildContext ctxt, int index) {
                            //           return Column(
                            //             children: [
                            //               ListTile(
                            //                 dense: true,
                            //                 contentPadding: EdgeInsets.symmetric(
                            //                     horizontal: 12, vertical: 5),
                            //                 leading: Container(
                            //                   constraints: BoxConstraints.tightFor(
                            //                       width: 60.0, height: 60.0),
                            //                   child: cartList[index].getImageUrl() ==
                            //                           ''
                            //                       ? null
                            //                       : Padding(
                            //                           padding:
                            //                               const EdgeInsets.all(0.0),
                            //                           child: Image.network(
                            //                               cartList[index]
                            //                                   .getImageUrl(),
                            //                               fit: BoxFit.cover),
                            //                         ),
                            //                 ),
                            //
                            //                 title: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(cartList[index].getName(),
                            //                         maxLines: 2,
                            //                         softWrap: false,
                            //                         style: TextStyle(
                            //                             fontSize: 16,
                            //                             fontWeight: FontWeight.w500,
                            //                             color: kblack),
                            //                         overflow: TextOverflow.ellipsis),
                            //                     SizedBox(
                            //                       height: 5,
                            //                     ),
                            //
                            //                     Text(
                            //                       "${translate('Qty')}: ${cartList[index].quantity} X ${cartList[index].getPriceText()}",
                            //                       style: TextStyle(
                            //                           fontSize: 14,
                            //                           fontWeight: FontWeight.w500,
                            //                           color: Colors.grey),
                            //                     ),
                            //                     SizedBox(
                            //                       height: 5,
                            //                     ),
                            //                     Text(
                            //                         "${translate("Rs")}." +
                            //                             "${cartList[index].getTotal()}",
                            //                         style: TextStyle(
                            //                             fontSize: 16,
                            //                             color: kblack,
                            //                             fontWeight: FontWeight.w500))
                            //                     // Text(cartObj.products[index].getOptionText(),
                            //                     //     style: TextStyle(color: kColorButtonCart))
                            //                   ],
                            //                 ),
                            //                 // trailing: Text(
                            //                 //   "${cartObj.products[index].total}",
                            //                 //   style: TextStyle(fontWeight: FontWeight.bold),
                            //                 // ),
                            //               ),
                            //               index + 1 == cartList.length
                            //                   ? SizedBox()
                            //                   : Divider()
                            //             ],
                            //           );
                            //         }),
                            //   ),
                            // ),
                            // SizedBox(height: 8),
                            // Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 10),
                            //     child: Text("Bill Details".tr,
                            //         style: Common.textFormFieldBold)),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(12.0),
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(vertical: 8.0),
                            //       child: ListTile(
                            //         // alignment: Alignment.centerLeft,
                            //         visualDensity: VisualDensity.compact,
                            //         dense: true,
                            //         leading: Icon(
                            //           FontAwesomeIcons.ticket,
                            //           size: 30,
                            //         ),
                            //         title: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               "Test20 Coupon Applied".tr,
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Colors.green,
                            //                   fontSize: 18),
                            //             ),
                            //             SizedBox(
                            //               height: 4,
                            //             ),
                            //             Text(
                            //               "₹930 ${translate('Save on this Order')}",
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Colors.grey,
                            //                   fontSize: 16),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 8),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 10),
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(12.0),
                            //     ),
                            //     child: ListView.builder(
                            //       shrinkWrap: true,
                            //       padding: EdgeInsets.all(8),
                            //       physics: NeverScrollableScrollPhysics(),
                            //       itemCount: totalList.length,
                            //       itemBuilder: (context, index) {
                            //         return Column(
                            //           children: [
                            //             Row(
                            //               children: [
                            //                 Container(
                            //                     width: 210,
                            //                     padding: EdgeInsets.symmetric(
                            //                         horizontal: 8, vertical: 4),
                            //                     child: Text(
                            //                       totalList[index]['title'],
                            //                       style: TextStyle(
                            //                           fontSize: 16,
                            //                           color: kgreyDark,
                            //                           fontWeight: FontWeight.w400),
                            //                     )),
                            //                 Spacer(),
                            //                 Container(
                            //                   padding: EdgeInsets.symmetric(
                            //                       horizontal: 8, vertical: 4),
                            //                   child: Text(
                            //                       '${translate("Rs")}.' +
                            //                           totalList[index]['text']
                            //                               .toString(),
                            //                       style: TextStyle(
                            //                           fontSize: 16,
                            //                           fontWeight: FontWeight.bold)),
                            //                 ),
                            //               ],
                            //             ),
                            //             index + 1 == totalList.length
                            //                 ? SizedBox()
                            //                 : Divider()
                            //           ],
                            //         );
                            //       },
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 8),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(12.0),
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(vertical: 8.0),
                            //       child: ListTile(
                            //         // alignment: Alignment.centerLeft,
                            //         visualDensity: VisualDensity.compact,
                            //         dense: true,
                            //         leading: Icon(
                            //           FontAwesomeIcons.truck,
                            //           size: 30,
                            //         ),
                            //         title: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               "Expected delivery".tr,
                            //               style: TextStyle(
                            //                   fontSize: 18,
                            //                   fontWeight: FontWeight.w400),
                            //             ),
                            //             Text(
                            //               "in 4 - 5 business days.".tr,
                            //               style: TextStyle(
                            //                   fontSize: 16, color: Colors.grey),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 8),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CANCELLATION POLICY",
                                        style: TextStyle(
                                            color: kgreyDivider,
                                            letterSpacing: 3),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        '''Please ensure order details are correct. This order, if cancelled is non- refundable'''
                                            .tr,
                                        style: TextStyle(
                                          color: kgreyDivider,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  _fetchCart() async {
    warning = '';
    int intAddressId = 0;
    if (intSelectedAddressIndex >= 0 &&
        addressList.length > intSelectedAddressIndex) {
      intAddressId = addressList[intSelectedAddressIndex].id;
    }
    print(intAddressId);
    final response = await http.get(
        Common.getURL(
            "store_cart?shipping_address_id=${intAddressId.toString()}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString(),
          'shipping_address_id': intAddressId.toString()
          // "content-type": "application/x-www-form-urlencoded",
        });
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();

      print(parsed);
      total = '${resBody["payable"]}';
      totalList = resBody["total"].cast<Map<String, dynamic>>();
      warning = resBody['warning'].toString();
      weight = resBody['weight'] * 1.0;
      couponApplied = resBody['coupon'];
      print(total);
      cartList =
          parsed.map<CartModel>((json) => CartModel.fromJson(json)).toList();

      setState(() {
        Common.cartCount = cartList.length;
        dynamic carttotal = resBody['payable'];
        Common.cartTotal = carttotal.round();
        // Common.cartTotal = resBody['payable'];
        _loading = false;
        show = false;
      });
    } else {
      throw Exception('Failed to load request');
    }
  }

  _fetchAddress() async {
    final response = await http
        .get(Common.getURL("store_addressList"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // "content-type": "application/x-www-form-urlencoded",
      'Cookie': Common.getCookie().toString()
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      print(resBody);
      final parsed = resBody["data"].cast<Map<String, dynamic>>();

      addressList = parsed
          .map<AddressModel>((json) => AddressModel.fromJson(json))
          .toList();

      if (addressList.length == 0) {
        EasyLoading.showToast(
            'No address found. Please enter delivery address.');
        // bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProfileScreen();
        }));
        _fetchAddress();
        return;
      }
      AddressModel? selectedAddress;
      String addressId = await Session.getPaymentAddressId();
      print('~~~' + addressId);
      // checked saved Address ID
      if (addressId.isNotEmpty &&
          addressId != "null" &&
          addressList.length > 0) {
        print('~~~1');
        selectedAddress = addressList.firstWhere(
            (element) => element.id.toString() == addressId,
            orElse: () => addressList[0]);
      }

      // else checked first address
      if (selectedAddress == null || !selectedAddress.getIsInitialized()) {
        print('~~~2');
        if (addressList.length > 0) {
          print('~~~3');
          selectedAddress = addressList[0];
        }
      }

      // if Address Found -> set in Local
      if (selectedAddress != null && selectedAddress.getIsInitialized()) {
        print('~~~4');
        Session.setPaymentAddressModel(selectedAddress);
        intSelectedAddressIndex = addressList
            .indexWhere((element) => element.id == selectedAddress?.id);
      }

      // Not found Index check Again
      if (intSelectedAddressIndex < 0)
        intSelectedAddressIndex = addressList.indexOf(selectedAddress!);

      this.loadPaymentDefault();
      this.refreshCart();
      setState(() {
        // isLoading = false;
      });
    } else {
      refreshCart();
      // throw Exception('Failed to load request');
    }
  }

  void addOrder() async {
    EasyLoading.show(status: translate('Creating order...'));
    final response = await http.post(Common.getURL("store_orderAdd"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'payment_firstname': await Session.getPaymentFirstName(),
          'payment_lastname': await Session.getPaymentLastName(),
          'payment_address_1': await Session.getPaymentAddress1(),
          'payment_address_2': await Session.getPaymentAddress2(),
          'payment_city': await Session.getPaymentCity(),
          'payment_postcode': await Session.getPaymentPostCode(),
          'payment_country': await Session.getPaymentCountry(),
          'payment_zone': await Session.getPaymentZone(),
          'shipping_firstname': await Session.getPaymentFirstName(),
          'shipping_lastname': await Session.getPaymentLastName(),
          'shipping_address_1': await Session.getPaymentAddress1(),
          'shipping_address_2': await Session.getPaymentAddress2(),
          'shipping_city': await Session.getPaymentCity(),
          'shipping_postcode': await Session.getPaymentPostCode(),
          'shipping_country': await Session.getPaymentCountry(),
          'shipping_zone': await Session.getPaymentZone(),
          'comment': 'Order Created',
          'order_total': total,
          'device_type': 'android',
          'payment_method': selectedPaymentOption
        }));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      setState(() {});
      // _fetchCart();
      // TODO: CHECK DELIVERY CHARGES
      // TODO: PAYPAL PAYMENT GATEWAY...
      // Navigator.pop(context);
      // Navigator.pop(context);
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) {
      //       return StoreOrderPage();
      //     },
      //   ),
      // );

      //
      if (selectedPaymentOption == "COD") {
        // Get.back();
        updateOrderpending(
          resBody["order_id"],
        );
        Get.back();
        cartController.fetchCart();
        Get.offAll(ThankYouPage());
      } else {
        this.prepareRequest(
            resBody["order_id"].toString(), resBody["amount"].toString());
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to load request');
    }
  }

  void updateOrderSuccess(orderId) {
    this._updateOrder(orderId, '2');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Payment success...!'.tr)));
  }

  void updateOrderFailure(orderId) {
    this._updateOrder(orderId, '0'); // Missing
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Payment failed...!'.tr)));
  }

  updateOrderpending(orderId) {
    this._updateOrder(orderId, '2'); // Missing
  }

  void _updateOrder(orderId, orderStatusId) async {
    EasyLoading.show(status: translate('Updating order status...!'));
    final response = await http.post(Common.getURL("store_orderUpdate"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'order_id': orderId.toString(),
          'order_status_id': orderStatusId.toString()
        }));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      setState(() {});
      // Only In Success
      if (orderStatusId == '2') {
        // _fetchCart();
        // TODO: CHECK DELIVERY CHARGES
        // TODO: PAYPAL PAYMENT GATEWAY...
        Navigator.pop(context);
        Navigator.pop(context);
        Get.offAll(ThankYouPage());
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to load request');
    }
  }

  // Future<void> initPlatformState(amount) async {
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // EasyLoading.show(status: 'Payable amount to ccavenu' + amount.toString());
  //   try {
  //     await CcAvenue.cCAvenueInit(
  //         transUrl: 'https://test.ccavenue.com/transaction/initTrans', //secure
  //         accessCode: 'AVRO76JC71CL46ORLC',
  //         amount: amount.toString(),
  //         cancelUrl: 'http://manjha.in/merchant/ccavResponseHandler.jsp',
  //         currencyType: 'INR',
  //         merchantId: '879485',
  //         orderId: '519',
  //         redirectUrl: 'http://manjha.in/merchant/ccavResponseHandler.jsp',
  //         rsaKeyUrl: 'https://test.ccavenue.com/transaction/jsp/GetRSA.jsp');
  //   } on PlatformException {
  //     print('PlatformException');
  //   }
  // }

  prepareRequest(orderId, amount) async {
    // store_paytmChecksum
    EasyLoading.show(status: translate('Initiating payment request...'));
    print(Common.getURL(
        "store_paytmChecksum" + "?order_id=$orderId&amount=$amount"));
    final response = await http.get(
        Common.getURL(
            "store_paytmChecksum" + "?order_id=$orderId&amount=$amount"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "content-type": "application/x-www-form-urlencoded",
          'Cookie': Common.getCookie().toString()
        });
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      print(resBody);
      print(resBody["body"]);
      if (resBody["body"]["txnToken"] != null &&
          resBody["body"]["txnToken"].toString().isNotEmpty) {
        initPaymentPayment(orderId, resBody["body"]["txnToken"], amount);
      }

      return true;
    } else {
      EasyLoading.showToast('Failed to load request. Please try again.');
    }
    return false;
  }

  // String mid = "EJpcwX73628126041744",
  //     orderId = "Order_1002",
  //     txnToken = "64e34583b58f449498b7ce8b1bed3e5e1651072181454";
  String result = "";
  bool isStaging = false;
  // bool isStaging = true;
  bool isApiCallInprogress = false;
  bool restrictAppInvoke = false;
  initPaymentPayment(orderId, txnToken, amount) {
    String callbackUrl =
        "https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId&mid=${Common.PAYTM_MID}";
    // String callbackUrl = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId&mid=${Common.PAYTM_MID}";
    print(callbackUrl);
    var response = AllInOneSdk.startTransaction(Common.PAYTM_MID, orderId,
        amount.toString(), txnToken, callbackUrl, isStaging, restrictAppInvoke);
    response.then((value) {
      print(value);
      setState(() {
        result = value.toString();
        print('then...');
        print(result);
        EasyLoading.showToast(result);

        // {CURRENCY: INR, GATEWAYNAME: WALLET, RESPMSG: Txn Success, BANKNAME: WALLET, PAYMENTMODE: PPI, MID: EJpcwX73628126041744, RESPCODE: 01, TXNAMOUNT: 1.00, TXNID: 20220429111212800110168345642437522, ORDERID: 24, BANKTXNID: 185929690176, STATUS: TXN_SUCCESS, TXNDATE: 2022-04-29 20:43:14.0, CHECKSUMHASH: ivr6ceGxC7an7xdt2QpYyXUkcCLoVATkjH62ntHE8/vQmvbnIZxH4eBO8ofOS4NjQe+aqf478ewq8ErMCzaXkfuMojOsGfm+ODLY8SaFcTM=}
        if (result.isEmpty) updateOrderSuccess(orderId);
      });
    }).whenComplete(() {
      print('complete...');
      // updateOrderSuccess(orderId);
    }).catchError((onError) {
      print('error...');
      print(onError);
      updateOrderFailure(orderId);
      if (onError is PlatformException) {
        setState(() {
          result = onError.message! + " \n  " + onError.details.toString();
        });
      } else {
        setState(() {
          result = onError.toString();
        });
      }
      print(result);
    });
  }

  // void _showAddressDialog(context, List<AddressModel> addressList) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     // barrierLabel: "Address",
  //     // barrierDismissible: false,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     // transitionDuration: Duration(milliseconds: 300),
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return StatefulBuilder(builder: (context, setState) {
  //         return AlertDialog(
  //           contentPadding: EdgeInsets.all(0.0),
  //           title: Row(children: [
  //             BoldText(Lang.get("Select Address"), 18.0, kgreyDark),
  //             Expanded(child: SizedBox()),
  //             IconButton(
  //                 icon: Icon(Icons.close),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 })
  //           ]),
  //           titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 8),
  //           content: Container(
  //               // height: 300,
  //               width: 300.0,
  //               child: ListView.builder(
  //                   padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
  //                   shrinkWrap: true,
  //                   itemCount: addressList.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return ListTile(
  //                       onTap: () async {
  //                         Session.setPaymentAddressModel(addressList[index]);
  //                         loadPaymentDefault();
  //
  //                         intSelectedAddressIndex = index;
  //                         refreshCart();
  //                         Navigator.of(context).pop();
  //                       },
  //                       // dense: true,
  //                       // contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
  //                       title: NormalText(addressList[index].getName(), kblack, 14.0),
  //                       subtitle: Text(addressList[index].getAddress()),
  //                       trailing: index == intSelectedAddressIndex
  //                           ? Icon(Icons.radio_button_checked)
  //                           : Icon(Icons.radio_button_off),
  //                     );
  //                   })),
  //           // actionsPadding: EdgeInsets.all(0.0),
  //           actions: <Widget>[
  //             // usually buttons at the bottom of the dialog
  //             // new FlatButton(
  //             //   child: NormalText(Lang.get("Cancel"), kheader, 16.0),
  //             //   padding: EdgeInsets.only(right: 16, left: 16.0),
  //             //   onPressed: () {
  //             //     Navigator.of(context).pop();
  //             //   },
  //             // ),
  //             MaterialButton(
  //               child: BoldText(Lang.get("Manage"), 16.0, kheader),
  //               padding: EdgeInsets.only(right: 16, left: 16.0),
  //               onPressed: () async {
  //                 // setState(() {
  //                 await Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => StoreAddressPage()),
  //                 );
  //                 Navigator.of(context).pop();
  //                 _fetchAddress();
  //               },
  //             ),
  //
  //             MaterialButton(
  //               child: BoldText(Lang.get("Add New"), 16.0, kheader),
  //               padding: EdgeInsets.only(right: 16, left: 16.0),
  //               onPressed: () async {
  //                 // setState(() {
  //                 await Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => StoreAddressAddPage()),
  //                 );
  //                 Navigator.of(context).pop();
  //                 _fetchAddress();
  //               },
  //             ),
  //           ],
  //         );
  //       });
  //     },
  //   );
  // }

  showcheckoutbottomsheet(context, List<AddressModel> addressList) {
    return showModalBottomSheet(
      backgroundColor: cartbackgroundcolor,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  BoldText(Lang.get("Select an address"), 25.0, kgreyDark),
                  Expanded(child: SizedBox()),
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ]),
                SizedBox(
                  height: 15,
                ),
                Card(
                    elevation: 0,
                    // decoration: BoxDecoration(
                    //     color: kwhite, borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () async {
                        await Get.to(StoreAddressPage());
                        Get.back();
                        _fetchAddress();
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      title: BoldText(Lang.get("Manage"), 23.0, kheader),
                      leading: Icon(Icons.add, size: 25, color: kheader),
                    )
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(children: [
                    //
                    //
                    //   ]),
                    // ),
                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextCustom(
                    "SAVED ADDRESSES",
                    kgreyDark,
                    20,
                    fonntweight: FontWeight.w600,
                  ),
                ),
                Card(
                    elevation: 0,
                    //   width: 300.0,
                    child: Container(
                      height: addressList.length > 3
                          ? 250
                          : addressList.length == 1
                              ? 100
                              : 170,
                      child: Scrollbar(
                        thumbVisibility: true,
                        thickness: 5,
                        child: ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              // shrinkWrap: true,
                              itemCount: addressList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  onTap: () async {
                                    Session.setPaymentAddressModel(
                                        addressList[index]);
                                    loadPaymentDefault();

                                    intSelectedAddressIndex = index;
                                    refreshCart();
                                    Navigator.of(context).pop();
                                  },
                                  // dense: true,
                                  // contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  title: TextCustom(
                                      addressList[index].getName(),
                                      kblack,
                                      16.0,
                                      fonntweight: FontWeight.w600),
                                  subtitle:
                                      Text(addressList[index].getAddress()),
                                  trailing: index == intSelectedAddressIndex
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )
                                      : SizedBox(),
                                );
                              }),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void myCartDetails() async {
    // await Common.analytics.setCurrentScreen(screenName: 'CartScreen');
    // cartObj = await Services.cartList(Session.getCustomerId());
    await _fetchCart();
    setState(() {
      _loading = false;
    });
  }

  void _fetchCartUpdate(cartId, qty) async {
    cartUpdate();

    // EasyLoading.show(status: '${translate('Updating from cart')}');
    final response = await http.post(Common.getURL("store_cartUpdate"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'cart_id': cartId.toString(),
          'quantity': qty.toString(),
        }));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      setState(() {});
      _fetchCart();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
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
      if (resBody["success"]) _fetchCart();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }

  void postcodeUpdate() async {
    // EasyLoading.show(status: translate('Checking postcode...'));
    final response = await http.post(Common.getURL("store_postcodeCheck"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body:
            jsonEncode(<String, String>{'postcode': _pincodeController.text}));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      setState(() {
        postcodeApplied = true;
        postcodeDeliverable = resBody["success"];
        // if (postcodeDeliverable == null) {
        //   postcodeDeliverable = false;
        // }
        postcodeMessage = resBody["message"].toString();
      });

      // _fetchCart();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }

  getQuantityContainer(CartModel cartItem) {
    return Container(
        // width: 200,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
          _decrementButton(cartItem),
          Text(
            ' ${cartItem.quantity} ',
            style: TextStyle(fontSize: 16.0),
          ),
          _incrementButton(cartItem),
        ]));
  }

  Widget _incrementButton(CartModel cartItem) {
    // return FloatingActionButton(
    //   child: Icon(Icons.add, color: Colors.black87),
    //   // backgroundColor: Colors.green[100],
    //   backgroundColor: Colors.grey[200],
    //   mini: true,
    //   elevation: 1,
    //   onPressed: () {

    //     setState(() {
    // item.quantity += 5;
    //       // item.quantity++;
    //     });
    //   },
    // );
    return MaterialButton(
      color: Colors.white, //Color(0xFF525c5e),
      height: 30,
      visualDensity: VisualDensity.compact,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: kColorButtonCart)),
      onPressed: () async {
        // setState(() {
        //   cartItem.quantity += cartItem.getQtyLot();
        //   // item.quantity++;
        // });

        _quantityController.text = cartItem.quantity.toString();
        bool result = await showQuanityBox(context, false);
        if (result == '' ||
            result == false ||
            _quantityController.text.isEmpty) {
          _quantityController.text = '';
          print('Quantity dialog cancelled...');

          return;
        } else {
          setState(() {
            cartItem.quantity = int.parse(_quantityController.text);
            _quantityController.text = '';
          });
        }
        MixpanelController.logScreen(MixpanelController.PageProductDetail,
            properties: {
              "Item Added to Cart": "${cartItem.productName}",
              "Quantity": cartItem.quantity.toString()
            });
        _fetchCartUpdate(cartItem.id, cartItem.quantity);
      },
      minWidth: 40,
      child: Icon(Icons.add, size: 14, color: kColorButtonCart),
    );
  }

  Widget _decrementButton(CartModel cartItem) {
    // return FloatingActionButton(
    //     mini: true,
    //     onPressed: () {
    //       setState(() {
    //         if (item.quantity <= 1) {
    //           // listSelected.remove(item);
    //           setState(() {});
    //         } else if (item.quantity <= 1) {
    //           // REMOVE
    //         }
    //         if (item.quantity <= 5) {
    //           // REMOVE
    //           item.quantity = 1;
    //         } else {
    //           item.quantity -= 5;
    //         }
    //       });
    //     },
    //     child: Icon(Icons.remove, color: Colors.black87),
    //     elevation: 1,
    //     // backgroundColor: Colors.red[100]
    //     backgroundColor: Colors.grey[200],
    //     );
    return MaterialButton(
      color: Colors.white, //Color(0xFF525c5e),
      height: 30,
      visualDensity: VisualDensity.compact,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: kColorButtonCart)),
      onPressed: () async {
        // setState(() {
        //   if (cartItem.quantity <= cartItem.getQtyLot()) {
        //     //1
        //     // REMOVE
        //     print('remove' + cartItem.quantity.toString());
        //     cartItem.quantity = 0;
        //     print('remove' + cartItem.quantity.toString());
        //   } else if (cartItem.quantity <= cartItem.getQtyLot()) {
        //     // REMOVE
        //     cartItem.quantity = 1;
        //   } else {
        //     cartItem.quantity -= cartItem.getQtyLot();
        //   }
        //   _fetchCartUpdate(cartItem.id, cartItem.quantity);
        // });
        _quantityController.text = cartItem.quantity.toString();
        bool result = await showQuanityBox(context, false);
        if (result == '' ||
            result == false ||
            _quantityController.text.isEmpty) {
          _quantityController.text = '';
          print('Quantity dialog cancelled...');

          return;
        } else {
          setState(() {
            cartItem.quantity = int.parse(_quantityController.text);
            _quantityController.text = '';
          });
        }
        if (_quantityController.text.isEmpty)
          cartController.cartListcheckout.clear();
        MixpanelController.logScreen(MixpanelController.PageProductDetail,
            properties: {
              "Item Remove to Cart": "${cartItem.productName}",
              "Quantity": cartItem.quantity.toString()
            });
        _fetchCartUpdate(cartItem.id, cartItem.quantity);
      },
      minWidth: 40,
      child: Icon(Icons.remove, size: 14, color: kColorButtonCart),
    );
  }

  Widget getQtyBox(CartModel cartItem) {
    List<num> qtyList;
    if (cartItem.getQtyLot() == 5) {
      qtyList = range(0, 201, 5).toList();
    } else {
      qtyList = range(0, 21).toList();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonHideUnderline(
        child: new DropdownButton<int>(
          isDense: true,
          value: cartItem.quantity,
          items: qtyList.toList().map((dynamic value) {
            return new DropdownMenuItem<int>(
              value: value,
              child: new Text(value.toString()),
            );
          }).toList(),
          onChanged: (int? value) async {
            // EasyLoading.show();
            // product.flag = true;
            cartItem.quantity = value!;
            _fetchCartUpdate(cartItem.id, cartItem.quantity);
            EasyLoading.dismiss();
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget getOptionText(List<dynamic> option) {
    return Text(option.map((e) => e['value']).join(','),
        style: TextStyle(color: kColorButtonCart));
  }

  TextEditingController _couponController = new TextEditingController();
  showCouponDialog() async {
    await showDialog<String>(
      context: this.context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text("Coupon Code".tr),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.clear))
          ],
        ),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                controller: _couponController,
                keyboardType: TextInputType.name,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // labelText: 'Enter coupon',
                  hintText: '${translate("Enter coupon code here...!")}',
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => themecolor.withOpacity(0.5))),
              child:
                  Text('Apply'.tr, style: TextStyle(color: kColorButtonCart)),
              onPressed: () {
                if (_couponController.text.length < 3) {
                  EasyLoading.showToast("Please enter min 3 character.");
                  return;
                }
                print(_couponController.text);
                Navigator.pop(this.context);
                couponUpdate();
                // CategoryModel category = new CategoryModel(
                //     name: _searchController.text, isSearch: true);
                // Common.pushPage(context, CategoryPage(category));

                // EasyLoading.showToast("Thank you, your otp has been submitted.");
              })
        ],
      ),
    );
  }

  TextEditingController _pincodeController = new TextEditingController();

  TextEditingController _quantityController = new TextEditingController();
  showQuanityBox(BuildContext context, bool addNew) async {
    // Session.shippingPopupSeenNow();
    // if (await Session.isShippingPopupSeen() && !bypass) {
    //   return false;
    // }

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: EdgeInsets.all(25),
          // backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          // title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
            trailing: IconButton(
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: NormalForm(
                  FontAwesomeIcons.cartPlus,
                  Lang.get("Quantity"),
                  controller: _quantityController,
                  textInputType: TextInputType.number,
                ),
              )
            ],
          ),
          actions: <Widget>[
            if (!addNew)
              TextButton.icon(
                  icon: Icon(Icons.delete_outline, color: kdeletecolor),
                  label: BoldText('${translate('Remove')}', 14, kdeletecolor),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => kbuttoncolorred)),
                  onPressed: () {
                    _quantityController.text = "0";
                    Navigator.of(context).pop(true);
                  }),
            // SizedBox(width: 50),
            // FlatButton(
            //     child: BoldText('Cancel', 14, kColorButtonCart),
            //     onPressed: () {
            //       Navigator.of(context).pop(false);
            //     }),
            TextButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => themecolor.withOpacity(0.5))),
              icon: Icon(Icons.add_shopping_cart, color: kColorButtonCart),
              label: BoldText(
                  (Lang.get(addNew
                      ? "${translate('Add')}"
                      : "${translate('Update')}")),
                  14,
                  kColorButtonCart),
              onPressed: () {
                if (_quantityController.text.isEmpty) {
                  EasyLoading.showToast("Please enter quantity.");
                  return;
                }
                if (int.tryParse(_quantityController.text) != null &&
                    (int.tryParse(_quantityController.text)! <= 0 ||
                        int.tryParse(_quantityController.text)! > 10000)) {
                  EasyLoading.showToast("Please enter proper quantity.");
                  return;
                }
                // Close the dialog
                Navigator.of(context).pop(true);
                // Session.shippingPopupSeenNow();
              },
            ),
          ],
        );
      },
    );
  }
}
