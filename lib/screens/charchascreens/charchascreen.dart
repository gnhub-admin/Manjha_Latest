import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/screens/charchascreens/charcha_profile.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/getxcontrollers/charchacontroller.dart';
import 'package:manjha/screens/charchascreens/charchadetailpage.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:share_plus/share_plus.dart';
import '../../getxcontrollers/maincontroller.dart';
import '../../model/suraj_charcha_model.dart';
import 'charchaadd.dart';

//ignore: must_be_immutable
class CharchaScreen extends StatefulWidget {
  ForumType forumType = ForumType.Forum;
  CharchaScreen(this.forumType);

  @override
  _CharchaScreenState createState() => _CharchaScreenState();
}

enum ForumType { Forum, Article }

class ForumTypeLabel {
  ForumType forumType = ForumType.Forum;
  late String forumPageTitle;
  late String forumAddButtonTitle;
  late String forumAddAnswerTitle;
  late String myPageTitle;
  late String myAddButtonTitle;
  late String myPageSubHeading;
  late String addPageTitle;
  late String addTextTitle;
  late String addTextDescription;

  late String detailPageTitle;
  late String detailTextHeading;
  late String detailTextAnswer;
  late String detailTextAnswerHint;

  String profilePhoto = '';
  bool hasProfilePhoto() {
    return (profilePhoto.isNotEmpty);
  }

  setProfilePhoto(String photo) {
    profilePhoto = photo;
  }

  String getProfilePhoto() {
    return profilePhoto;
  }

  bool isForum() {
    return forumType == ForumType.Forum;
  }

  bool isArticle() {
    return forumType == ForumType.Article;
  }

  ForumTypeLabel(this.forumType) {
    switch (forumType) {
      case ForumType.Forum:
        forumPageTitle = 'Sawal Jawab';
        forumAddButtonTitle = '${translate("Ask Your Question (सवाल पूछें)")}';
        forumAddAnswerTitle = 'Write your answer';
        myPageTitle = 'Profile';
        myAddButtonTitle = '${translate("Ask Your Question")}';
        myPageSubHeading = 'My Posts';
        addPageTitle = 'Post your question';
        addTextTitle = 'Title';
        addTextDescription = 'Write your question';
        detailPageTitle = 'Sawal Jawab';
        detailTextHeading = 'Sawal Jawab';
        detailTextAnswer = 'Answer';
        detailTextAnswerHint = 'Write your answer';
        break;

      case ForumType.Article:
      default:
        forumPageTitle = 'Matsya Gyan';
        forumAddButtonTitle = 'Apka Matsya Gyan Sajha Karain';
        forumAddAnswerTitle = 'Comment here';

        myPageTitle = 'Profile';
        myAddButtonTitle = 'Apka Matsya Gyan Sajha Karain';
        myPageSubHeading = 'My Articles';

        addPageTitle = 'Apka Matsya Gyan Sajha Karain';
        addTextTitle = 'Title of article';
        addTextDescription = 'Write something here...';

        detailPageTitle = 'Matsya Gyan';
        detailTextHeading = 'Matsya Gyan';
        detailTextAnswer = 'Comment';
        detailTextAnswerHint = 'Write your comment';
        break;
    }
  }
}

