import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/model/getfourmdetailsresponse.dart';
import 'package:manjha/screens/charchascreens/charchascreen.dart';
import 'dart:async';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textfieldscreen.dart';
import 'package:manjha/widget/textstyle.dart';
import '../../getxcontrollers/charchacontroller.dart';
import '../../model/suraj_charcha_model.dart';

//ignore: must_be_immutable
class ForumDetailPage extends StatefulWidget {
  Forumdd _forumItem;
  ForumTypeLabel label;

  @override
  ForumDetailPage(this._forumItem, this.label);

  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  TextEditingController answerController = new TextEditingController();
  CharchaController charchaController = Get.put(CharchaController());
  List<ForumDetailItem> list = [];
  var isFirstLoading = true;

  getcharchadetail() {
    getfourmdetails(fourmid: widget._forumItem.id.toString()).then((value) {
      setState(() {
        list = value.data ?? [];
        isFirstLoading = false;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void initState() {
    getcharchadetail();
    loadSession();
    super.initState();
  }

  loadSession() async {
    String customerPhotoUrl = await saveUser()?.data?.customerPhoto ?? "";
    String defaultUrl = image_customer_url;

    this.profilePhoto = "$defaultUrl$customerPhotoUrl";
    setState(() {});
  }

  String profilePhoto = '';

  List<Widget> getNoRecord() {
    return [
      Divider(),
      Container(
          //height: 100,
          // padding: EdgeInsets.all(8.0),
          width: double.infinity,
          child: Card(
              elevation: 0,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                      child: NormalText(
                          "${translate("Be the first to comment...")}",
                          /*kdarkBlue*/ kheader,
                          18.0)))))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolorcart,
      appBar: AppBar(
        // iconTheme: IconThemeData(color: kblack),
        backgroundColor: backgroundcolorcart,
        elevation: 0,
        title: Text(
          // widget._forumItem == ''
          //     ? widget.label.myPageTitle
          //     : widget._forumItem.question ?? "",
          translate("Comments"),
          style: TextStyle(color: kblack, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        // elevation: 2.0,
      ),
      // floatingActionButton: new FloatingActionButton(
      //     elevation: 0.0,
      //     foregroundColor: kwhite,
      //     child: new Icon(Icons.add),
      //     backgroundColor: kheader,
      //     onPressed: () {
      //       this._showDialog();
      //       // Fluttertoast.showToast(msg: ('Add New'));
      //     }),
      body: isFirstLoading
          ? Center(
              child: CircularProgressIndicator(color: kheader),
            )
          : ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  populateItem(this.widget._forumItem),
                ],
              )),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isFirstLoading
          ? SizedBox.shrink()
          : Card(
              color: Colors.transparent,
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                // padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: cartbackgroundcolor,
                          foregroundImage: NetworkImage(profilePhoto),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Card(
                          elevation: 0,
                          // margin: EdgeInsets.symmetric(vertical: 0),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, right: 5, top: 0),
                            decoration: BoxDecoration(
                              // color: Color(0xffD1D3D5),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              controller: answerController,
                              decoration: InputDecoration(
                                suffix: Container(
                                  // width: 50,
                                  height: 15,
                                  child: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      // Fluttertoast.showToast(
                                      //   msg: "Comment Feature Is In Development",
                                      //   fontSize: 12,
                                      //   textColor: Colors.white,
                                      //   backgroundColor: Colors.red,
                                      // );

                                      if (answerController.text.length != 0) {
                                        await charchaController
                                            .getforumAnswerAdd(
                                                questionid: widget._forumItem.id
                                                    .toString(),
                                                answer: answerController.text);
                                        await getcharchadetail();
                                        answerController.text = '';
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        print('post');
                                      }
                                    },
                                    icon: Icon(
                                      CupertinoIcons.location_fill,
                                      size: 18,
                                      color: themecolor,
                                    ),
                                  ),
                                ),
                                // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                hintText:
                                    '${translate("Write your message...")}',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     Fluttertoast.showToast(
                    //       msg: "Comment Feature Is In Development",
                    //       fontSize: 12,
                    //       textColor: Colors.white,
                    //       backgroundColor: Colors.red,
                    //     );
                    //   },
                    //   icon: Icon(CupertinoIcons.location),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  Padding populateItem(Forumdd forumItem) {
    String dates =
        DateFormat("dd-MM-yyyy", Localizations.localeOf(context).toString())
            .format(forumItem.createdAt ?? DateTime.now());
    return Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: InkWell(
            // onTap: () async {
            //   print(forumItem.question);
            // Fluttertoast.showToast(msg: (forumItem.question));
            // bool blnResponse =
            //     await Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return ForumDetailPage(forumItem, this.widget.label);
            // }));
            // print('arjun' + blnResponse.toString());
            // if (blnResponse != null && blnResponse) {
            //   this._fetchData();
            // }
            // },
            child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Container(
                  //height: 100,
                  // width: double.infinity,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor: Colors.white,
                          leading: InkWell(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (_) => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50),
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
                              foregroundImage:
                                  NetworkImage(forumItem.getCustomerPhoto()),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text("${"Ahmed"}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                // Text(" · 1d",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                                // BoldText(forumItem.customerName ?? "", 16, kblack),
                                // NormalText(dates, kgreyDark, 12),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${forumItem.customerName ?? ""}",
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(forumItem.question ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0))
                                  ],
                                ),
                              ),
                              forumItem.hasDescription()
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Text(forumItem.description ?? "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0))
                                        ],
                                      ),
                                    )
                                  : Container(),
                              forumItem.hasImage()
                                  ? Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      height: 180,
                                      // width: 250,
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(0),
                                      //     image: DecorationImage(
                                      //       image: NetworkImage("https://i.pinimg.com/736x/53/d5/77/53d577fbc7ff15fec6f6a46b161e47d8.jpg"),fit: BoxFit.cover,
                                      //     )
                                      // ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(
                                                  forumItem.getImageURL())),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(0))),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${forumItem.getLikes()} · ${forumItem.getComments()}",
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 50,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //           image: DecorationImage(
                        //               fit: BoxFit.fitWidth,
                        //               image: NetworkImage(
                        //                   forumItem.getCustomerPhoto())),
                        //           borderRadius: BorderRadius.circular(100)),
                        //     ),
                        //     SizedBox(width: 10),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         BoldText(
                        //             forumItem.customerName ?? "", 18, kblack),
                        //         NormalText(forumItem.getFormattedDate(),
                        //             kgreyDark, 14),
                        //       ],
                        //     )
                        //   ],
                        // ),
                        // Text(forumItem.question ?? "",
                        //     style:
                        //         TextStyle(fontSize: 16.0, color: kgreyDark)),
                        // //  SizedBox(height: 10),
                        // forumItem.hasDescription()
                        //     ? ExpandableText(forumItem.description ?? "")
                        //     : Container(),
                        // forumItem.hasImage()
                        //     ? Container(
                        //         height: 180,
                        //         decoration: BoxDecoration(
                        //             image: DecorationImage(
                        //                 fit: BoxFit.fitWidth,
                        //                 image: NetworkImage(
                        //                     forumItem.getImageURL())),
                        //             borderRadius: BorderRadius.all(
                        //                 Radius.circular(8.0))),
                        //         // child: Image(
                        //         //     image: NetworkImage(
                        //         //         'https://manjha.in/public/news/1621076362.png')),
                        //       )
                        //     : Container(),
                        // Divider(),
                        SizedBox(height: 5),
                        // populateCommentBox(),
                        // SizedBox(height: 10),
                        /**/
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Column(children: [
                        //       IconButton(
                        //         icon: Icon(
                        //             forumItem.isLiked()
                        //                 ? FontAwesomeIcons.solidThumbsUp
                        //                 : FontAwesomeIcons.thumbsUp,
                        //             color: kgreyDark),
                        //         onPressed: () {
                        //           this._fetchLikeUnLike(forumItem.id);
                        //         },
                        //       ),
                        //       NormalText(forumItem.getLikes(), kgreyDark, 12),
                        //     ]),
                        //     Column(children: [
                        //       IconButton(
                        //         icon: Icon(FontAwesomeIcons.comment,
                        //             color: kgreyDark),
                        //         onPressed: () {},
                        //       ),
                        //       NormalText(
                        //           forumItem.getComments(), kgreyDark, 12),
                        //     ]),
                        //     Column(children: [
                        //       IconButton(
                        //         icon: Icon(FontAwesomeIcons.shareAlt,
                        //             color: kgreyDark),
                        //         onPressed: () {},
                        //       ),
                        //       NormalText('Share', kgreyDark, 12),
                        //     ]),
                        //   ],
                        // )
                        // NormalText("28, Nov at 15:30 pm", kdarkBlue, 12),
                        Column(
                            children: list.length == 0
                                ? this.getNoRecord()
                                :
                                // list.map((forumDetailItem) {
                                //         return Padding(
                                //           padding: const EdgeInsets.only(bottom: 20),
                                //           child: populateSubItem(forumDetailItem,index, list.length),
                                //         );
                                //       }).toList()),
                                List.generate(list.length, (index) {
                                    final forumDetailItem = list[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 00),
                                      child: populateSubItem(
                                          forumDetailItem, index, list.length),
                                    );
                                  })),
                      ])),
            ),
          ],
        )));
  }

  Widget populateSubItem(
      ForumDetailItem forumDetailItem, int index, int itemCount) {
    String dates =
        DateFormat("dd-MM-yyyy", Localizations.localeOf(context).toString())
            .format(forumDetailItem.createdAt ?? DateTime.now());
    return Column(
      children: [
        Divider(color: Colors.grey),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
              onTap: () {
                print(forumDetailItem.answer);
                // Fluttertoast.showToast(msg: (forumDetailItem.question));
              },
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    dense: true,
                    minVerticalPadding: 0,
                    minLeadingWidth: -5,
                    tileColor: Colors.white,
                    leading: InkWell(
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
                                      image: NetworkImage(
                                          forumDetailItem.getCustomerPhoto()),
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
                        radius: 15,
                        backgroundColor: cartbackgroundcolor,
                        foregroundImage:
                            NetworkImage(forumDetailItem.getCustomerPhoto()),
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              forumDetailItem.getName(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
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
                            (!forumDetailItem.isDeletePermission())
                                ? SizedBox()
                                : Container(
                                    width: 30,
                                    alignment: Alignment.centerRight,
                                    child: PopupMenuButton(
                                        icon: Icon(
                                          Icons.more_vert,
                                          size: 20,
                                        ),
                                        onSelected: (value) async {
                                          if (value == 'delete') {
                                            await charchaController
                                                .getforumAnswerdelete(
                                                    questionid: forumDetailItem
                                                        .id
                                                        .toString());
                                            await getcharchadetail();
                                          }
                                        },
                                        itemBuilder: (context) => [
                                              const PopupMenuItem<String>(
                                                value: 'delete',
                                                child: Text('Delete'),
                                              ),
                                            ]),
                                  )
                            // Container(
                            //   width: 15,
                            //   alignment: Alignment.centerRight,
                            //   child: Align(
                            //     alignment: Alignment.topRight,
                            //     child: PopupMenuButton<String>(
                            //       icon: Icon(CupertinoIcons.ellipsis_vertical,color: Colors.black,size: 18,),
                            //       itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            //         PopupMenuItem<String>(
                            //           value: 'report',
                            //           child: Text('Report'),
                            //         ),
                            //         PopupMenuItem<String>(
                            //           value: 'block user',
                            //           child: Text('Block User'),
                            //         ),
                            //       ],
                            //       onSelected: (String value) {
                            //         switch (value) {
                            //           case 'archive':
                            //             break;
                            //           case 'contact':
                            //             break;
                            //         }
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    // subtitle: Padding(
                    //   padding: const EdgeInsets.only(right: 5),
                    //   child: Text(forumDetailItem.answer ?? "",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10),),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        forumDetailItem.answer ?? "",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              )),
        ),
        // if (index != itemCount - 1)
        // Divider(
        //   thickness: 0.25,
        //   color: Colors.grey,
        //   indent: 15,
        //   endIndent: 15,
        // )
      ],
    );
  }

  // Widget populateCommentBox() {
  //   return Padding(
  //       padding: EdgeInsets.fromLTRB(0, 8, 0, 4), //const EdgeInsets.all(8.0),
  //       child: Container(
  //           //height: 100,
  //           width: double.infinity,
  //           padding: EdgeInsets.only(top: 8),
  //           decoration: BoxDecoration(
  //               border: Border(top: BorderSide(color: kgreyFill))),
  //           child: Card(
  //             elevation: 0,
  //             child: Padding(
  //               padding: const EdgeInsets.all(0.0),
  //               child: Row(
  //                 children: [
  //                   Container(
  //                     height: 50,
  //                     width: 50,
  //                     decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                             fit: BoxFit.fitWidth,
  //                             image:
  //                                 NetworkImage(widget.label.getProfilePhoto())),
  //                         borderRadius: BorderRadius.circular(100)),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                       child: NormalForm(
  //                           null, this.widget.label.detailTextAnswerHint,
  //                           controller: answerController,
  //                           textInputType: TextInputType.multiline)),
  //                   MaterialButton(
  //                       child: Icon(FontAwesomeIcons.paperPlane,
  //                           color: kwhite, size: 18),
  //                       minWidth: 50,
  //                       color: kheader,
  //                       padding: EdgeInsets.fromLTRB(0, 0, 4, 4),
  //                       shape: CircleBorder(),
  //                       onPressed: () async {
  //                         // if (answerController.text.length == 0) {
  //                         //   EasyLoading.showToast('Please enter something.');
  //                         //   return;
  //                         // }
  //                         // await this._fetchAdd(
  //                         //     widget._forumItem.id, answerController.text);
  //                         // answerController.text = '';
  //                         // FocusScope.of(context).requestFocus(FocusNode());
  //                         // print('post');
  //                       }),
  //                 ],
  //               ),
  //             ),
  //           )));
  // }

  // _showDialog() async {
  //   TextEditingController _answerController = new TextEditingController();
  //   await showDialog<String>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       contentPadding: const EdgeInsets.all(16.0),
  //       title: new Text(this.widget.label.detailTextHeading),
  //       content: new Row(
  //         children: <Widget>[
  //           new Expanded(
  //             child: new TextField(
  //               autofocus: true,
  //               controller: _answerController,
  //               decoration: new InputDecoration(
  //                   labelText: this.widget.label.detailTextAnswer,
  //                   hintText: this.widget.label.detailTextAnswerHint),
  //             ),
  //           )
  //         ],
  //       ),
  //       actions: <Widget>[
  //         MaterialButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             }),
  //         MaterialButton(
  //             child: const Text('Submit'),
  //             onPressed: () {
  //               // if (_answerController.text.length == 0) {
  //               //   EasyLoading.showToast("Please enter your answer.");
  //               //   return;
  //               // }
  //               // this._fetchAdd(widget._forumItem.id, _answerController.text);
  //               // // Fluttertoast.showToast(msg: "Answer has been submitted.");
  //               // Navigator.pop(context);
  //             })
  //       ],
  //     ),
  //   );
  // }
}

