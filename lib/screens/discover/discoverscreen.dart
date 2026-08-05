import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manjha/getxcontrollers/videocontroller.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/model/getcategoryresponses.dart';
import 'package:manjha/model/getvideoresponse.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../getxcontrollers/maincontroller.dart';
import '../../getxcontrollers/mixpanelcontroller.dart';
import '../../services/apiconst.dart';
import '../const.dart';
import '../localconst.dart';
import 'newspage.dart';
import 'videoblogscreens.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  VideoController videoController = Get.put(VideoController());
  MainController m = Get.put(MainController());

  @override
  void initState() {
    if (m.fourthscreen.isFalse) {
      videoController.CategoryApiCall();
      videoController.videoApiCall();
      m.fourthscreen.value = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: kwhite,
        //   automaticallyImplyLeading: false,
        //   centerTitle: true,
        //   title: Text(
        //     "Discover".tr,
        //     style: const TextStyle(
        //         fontSize: 20, fontWeight: FontWeight.bold, color: kheader),
        //   ),
        //   elevation: 0,
        // ),
        body: ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            // videoController.showcategory.isTrue ? SizedBox.shrink() : Material(
            //   color: Colors.transparent,
            //   child: ListTile(
            //     splashColor: Colors.transparent,
            //     focusColor: Colors.transparent,
            //     hoverColor: Colors.transparent,
            //     selectedTileColor: Colors.transparent,
            //     dense: true,
            //     tileColor: Colors.transparent,
            //     visualDensity: VisualDensity.compact,
            //     // title: NormalText("Browse Latest Videos".tr, kdarkBlue, 22),
            //     title: Text(
            //       "Browse Latest Videos".tr,
            //       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            //     ),
            //     trailing: Text(
            //       "View More".tr,
            //       style: const TextStyle(color: kheader, fontSize: 12, fontWeight: FontWeight.w500),
            //     ),
            //     onTap: () {
            //       Get.to(() => videoblogScreens(videos: videoController.video));
            //     },
            //   ),
            // ),
            Obx(
              () => Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      selectedTileColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      dense: true,
                      tileColor: Colors.transparent,
                      visualDensity: VisualDensity.compact,
                      // title: NormalText("Browse Latest Videos".tr, kdarkBlue, 22),
                      title: Text(
                        "Browse Latest Videos".tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      trailing: Text(
                        "View More".tr,
                        style: const TextStyle(
                            color: kheader,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        MixpanelController.logScreen(
                          MixpanelController.PageVideoBlog,
                        );
                        Get.to(() =>
                            videoblogScreens(videos: videoController.video));
                      },
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 180,
                    // height: MediaQuery.of(context).size.height * 0.23,
                    child: videoController.show.isFalse
                        ? SizedBox()
                        : ListView.builder(
                            shrinkWrap: false,
                            itemCount: videoController.video?.length,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return populateItemVideo(
                                  videoController.video![index]);
                            }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // videoController.showcategory.isTrue ? SizedBox.shrink() : Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
            //     alignment: Alignment.centerLeft,
            //     // child: NormalText("Read latest news and Articles".tr, kdarkBlue, 22)),
            //   child: Text("Read latest news and Articles".tr,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)),
            Obx(() => Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 5),
                            alignment: Alignment.centerLeft,
                            // child: NormalText("Read latest news and Articles".tr, kdarkBlue, 22)),
                            child: Text(
                              "Read latest news and Articles".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                        videoController.showcategory.isFalse
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 35),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: videoController.category?.length,
                                itemBuilder: (context, index) {
                                  return populateItemNewsCategory(
                                      videoController.category![index]);
                                }),
                      ],
                    )
                // GridView.builder(
                //         shrinkWrap: true,
                //         primary: true,
                //         padding: const EdgeInsets.only(bottom: 25),
                //         physics: const NeverScrollableScrollPhysics(),
                //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 2,
                //         ),
                //         itemCount: videoController.category?.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return populateItemNewsCategory(videoController.category![index]);
                //         }),
                )
          ],
        ),
      ),
    ));
  }

  Widget populateItemNewsCategory(DatumCategory category) {
    return
        //   Container(
        //   padding: const EdgeInsets.all(5),
        //   child: GestureDetector(
        //     onTap: () {
        //       Get.to(() => NewsPage(
        //           CategoryName: category.categoryName,
        //           newsCategoryId: category.id,
        //           newsTitle: category.newsCategoryName,
        //           headerColor: Common.getHaxColor(category.colorCode)));
        //     },
        //     child: Container(
        //         margin: const EdgeInsets.all(4),
        //         // padding: EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //             color: kwhite,
        //             borderRadius: BorderRadius.circular(8),
        //             boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)]),
        //         // elevation: 4,
        //         // color: kitembg,
        //         // margin: EdgeInsets.all(10),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Expanded(
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                     color: Common.getHaxColor(category.colorCode), borderRadius: BorderRadius.circular(10)),
        //                 alignment: Alignment.center,
        //                 child: ClipOval(
        //                   child: Image.network(
        //                     image_news_url + category.newsCategoryImage.toString(),
        //                     fit: BoxFit.cover,
        //                     height: 80.0,
        //                     width: 80.0,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               // color: Colors.amber,
        //               alignment: Alignment.center,
        //               height: 60,
        //               padding: const EdgeInsets.symmetric(horizontal: 10),
        //               child: NormalText("${category.categoryName}", kblack, 16, textAlign: TextAlign.center),
        //             ),
        //           ],
        //         )),
        //   ),
        // );
        Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: InkWell(
                // splashColor: Colors.transparent,
                // highlightColor: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  MixpanelController.logScreen(MixpanelController.PageNewsList,
                      properties: {"News Category": category.categoryName});
                  Get.to(() => NewsPage(
                      CategoryName: category.categoryName,
                      newsCategoryId: category.id,
                      newsTitle: category.newsCategoryName,
                      headerColor: Common.getHaxColor(category.colorCode)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: kwhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Common.getHaxColor(category.colorCode),
                                // color: Colors.transparent,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(10)
                              ),
                              alignment: Alignment.center,
                              child: ClipOval(
                                child: Image.network(
                                  image_news_url +
                                      category.newsCategoryImage.toString(),
                                  fit: BoxFit.cover,
                                  height: 80.0,
                                  width: 80.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(category.categoryName ?? "",
                                      textScaleFactor: 1.35,
                                      maxLines: 2,
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: kblack,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(
                                    height: 2.5,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 35,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
  }

  Widget populateItemVideo(Datum videoItem) {
    String formattedDate = DateFormat(
            "MMM d, yyyy - h:mm", Localizations.localeOf(context).toString())
        .format(videoItem.getDate());
    if (languagecode() == "hi") {
      formattedDate = formattedDate.replaceAllMapped(
          RegExp(r'[0-9]'), (match) => getHindiNumber(match.group(0) ?? "0"));
    } else if (languagecode() == "or") {
      formattedDate = formattedDate.replaceAllMapped(
          RegExp(r'[0-9]'), (match) => getOdiaNumber(match.group(0) ?? "0"));
    }

    return Container(
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.only(right: 8),
        child: InkWell(
          onTap: () {
            Fluttertoast.showToast(msg: translate('Opening YouTube'));
            // ignore: deprecated_member_use
            MixpanelController.logScreen(MixpanelController.PageDiscover,
                properties: {"Youtube Video": videoItem.videoTitleLang});
            // ignore: deprecated_member_use
            launch(videoItem.videoUrl!);
          },
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent),
                    // height: 200,
                    // width:312,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        // height: 190,
                        // width: 324,
                        height: 100,
                        // width: 150,
                        fit: BoxFit.fill,
                        fadeInCurve: Curves.bounceIn,
                        imageUrl: videoItem.videoImage ?? "",
                        cacheKey: videoItem.videoImage ?? "",
                        placeholder: (context, url) => Center(
                          child: Image.asset(
                            'assets/no-photo.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Image.asset(
                            'assets/no-photo.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              // width: 312,
                              child: Text(videoItem.videoTitleLang ?? "",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: "nunito",
                                      fontWeight: FontWeight.w600,
                                      color: kblack,
                                      fontSize: 12)),
                            ),
                            FittedBox(
                              child: TextCustom(
                                // dates.toString(),
                                formattedDate.toString(),
                                Colors.grey,
                                11,
                                fonntweight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
