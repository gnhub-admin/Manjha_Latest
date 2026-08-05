import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quiver/iterables.dart';
import '../../getxcontrollers/cartcontroller.dart';
import '../../getxcontrollers/mixpanelcontroller.dart';
import '../../languagetranslation/apptranslation.dart';
import '../../model/cart_model.dart';
import '../../widget/textfieldscreen.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../localconst.dart';

class itemcart extends StatefulWidget {
  @override
  _itemcartState createState() => _itemcartState();
}

class _itemcartState extends State<itemcart> {
  List<CartModel> cartList = [];
  bool couponApplied = false;
  bool postcodeApplied = false;
  bool postcodeDeliverable = true;
  String postcodeMessage = "Pincode is undeliverable.";
  bool cartChanged = false;
  cartUpdate() {
    cartChanged = true;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loading = true;
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
  String total = "0";
  String warning = "";
  double weight = 0.0;
  isWarning() {
    return warning.isNotEmpty;
  }

  getTotal() {
    if (total.isNotEmpty) {
      return "${translate("Rs")}." + total + "/-";
    }
    return "${translate("Rs")}.0/-";
  }
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    // cartList = new ProductModel();
    myCartDetails();
    // Get.off(StoreCheckoutPage());
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

    EasyLoading.show(status: '${translate('Updating from cart')}');
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

  Future<void> deleteCartItem(int cartId) async {
    cartUpdate();

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
      // _fetchCart();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }

  Future<void> clearCart() async {
    EasyLoading.show(status: translate('Clearing cart'));
    try {
      for (var item in cartList) {
        await deleteCartItem(item.id!);
      }
      EasyLoading.dismiss();
      setState(() {
        cartList.clear();
      });
      EasyLoading.showToast(translate('Cart cleared successfully'));
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showToast(translate('Failed to clear cart: $e'));
      print('Failed to clear cart: $e');
    }
  }

  void couponUpdate() async {
    EasyLoading.show(status: translate('Checking coupon...'));
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
    EasyLoading.show(status: translate('Checking postcode...'));
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

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? Center(
        child:
        CircularProgressIndicator(color: kheader, strokeWidth: 2))
        : cartList.length <= 0
        ? Center(
      child: Column(
        children: [
          Text("Cart Is Empty")
        ],
      ),
    )//Center(child: Icon(Icons.hourglass_empty_rounded))
        : ScrollConfiguration(
          behavior:
          ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              // padding: const EdgeInsets.all(8.0),
              children: [
                Column(
                  children: [
                    Visibility(
                      visible: isWarning(),
                      child: Container(
                        // color: Colors.red,
                          margin: EdgeInsets.only(bottom: 15),
                          width: double.infinity,
                          child: Card(
                              color: Colors.red[200],
                              child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: BoldText(
                                      warning, 16.0, kblack)))),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartList.length <= 0
                            ? 0
                            : cartList.length,
                        itemBuilder:
                            (BuildContext ctxt, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0,
                                right: 5,
                                bottom: 15),
                            child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      12.0),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      constraints:
                                      BoxConstraints
                                          .tightFor(
                                          width: 80.0,
                                          height: 90.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.only(
                                            topLeft: Radius
                                                .circular(
                                                12),
                                            bottomLeft: Radius
                                                .circular(
                                                12)),
                                        // color: kheader.withOpacity(0.1),
                                        color:
                                        Colors.transparent,
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .all(8.0),
                                        child: Image.network(
                                            cartList[index]
                                                .getImageUrl(),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .all(8.0),
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
                                                  child:
                                                  Container(
                                                    child: Text(
                                                      cartList[
                                                      index]
                                                          .getName(),
                                                      maxLines:
                                                      2,
                                                      style: TextStyle(
                                                          fontSize:
                                                          14,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                      softWrap:
                                                      false,
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
                                                  vertical:
                                                  0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    // flex: 4,
                                                    child:
                                                    Container(
                                                      child:
                                                      Text(
                                                        "Code: ${cartList[index].productCode ?? ""}",
                                                        maxLines:
                                                        2,
                                                        style: TextStyle(
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: Colors.grey),
                                                        softWrap:
                                                        false,
                                                        overflow:
                                                        TextOverflow.ellipsis,
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
                                                            cartList[index]),
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
                                                  "${translate("Rs")}." + cartList[index].price.toString() ==
                                                      ''
                                                      ? "N.A."
                                                      : cartList[
                                                  index]
                                                      .price
                                                      .toString(),
                                                  style:
                                                  TextStyle(
                                                    fontSize:
                                                    12,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    color: Colors
                                                        .grey,
                                                    decoration: cartList[index].price.toString() !=
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
                                                  "${translate("Rs")}." + cartList[index].specialPrice.toString() ==
                                                      ''
                                                      ? "N.A."
                                                      : cartList[
                                                  index]
                                                      .specialPrice
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                      14,
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
                                )),
                          );
                        }),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: couponApplied
                          ? ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12.0),
                        ),
                        onTap: () {
                          _showCouponDialog();
                        },
                        leading: Icon(FontAwesomeIcons.ticket),
                        title: Text(
                          "'${_couponController.text.toUpperCase()}' ${translate("coupon applied!")}",
                          style: TextStyle(color: kColorPrice),
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
                          _showCouponDialog();
                        },
                        leading: Icon(
                          FontAwesomeIcons.ticket,
                        ),
                        title: Text(
                          "Apply coupon code...!".tr,
                          style: TextStyle(color: kColorLabel),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.grey),
                          onPressed: () {
                            _showCouponDialog();
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
                  ],
                ),
              ],
            ),
          ),
        );
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
        if(_quantityController.text.isEmpty)
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

  List<dynamic> totalList = [];
  _fetchCart() async {
    // EasyLoading.show();
    warning = '';
    final response =
        await http.get(Common.getURL("store_cart"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': Common.getCookie().toString()
      // "content-type": "application/x-www-form-urlencoded",
    });
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();

      print(parsed);
      total = resBody["payable"].toString();
      print(resBody["payable"]);
      _couponController.text = resBody["coupon"].toString();
      warning = resBody['warning'].toString();
      weight = resBody['weight'] * 1.0;

      cartList =
          parsed.map<CartModel>((json) => CartModel.fromJson(json)).toList();

      setState(() {
        Common.cartCount = cartList.length;
        dynamic carttotal = resBody['payable'];
        Common.cartTotal = carttotal.round();
        // Common.cartTotal = resBody['payable'];
        totalList = resBody["total"];
        _loading = false;
        if (_couponController.text.length > 0) {
          couponApplied = true;
        } else {
          couponApplied = false;
        }
      });
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }

  TextEditingController _couponController = new TextEditingController();
  _showCouponDialog() async {
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
  // _showPincodeDialog() async {
  //   await showDialog<String>(
  //     context: this.context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //       ),
  //       contentPadding: const EdgeInsets.all(16.0),
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           new Text("Pincode".tr),
  //           IconButton(
  //               onPressed: () {
  //                 Get.back();
  //               },
  //               icon: Icon(Icons.clear))
  //         ],
  //       ),
  //       content: new Row(
  //         children: <Widget>[
  //           new Expanded(
  //             child: new TextField(
  //               autofocus: true,
  //               controller: _pincodeController,
  //               keyboardType: TextInputType.number,
  //               maxLength: 6,
  //               decoration: new InputDecoration(
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
  //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //                 // labelText: 'Enter coupon',
  //                 hintText: '${translate("Enter pincode here...!")}',
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: <Widget>[
  //         // MaterialButton(
  //         //     color: themecolor,
  //         //     child: Text('Cancel'.tr, style: TextStyle(color: kwhite)),
  //         //     onPressed: () {
  //         //       Navigator.pop(this.context);
  //         //     }),
  //         TextButton(
  //             style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.resolveWith((states) => themecolor.withOpacity(0.5))),
  //             child: Text('Check'.tr, style: TextStyle(color: kColorButtonCart)),
  //             onPressed: () {
  //               if (_pincodeController.text.length < 3) {
  //                 EasyLoading.showToast("Please enter min 3 character.");
  //                 return;
  //               }
  //               print(_pincodeController.text);
  //               postcodeUpdate();
  //               Navigator.pop(this.context);
  //               // CategoryModel category = new CategoryModel(
  //               //     name: _searchController.text, isSearch: true);
  //               // Common.pushPage(context, CategoryPage(category));
  //
  //               // EasyLoading.showToast("Thank you, your otp has been submitted.");
  //             })
  //       ],
  //     ),
  //   );
  // }

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
            borderRadius: BorderRadius.circular(12.0),
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

