import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/screens/helper.dart';
import 'package:manjha/model/getvideoresponse.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../getxcontrollers/mixpanelcontroller.dart';
import '../../services/apiconst.dart';

class videoblogScreens extends StatefulWidget {
  final List<Datum>? videos;
  const videoblogScreens({super.key, this.videos});

  @override
  State<videoblogScreens> createState() => _videoblogScreensState();
}

class _videoblogScreensState extends State<videoblogScreens> {
  // VideoController videoController = Get.put(VideoController());
  @override
  void initState() {
    // videoController.videoApiCall(code: "bn");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgreyFill,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Videos Blog".tr,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: kblack),
        ),
        elevation: 0,
        backgroundColor: kgreyFill,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: PopupMenuButton<String>(
          //     child: Icon(
          //       Icons.change_circle_outlined,
          //       color: kblack,
          //     ),
          //     onSelected: (value) =>
          //         videoController.videoApiCall(code: value),
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //       PopupMenuItem<String>(
          //         onTap: () {
          //           videoController.language = "en";
          //         },
          //         value: 'en',
          //         child: Text('English'),
          //       ),
          //       PopupMenuItem<String>(
          //         onTap: () {
          //           videoController.language = "bn";
          //         },
          //         value: 'bn',
          //         child: Text('Bangla'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  itemCount: widget.videos?.length,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    Datum? videos = widget.videos?[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: VideoWidget(data: videos),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final Datum? data;
  const VideoWidget({super.key, this.data});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    // String dates =
    // DateFormat("MMM d, yyyy h:mm", Localizations.localeOf(context).toString()).format((widget.data?.getDate())!);
    String formattedDate = DateFormat(
            "MMM d, yyyy h:mm", Localizations.localeOf(context).toString())
        .format((widget.data?.getDate())!);
    if (languagecode() == "hi") {
      formattedDate = formattedDate.replaceAllMapped(
          RegExp(r'[0-9]'), (match) => getHindiNumber(match.group(0) ?? "0"));
    } else if (languagecode() == "or") {
      formattedDate = formattedDate.replaceAllMapped(
          RegExp(r'[0-9]'), (match) => getOdiaNumber(match.group(0) ?? "0"));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          MixpanelController.logScreen(MixpanelController.PageDiscover,
              properties: {"Youtube Video": widget.data?.videoTitleLang});
          launchUrl(Uri.parse(widget.data?.videoUrl ?? ""),
              mode: LaunchMode.externalApplication);
        },
        child: Card(
          elevation: 2.5,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                  // width: screenwidth(context, dividedby: 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fadeInCurve: Curves.bounceIn,
                      imageUrl: widget.data?.videoImage ?? "",
                      cacheKey: widget.data?.videoImage ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                          child: Image.asset(
                        'assets/no-photo.png',
                        fit: BoxFit.cover,
                      )),
                      errorWidget: (context, url, error) => Center(
                          child: Image.asset(
                        'assets/no-photo.png',
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenwidth(context, dividedby: 1),
                          child: Text(widget.data?.videoTitleLang ?? "",
                              style: TextStyle(
                                  fontFamily: "nunito",
                                  fontWeight: FontWeight.w600,
                                  color: kblack,
                                  fontSize: 15)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(formattedDate,
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.grey)),

                        // TextCustom(
                        //   DateTime.now().toString(),
                        //   kgreyDark,
                        //   14,
                        //   fonntweight: FontWeight.w400,
                        // )
                      ],
                    ),
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
        ),
      ),
    );
  }
}
