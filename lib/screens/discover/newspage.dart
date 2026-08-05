import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manjha/model/news_description_model.dart';
import 'package:manjha/services/apiconst.dart';
import '../../getxcontrollers/mixpanelcontroller.dart';
import '../../getxcontrollers/videocontroller.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../helper.dart';
import '../localconst.dart';
import 'newssdetails.dart';

// ignore: must_be_immutable
class NewsPage extends StatefulWidget {
  int? newsCategoryId;
  String? newsTitle = 'Latest News';
  Color? headerColor = kheader;
  String? CategoryName;
  NewsPage({this.newsCategoryId, this.newsTitle, this.headerColor, this.CategoryName});
  @override
  _NewsPageState createState() => _NewsPageState();
}

class NewsItem {
  final int id;
  final String news_title;
  final String news_image;
  final String imageurl;
  final String news_description;
  final int news_category_id;
  final String shareUrl;
  final String color_code;
  final String created_at;

  DateTime getDate() {
    return DateTime.parse(created_at);
  }

  String getImageUrl() {
    return image_news_url + (this.news_image.isEmpty || this.news_image.isEmpty ? "no-photo.png" : this.news_image);
  }

  String getShareLink() {
    return this.news_title +
        '\n' +
        // this.shareUrl +
        '\n\nअधिक जानकारी के लिए मांझा ऐप पर देखिए $app_link या हमारी वेबसाइट विजिट करे http://www.manjha.in';
  }

  Color getColor() {
    if (this.color_code.isEmpty || this.color_code.isEmpty) return kitembg;

    return Common.getHaxColor(this.color_code);
  }

  String getFormattedDate() {
    var formatter = new DateFormat('MMM dd, yyyy'); //'yyyy-MM-dd'
    return formatter.format(getDate());
  }

  NewsItem(
      {required this.id,
      required this.news_title,
      required this.news_image,
      required this.imageurl,
      required this.news_description,
      required this.news_category_id,
      required this.shareUrl,
      required this.color_code,
      required this.created_at});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      news_title: json['news_title_lang'].toString(),
      news_image: json['news_image'].toString(),
      imageurl: json['image_url'].toString(),
      news_description: json['news_description_lang'].toString(),
      news_category_id: json['news_category_id'],
      shareUrl: json['shareUrl'].toString(),
      color_code: json['color_code'].toString(),
      created_at: json['created_at'].toString(),
    );
  }
}

class _NewsPageState extends State<NewsPage> {
  String textCustomerName = "Guest";
  VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    videoController.newsdiscription.clear();

    // videoController.newsdiscription?.clear();
    textCustomerName = saveUser()?.data?.fullName ?? "";