//ignore: must_be_immutable
class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isEnable = false;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    widget.isEnable = (widget.text.length > 50);
    return new Column(children: <Widget>[
      new ConstrainedBox(
          constraints: widget.isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(maxHeight: 50.0),
          child: new Text(
            widget.text,
            softWrap: true,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.left,
          )),
      !widget.isEnable
          ? new Container()
          : Align(
              alignment: Alignment.centerRight,
              child: new TextButton(
                  // : kheader,
                  // height: 30,
                  child: Text(widget.isExpanded ? 'read less' : 'read more'),
                  onPressed: () =>
                      setState(() => widget.isExpanded = !widget.isExpanded)),
            ) //widget.isExpanded = true
    ]);
  }
}

/*
*  child: Container(
                  //height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: kgreyFill))),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage(forumDetailItem
                                              .getCustomerPhoto())),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BoldText(
                                        forumDetailItem.getName(), 18, kblack),
                                    NormalText(forumDetailItem.getFormattedDate(),
                                        kgreyDark, 14),
                                  ],
                                )),
                                (!forumDetailItem.isDeletePermission())
                                    ? SizedBox()
                                    : PopupMenuButton(
                                        icon: Icon(Icons.more_vert),
                                        onSelected: (value) {
                                          // if (value == 'delete') {
                                          //   this._fetchDelete(forumDetailItem.id);
                                          // }
                                        },
                                        itemBuilder: (context) => [
                                              const PopupMenuItem<String>(
                                                value: 'delete',
                                                child: Text('Delete'),
                                              ),
                                            ])
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 58.0),
                              child: Text(forumDetailItem.answer ?? "",
                                  style:
                                      TextStyle(color: kblack, fontSize: 16.0)),
                            ),
                          ]),
                    ),
                  )),
* */
