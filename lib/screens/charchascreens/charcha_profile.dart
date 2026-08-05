import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:manjha/model/my_forum_response_model.dart';
import '../../getxcontrollers/charchacontroller.dart';
import '../../languagetranslation/apptranslation.dart';
import '../../model/charcharesponse.dart';
import '../../services/apiconst.dart';
import 'charchaadd.dart';
import 'charchascreen.dart';
import '../const.dart';
import '../helper.dart';

// ignore: must_be_immutable
class CharchaProfile extends StatefulWidget {
  ForumTypeLabel label;
  CharchaProfile(this.label);

  @override
  State<CharchaProfile> createState() => _CharchaProfileState();
}

class _CharchaProfileState extends State<CharchaProfile> {
  CharchaController charCha = Get.put(CharchaController());

  @override
  void initState() {
    this.loadSession();
    charCha.getMyForumApiCall();
    super.initState();
  }

  loadSession() async {
    String customerPhotoUrl = await saveUser()?.data?.customerPhoto ?? "";
    String defaultUrl = image_customer_url;

    this.customerName = await saveUser()?.data?.fullName ?? '';
    // this.profilePhoto = await saveUser()?.data?.customerPhoto ?? "";
    this.profilePhoto = "$defaultUrl$customerPhotoUrl";
    print("Profile Pik ${profilePhoto}");
    this.customerCity = await saveUser()?.data?.cityname ?? '';
    setState(() {});
  }

  TextEditingController textController = TextEditingController();

  String profilePhoto = '';
  String customerName = '';
  String customerCity = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ForumTypeLabel label = ForumTypeLabel(ForumType.Forum);
  String _textCustImageUrl = "no-photo.png";

  Forum? forumItem;

  int count = 169;

  bool tapped = false;