    // this._fetchData();
    // videoController.newsApiCall(categoryid: widget.newsCategoryId!);
    fetchData(widget.newsCategoryId!);
    super.initState();
  }

  void fetchData(int categoryId) async {
    await videoController.newsApiCall(categoryid: categoryId);
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgreyFill,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kwhite),
        backgroundColor: themecolor,
        // title:
        // BoldText("${translate('Latest News')}", 25.0, kwhite),
        // title: Text(
        //   "${this.widget.newsTitle ?? ""}",
        //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kwhite),
        // ),
        title: Text(
          "${this.widget.CategoryName ?? ""}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kwhite),
        ),
        // BoldText(this.widget.newsTitle ?? "", 20, kblack),
        centerTitle: false,
        elevation: 0.0,
      ),
      // body: isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(color: kheader),
      //       )
      //     : ListView.builder(
      //     itemCount: videoController.newsdiscription?.length,
      //     itemBuilder: (context,index) {
      //       return videoController.newsdiscription.map((e) => populateItem(e)).toList();
      //     })
      body: Obx(
        () =>
            // videoController.shownews.isTrue
            //     ? const Center(
            //   child: CircularProgressIndicator(
            //     color: kheader,
            //   ),
            // )
            //     : //SingleChildScrollView(
            //child: Padding(
            //padding: EdgeInsets.only(bottom: 73),
            // child: Column(
            //     children: list.map((forumItem) {
            //   return populateItem(forumItem);
            // }).toList()),
            ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5),
            itemCount: videoController.newsdiscription.length,
            itemBuilder: (context, index) {
              return populateItem(videoController.newsdiscription[index]);
            },
          ),

          // ListView.builder(
          //     padding: EdgeInsets.symmetric(vertical: 5),
          //     itemCount: charCha.forumList.length + 1,
          //     // physics: NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       if (index == 0) {
          //         return InkWell(
          //           overlayColor: MaterialStateProperty.all(Colors.transparent),
          //           borderRadius: BorderRadius.circular(15),
          //           onTap: () {
          //             Get.to(ForumAdd(label));
          //           },
          //           child: Padding(
          //             padding: EdgeInsets.only(left: 15, top: 5,bottom: 5,right: 10),
          //             child: Row(
          //               children: [
          //                 InkWell(
          //                   onTap: () async {
          //                     await showDialog(
          //                       context: context,
          //                       builder: (_) => Center(
          //                         child: Padding(
          //                           padding: const EdgeInsets.only(left: 50, right: 50),
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               shape: BoxShape.circle,
          //                               image: DecorationImage(
          //                                   image: NetworkImage(profilePhoto), fit: BoxFit.contain),
          //                             ),
          //                             child: GestureDetector(
          //                               onTap: () {
          //                                 Navigator.pop(context);
          //                               },
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     );
          //           },
          //                   child: CircleAvatar(
          //                     radius: 18,
          //                     backgroundColor: Colors.grey,
          //                     foregroundImage: NetworkImage(profilePhoto),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //                 Expanded(
          //                   child: Card(
          //                     elevation: 2,
          //                     child: Container(
          //                       // padding: EdgeInsets.all(7.5),
          //                       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //                       decoration: BoxDecoration(
          //                           color: Colors.white,
          //                           border: Border.all(color: Colors.transparent, width: 0),
          //                           borderRadius: BorderRadius.circular(15)),
          //                       child: Container(
          //                         padding: EdgeInsets.symmetric(horizontal: 7.5),
          //                         decoration: BoxDecoration(
          //                           color: Colors.transparent,
          //                           borderRadius: BorderRadius.circular(10),
          //                         ),
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           crossAxisAlignment: CrossAxisAlignment.center,
          //                           children: [
          //                             Expanded(
          //                               child: Container(
          //                                 padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 7),
          //                                 decoration: BoxDecoration(
          //                                   // color: Color(0xffD1D3D5),
          //                                   color: Colors.white,
          //                                   borderRadius: BorderRadius.circular(25),
          //                                 ),
          //                                 child: InkWell(
          //                                   onTap: () {
          //                                     Get.to(ForumAdd(label));
          //                                   },
          //                                   child: Padding(
          //                                     padding: const EdgeInsets.symmetric(horizontal: 5),
          //                                     child: Row(
          //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                       crossAxisAlignment: CrossAxisAlignment.center,
          //                                       children: [
          //                                         Text(
          //                                           label.myAddButtonTitle,
          //                                           style: TextStyle(
          //                                               color: Color(0xff6F6F6F), fontWeight: FontWeight.w500),
          //                                         ),
          //                                         // Icon(CupertinoIcons.location,size: 18,color: Color(0xff6F6F6F),),
          //                                         // Image.asset(
          //                                         //   "assets/vector-profile.png",
          //                                         //   height: 20,
          //                                         // ),
          //                                         Icon(CupertinoIcons.location,size: 16,color: Colors.grey,)
          //                                         // Expanded(
          //                                         //   child: TextFormField(
          //                                         //       controller: textController,
          //                                         //       style: TextStyle(
          //                                         //           fontFamily: "nunito",
          //                                         //           fontWeight: FontWeight.w500,
          //                                         //           color: kgreyDark,
          //                                         //           fontSize: 15.5),
          //                                         //       decoration: InputDecoration(
          //                                         //         // filled: true,
          //                                         //         // fillColor: Colors.grey.shade100,
          //                                         //         suffix: Padding(
          //                                         //           padding: const EdgeInsets.only(right: 10),
          //                                         //           child: Icon(CupertinoIcons.location,color: Colors.grey,size: 18,),
          //                                         //         ),
          //                                         //           hintText: label.myAddButtonTitle,
          //                                         //           hintStyle: TextStyle(
          //                                         //               fontFamily: "nunito",
          //                                         //               fontWeight: FontWeight.w500,
          //                                         //               color: kgreyDark,
          //                                         //               fontSize: 15.5),
          //                                         //           contentPadding: const EdgeInsets.only(
          //                                         //               left: 10, bottom: 0, top: 0),
          //                                         //           focusColor: Colors.grey.shade700,
          //                                         //           focusedBorder: OutlineInputBorder(
          //                                         //             borderSide: BorderSide.none,
          //                                         //             borderRadius: BorderRadius.circular(15.0),
          //                                         //           ),
          //                                         //           enabledBorder: OutlineInputBorder(
          //                                         //             borderSide: BorderSide.none,
          //                                         //             borderRadius: BorderRadius.circular(15.0),
          //                                         //           ))),
          //                                         // ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       } else {
          //         return populateItem(charCha.forumList[index - 1]);
          //       }
          //     },
          //   ),
        ),
      ),
      /*isLoading
          ? Center(
        child: CircularProgressIndicator(color: kheader),
      )
          : videoController.newsdiscription == null || videoController.newsdiscription!.isEmpty || videoController.newsdiscription?.length == 0
          ? getNoRecordBox()
          :
      ListView.builder(
        itemCount: videoController.newsdiscription!.length,
        itemBuilder: (BuildContext context, int index) {
          return populateItem(videoController.newsdiscription![index]);
        },
      ),*/
      // SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             Column(
      //                 children: list.length == 0
      //                     ? this.getNoRecordBox()
      //                     : list.map((newsItem) => populateItem(newsItem)).toList()
      //             ),
      //           ],
      //         ),
      //       )
    );
  }

  Widget getNoRecordBox() {
    return Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: NormalText("No data found", kblack, 16.0),
          ),
        ));
  }



  Widget populateItem(NewsDescriptionModel newsItem) {
    String formattedDate =
        DateFormat("MMM d, yyyy h:mm", Localizations.localeOf(context).toString()).format(newsItem.getDate());
    if(languagecode() == "hi"){
     formattedDate = formattedDate.replaceAllMapped(RegExp(r'[0-9]'), (match) => getHindiNumber(match.group(0) ?? "0"));}
    else if(languagecode() == "or") {
      formattedDate = formattedDate.replaceAllMapped(RegExp(r'[0-9]'), (match) => getOdiaNumber(match.group(0) ?? "0"));}

    return Padding(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 4), //const EdgeInsets.all(8.0),
        child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              MixpanelController.logScreen(MixpanelController.PageNewsDetails,
                  properties: {"News Title": newsItem.newsTitleLang});
              print(newsItem.newsTitle);
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return NewsDetailPage(newsItem);
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: kwhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Container(
                        //   height: 75.0,
                        //   width: 75.0,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8),
                        //       image: DecorationImage(image: NetworkImage(newsItem.imageurl))),
                        // ),
                        /**/
                        // Stack(
                        //   children: [
                        //     Container(
                        //       height: 75.0,
                        //       width: 75.0,
                        //       alignment: Alignment.center,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8),
                        //         image: DecorationImage(
                        //           image: NetworkImage(newsItem.imageurl),
                        //           fit: BoxFit.cover,
                        //           onError: (_, __) {
                        //             setState(() {
                        //               imageLoading = false;
                        //             });
                        //           },
                        //
                        //           onImageLoad: (_, __) {
                        //             setState(() {
                        //               imageLoading = false;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //     if (imageLoading)
                        //     Positioned.fill(
                        //       child: Center(
                        //         child: CircularProgressIndicator(),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        /**/
                        CachedNetworkImage(
                          imageUrl: newsItem.getImageUrl(),
                          cacheKey: newsItem.getImageUrl(),
                          imageBuilder: (context, imageProvider) => ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image(
                                image:
                                    // AssetImage('images/blogpost.png'),
                                    NetworkImage(newsItem.getImageUrl()),
                                height: 80.0,
                                width: 80.0,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )),
                          placeholder: (context, url) => Container(
                            height: 80.0,
                            width: 80.0,
                            alignment: Alignment.center,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: kheader,
                              strokeWidth: 3,
                            )),
                          ),
                          // errorWidget: (context, url, error) =>
                          //     Visibility(
                          //         visible: false,
                          //         child: Container(
                          //           child: Text("Image Loading Error..."),
                          //         )),
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
                                image: DecorationImage(image: AssetImage("assets/no-photo.png"), fit: BoxFit.cover)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: screenwidth(context, dividedby: 1),
                                child: Text(newsItem.newsTitle ?? "",
                                    style: TextStyle(
                                        fontFamily: "nunito",
                                        fontWeight: FontWeight.w600,
                                        color: kblack,
                                        fontSize: 15)),
                              ),
                              // Text(newsItem.newsTitle ?? "",
                              //     textScaleFactor: 1.35,
                              //     maxLines: 1,
                              //     softWrap: true,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: TextStyle(
                              //       color: kblack,
                              //       fontWeight: FontWeight.w500,
                              //     )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(formattedDate, textScaleFactor: 1, style: TextStyle(color: Colors.grey)),
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
                  // Container(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         // RichText(text: TextSpan(text: newsItem.news_description)),
                  //         Expanded(
                  //             child: NormalText(
                  //                 newsItem.news_title, kdarkBlue, 14)),
                  //         MaterialButton(
                  //             child: Icon(
                  //               FontAwesomeIcons.shareAlt,
                  //               color: kdarkBlue,
                  //               size: 18,
                  //             ),
                  //             minWidth: 40,
                  //             color: Colors.white,
                  //             elevation: 6,
                  //             shape: CircleBorder(),
                  //             onPressed: () async {
                  //               EasyLoading.show();
                  //               await Share.share(newsItem.getShareLink());
                  //               EasyLoading.dismiss();
                  //               // getSellerWhatApp(saleitem.id);
                  //             }),
                  //       ],
                  //     )),
                ],
              ),
            )));
  }

  List<NewsDescriptionModel> list = [];
  var isLoading = false;
  bool imageLoading = true;

  // _fetchData() async {
  //   if (mounted)
  //     setState(() {
  //       isLoading = true;
  //     });
  //   var request =
  //       http.Request('GET', Uri.parse('$baseUrl2${languagecode()}/news?news_category_id=${widget.newsCategoryId}'));
  //   request.bodyFields = {};
  //   request.headers.addAll(<String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Cookie': Common.getCookie().toString()
  //     // "content-type": "application/x-www-form-urlencoded",
  //   });
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     String responseBody = await response.stream.bytesToString();
  //
  //     List<dynamic> data = json.decode(responseBody)['data'];
  //     // list = data.map((item) => NewsItem.fromJson(item)).toList();
  //     if (mounted)
  //       setState(() {
  //         isLoading = false;
  //       });
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
}
