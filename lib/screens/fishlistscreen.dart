import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/seddpages/fishdetailsscreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../getxcontrollers/homecotroller.dart';
import '../model/searchfishresponse.dart';
import '../services/apiconst.dart';
import 'const.dart';
import 'localconst.dart';

class FishScreenList extends StatefulWidget {
  final String? fishname;
  const FishScreenList({super.key, this.fishname});

  @override
  State<FishScreenList> createState() => _FishScreenListState();
}

class _FishScreenListState extends State<FishScreenList> {
  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolorcart,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kblack),
          backgroundColor: cartbackgroundcolor,
          elevation: 0,
          automaticallyImplyLeading: true,
          title:
              Text("${widget.fishname} List", style: TextStyle(color: kblack)),
        ),
        body: GetBuilder<HomePageController>(
          builder: (controller) => controller.fidhloadingtyp.isFalse
              ? Center(
                  child: CircularProgressIndicator(
                  color: kheader,
                  strokeWidth: 2,
                ))
              : controller.fishlisttypewise.length == 0
                  ? Center(
                      child: Text(
                        "No Fish Found",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.fishlisttypewise.length,
                      itemBuilder: (context, index) {
                        Fishes fish = controller.fishlisttypewise[index];

                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      () => FishDetailsScreen(saleItem: fish));
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          height: 150,
                                          width: 130,
                                          imageUrl: fish.getImageURL(),
                                          cacheKey: fish.getImageURL(),
                                          // imageUrl: newsItem?.getImageUrl() ?? "",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 130,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    fish.getImageURL()),
                                              ),
                                            ),
                                            // child: Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           top: 10, right: 10),
                                            //   child: GestureDetector(
                                            //     onTap: () {
                                            //       setState(() {
                                            //         fish.setFavorite(!fish
                                            //             .is_favorite());
                                            //       });
                                            //       homePageController
                                            //           .myFavoriteAdd(
                                            //               fish.id,
                                            //               isRemove: fish
                                            //                   .is_favorite());
                                            //     },
                                            //     child: Align(
                                            //       alignment:
                                            //           Alignment.topRight,
                                            //       child: Icon(
                                            //         fish.isFavorite == 1
                                            //             ? CupertinoIcons
                                            //                 .heart_fill
                                            //             : CupertinoIcons
                                            //                 .heart,
                                            //         color:
                                            //             fish.isFavorite == 1
                                            //                 ? Colors.red
                                            //                 : Colors.white,
                                            //       ),
                                            //     ),
                                            //     // child: Align(
                                            //     //     alignment: Alignment.topRight,
                                            //     //     child: Icon(tapped ? CupertinoIcons.heart_fill : CupertinoIcons.heart, color: tapped ? Colors.red : Colors.white,)),
                                            //   ),
                                            // ),
                                          ),
                                          placeholder: (context, url) => Center(
                                              child: Image.asset(
                                            'assets/no-photo.png',
                                            fit: BoxFit.cover,
                                          )),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                                  child: Image.asset(
                                            'assets/no-photo.png',
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  softWrap: true,
                                                  textScaleFactor: 1.3,
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${fish.fishTypeName} ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      // TextSpan(
                                                      //   text: 'fish',
                                                      //   style: TextStyle(
                                                      //       color: Colors.black,
                                                      //       fontWeight:
                                                      //           FontWeight.w400),
                                                      // ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${fish.sellerName}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .location_solid,
                                                      color: kheader,
                                                      size: 20,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          "${fish.address} | ${fish.distance?.toStringAsFixed(0)}km",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: kgreyDark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    )
                                                  ],
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.symmetric(
                                                //       vertical: 5),
                                                //   child: RichText(
                                                //     softWrap: true,
                                                //     textScaleFactor: 1.5,
                                                //     textAlign: TextAlign.start,
                                                //     text: TextSpan(
                                                //       children: [
                                                //         TextSpan(
                                                //           text: '₹ ',
                                                //           style: TextStyle(
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .w400,
                                                //               color:
                                                //                   Colors.black,
                                                //               fontSize: 18),
                                                //         ),
                                                //         TextSpan(
                                                //           text:
                                                //               '${fish.getPrice()}',
                                                //           style: TextStyle(
                                                //               color:
                                                //                   Colors.black,
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .w400),
                                                //         ),
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Price:',
                                                            style: TextStyle(
                                                                color:
                                                                    kgreyDark,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            '${fish.getPrice()}',
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Size:',
                                                            style: TextStyle(
                                                                color:
                                                                    kgreyDark,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            '${fish.fishSizeType}',
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                color:
                                                                    themecolor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Weight:',
                                                            style: TextStyle(
                                                                color:
                                                                    kgreyDark,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            fish.getWeight(),
                                                            style: TextStyle(
                                                                color:
                                                                    themecolor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            homePageController
                                                                .saleitemLog(
                                                                    fish.id,
                                                                    homePageController
                                                                        .ACTION_CALL);
                                                            launch(
                                                                "tel:+91${fish.contactno}");
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    themecolor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Center(
                                                              child: Icon(
                                                                  Icons.call,
                                                                  color: kwhite,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            homePageController
                                                                .saleitemLog(
                                                                    fish.id,
                                                                    homePageController
                                                                        .ACTION_WHATSAPP);
                                                            String strUserName =
                                                                await saveUser()
                                                                        ?.data
                                                                        ?.fullName ??
                                                                    "";
                                                            String strCity =
                                                                await saveUser()
                                                                        ?.data
                                                                        ?.cityname ??
                                                                    "";

                                                            String strMessage =
                                                                Common.getWhtapAppMessage(
                                                                    strUserName,
                                                                    strCity);
                                                            launch(Uri.encodeFull(
                                                                "https://wa.me/91${fish.contactno}?text=$strMessage"));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Center(
                                                              child: Icon(
                                                                  FontAwesomeIcons
                                                                      .whatsapp,
                                                                  color: kwhite,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              fish.setFavorite(!fish
                                                                  .is_favorite());
                                                            });
                                                            homePageController
                                                                .myFavoriteAdd(
                                                                    fish.id,
                                                                    isRemove: fish
                                                                        .is_favorite());
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 1.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Center(
                                                              child: Icon(
                                                                  fish.isFavorite ==
                                                                          1
                                                                      ? CupertinoIcons
                                                                          .heart_fill
                                                                      : CupertinoIcons
                                                                          .heart,
                                                                  // FontAwesomeIcons
                                                                  //     .heart,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            'Updated at:',
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          Text(
                                                            fish.getLastUpdateDate(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  clipBehavior: Clip.none,
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      height: 0,
                                      padding: EdgeInsets.zero,
                                      value: 'phone',
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.phone,
                                          color: kheader.withOpacity(0.7),
                                        ),
                                        title: Text('Phone'),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      height: 0,
                                      padding: EdgeInsets.zero,
                                      value: 'whatsapp',
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.message_outlined,
                                          color: Colors.green.withOpacity(0.5),
                                        ),
                                        title: Text('WhatsApp'),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      height: 0,
                                      padding: EdgeInsets.zero,
                                      value: 'share',
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.share_outlined,
                                          color: kdarkBlue,
                                        ),
                                        title: Text('Share'),
                                      ),
                                    ),
                                  ],
                                  onSelected: (String value) async {
                                    switch (value) {
                                      case 'phone':
                                        homePageController.saleitemLog(fish.id,
                                            homePageController.ACTION_CALL);
                                        launch("tel:+91${fish.contactno}");
                                        break;
                                      case 'whatsapp':
                                        homePageController.saleitemLog(fish.id,
                                            homePageController.ACTION_WHATSAPP);
                                        String strUserName =
                                            await saveUser()?.data?.fullName ??
                                                "";
                                        String strCity =
                                            await saveUser()?.data?.cityname ??
                                                "";

                                        String strMessage =
                                            Common.getWhtapAppMessage(
                                                strUserName, strCity);
                                        launch(Uri.encodeFull(
                                            "https://wa.me/91${fish.contactno}?text=$strMessage"));

                                        break;
                                      case 'share':
                                        homePageController.saleitemLog(fish.id,
                                            homePageController.ACTION_SHARE);
                                        if (fish.hasImage()) {
                                          final box = context.findRenderObject()
                                              as RenderBox?;

                                          var response = await http.get(
                                              Common.getURL(
                                                  fish.getImageURL()));
                                          final documentDirectory =
                                              (await getExternalStorageDirectory())!
                                                  .path;
                                          File imgFile = new File(
                                              '$documentDirectory/manjha.png');
                                          imgFile.writeAsBytesSync(
                                              response.bodyBytes);
                                          Share.shareFiles(
                                              ['$documentDirectory/manjha.png'],
                                              text: fish.getShareText(),
                                              // text: subject,
                                              sharePositionOrigin: box!
                                                      .localToGlobal(
                                                          Offset.zero) &
                                                  box.size);
                                        } else {
                                          final ByteData bytes =
                                              await rootBundle
                                                  .load('assets/no-photo.png');
                                          final Uint8List list =
                                              bytes.buffer.asUint8List();

                                          final tempDir =
                                              await getTemporaryDirectory();
                                          final file = await new File(
                                                  '${tempDir.path}/no-photo.png')
                                              .create();
                                          file.writeAsBytesSync(list);

                                          Share.shareFiles(['${file.path}'],
                                              text: fish.getShareText());
                                          //Share.share(saleitem.getShareText());
                                        }
                                        break;
                                    }
                                  },
                                ),
                                // Icon(CupertinoIcons.ellipsis_vertical),
                              ),
                            ],
                          ),
                        );
                      }),
        ));
  }
}