  final List<String> userName = [
    "Alex Costa",
    "Abdullah Fazal",
    "Robby Jan",
    "Manish Malhotra",
    "Deep Patel"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: cartbackgroundcolor,
      appBar: AppBar(
        backgroundColor: cartbackgroundcolor,
        automaticallyImplyLeading: true,
        title: Text(
          label.myPageTitle,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: kblack),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //         vertical: screenheight(context, dividedby: 45)),
              //     child: Material(
              //         elevation: 2,
              //         shape: CircleBorder(
              //             side: BorderSide(width: 1, color: Colors.grey)),
              //         clipBehavior: Clip.antiAlias,
              //         color: Colors.transparent,
              //         child: profilePhoto.isNotEmpty
              //             ? Ink.image(
              //                 image: NetworkImage(profilePhoto),
              //                 fit: BoxFit.contain,
              //                 width: 150,
              //                 height: 150,
              //                 child: InkWell(
              //                   radius: 0,
              //                   onTap: () async {
              //                     await showDialog(
              //                       context: context,
              //                       builder: (_) => Center(
              //                         child: Padding(
              //                           padding: const EdgeInsets.only(
              //                               left: 50, right: 50),
              //                           child: Container(
              //                             decoration: BoxDecoration(
              //                               shape: BoxShape.circle,
              //                               image: DecorationImage(
              //                                   image:
              //                                       NetworkImage(profilePhoto),
              //                                   fit: BoxFit.contain),
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
              //                   },
              //                 ),
              //               )
              //             : Ink.image(
              //                 image: NetworkImage(
              //                     image_customer_url + _textCustImageUrl),
              //                 fit: BoxFit.contain,
              //                 width: 150,
              //                 height: 150,
              //                 child: InkWell(
              //                   radius: 0,
              //                   onTap: () async {
              //                     await showDialog(
              //                       context: context,
              //                       builder: (_) => Center(
              //                         child: Padding(
              //                           padding: const EdgeInsets.only(
              //                               left: 50, right: 50),
              //                           child: Container(
              //                             decoration: BoxDecoration(
              //                               shape: BoxShape.circle,
              //                               image: DecorationImage(
              //                                   image: NetworkImage(
              //                                       image_customer_url +
              //                                           _textCustImageUrl),
              //                                   fit: BoxFit.contain),
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
              //                   },
              //                 ),
              //               )),
              //   ),
              // ),
              InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Get.to(() => ForumAdd(label));
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(profilePhoto),
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
                          backgroundColor: cartbackgroundcolor,
                          foregroundImage: NetworkImage(profilePhoto),
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
                                    color: Colors.transparent, width: 0),
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 7.5),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7.5, vertical: 7),
                                      decoration: BoxDecoration(
                                        // color: Color(0xffD1D3D5),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => ForumAdd(label));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                label.myAddButtonTitle,
                                                style: TextStyle(
                                                    color: Color(0xff6F6F6F),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Icon(
                                                CupertinoIcons.location,
                                                size: 16,
                                                color: Colors.grey,
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "${label.myPageSubHeading}",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              GetBuilder<CharchaController>(
                builder: (charCha) => charCha.charChaCall.isFalse
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: kheader, strokeWidth: 2),
                      )
                    : //SingleChildScrollView(
                    //child: Padding(
                    //padding: EdgeInsets.only(bottom: 73),
                    // child: Column(
                    //     children: list.map((forumItem) {
                    //   return populateItem(forumItem);
                    // }).toList()),
                charCha.myForumList.length == 0 ? Column(
                  children: [
                    SizedBox(height: screenheight(context,dividedby: 5),),
                    Center(child: Text("No Post Available",style: TextStyle(color: kblack,fontSize: 20,fontWeight: FontWeight.w600),)),
                  ],
                ) : Container(
                        height: MediaQuery.of(context).size.height,
                        child: ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: ListView.builder(
                            // padding: EdgeInsets.symmetric(vertical: 5),
                            itemCount: charCha.myForumList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (charCha.myForumList.length == 0 ||
                                  charCha.myForumList.isEmpty) {
                                return Center(
                                  child: Text("No Posts Yet Made!!!"),
                                );
                              } else {
                                return populateItem(charCha.myForumList[index]);
                              }
                            },
                          ),
                        ),
                      ),
              ),
              // ListView.separated(
              //   shrinkWrap: true,
              //   // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: userName.length,
              //   itemBuilder: (context, index) {
              //     return GestureDetector(
              //       onTap: () {
              //       },
              //       child: Container(
              //         margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(20)
              //         ),
              //         child: Column(
              //           children: [
              //             ListTile(
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(20)
              //               ),
              //               tileColor: Colors.white,
              //               leading: CircleAvatar(
              //                 backgroundColor: Colors.grey,
              //                 foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi6tPF5JeRbN6KORVIAQzb3xa0r-rSzYuzvKPHMa4s6A&s"),
              //               ),
              //               title: Padding(
              //                 padding: const EdgeInsets.only(top: 5),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Text("${userName[index]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
              //                         // Text(" · 1d",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
              //                       ],
              //                     ),
              //                     Align(
              //                       alignment: Alignment.topRight,
              //                       child: PopupMenuButton<String>(
              //                         icon: Icon(CupertinoIcons.ellipsis,color: kheader,),
              //                         itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              //                           PopupMenuItem<String>(
              //                             value: 'report',
              //                             child: Text('Report'),
              //                           ),
              //                           PopupMenuItem<String>(
              //                             value: 'block user',
              //                             child: Text('Block User'),
              //                           ),
              //                         ],
              //                         onSelected: (String value) {
              //                           switch (value) {
              //                             case 'archive':
              //                               break;
              //                             case 'contact':
              //                               break;
              //                           }
              //                         },
              //                       ),
              //                       // Icon(CupertinoIcons.ellipsis_vertical),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               subtitle: Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 0),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Text("Hello ! Robbi How are you?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),)
              //                       ],
              //                     ),
              //                     (index == 0 || index == 3) ?
              //                     Container(
              //                       margin: EdgeInsets.symmetric(vertical: 15),
              //                       alignment: AlignmentDirectional.centerStart,
              //                       height: 150,
              //                       width: 250,
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(20),
              //                           image: DecorationImage(
              //                             image: NetworkImage("https://i.pinimg.com/736x/53/d5/77/53d577fbc7ff15fec6f6a46b161e47d8.jpg"),fit: BoxFit.cover,
              //                           )
              //                       ),
              //                     ) : SizedBox.shrink(),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
              //               child: Column(
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 10,bottom: 10),
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: [
              //                         GestureDetector(
              //                           onTap: () {
              //                             setState(() {
              //                               tapped = !tapped;
              //                               tapped == true ? count ++ : count --;
              //                             });
              //                           },
              //                           child: Row(
              //                             children: [
              //                               Icon((index == 0 || index == 3) ? tapped ? CupertinoIcons.hand_thumbsup_fill : CupertinoIcons.hand_thumbsup : CupertinoIcons.hand_thumbsup,color: kheader,size: 18,),
              //                               SizedBox(
              //                                 width: 5,
              //                               ),
              //                               Text("Like",style: TextStyle(color: kheader,fontWeight: FontWeight.w400,fontSize: 14),),
              //                             ],
              //                           ),
              //                         ),
              //                         Row(
              //                           children: [
              //                             Icon(CupertinoIcons.chat_bubble,color: kheader,size: 18,),
              //                             SizedBox(
              //                               width: 5,
              //                             ),
              //                             Text("Comment",style: TextStyle(color: kheader,fontWeight: FontWeight.w400,fontSize: 14),),
              //                           ],
              //                         ),
              //                         GestureDetector(
              //                           onTap: () {
              //                             Fluttertoast.showToast(
              //                               msg: "Share Feature Is In Progress",
              //                               fontSize: 12,
              //                               textColor: Colors.white,
              //                               backgroundColor: Colors.red,
              //                             );
              //                           },
              //                           child: Row(
              //                             children: [
              //                               Icon(CupertinoIcons.location,color: kheader,size: 18,),
              //                               SizedBox(
              //                                 width: 5,
              //                               ),
              //                               Text("Send",style: TextStyle(color: kheader,fontWeight: FontWeight.w400,fontSize: 14),),
              //                             ],
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.symmetric(vertical: 5),
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       crossAxisAlignment: CrossAxisAlignment.center,
              //                       children: [
              //                         Text("${index == 0 ? count : index == 3 ? count : 188} Like · ${index == 0 ? count : index == 3 ? count : 188} Comment",style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600,fontSize: 10),),
              //                         Text("12 Mar 2024",style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600,fontSize: 10),),
              //                       ],
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 10,bottom: 10),
              //                     child: RichText(
              //                       softWrap: true,
              //                       overflow: TextOverflow.ellipsis,
              //                       textScaleFactor: 0.9,
              //                       maxLines: 2,
              //                       text: TextSpan(
              //                         children: <TextSpan>[
              //                           TextSpan(
              //                               text: 'Alex Costa : ',
              //                               style: TextStyle(
              //                                   color: Colors.black,
              //                                   fontWeight: FontWeight.bold)),
              //                           TextSpan(
              //                               text:
              //                               'Your listing has been submitted to the admin for approval Your listing has been submitted to the admin for approval',
              //                               style: TextStyle(color: kgreyDark))
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              //   separatorBuilder: (context, index) {
              //     return Divider(color: Colors.grey,height: 0,thickness: 0.2,);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  populateItem(MyForum myForumItem) {
    String dates =
        DateFormat("dd-MM-yyyy", Localizations.localeOf(context).toString())
            .format(myForumItem.createdAt ?? DateTime.now());
    return GestureDetector(
      onTap: () {
        // Get.to(() => ForumDetailPage(forumItem, label));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12.5, vertical: 7),
        elevation: 0,
        child: Container(
          // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    CircleAvatar(
                  backgroundColor: cartbackgroundcolor,
                  foregroundImage: NetworkImage(profilePhoto),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      saveUser()?.data?.id == myForumItem.customerId
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${myForumItem.customerName ?? ""}",
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
                                  "${myForumItem.customerName ?? ""}",
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
                                  questionid: myForumItem.id.toString());
                              charCha.getMyForumApiCall();
                            },
                          ),
                          // Icon(CupertinoIcons.ellipsis_vertical),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     saveUser()?.data?.id == myForumItem.customerId
                      //         ? GestureDetector(
                      //             onTap: () async {
                      //               await Share.share(myForumItem.getShareLink(myForumItem.customerName ?? ""));
                      //             },
                      //             child: Padding(
                      //               padding: const EdgeInsets.only(right: 0),
                      //               child: Row(
                      //                 children: [
                      //                   Icon(
                      //                     Icons.share,
                      //                     color: kheader,
                      //                     size: 18,
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           )
                      //         : GestureDetector(
                      //             onTap: () async {
                      //               await Share.share(myForumItem.getShareLink(myForumItem.customerName ?? ""));
                      //             },
                      //             child: Row(
                      //               children: [
                      //                 Icon(
                      //                   Icons.share,
                      //                   color: kheader,
                      //                   size: 18,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //     Visibility(
                      //       visible: saveUser()?.data?.id != myForumItem.customerId, // USER ARE DIFFERENT
                      //       child: PopupMenuButton(
                      //           icon: Icon(
                      //             CupertinoIcons.ellipsis,
                      //             color: kheader,
                      //           ),
                      //           onSelected: (value) {
                      //             if (value == 'report') {
                      //               // showReportAbuse(myForumItem.id);
                      //               // EasyLoading.showToast(
                      //               //     'Report has been submitted successfully.');
                      //             } else if (value == 'block') {
                      //               // this._fetchDelete(forumDetailItem.id);
                      //               charCha.getblock(customerid: myForumItem.customerId.toString());
                      //               // this._fetchForumBlocked(
                      //               //     forumItem.customer_id);
                      //               // EasyLoading.showToast(
                      //               //     'User has been blocked.');
                      //             }
                      //           },
                      //           itemBuilder: (context) => [
                      //                 PopupMenuItem<String>(
                      //                   value: 'report',
                      //                   child: Text('${translate("Report")}'),
                      //                 ),
                      //                 PopupMenuItem<String>(
                      //                   value: 'block',
                      //                   child: Text('${translate("Block User")}'),
                      //                 ),
                      //               ]),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                // subtitle: Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 0),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const SizedBox(height: 10),
                //       label.isArticle()
                //           ? Text(forumItem.question ?? '',
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(color: kblack, fontSize: 16.0))
                //           : Container(),
                //       forumItem.hasDescription()
                //           ? Text(forumItem.description ?? "",
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(color: kgreyDark, fontSize: 16.0))
                //           : Container(),
                //       // forumItem.hasImage()
                //       //     ?
                //       // Container(
                //       //   margin: EdgeInsets.symmetric(vertical: 15),
                //       //   alignment: AlignmentDirectional.centerStart,
                //       //   height: 150,
                //       //   width: double.infinity,
                //       //   decoration: BoxDecoration(
                //       //       borderRadius: BorderRadius.circular(20),
                //       //       image: DecorationImage(
                //       //         image: NetworkImage(forumItem.getImageURL()),fit: BoxFit.cover,
                //       //       )
                //       //   ),
                //       //   // child: Image(
                //       //   //             image: NetworkImage(
                //       //   //                 'https://manjha.in/public/news/1621076362.png')),
                //       // )
                //       //     : SizedBox.shrink(),
                //       // Row(
                //       //   children: [
                //       //     Text("Hello ! Robbi How are you?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),)
                //       //   ],
                //       // ),
                //       // (index == 0 || index == 3) ?
                //       // Container(
                //       //   margin: EdgeInsets.symmetric(vertical: 15),
                //       //   alignment: AlignmentDirectional.centerStart,
                //       //   height: 150,
                //       //   width: 250,
                //       //   decoration: BoxDecoration(
                //       //       borderRadius: BorderRadius.circular(20),
                //       //       image: DecorationImage(
                //       //         image: NetworkImage("https://i.pinimg.com/736x/53/d5/77/53d577fbc7ff15fec6f6a46b161e47d8.jpg"),fit: BoxFit.cover,
                //       //       )
                //       //   ),
                //       // )
                //       // : SizedBox.shrink(),
                //     ],
                //   ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    label.isForum()
                        ? Text(myForumItem.question ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kblack, fontSize: 12.0))
                        : Container(),
                    myForumItem.hasDescription()
                        ? Text(myForumItem.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kgreyDark, fontSize: 12.0))
                        : Container(),
                    // Text("Hello how are you we are the developers of manjha application keep in touch with us life bana dunga", maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: TextStyle(color: kgreyDark, fontSize: 16.0))
                    // forumItem.hasImage()
                    //     ?
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 15),
                    //   alignment: AlignmentDirectional.centerStart,
                    //   height: 150,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       image: DecorationImage(
                    //         image: NetworkImage(forumItem.getImageURL()),fit: BoxFit.cover,
                    //       )
                    //   ),
                    //   // child: Image(
                    //   //             image: NetworkImage(
                    //   //                 'https://manjha.in/public/news/1621076362.png')),
                    // )
                    //     : SizedBox.shrink(),
                    // Row(
                    //   children: [
                    //     Text("Hello ! Robbi How are you?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),)
                    //   ],
                    // ),
                    // (index == 0 || index == 3) ?
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 15),
                    //   alignment: AlignmentDirectional.centerStart,
                    //   height: 150,
                    //   width: 250,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       image: DecorationImage(
                    //         image: NetworkImage("https://i.pinimg.com/736x/53/d5/77/53d577fbc7ff15fec6f6a46b161e47d8.jpg"),fit: BoxFit.cover,
                    //       )
                    //   ),
                    // )
                    // : SizedBox.shrink(),
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
                    myForumItem.hasImage()
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            alignment: AlignmentDirectional.centerStart,
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(myForumItem.getImageURL()),
                                  fit: BoxFit.cover,
                                )),
                            // child: Image(
                            //             image: NetworkImage(
                            //                 'https://manjha.in/public/news/1621076362.png')),
                          )
                        : SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   tapped = !tapped;
                                  //   tapped == true ? count ++ : count --;
                                  // });
                                  charCha.getlikedislike(
                                      questionsid: myForumItem.id.toString());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      myForumItem.isLiked()
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
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Get.to(() => ForumDetailPage(myForumItem, label));
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
                                "${myForumItem.getLikes()} · ${myForumItem.getComments()}",
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
                    /**/
                    // Visibility(
                    //     visible: myForumItem.comments!.length > 0,
                    //     child: Column(
                    //       children: [
                    //         Divider(
                    //           color: Colors.grey,height: 0,thickness: 0.25,
                    //         ),
                    //         ListView.builder(
                    //             itemCount: myForumItem.comments?.length ?? 0,
                    //             shrinkWrap: true,
                    //             padding: EdgeInsets.symmetric(horizontal: 20),
                    //             primary: false,
                    //             physics: const NeverScrollableScrollPhysics(),
                    //             // separatorBuilder: (context, index) {
                    //             //   return const Divider(
                    //             //     color: Colors.grey,height: 0,thickness: 5,
                    //             //   );
                    //             // },
                    //             itemBuilder: (context, index) {
                    //               return Padding(
                    //                 padding: const EdgeInsets.only(top: 10, bottom: 10),
                    //                 child: RichText(
                    //                   softWrap: true,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   textScaleFactor: 0.9,
                    //                   maxLines: 2,
                    //                   text: TextSpan(
                    //                     children: <TextSpan>[
                    //                       TextSpan(
                    //                           text: "${myForumItem.comments?[index].getName()} : ",
                    //                           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    //                       TextSpan(
                    //                           text: myForumItem.comments?[index].answer ?? "",
                    //                           style: TextStyle(color: kgreyDark))
                    //                     ],
                    //                   ),
                    //                 ),
                    //               );
                    //               //   Row(
                    //               //   children: [
                    //               //     Container(
                    //               //       height: 30,
                    //               //       width: 30,
                    //               //       decoration: BoxDecoration(
                    //               //           image: DecorationImage(
                    //               //               fit: BoxFit.fitWidth,
                    //               //               image: NetworkImage(forumItem.comments?[index].getCustomerPhoto() ?? "")),
                    //               //           borderRadius: BorderRadius.circular(100)),
                    //               //     ),
                    //               //     const SizedBox(width: 10),
                    //               //     Expanded(
                    //               //         child: Column(
                    //               //           crossAxisAlignment: CrossAxisAlignment.start,
                    //               //           children: [
                    //               //             BoldText(forumItem.comments?[index].getName(), 14, kblack,
                    //               //                 overflow: TextOverflow.visible),
                    //               //             Text(forumItem.comments?[index].answer ?? "",
                    //               //                 maxLines: 2,
                    //               //                 overflow: TextOverflow.ellipsis,
                    //               //                 style: TextStyle(color: kgreyDark, fontSize: 16.0)),
                    //               //           ],
                    //               //         )),
                    //               //   ],
                    //               // );
                    //             }),
                    //       ],
                    //     )),
                    /**/
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
              )
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
}
