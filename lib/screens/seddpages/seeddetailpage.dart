import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manjha/model/gethitcheryresponse.dart';
import 'package:manjha/model/getseeddetailsresponse.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../getxcontrollers/homecotroller.dart';
import '../../languagetranslation/apptranslation.dart';
import '../const.dart';
import '../localconst.dart';

class SeedDetailsPage extends StatefulWidget {
  final Fish hatchery;
  const SeedDetailsPage({super.key, required this.hatchery});

  @override
  State<SeedDetailsPage> createState() => _SeedDetailsPageState();
}

class _SeedDetailsPageState extends State<SeedDetailsPage> {
  HomePageController homePageController = Get.put(HomePageController());
  List<String> imgList = [];

  Getseeddetails? list;
  bool show = false;
  getseeddetailApiCall({required String code}) async {
    // showcategory.value = false;
    // EasyLoading.show();
    await getseeddetails(hatcheruid: code).then((value) {
      setState(() {
        show = true;
        list = value;
      });
      imgList.add(widget.hatchery.getImageUrl());
      imgList.addAll(
          widget.hatchery.images!.map((e) => widget.hatchery.getMediaUrl(e)));
      // Fluttertoast.showToast(msg: value.message ?? "");
      // showcategory.value = true;
      // EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      // EasyLoading.dismiss();
      print("error....$error");
    });
  }

  @override
  void initState() {
    getseeddetailApiCall(code: widget.hatchery.id.toString());
    // TODO: implement initState
    super.initState();
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kblack,
        ),
        backgroundColor: kwhite,
        title: Text(
          'Seed Listing',
          style: TextStyle(color: kblack, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: show == false
          ? Center(
              child: CircularProgressIndicator(color: kheader, strokeWidth: 2))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CarouselSlider(
                        // carouselController: _controller,
                        options: CarouselOptions(
                          // aspectRatio: 16 / 10,
                          viewportFraction: 1,
                          animateToClosest: true,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: List.generate(
                            imgList.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: InkWell(
                                    onTap: () {
                                      // print("$index tapped");
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            "${imgList[index]}"),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )).toList()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < imgList.length; i++)
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: _current == i ? 10 : 10,
                            height: _current == i ? 10 : 10,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == i ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  child: Text(
                                    "${list?.hatchery?.hatcheryName}",
                                    textScaleFactor: 1.5,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Sold By: ",
                                        style: TextStyle(
                                            color: Color(0xffA6A7A7),
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                      "${list?.hatchery?.ownerName}",
                                      style: TextStyle(
                                          color: kheader,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${list?.hatchery?.address}",
                                  style: TextStyle(
                                      color: Color(0xff929797),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            // Stack(
                            //   alignment: Alignment.center,
                            //   children: [
                            //     Container(
                            //       decoration: BoxDecoration(
                            //         // color: kwhite,
                            //         shape: BoxShape.rectangle,
                            //
                            //         boxShadow: [
                            //           BoxShadow(
                            //               color: Colors.grey, blurRadius: 2)
                            //         ],
                            //         borderRadius: BorderRadius.all
                            //           Radius.circular(5.0),
                            //         ),
                            //       ),
                            //       height: 100,
                            //       width: 60,
                            //       child: FadeInImage.assetNetwork(
                            //         fadeInCurve: Curves.easeInOut,
                            //         fadeInDuration:
                            //         Duration(milliseconds: 100),
                            //         imageErrorBuilder: (context, error,
                            //             stackTrace) =>
                            //             Image.asset("assets/no-photo.png"),
                            //         placeholder: 'assets/no-photo.png',
                            //         image: widget._hatchery.getImageUrl(),
                            //         height: 50.0,
                            //         width: 50.0,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //     MaterialButton(
                            //         child: Icon(
                            //           FontAwesomeIcons.play,
                            //           color: Colors.white,
                            //           size: 15,
                            //         ),
                            //         // color: kWhatsApp,
                            //         minWidth: 45,
                            //         height: 35,
                            //         color: kheader.withAlpha(150),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //             BorderRadius.circular(5),
                            //             side: BorderSide(
                            //                 color: Colors.transparent)),
                            //         onPressed: () {
                            //           showVideo(
                            //               widget._hatchery.getVideoUrl());
                            //         })
                            //   ],
                            // ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => kheader)),
                                onPressed: () {
                                  homePageController.hatcheryLog(
                                      widget.hatchery.id,
                                      homePageController.ACTION_CALL);
                                  // ignore: deprecated_member_use
                                  launch("tel:+91${widget.hatchery.mobileno}");
                                },
                                icon: Icon(
                                  Icons.call,
                                  color: kwhite,
                                ),
                                label: Text(
                                  "Call Now",
                                  style: TextStyle(color: kwhite),
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.green)),
                                onPressed: () async {
                                  homePageController.hatcheryLog(
                                      widget.hatchery.id,
                                      homePageController.ACTION_WHATSAPP);
                                  String strUserName =
                                      await saveUser()?.data?.fullName ?? "";
                                  String strCity =
                                      await saveUser()?.data?.cityname ?? "";

                                  String strMessage = Common.getWhtapAppMessage(
                                      strUserName, strCity);
                                  // ignore: deprecated_member_use
                                  launch(Uri.encodeFull(
                                      "https://wa.me/91${widget.hatchery.mobileno}?text=$strMessage"));
                                },
                                icon: Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: kwhite,
                                ),
                                label: Text(
                                  "Whatsapp Now",
                                  style: TextStyle(color: kwhite),
                                )),
                            Container(
                              child: IconButton(
                                  onPressed: () {
                                    homePageController.hatcheryLog(
                                        widget.hatchery.id,
                                        homePageController.ACTION_SHARE);
                                    Share.share(widget.hatchery.getShareText());
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.red,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ...List.generate(list?.data?.length ?? 0,
                      (index) => buildListItem(context, list?.data?[index])),
                ],
              ),
            ),
    );
  }

  Widget buildListItem(BuildContext context, Datum? data) {
    return Container(
      height: 120,
      padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Get.to(() => PremiumSellerDetail());
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeInImage.assetNetwork(
                          fadeInCurve: Curves.easeInOut,
                          fadeInDuration: Duration(milliseconds: 100),
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.network(
                            data?.getImageUrl() ?? "",
                            height: 80,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          placeholder: 'assets/fish-hatcheries.jpg',
                          image: "assets/fish-hatcheries.jpg",
                          height: 80,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          decoration: data?.seedVideo != null
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.5),
                                    ],
                                  ),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                        ),
                        if (data?.seedVideo != null)
                          MaterialButton(
                            child: Icon(
                              FontAwesomeIcons.play,
                              color: Colors.white,
                              size: 15,
                            ),
                            minWidth: 45,
                            height: 35,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.transparent),
                            ),
                            onPressed: () {
                              showVideo(data?.getVideoUrl() ?? "");
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data?.seedName ?? "",
                              textScaleFactor: 1.5,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: EllipsisMenu(),
                            //   // GestureDetector(
                            //   //     onTap: () {
                            //   //       print("Done");
                            //   //     },
                            //   //       child: Icon(CupertinoIcons.ellipsis,color: kheader,)),
                            // ),
                          ],
                        ),
                        // SizedBox(height: 8),
                        // Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Size:',
                                    style: TextStyle(
                                        color: kgreyDark,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Line:',
                                    style: TextStyle(
                                        color: kgreyDark,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Price:',
                                    style: TextStyle(
                                        color: kgreyDark,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    data?.getSize() ?? "",
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    data?.getWeight() ?? "",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data?.getPrice() ?? "",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getNoRecordBox() {
    // return [
    return Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: NormalText("No data found", kblack, 16.0),
          ),
        ));
    // ];
  }