class _CharchaScreenState extends State<CharchaScreen>
    with SingleTickerProviderStateMixin {
  CharchaController charCha = Get.put(CharchaController());
  MainController m = Get.put(MainController());

  ForumTypeLabel label = ForumTypeLabel(ForumType.Forum);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if (m.thirdscreen.isFalse) {
      charCha.charChaCall.value = false;
      label = ForumTypeLabel(widget.forumType);
      if (charCha.charChaCall.isFalse) {
        charCha.getcharchaApiCall(page: charCha.currentPage);
      }
      // this._fetchData();
      super.initState();
      loadSession();
      m.thirdscreen.value = true;
    }
    // Common.analytics.setCurrentScreen(screenName: 'CharchaScreen');
  }

  loadSession() async {
    String customerPhotoUrl = await saveUser()?.data?.customerPhoto ?? "";
    String defaultUrl = image_customer_url;

    this.profilePhoto = "$defaultUrl$customerPhotoUrl";
    setState(() {});
  }

  String profilePhoto = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolorcart,
        // appBar: AppBar(
        //   backgroundColor: Colors.grey.shade100,
        //   automaticallyImplyLeading: false,
        //   title:
        //   centerTitle: true,
        //   elevation: 0,
        //   // actions: [
        //   //   (label.hasProfilePhoto())
        //   //       ? GestureDetector(
        //   //           onTap: () async {
        //   //             // bool blnResult = await Navigator.push(context,
        //   //             //     MaterialPageRoute(builder: (_) {
        //   //             //   return ForumMy(this.label);
        //   //             // }));
        //   //             // if (blnResult != null && blnResult) {
        //   //             //   _fetchData();
        //   //             // }
        //   //           },
        //   //           child: Container(
        //   //             margin: EdgeInsets.all(10),
        //   //             decoration: BoxDecoration(
        //   //                 color: kwhite,
        //   //                 borderRadius: BorderRadius.circular(30),
        //   //                 boxShadow: const [
        //   //                   BoxShadow(color: Colors.grey, blurRadius: 2)
        //   //                 ]),
        //   //             child: ClipOval(
        //   //                 child: Image.network(
        //   //               label.getProfilePhoto(),
        //   //               // "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
        //   //               fit: BoxFit.cover,
        //   //               height: 30,
        //   //               width: 35,
        //   //             )),
        //   //           ),
        //   //         )
        //   //       : const SizedBox(),
        //   //   Container(
        //   //     padding: EdgeInsets.only(right: 5),
        //   //     margin: EdgeInsets.only(right: 10),
        //   //     child: MaterialButton(
        //   //         child: Icon(
        //   //           Icons.person_outline,
        //   //           color: kheader,
        //   //           size: 18,
        //   //         ),
        //   //         minWidth: 25,
        //   //         visualDensity: VisualDensity.compact,
        //   //         color: Colors.white,
        //   //         elevation: 0,
        //   //         shape: CircleBorder(),
        //   //         onPressed: () async {
        //   //           ForumTypeLabel label = new ForumTypeLabel(ForumType.Forum);
        //   //           label.setProfilePhoto(
        //   //               await saveUser()?.data?.customerPhoto ?? "");
        //   //           bool blnResult = await Navigator.push(context,
        //   //               MaterialPageRoute(builder: (_) {
        //   //             // return ForumMy(label);
        //   //             return CharchaProfile(label);
        //   //           }));
        //   //           if (blnResult != '' && blnResult) {
        //   //             // _fetchData();
        //   //           }
        //   //         }),
        //   //   ),
        //   // ],
        // ),
        body: GetBuilder<CharchaController>(
          builder: (charCha) => charCha.charChaCall.isFalse
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kheader,
                  ),
                )
              : LazyLoadScrollView(
                  onEndOfPage: () {
                    charCha.getcharchaApiCall(page: charCha.currentPage);
                  },
                  child: RefreshIndicator(
                    onRefresh: () {
                      charCha.forumList.clear();
                      return charCha.getcharchaApiCall(page: 1);
                    },
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        itemCount: charCha.forumList.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Get.to(() => ForumAdd(label));
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          label.forumPageTitle.tr,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: kblack),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.to(CharchaProfile(label));
                                          },
                                          icon: Icon(Icons.person_2_outlined))
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 5, bottom: 5, right: 10),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (_) => Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50, right: 50),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              profilePhoto),
                                                          fit: BoxFit.contain),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor:
                                                cartbackgroundcolor,
                                            foregroundImage: NetworkImage(
                                                image_customer_url +
                                                    (saveUser()
                                                            ?.data
                                                            ?.customerPhoto ??
                                                        "")),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Card(
                                            elevation: 0,
                                            child: Container(
                                              // padding: EdgeInsets.all(7.5),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.transparent,
                                                      width: 0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7.5),
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 7.5,
                                                                vertical: 7),
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Color(0xffD1D3D5),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(() =>
                                                                ForumAdd(
                                                                    label));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  label
                                                                      .myAddButtonTitle,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff6F6F6F),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .location,
                                                                  size: 16,
                                                                  color: Colors
                                                                      .grey,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (index == charCha.forumList.length) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 35),
                                child: CircularProgressIndicator(
                                  color: kheader,
                                ),
                              ),
                            );
                          } else {
                            return populateItem(charCha.forumList[index - 1]);
                          }
                        },
                        controller: scrollController,
                      ),
                    ),
                  ),
                ),
        ));
  }

  populateItem(Forumdd forumItem) {
    String dates =
        DateFormat("dd-MM-yyyy", Localizations.localeOf(context).toString())
            .format(forumItem.createdAt ?? DateTime.now());
    return GestureDetector(
      onTap: () {
        Get.to(() => ForumDetailPage(forumItem, label))?.then((value) {
          charCha.forumList.clear();
          charCha.getcharchaApiCall(page: 0);
        });
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12.5, vertical: 7),
        elevation: 0,
        child: Container(
          // margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.white,
                leading:
                    // saveUser()?.data?.id == forumItem.customerId ? Padding(
                    //   padding: const EdgeInsets.only(top: 15),
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.grey,
                    //     foregroundImage: NetworkImage(forumItem.getCustomerPhoto()),
                    //   ),
                    // ):
                    InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      forumItem.getCustomerPhoto()),
                                  fit: BoxFit.contain),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: cartbackgroundcolor,
                    foregroundImage: NetworkImage(forumItem.getCustomerPhoto()),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      saveUser()?.data?.id == forumItem.customerId
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${forumItem.customerName ?? ""}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    dates,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10),
                                  ),
                                  // Text(" · 1d",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${forumItem.customerName ?? ""}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  dates,
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await Share.share(forumItem
                                  .getShareLink(forumItem.customerName ?? ""));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: kheader,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: saveUser()?.data?.id !=
                                forumItem.customerId, // USER ARE DIFFERENT
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 20,
                                  alignment: Alignment.centerRight,
                                  child: PopupMenuButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        CupertinoIcons.ellipsis,
                                        size: 22,
                                        color: kheader,
                                      ),
                                      onSelected: (value) {
                                        if (value == 'report') {
                                          showReportAbuse(forumItem.id);
                                          // EasyLoading.showToast(
                                          //     'Report has been submitted successfully.');
                                        } else if (value == 'block') {
                                          // this._fetchDelete(forumDetailItem.id);
                                          charCha.getblock(
                                              customerid: forumItem.customerId
                                                  .toString());
                                          // this._fetchForumBlocked(
                                          //     forumItem.customer_id);
                                          // EasyLoading.showToast(
                                          //     'User has been blocked.');
                                        }
                                      },
                                      itemBuilder: (context) => [
                                            PopupMenuItem<String>(
                                              value: 'report',
                                              child: Text(
                                                  '${translate("Report")}'),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'block',
                                              child: Text(
                                                  '${translate("Block User")}'),
                                            ),
                                          ]),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: saveUser()?.data?.id ==
                                forumItem.customerId, // USER ARE DIFFERENT
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 25,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton<String>(
                                      icon: Icon(
                                        CupertinoIcons.ellipsis,
                                        color: kheader,
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ],
                                      onSelected: (String value) async {
                                       await charCha.getforumQuestionsdelete(
                                            questionid:
                                                forumItem.id.toString());
                                        charCha.forumList.clear();
                                        charCha.getcharchaApiCall(page: 1);
                                      },
                                    ),
                                    // Icon(CupertinoIcons.ellipsis_vertical),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    label.isForum()
                        ? Text(forumItem.question ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kblack, fontSize: 12.0))
                        : Container(),
                    forumItem.hasDescription()
                        ? Text(forumItem.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kgreyDark, fontSize: 12.0))
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  children: [
                    forumItem.hasImage()
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            alignment: AlignmentDirectional.centerStart,
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                image: DecorationImage(
                                  image: NetworkImage(forumItem.getImageURL()),
                                  fit: BoxFit.cover,
                                )),
                            // child: Image(
                            //             image: NetworkImage(
                            //                 'https://manjha.in/public/news/1621076362.png')),
                          )
                        : SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  charCha.getlikedislike(
                                      questionsid: forumItem.id.toString());
                                  setState(() {
                                    forumItem.likedId = forumItem.likedId! > 0
                                        ? 0
                                        : saveUser()?.data?.id;
                                    forumItem.likedId = forumItem.likedId! > 0
                                        ? forumItem.totalLiked =
                                            (forumItem.totalLiked! + 1)
                                        : forumItem.totalLiked =
                                            (forumItem.totalLiked! - 1);
                                    print(forumItem.totalLiked);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        (forumItem.likedId ?? 0) > 0
                                            ? CupertinoIcons.hand_thumbsup_fill
                                            : CupertinoIcons.hand_thumbsup,
                                        color: kheader,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        translate("Like"),
                                        style: TextStyle(
                                            color: kheader,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Get.to(() => ForumDetailPage(forumItem, label));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.chat_bubble,
                                      color: kheader,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      translate('Comment'),
                                      style: TextStyle(
                                          color: kheader,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () async {
                              //     await Share.share(forumItem.getShareLink(forumItem.customerName ?? ""));
                              //   },
                              //   child: Row(
                              //     children: [
                              //       Icon(
                              //         CupertinoIcons.location,
                              //         color: kheader,
                              //         size: 18,
                              //       ),
                              //       SizedBox(
                              //         width: 5,
                              //       ),
                              //       Text(
                              //         translate('Send'),
                              //         style: TextStyle(color: kheader, fontWeight: FontWeight.w400, fontSize: 14),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${forumItem.totalLiked == 1 ? "${forumItem.totalLiked} Like" : "${forumItem.totalLiked} Like"}  · ${forumItem.getComments()}",
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 5),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         "${forumItem.getLikes()} · ${forumItem.getComments()}",
                    //         style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600, fontSize: 10),
                    //       ),
                    //       Text(
                    //         dates,
                    //         style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600, fontSize: 10),
                    //       ),
                    //       // NormalText(forumItem.getFormattedDate(), kgreyDark, 14),
                    //     ],
                    //   ),
                    // ),
                    Visibility(
                        visible: forumItem.comments!.length > 0,
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey,
                              height: 0,
                              thickness: 0.25,
                            ),
                            ListView.builder(
                                itemCount: forumItem.comments?.length ?? 0,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                primary: false,
                                physics: const NeverScrollableScrollPhysics(),
                                // separatorBuilder: (context, index) {
                                //   return const Divider(
                                //     color: Colors.grey,height: 0,thickness: 5,
                                //   );
                                // },
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: RichText(
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 0.9,
                                      maxLines: 2,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "${forumItem.comments?[index].getName()} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: forumItem.comments?[index]
                                                      .answer ??
                                                  "",
                                              style:
                                                  TextStyle(color: kgreyDark))
                                        ],
                                      ),
                                    ),
                                  );
                                  //   Row(
                                  //   children: [
                                  //     Container(
                                  //       height: 30,
                                  //       width: 30,
                                  //       decoration: BoxDecoration(
                                  //           image: DecorationImage(
                                  //               fit: BoxFit.fitWidth,
                                  //               image: NetworkImage(forumItem.comments?[index].getCustomerPhoto() ?? "")),
                                  //           borderRadius: BorderRadius.circular(100)),
                                  //     ),
                                  //     const SizedBox(width: 10),
                                  //     Expanded(
                                  //         child: Column(
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             BoldText(forumItem.comments?[index].getName(), 14, kblack,
                                  //                 overflow: TextOverflow.visible),
                                  //             Text(forumItem.comments?[index].answer ?? "",
                                  //                 maxLines: 2,
                                  //                 overflow: TextOverflow.ellipsis,
                                  //                 style: TextStyle(color: kgreyDark, fontSize: 16.0)),
                                  //           ],
                                  //         )),
                                  //   ],
                                  // );
                                }),
                          ],
                        )),
                    Divider(
                      color: Colors.grey,
                      height: 0,
                      thickness: 0.25,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 0.9,
                      maxLines: 2,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "Add Your Comment",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10,bottom: 10),
                    //   child: RichText(
                    //     softWrap: true,
                    //     overflow: TextOverflow.ellipsis,
                    //     textScaleFactor: 0.9,
                    //     maxLines: 2,
                    //     text: TextSpan(
                    //       children: <TextSpan>[
                    //         TextSpan(
                    //             text: forumItem.comments?[index].getName(),
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.bold)),
                    //         TextSpan(
                    //             text:
                    //             forumItem.comments?[index].answer ?? "",
                    //             style: TextStyle(color: kgreyDark))
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              /**/
            ],
          ),
        ),
      ),
    );
    //   Padding(
    //   padding: const EdgeInsets.fromLTRB(0, 8, 0, 4), //const EdgeInsets.all(8.0),
    //   child: InkWell(
    //     onTap: () async {
    //       Get.to(ForumDetailPage(forumItem, label));
    //     },
    //     child: Container(
    //       //height: 100,
    //       width: double.infinity,
    //       child: Card(
    //         margin: const EdgeInsets.all(0),
    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), //15
    //         elevation: 0.5,
    //         child: Padding(
    //           padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    //           child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: <Widget>[
    //                 Row(
    //                   children: [
    //                     Container(
    //                       height: 50,
    //                       width: 50,
    //                       decoration: BoxDecoration(
    //                           image: DecorationImage(
    //                               fit: BoxFit.fitWidth, image: NetworkImage(forumItem.getCustomerPhoto())),
    //                           borderRadius: BorderRadius.circular(100)),
    //                     ),
    //                     const SizedBox(width: 10),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Container(
    //                           width: 250,
    //                           child:
    //                               BoldText(forumItem.customerName ?? "", 16, kblack, overflow: TextOverflow.ellipsis),
    //                         ),
    //                         NormalText(forumItem.getFormattedDate(), kgreyDark, 14),
    //                       ],
    //                     ),
    //                     const Spacer(),
    //                     Visibility(
    //                       visible: saveUser()?.data?.id != forumItem.customerId, // USER ARE DIFFERENT
    //                       child: PopupMenuButton(
    //                           icon: const Icon(Icons.more_vert),
    //                           onSelected: (value) {
    //                             if (value == 'report') {
    //                               showReportAbuse(forumItem.id);
    //                               // EasyLoading.showToast(
    //                               //     'Report has been submitted successfully.');
    //                             } else if (value == 'block') {
    //                               // this._fetchDelete(forumDetailItem.id);
    //                               charCha.getblock(customerid: forumItem.customerId.toString());
    //                               // this._fetchForumBlocked(
    //                               //     forumItem.customer_id);
    //                               // EasyLoading.showToast(
    //                               //     'User has been blocked.');
    //                             }
    //                           },
    //                           itemBuilder: (context) => [
    //                                 const PopupMenuItem<String>(
    //                                   value: 'report',
    //                                   child: Text('Report'),
    //                                 ),
    //                                 const PopupMenuItem<String>(
    //                                   value: 'block',
    //                                   child: Text('Block User'),
    //                                 ),
    //                               ]),
    //                     )
    //                   ],
    //                 ),
    //                 const SizedBox(height: 10),
    //                 // BoldText(forumItem.question, 18.0, kblack),
    //                 label.isArticle()
    //                     ? Text(forumItem.question ?? '',
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                         style: TextStyle(color: kblack, fontSize: 16.0))
    //                     : Text(forumItem.question ?? "",
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                         style: TextStyle(color: kgreyDark, fontSize: 16.0)),
    //                 forumItem.hasDescription()
    //                     ? Text(forumItem.description ?? "",
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                         style: TextStyle(color: kgreyDark, fontSize: 16.0))
    //                     : Container(),
    //                 forumItem.hasImage()
    //                     ? Container(
    //                         height: 180,
    //                         decoration: BoxDecoration(
    //                             image:
    //                                 DecorationImage(fit: BoxFit.fitWidth, image: NetworkImage(forumItem.getImageURL())),
    //                             borderRadius: const BorderRadius.all(Radius.circular(8.0))),
    //                         // child: Image(
    //                         //     image: NetworkImage(
    //                         //         'https://manjha.in/public/news/1621076362.png')),
    //                       )
    //                     : Container(),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: [
    //                     Row(children: [
    //                       IconButton(
    //                         visualDensity: VisualDensity.compact,
    //                         icon: Icon(forumItem.isLiked() ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
    //                             color: forumItem.isLiked() ? kheader : kheader //kgreyDark
    //                             ),
    //                         onPressed: () {
    //                           charCha.getlikedislike(questionsid: forumItem.id.toString());
    //                         },
    //                       ),
    //                       GestureDetector(
    //                           // onTap: () =>
    //                           //     this._fetchLikeUnLike(forumItem.id),
    //                           child: Container(
    //                         child: NormalText(forumItem.getLikes(), kheader, 12),
    //                       )),
    //                     ]),
    //                     Row(children: [
    //                       IconButton(
    //                         visualDensity: VisualDensity.compact,
    //                         icon: Icon(FontAwesomeIcons.comment, color: kheader),
    //                         onPressed: () async {
    //                           Get.to(ForumDetailPage(forumItem, label));
    //                         },
    //                       ),
    //                       NormalText(forumItem.getComments(), kheader, 12),
    //                     ]),
    //                     Row(
    //                       children: [
    //                         IconButton(
    //                           visualDensity: VisualDensity.compact,
    //                           icon: Icon(FontAwesomeIcons.shareNodes, color: kheader),
    //                           onPressed: () async {
    //                             EasyLoading.show();
    //                             await Share.share(forumItem.getShareLink(forumItem.customerName ?? ""));
    //                             EasyLoading.dismiss();
    //                           },
    //                         ),
    //                         GestureDetector(onTap: () async {}, child: NormalText('Share', kgreyDark, 12)),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 Visibility(
    //                     visible: forumItem.comments!.length > 0,
    //                     child: Container(
    //                       margin: const EdgeInsets.only(top: 8),
    //                       padding: const EdgeInsets.all(8),
    //                       decoration: BoxDecoration(
    //                         color: kgreyFill,
    //                         borderRadius: BorderRadius.circular(8),
    //                         // border: Border(
    //                         //     top: BorderSide(color: kgreyFill))
    //                       ),
    //                       child: ListView.separated(
    //                           itemCount: forumItem.comments?.length ?? 0,
    //                           shrinkWrap: true,
    //                           primary: false,
    //                           physics: const NeverScrollableScrollPhysics(),
    //                           separatorBuilder: (context, index) {
    //                             return const Divider();
    //                           },
    //                           itemBuilder: (context, index) {
    //                             return Row(
    //                               children: [
    //                                 Container(
    //                                   height: 30,
    //                                   width: 30,
    //                                   decoration: BoxDecoration(
    //                                       image: DecorationImage(
    //                                           fit: BoxFit.fitWidth,
    //                                           image: NetworkImage(forumItem.comments?[index].getCustomerPhoto() ?? "")),
    //                                       borderRadius: BorderRadius.circular(100)),
    //                                 ),
    //                                 const SizedBox(width: 10),
    //                                 Expanded(
    //                                     child: Column(
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     BoldText(forumItem.comments?[index].getName(), 14, kblack,
    //                                         overflow: TextOverflow.visible),
    //                                     Text(forumItem.comments?[index].answer ?? "",
    //                                         maxLines: 2,
    //                                         overflow: TextOverflow.ellipsis,
    //                                         style: TextStyle(color: kgreyDark, fontSize: 16.0)),
    //                                   ],
    //                                 )),
    //                               ],
    //                             );
    //                           }),
    //                     ))
    //                 // NormalText("28, Nov at 15:30 pm", kdarkBlue, 12),
    //               ]),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  List<String> listReportReason = [
    'Spam or Fruad',
    'Harmful Activity',
    'Irrelevant or annoying',
    'Racism, Discrimination or Hate speech',
    'Misinformation',
    'Violations of privacy'
  ];

  showReportAbuse(forumId) async {
    final result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        builder: (BuildContext context) {
          // return object of type Dialog
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listReportReason.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listReportReason[index]),
                onTap: () {
                  Navigator.of(context).pop();
                  charCha.getreportreason(
                      reason: listReportReason[index],
                      questionsid: forumId.toString());
                },
              );
            },
          );
        });

    // SELECTED AREA
    if (result == null) return;

    setState(() {});
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("Sorting by $result")));

    // TODO: FILTER DATA AS PER SELECTION
  }

  bool get wantKeepAlive => true;
}
