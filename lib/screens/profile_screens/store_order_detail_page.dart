import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../model/orderitemmodel.dart';
import '../const.dart';
import '../localconst.dart';

class StoreOrderDetailPage extends StatefulWidget {
  final int id;
  const StoreOrderDetailPage({required this.id, super.key});

  @override
  State<StoreOrderDetailPage> createState() => _StoreOrderDetailPageState();
}

class _StoreOrderDetailPageState extends State<StoreOrderDetailPage> {
  bool loading = true;
  OrderItemModel? orderItem;

  fetchOrderList() async {
    // EasyLoading.show();
    final response = await http.get(
        Common.getURL("store_orderDetail/${widget.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        });
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      if (resBody["success"] == false) logoutfuntion();

      orderItem = OrderItemModel.fromJson(resBody["data"]);

      setState(() {
        loading = false;
      });
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: kheader,
        elevation: 0,
        title: Text(
          "Order Detail",
          style: TextStyle(color: kwhite),
        ),
        automaticallyImplyLeading: true,
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  elevation: 2,
                  color: kwhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kwhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: kheader,
                                size: 35,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  child: Text(
                                "${orderItem?.customerName}",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: kheader,
                                size: 35,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  child: Text(
                                "${orderItem?.shippingAddress1}",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w500),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.credit_card_rounded,
                                color: kheader,
                                size: 32,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${orderItem?.paymentMethod}",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${orderItem?.shippingMethod}",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                color: kheader,
                                size: 30,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${orderItem?.orderStatus}",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      DateFormat('dd MMM yyyy').format(
                                          orderItem?.createdAt ??
                                              DateTime.now()),
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderItem?.products.length,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, index) {
                      Product? product = orderItem?.products[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          minVerticalPadding: 10,
                          // leading: Image.network(orderList[i].thumb),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "${product?.name}",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff4D4D4D)),
                                    ),
                                  ),
                                  Text(
                                    "Model:${product?.model}(Rs.${product?.price}/- x ${product?.quantity})",
                                    textScaleFactor: 0.9,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff959595)),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    "Rs.${product?.total}/-",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kheader),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // subtitle:
                          // trailing: Text(
                          //   "Rs.282675.0/-",
                          //   style: TextStyle(fontWeight: FontWeight.bold,color: kheader),
                          // ),
                          onTap: () {},
                          // IconButton(icon: Icon(Icons.delete_forever), onPressed: null),
                        ),
                      );
                    }),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    minVerticalPadding: 10,
                    // leading: Image.network(orderList[i].thumb),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                          orderItem?.totals.length ?? 0,
                          (index) => Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "${orderItem?.totals[index].title}",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff4D4D4D)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Text(
                                        "Rs.${orderItem?.totals[index].value}/-",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kheader),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                    ),
                    // subtitle:
                    // trailing: Text(
                    //   "Rs.282675.0/-",
                    //   style: TextStyle(fontWeight: FontWeight.bold,color: kheader),
                    // ),
                    onTap: () {},
                    // IconButton(icon: Icon(Icons.delete_forever), onPressed: null),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "History",
                    textScaleFactor: 1.4,
                    style: TextStyle(
                        color: Color(0xff4D4D4D), fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: List.generate(
                    orderItem?.history.length ?? 0,
                    (index) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ListTile(
                        minVerticalPadding: 10,
                        // leading: Image.network(orderList[i].thumb),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "${orderItem?.history[index].orderStatus}",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4D4D4D)),
                                  ),
                                ),
                                Text(
                                  "${orderItem?.history[index].comment}",
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff959595)),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Text(
                                  DateFormat('dd MMM yyyy').format(
                                      orderItem?.history[index].createdAt ??
                                          DateTime.now()),
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff4D4D4D)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // subtitle:
                        // trailing: Text(
                        //   "Rs.282675.0/-",
                        //   style: TextStyle(fontWeight: FontWeight.bold,color: kheader),
                        // ),
                        onTap: () {},
                        // IconButton(icon: Icon(Icons.delete_forever), onPressed: null),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