  @override
  void dispose() {
    _vcontroller!.pause();
    // TODO: implement dispose
    super.dispose();
  }

  VideoPlayerController? _vcontroller;

  showVideo(String videoUrl) async {
    EasyLoading.show(status: translate('Streaming Video...'));
    // ignore: deprecated_member_use
    _vcontroller = VideoPlayerController.network(videoUrl);
    await _vcontroller!.initialize();
    EasyLoading.dismiss();

    if (_vcontroller!.value.isInitialized) _vcontroller!.play();
    showGeneralDialog(
      context: context,
      barrierLabel: "SearchByFish",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, anim1, anim2) {
        // return object of type Dialog
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            title: BoldText(widget.hatchery.hatcheryName ?? '', 20.0, kheader),
            titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            content: Container(
              child: _vcontroller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _vcontroller!.value.aspectRatio,
                      child: VideoPlayer(_vcontroller!),
                    )
                  : Container(child: Text('Video not loaded..')),
            ),
            actionsPadding: EdgeInsets.all(0.0),
            actions: <Widget>[
              new MaterialButton(
                child: BoldText("Close", 16.0, kheader),
                padding: EdgeInsets.only(right: 16, left: 16.0),
                onPressed: () {
                  _vcontroller!.pause();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  // Widget getNoRecordBox() {
  //   // return [
  //   return Card(
  //       margin: EdgeInsets.all(10),
  //       child: Padding(
  //         padding: EdgeInsets.all(16),
  //         child: SizedBox(
  //           width: double.infinity,
  //           child: NormalText("No data found", kblack, 16.0),
  //         ),
  //       ));
  //   // ];
  // }
}
