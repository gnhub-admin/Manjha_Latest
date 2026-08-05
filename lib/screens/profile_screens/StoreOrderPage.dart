import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../model/OrderModel.dart';
import '../const.dart';
import '../localconst.dart';
import '../mainscreen.dart';
import 'orderdetails.dart';

class StoreOrderPage extends StatefulWidget {
  StoreOrderPage();

  @override
  _StoreOrderPageState createState() => _StoreOrderPageState();
}

class _StoreOrderPageState extends State<StoreOrderPage> {
  bool loading = true;
  List<OrderModel> orderList = [];

  _fetchOrderList() async {
    // EasyLoading.show();
    loading = true;
    final response = await http
        .get(Common.getURL("store_orderList"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': Common.getCookie().toString()
      // "content-type": "application/x-www-form-urlencoded",
    });
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      if (resBody["success"] == false) {
        logoutfuntion();
      } else {
        final parsed = resBody["data"].cast<Map<String, dynamic>>();
        print(parsed);

        orderList = parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      }
      if (mounted)
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
    super.initState();
    _fetchOrderList();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cartbackgroundcolor,
      appBar: AppBar(
        backgroundColor: cartbackgroundcolor,
        elevation: 0,
        title: Text(
          "My Orders",
          style: TextStyle(color: kblack),
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     height: 40,
        //     width: 40,
        //     decoration: BoxDecoration(
        //         color: kColorAppDefault,
        //         border: Border.all(color: Colors.transparent),
        //         borderRadius: BorderRadius.all(Radius.circular(200))),
        //     child: InkWell(
        //       onTap: () {
        //         Navigator.of(context).pop();
        //       },
        //       child: Icon(
        //         Icons.chevron_left_sharp,
        //         color: Colors.white,
        //         size: 35,
        //       ),
        //     ),
        //   ),
        // ),
        automaticallyImplyLeading: true,
        actions: [],
      ),
      body:
          // _loading == true
          //     ? Center(
          //         child: CircularProgressIndicator(
          //         strokeWidth: 2,
          //       ))
          //     : orderList.length == 0
          //         ? Common.containerNoDataFound('No order found.')
          //         :
          // ListView.builder(
          //             itemCount: orderList.length,
          //             itemBuilder: (context, int i) {
          //               return Card(
          //                 child: ListTile(
          //                   // leading: Image.network(orderList[i].thumb),
          //                   leading: Container(
          //                     // width: 50,
          //                     padding: EdgeInsets.only(top: 12, left: 8),
          //                     child: Column(
          //                       children: [
          //                         Text(
          //                           new DateFormat("dd")
          //                               .format(orderList[i].createdAt),
          //                           style: TextStyle(
          //                               fontSize: 18, fontWeight: FontWeight.bold),
          //                         ),
          //                         Text(
          //                             new DateFormat("MMM yy")
          //                                 .format(orderList[i].createdAt),
          //                             style: TextStyle(fontSize: 13)),
          //                       ],
          //                     ),
          //                   ),
          //                   title: Text("Order# " +
          //                       orderList[i].id.toString() +
          //                       " - " +
          //                       // orderList[i].products.toString() +
          //                       "1 item"),
          //                   subtitle: Text("Rs.${orderList[i].total}/-"),
          //                   trailing: Text(
          //                     orderList[i].orderStatus,
          //                     style: TextStyle(fontWeight: FontWeight.bold),
          //                   ),
          //                   onTap: () {
          //                     // Navigator.pushReplacement(
          //                     //   context,
          //                     //   MaterialPageRoute(
          //                     //       builder: (context) =>
          //                     //           StoreOrderDetailPage(this.orderList[i].id)),
          //                     // );
          //                   },
          //                   // IconButton(icon: Icon(Icons.delete_forever), onPressed: null),
          //                 ),
          //               );
          //             }),
          loading == true
              ? Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 2,
                ))
              : orderList.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "No Orders Yet...",
                            style: TextStyle(
                                color: themecolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.offAll(
                                      () => MainScreens(initialIndex: 0));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    backgroundColor:
                                        MaterialStatePropertyAll(themecolor),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                child: Text("Continue Shopping")),
                          ),
                        ],
                      ),
                    )
                  : ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          itemCount: orderList.length,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemBuilder: (context, int i) {
                            OrderModel orders = orderList[i];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(bottom: 15),
                              child: ListTile(
                                onTap: () {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           StoreOrderDetailPage(id:this.orderList[i].id,)),
                                  // );
                                  Get.off(OrderDetail(
                                    id: orderList[i].id,
                                  ));
                                },
                                // leading: Image.network(orderList[i].thumb),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // leading: IntrinsicHeight(
                                //   child: Container(
                                //     padding: EdgeInsets.all(5),
                                //     margin: EdgeInsets.all(0),
                                //     decoration: BoxDecoration(
                                //       // color: AppTheme.deliverColor,
                                //       color: kheader,
                                //       borderRadius: BorderRadius.circular(5),
                                //     ),
                                //     child: Column(
                                //       children: [
                                //         Text(
                                //           "Order",
                                //           style: TextStyle(
                                //               color: kwhite, fontWeight: FontWeight.bold),
                                //         ),
                                //         Text(
                                //           "#${orders.invoiceNo}",
                                //           style: TextStyle(
                                //               color: kwhite, fontWeight: FontWeight.bold),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "#${orders.invoiceNo}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: kblack),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Rs.${orders.total}/-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: themecolor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: orders.orderStatusId == 4
                                                  ? Colors.green
                                                  : orders.orderStatusId == 2
                                                      ? Colors.blue
                                                      : orders.orderStatusId ==
                                                              1
                                                          ? Colors.black
                                                          : Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          child: Text(
                                            "${orders.orderStatus}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: kwhite,
                                                fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          DateFormat('dd MMM yy')
                                              .format(orders.createdAt),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // IconButton(icon: Icon(Icons.delete_forever), onPressed: null),
                              ),
                            );
                          }),
                    ),
    );
  }
}
