import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manjha/screens/helper.dart';
import 'package:manjha/screens/profile_screens/profile.dart';
import 'package:manjha/services/apiconst.dart';
import 'dart:math';
import '../../shared_pref/shared_pref.dart';
import '../../widget/common.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../homescreeen/sellfishscreen.dart';
import '../localconst.dart';
import '../premium_seller_section/premium_seller_main.dart';

class MyListingPage extends StatefulWidget {
  @override
  _MyListingPageState createState() => _MyListingPageState();
}

class _MyListingPageState extends State<MyListingPage> {
  CustomLocation? location;
  @override
  void initState() {
    super.initState();
    if (SharedPref.get(prefKey: PrefKey.location) != null) {
      Map<String, dynamic> item =
          jsonDecode(SharedPref.get(prefKey: PrefKey.location) ?? '');
      location = CustomLocation.fromJson(item);
    }

    this.myListing();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < [10, listFish.length].reduce(min); i++) {
      widgets.add(searchresult(listFish[i]));
    }
    if (listFish.length == 0) {
      widgets.add(Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: NormalText("No listing found", kblack, 16.0),
            ),
          )));
    }

    widgets.insert(0, getNote());

    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          backgroundColor: kwhite,
          title: BoldText(
              Lang.get("My Listing" +
                  (listFish.length > 0
                      ? (" (" + listFish.length.toString() + ")")
                      : "")),
              25,
              kblack),
          centerTitle: false,
          elevation: 0.0,
          actions: [],
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: RaisedButton(
        //     child: new Text("Fetch Data"),
        //     onPressed: _fetchData,
        //   ),
        // ),
        // floatingActionButton: index == 0
        //     ? FloatingActionButton(
        //         onPressed: () {},
        //         child: Icon(Icons.add),
        //         backgroundColor: themecolor)
        //     : SizedBox(),
        body: SingleChildScrollView(
          child: Column(children: [
            getNote(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 40,
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: index == 0 ? themecolor : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          "Basic",
                          style: TextStyle(
                              color: index == 0 ? kwhite : kblack,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ))),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: index == 1 ? themecolor : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          "Pro",
                          style: TextStyle(
                              color: index == 1 ? kwhite : kblack,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ))),
                  )),
                ],
              ),
            ),
            index == 0
                ? isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: kheader),
                      )
                    : Column(
                        children: [
                          Container(
                            height: 265,
                            width: screenwidth(context, dividedby: 1),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listFish.length + 1,
                              itemBuilder: (context, index) {
                                return Container(
                                    width: screenwidth(context, dividedby: 1.5),
                                    child: index == listFish.length
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                8,
                                                8,
                                                8,
                                                0), //const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 200,
                                                child: Card(
                                                  elevation: 6,
                                                  // color: kitembg,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                              SellFishScreen())
                                                          ?.then((value) =>
                                                              myListing());
                                                    },
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              size: 50,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              // "${translate('Pay Amount')} ${getTotal()}",
                                                              " Add Seed Listing",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                )),
                                          )
                                        : searchresult(listFish[index]));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            // color: Colors.red[200],
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                "Call :- 7071720718 to become potential member",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Potential Members :- ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: kgreyFill,
                                      radius: 25,
                                    ),
                                    title: Text(
                                      "Deep Patel",
                                    ),
                                    subtitle: Text("93XXXXXX30"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                : SizedBox(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => PremiumSellerMain());
                            },
                            child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: index == 1
                                        ? themecolor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "Premium Seed Panal",
                                  style: TextStyle(
                                      color: index == 1 ? kwhite : kblack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ))),
                          ),
                        ],
                      ),
                    ),
                  )
          ]
              //     <Widget>[
              //   searchresult(null),
              //   searchresult(null),
              //   // searchresult()
              // ],
              ),
        ));
  }

  // Padding searchresult(SaleItem saleitem) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(8, 8, 8, 0), //const EdgeInsets.all(8.0),
  //     child: Container(
  //         width: 200,
  //         child: Card(
  //           elevation: 6,
  //           // color: kitembg,
  //           child: InkWell(
  //             onTap: () {
  //               print(saleitem.seller_name);
  //
  //               // Navigator.push(
  //               //   context,
  //               //   MaterialPageRoute(
  //               //     builder: (context) => Orders(saleitem),
  //               //   ),
  //               // );
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(0.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: <Widget>[
  //                   Container(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: <Widget>[
  //                         new Image.network(
  //                           saleitem.getImageURL(),
  //                           fit: BoxFit.cover,
  //                           height: 100,
  //                           width: 100,
  //                         ),
  //                         Row(children: [
  //                           BoldText("Fish Seed: ", 12.0, kblack),
  //                           NormalText(saleitem.fish_type_name, kblack, 12.0),
  //                           // Expanded(child: SizedBox(width: 10)),
  //                           // BoldText("Price: ", 12.0, kblack),
  //                           // NormalText(saleitem.getPrice(), kblack, 12.0),
  //                         ]),
  //                         SizedBox(height: 3),
  //                         Row(children: [
  //                           BoldText("Price: ", 12.0, kblack),
  //                           NormalText(saleitem.getPrice(), kblack, 12.0),
  //                         ]),
  //                         SizedBox(height: 3),
  //                         Row(children: [
  //                           BoldText("Listed On: ", 12.0, kblack),
  //                           NormalText(
  //                               saleitem.getFormattedDate(), kblack, 12.0),
  //                         ]),
  //                         SizedBox(height: 3),
  //                         Row(children: [
  //                           BoldText("Expire On: ", 12.0, kblack),
  //                           NormalText(
  //                               saleitem.getFormattedDateExpiry(),
  //                               saleitem.getIsExpired() ? Colors.red : kblack,
  //                               12.0)
  //                         ]),
  //                         // new Image.asset(
  //                         //   //list.thumbnailUrl,
  //                         //   "assets/fish.jpg",
  //                         //   fit: BoxFit.cover,
  //                         //   height: 100.0,
  //                         //   width: 100.0,
  //                         // ),
  //                         // Expanded(
  //                         //     child: Padding(
  //                         //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //                         //   child: Column(
  //                         //     crossAxisAlignment: CrossAxisAlignment.start,
  //                         //     mainAxisAlignment: MainAxisAlignment.start,
  //                         //     children: [
  //                         //       BoldText(saleitem.seller_name, 16.0, kblack),
  //                         //       SizedBox(height: 3),
  //                         //
  //                         //       SizedBox(height: 3),
  //                         //       Row(children: [
  //                         //         BoldText("Size: ", 12.0, kblack),
  //                         //         NormalText(saleitem.fish_size_type, kblack, 12.0),
  //                         //         Expanded(child: SizedBox(width: 10)),
  //                         //         BoldText("Weight: ", 12.0, kblack),
  //                         //         NormalText(saleitem.getWeight(), kblack, 12.0),
  //                         //       ]),
  //                         //       SizedBox(height: 3),
  //                         //       Row(children: [
  //                         //         BoldText("Listed On: ", 12.0, kblack),
  //                         //         NormalText(
  //                         //             saleitem.getFormattedDate(), kblack, 12.0),
  //                         //       ]),
  //                         //       SizedBox(height: 3),
  //                         //       Row(children: [
  //                         //         BoldText("Expire On: ", 12.0, kblack),
  //                         //         NormalText(
  //                         //             saleitem.getFormattedDateExpiry(),
  //                         //             saleitem.getIsExpired() ? Colors.red : kblack,
  //                         //             12.0)
  //                         //       ]),
  //                         //       // saleitem.is_active
  //                         //       //     ? SizedBox(width: 0)
  //                         //       //     : BoldText("In Active", 14.0, Colors.red),
  //                         //       Row(
  //                         //           mainAxisAlignment: MainAxisAlignment.end,
  //                         //           children: [
  //                         //             MaterialButton(
  //                         //                 child: Icon(
  //                         //                   // ignore: deprecated_member_use
  //                         //                   FontAwesomeIcons.edit,
  //                         //                   color: kheader,
  //                         //                   size: 18,
  //                         //                 ),
  //                         //                 minWidth: 40,
  //                         //                 padding: EdgeInsets.zero,
  //                         //                 color: Colors.white,
  //                         //                 elevation: 6,
  //                         //                 shape: CircleBorder(),
  //                         //                 onPressed: () async {
  //                         //                   final result = await Navigator.push(
  //                         //                     context,
  //                         //                     MaterialPageRoute(
  //                         //                       builder: (context) =>
  //                         //                           SellFishScreen(
  //                         //                               saleitem: saleitem),
  //                         //                       // SaleUpdatePage(saleitem),
  //                         //                     ),
  //                         //                   );
  //                         //                   if (result != null && result) {
  //                         //                     this.myListing();
  //                         //                   }
  //                         //                 }),
  //                         //             MaterialButton(
  //                         //                 child: Icon(
  //                         //                   // ignore: deprecated_member_use
  //                         //                   FontAwesomeIcons.trashAlt,
  //                         //                   color: Colors.red,
  //                         //                   size: 18,
  //                         //                 ),
  //                         //                 minWidth: 40,
  //                         //                 color: Colors.white,
  //                         //                 elevation: 6,
  //                         //                 shape: CircleBorder(),
  //                         //                 onPressed: () {
  //                         //                   showAlertDialog(context, saleitem.id);
  //                         //                 }),
  //                         //           ]),
  //                         //       saleitem.getIsExpiryingInAWeekOrExpired()
  //                         //           ? MaterialButton(
  //                         //               onPressed: () {
  //                         //                 showAlertDialogExpiry(
  //                         //                     context, saleitem.id);
  //                         //               },
  //                         //               shape: Border.all(
  //                         //                   width: 1.0, color: Colors.red),
  //                         //               child: BoldText(
  //                         //                   Lang.get("Re-active Listing"),
  //                         //                   12.0,
  //                         //                   Colors.red))
  //                         //           : SizedBox(width: 0),
  //                         //     ],
  //                         //   ),
  //                         // )), //"Lorem ipsum"
  //                         // Container(
  //                         //   child: Column(
  //                         //     crossAxisAlignment: CrossAxisAlignment.center,
  //                         //     children: [
  //                         //       Container(
  //                         //           padding: EdgeInsets.all(25.0),
  //                         //           decoration: BoxDecoration(
  //                         //             color: Colors.transparent,
  //                         //             shape: BoxShape.circle,
  //                         //           ),
  //                         //           child: BoldText(saleitem.getDistance(), 14.0,
  //                         //               Colors.transparent)),
  //                         //       SizedBox(height: 10),
  //                         //       Row(
  //                         //         children: [
  //                         //           //phone_in_talk
  //                         //           IconButton(
  //                         //               icon: Icon(
  //                         //                 FontAwesomeIcons.edit,
  //                         //                 color: korange,
  //                         //               ),
  //                         //               onPressed: () async {
  //                         //                 final result = await Navigator.push(
  //                         //                   context,
  //                         //                   MaterialPageRoute(
  //                         //                     builder: (context) =>
  //                         //                         SaleUpdatePage(saleitem),
  //                         //                   ),
  //                         //                 );
  //                         //                 if (result != null && result) {
  //                         //                   this.myListing();
  //                         //                 }
  //                         //               }),
  //                         //           IconButton(
  //                         //               icon: Icon(
  //                         //                 FontAwesomeIcons.trashAlt,
  //                         //                 color: korange,
  //                         //               ),
  //                         //               onPressed: () {
  //                         //                 showAlertDialog(context, saleitem.id);
  //                         //                 // Fluttertoast.showToast(
  //                         //                 //     msg: "Delete seller details " +
  //                         //                 //         saleitem.seller_name);
  //                         //               }),
  //                         //         ],
  //                         //       )
  //                         //     ],
  //                         //   ),
  //                         // )
  //                       ],
  //                     ),
  //                   ),
  //                   // Container(
  //                   //   decoration: BoxDecoration(
  //                   //       color: kitembg,
  //                   //       borderRadius: BorderRadius.only(
  //                   //           bottomLeft: Radius.circular(10),
  //                   //           bottomRight: Radius.circular(10))),
  //                   //   padding: const EdgeInsets.all(8.0),
  //                   //   child: !saleitem.is_active
  //                   //       ? RichText(
  //                   //           text: TextSpan(
  //                   //             children: <TextSpan>[
  //                   //               TextSpan(
  //                   //                   text: 'In Active ',
  //                   //                   style: TextStyle(
  //                   //                       color: Colors.red,
  //                   //                       fontWeight: FontWeight.bold)),
  //                   //               TextSpan(
  //                   //                   text:
  //                   //                       '- Your listing has been submitted to the admin for approval',
  //                   //                   style: TextStyle(color: kgreyDark))
  //                   //             ],
  //                   //           ),
  //                   //         )
  //                   //       : RichText(
  //                   //           text: TextSpan(
  //                   //             children: <TextSpan>[
  //                   //               TextSpan(
  //                   //                   text: 'Active ',
  //                   //                   style: TextStyle(
  //                   //                       color: Colors.green,
  //                   //                       fontWeight: FontWeight.bold)),
  //                   //               TextSpan(
  //                   //                   text: '- Your listing has been active till ' +
  //                   //                       saleitem.getFormattedDateExpiry() +
  //                   //                       saleitem.getAdminRemark(withSpace: true),
  //                   //                   style: TextStyle(color: kgreyDark))
  //                   //             ],
  //                   //           ),
  //                   //         ),
  //                   // )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         )),
  //   );
  // }

  Padding searchresult(SaleItem saleitem) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0), //const EdgeInsets.all(8.0),
      child: Container(
          //height: 100,
          child: Card(
        elevation: 6,
        // color: kitembg,
        child: InkWell(
          onTap: () {
            print(saleitem.seller_name);
            //
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Orders(saleitem),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Image.network(
                        saleitem.getImageURL(),
                        fit: BoxFit.cover,
                        height: 165.0,
                        width: 100.0,
                      ),
                      // new Image.asset(
                      //   //list.thumbnailUrl,
                      //   "assets/fish.jpg",
                      //   fit: BoxFit.cover,
                      //   height: 100.0,
                      //   width: 100.0,
                      // ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BoldText(saleitem.seller_name, 16.0, kblack),
                            SizedBox(height: 3),
                            Row(children: [
                              // BoldText("Fish Seed: ", 12.0, kblack),
                              Container(
                                  width: screenwidth(context, dividedby: 5),
                                  child: NormalText(
                                      saleitem.fish_type_name, kblack, 12.0)),
                              // Expanded(child: SizedBox(width: 10)),
                              // BoldText("Price: ", 12.0, kblack),
                              // NormalText(saleitem.getPrice(), kblack, 12.0),
                            ]),
                            SizedBox(height: 3),
                            Row(children: [
                              // BoldText("Price: ", 12.0, kblack),
                              NormalText(saleitem.getPrice(), kblack, 12.0),
                            ]),
                            SizedBox(height: 3),
                            Column(children: [
                              Row(
                                children: [
                                  // BoldText("Size: ", 12.0, kblack),
                                  NormalText(
                                      saleitem.fish_size_type, kblack, 12.0),
                                ],
                              ),
                              // Expanded(child: SizedBox(width: 10)),
                              Row(
                                children: [
                                  // BoldText("Weight: ", 12.0, kblack),
                                  NormalText(
                                      saleitem.getWeight(), kblack, 12.0),
                                ],
                              ),
                            ]),
                            // SizedBox(height: 3),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                      child: Icon(
                                        FontAwesomeIcons.edit,
                                        color: kheader,
                                        size: 18,
                                      ),
                                      minWidth: 40,
                                      padding: EdgeInsets.zero,
                                      color: Colors.white,
                                      elevation: 6,
                                      shape: CircleBorder(),
                                      onPressed: () async {
                                        Get.to(() => SellFishScreen(
                                              saleitem: saleitem,
                                            ))?.then((value) => myListing());
                                      }),
                                  MaterialButton(
                                      child: Icon(
                                        FontAwesomeIcons.trashAlt,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      minWidth: 40,
                                      color: Colors.white,
                                      elevation: 6,
                                      shape: CircleBorder(),
                                      onPressed: () {
                                        showAlertDialog(context, saleitem.id);
                                      }),
                                ]),
                            // Row(children: [
                            //   // BoldText("Listed On: ", 12.0, kblack),
                            //   NormalText(
                            //       saleitem.getFormattedDate(), kblack, 12.0),
                            // ]),
                            // SizedBox(height: 3),
                            // Row(children: [
                            //   // BoldText("Expire On: ", 12.0, kblack),
                            //   NormalText(
                            //       saleitem.getFormattedDateExpiry(),
                            //       saleitem.getIsExpired() ? Colors.red : kblack,
                            //       12.0)
                            // ]),
                            // saleitem.is_active
                            //     ? SizedBox(width: 0)
                            //     : BoldText("In Active", 14.0, Colors.red),
                            saleitem.getIsExpiryingInAWeekOrExpired()
                                ? MaterialButton(
                                    onPressed: () {
                                      showAlertDialogExpiry(
                                          context, saleitem.id);
                                    },
                                    shape: Border.all(
                                        width: 1.0, color: Colors.red),
                                    child: BoldText(
                                        Lang.get("Re-active Listing"),
                                        12.0,
                                        Colors.red))
                                : SizedBox(width: 0),
                          ],
                        ),
                      )), //"Lorem ipsum"
                      // Container(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //           padding: EdgeInsets.all(25.0),
                      //           decoration: BoxDecoration(
                      //             color: Colors.transparent,
                      //             shape: BoxShape.circle,
                      //           ),
                      //           child: BoldText(saleitem.getDistance(), 14.0,
                      //               Colors.transparent)),
                      //       SizedBox(height: 10),
                      //       Row(
                      //         children: [
                      //           //phone_in_talk
                      //           IconButton(
                      //               icon: Icon(
                      //                 FontAwesomeIcons.edit,
                      //                 color: korange,
                      //               ),
                      //               onPressed: () async {
                      //                 final result = await Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         SaleUpdatePage(saleitem),
                      //                   ),
                      //                 );
                      //                 if (result != null && result) {
                      //                   this.myListing();
                      //                 }
                      //               }),
                      //           IconButton(
                      //               icon: Icon(
                      //                 FontAwesomeIcons.trashAlt,
                      //                 color: korange,
                      //               ),
                      //               onPressed: () {
                      //                 showAlertDialog(context, saleitem.id);
                      //                 // Fluttertoast.showToast(
                      //                 //     msg: "Delete seller details " +
                      //                 //         saleitem.seller_name);
                      //               }),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  decoration: BoxDecoration(
                      color: kitembg, borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8.0),
                  child: !saleitem.is_active
                      ? RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'In Active ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      '- Your listing has been submitted to the admin for approval',
                                  style: TextStyle(color: kgreyDark))
                            ],
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Active ',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: '- Your listing has been active till ' +
                                      saleitem.getFormattedDateExpiry() +
                                      saleitem.getAdminRemark(withSpace: true),
                                  style: TextStyle(color: kgreyDark))
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  List<SaleItem> listFish = [];
  var isLoading = false;

  myListing() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final response = await http.post(Common.getURL('myListing'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          "customer_id": saveUser()?.data?.id.toString() ?? "",
          "lat": location?.lat ?? '',
          "lng": location?.long ?? '',
          "limit": "100",
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"]["data"].cast<Map<String, dynamic>>();
      print(parsed);

      listFish =
          parsed.map<SaleItem>((json) => SaleItem.fromJson(json)).toList();

      if (mounted)
        setState(() {
          isLoading = false;
        });
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      throw Exception('Failed to load request');
    }
  }

  deleteSeller(saleItemId) async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final response = await http.post(Common.getURL('deleteSeller'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          "rawid": saleItemId.toString(),
          "customer_id": saveUser()?.data?.id.toString() ?? "",
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"]["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      EasyLoading.showToast(resBody["message"].toString());
      if (mounted)
        setState(() {
          isLoading = false;
          myListing();
        });
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      throw Exception('Failed to load request');
    }
  }

  expiryUpdate(saleItemId) async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final response = await http.post(Common.getURL('myListingExpiryUpdate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          "rawid": saleItemId.toString(),
          "customer_id": saveUser()?.data?.id.toString() ?? "",
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"]["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      EasyLoading.showToast(resBody["message"].toString());
      if (mounted)
        setState(() {
          isLoading = false;
          myListing();
        });
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      throw Exception('Failed to load request');
    }
  }

  showAlertDialog(BuildContext context, sallerId) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text(Lang.get("Cancel")),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = MaterialButton(
      child: Text(Lang.get("Continue")),
      onPressed: () {
        Navigator.of(context).pop();
        deleteSeller(sallerId);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Lang.get("Remove")),
      content: Text(Lang.get("Are you sure you want to remove?")),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogExpiry(BuildContext context, sallerId) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text(Lang.get("Cancel")),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = MaterialButton(
      child: Text(Lang.get("Continue")),
      onPressed: () {
        Navigator.of(context).pop();
        expiryUpdate(sallerId);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Lang.get("Listing Expiry")),
      content: Text(Lang.get(
          "Incase you have not sold and still available, and If you want to re-active you listing please continue, else delete the listing.")),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget getNote() {
//     Note:
// 1. Your listing will get expired after 6 months.
// 2. If your seed get sold please delete from here as well
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFffe6d2),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText('Note:', 12, kblack),
          NormalText(
              '1. Your listing will get expired after 6 months.', kblack, 12),
          NormalText('2. If your seed get sold please delete from here as well',
              kblack, 12),
        ],
      ),
    );
  }
}
