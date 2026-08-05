import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/model/news_description_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import '../../services/apiconst.dart';
import '../const.dart';
import '../helper.dart';
import 'newspage.dart';

// ignore: must_be_immutable
class NewsDetailPage extends StatefulWidget {
  NewsDescriptionModel _newsItem;

  @override
  NewsDetailPage(this._newsItem);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
    _loadContent();
    print(widget._newsItem);
  }

  _loadContent() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      // htmlContent =
      //     // "<h1>" +
      //     //     widget._newsItem.news_title +
      //     //     "</h1>" +
      //     (widget._newsItem.news_image.isEmpty
      //             ? ""
      //             : "<img src='" + widget._newsItem.getImageUrl() + "' style='width: 100%;'/>") +
      //         "<p>" +
      //         widget._newsItem.news_description +
      //         "</p>";
      isLoading = false;
    });
  }

  var isLoading = false;
  String htmlContent = "<p>Loading...</p>";

  // String htmlString = widget._newsItem.newsDescriptionLang ?? "";

  // String _parseHtmlString(String htmlString) {
  //   final document = parse(htmlString);
  //
  //   final String parsedString = parse(document.body!.text).documentElement!.text;
  //
  //   return parsedString;
  // }

  String _parseHtmlString(String htmlString) {
    // Parse the HTML string
    final document = parse(htmlString);

    // Extract text from the parsed document
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    // Replace the % sign and any surrounding whitespace with just the -
    final String cleanedString = parsedString.replaceAllMapped(
      RegExp(r'\s*%\s*'),
      (match) => '-',
    );

    return cleanedString;
  }

  // String _parseHtmlString(String htmlString) {
  //   String parsedString = htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  //
  //   parsedString = parsedString.replaceAll("&nbsp;", "\n");
  //
  //   parsedString = parsedString.trim();
  //
  //   parsedString = parsedString.replaceAll(RegExp(r'\n+'), '\n');
  //
  //   parsedString = parsedString.replaceAllMapped(
  //       RegExp(r'(\S)\s*(?=\S|$)'), (match) => '${match.group(1)}\n');
  //
  //   return parsedString;
  // }

  NewsItem? newsItem;

  @override
  Widget build(BuildContext context) {
    // String dates =
    // DateFormat("MMM d, yyyy h:mm", Localizations.localeOf(context).toString()).format(widget._newsItem.getDate());
    String formattedDate = DateFormat(
            "MMM d, yyyy h:mm", Localizations.localeOf(context).toString())
        .format(widget._newsItem.getDate());

    if (languagecode() == "hi") {
      formattedDate = formattedDate.replaceAllMapped(
          RegExp(r'[0-9]'), (match) => getHindiNumber(match.group(0) ?? "0"));
    } else if (languagecode() == "or") {
      formattedDate = formattedDate.replaceAllMapped(
          RegExp(r'[0-9]'), (match) => getOdiaNumber(match.group(0) ?? "0"));
    }

    return Scaffold(
        backgroundColor: kgreyFill,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kblack),
          backgroundColor: kwhite,
          elevation: 0,
          // toolbarHeight: 100,
          // title: BoldText(widget._newsItem.news_title, 20, kwhite),
          // title: Text("${widget._newsItem.news_title}",
          //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kwhite),
          // ),
          title: Text(
            "${translate("News Detail")}",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kblack),
          ),
          // bottom: PreferredSize(
          //   preferredSize: Size(0.0, 60.0),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         // BoldText("Latest News", 20, kblack),
          //         NormalText(widget._newsItem.getFormattedDate(), kblack, 12,
          //             textAlign: TextAlign.right),
          //         // BoldText(widget._newsItem.news_title, 16, kblack),
          //       ],
          //     ),
          //   ),
          // ),
          centerTitle: false,
          actions: [
            IconButton(
              tooltip: '${translate("Share")}',
              // icon: Icon(FontAwesomeIcons.shareAlt),
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () async {
                // EasyLoading.show();
                await Share.share(widget._newsItem.getShareLink());
                EasyLoading.dismiss();
              },
            )
          ],
          // elevation: 1.0,
        ),
        body: isLoading
            ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: kheader),
                ),
              )
            : ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                    child: Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(FullScreenImageView(
                                imageUrl: widget._newsItem.getImageUrl(),
                              ));
                            },
                            child: CachedNetworkImage(
                              imageUrl: widget._newsItem.getImageUrl(),
                              cacheKey: widget._newsItem.getImageUrl(),
                              // imageUrl: newsItem?.getImageUrl() ?? "",
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image(
                                        image:
                                            // AssetImage('images/blogpost.png'),
                                            NetworkImage(
                                                widget._newsItem.getImageUrl()),
                                        // height: screenheight(context,
                                        //     dividedby: 3.75),
                                        // width: double.infinity,
                                        fit: BoxFit.cover,
                                      )),
                              placeholder: (context, url) => Container(
                                height: screenheight(context, dividedby: 3.75),
                                width: double.infinity,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: kheader,
                                  strokeWidth: 3,
                                )),
                              ),
                              errorWidget: (context, url, error) =>
                                  // Visibility(
                                  //     visible: false,
                                  //     child: Container(
                                  //       child: Text("Image Loading Error..."),
                                  //     )),
                                  Container(
                                height: screenheight(context, dividedby: 3.75),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/no-photo.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(widget._newsItem.newsTitle ?? "",
                              textScaleFactor: 1.35,
                              style: TextStyle(
                                color: kblack,
                                fontWeight: FontWeight.w500,
                              )),
                          Text(formattedDate,
                              textScaleFactor: 1,
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              print(_parseHtmlString(
                                  widget._newsItem.newsDescriptionLang ?? ""));
                            },
                            child: Text(
                                _parseHtmlString(
                                    widget._newsItem.newsDescriptionLang ?? ""),
                                textScaleFactor: 1.3,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ],
                      )
                      // new HtmlWidget(
                      //   htmlContent,
                      //   // padding: EdgeInsets.all(12.0),
                      //   // onLinkTap: (url) {
                      //   //   print("Opening $url...");
                      //   // },
                      // ),
                      ),
                )),
              ));
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kwhite),
        backgroundColor: kblack,
        // title: Text('View Photo'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
