import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/screens/const.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:path/path.dart';
import '../../getxcontrollers/charchacontroller.dart';
import '../localconst.dart';
import 'charchascreen.dart';

//ignore: must_be_immutable
class ForumAdd extends StatefulWidget {
  ForumTypeLabel label;
  ForumAdd(this.label);
  @override
  _ForumAddState createState() => _ForumAddState();
}

class _ForumAddState extends State<ForumAdd> {
  @override
  void initState() {
    this.loadSession();
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

  String profilePhoto = '';
  String customerName = '';
  String customerCity = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CharchaController charCha = Get.put(CharchaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cartbackgroundcolor,
        appBar: AppBar(
          backgroundColor: cartbackgroundcolor,
          iconTheme: IconThemeData(color: kblack),
          title: Text(translate(this.widget.label.addPageTitle),
              style: TextStyle(
                  color: kblack, fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.symmetric(horizontal: 12.5, vertical: 7),
                    child: Container(
                      width: 360.0,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(100),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: kgreyDark, width: 0.5)),
                                child: profilePhoto.isNotEmpty
                                    ? InkWell(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        // borderRadius: BorderRadius.circular(15),
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
                                        child: ClipOval(
                                            child: Image.network(
                                          profilePhoto,
                                          fit: BoxFit.cover,
                                          height: 40.0,
                                          width: 40.0,
                                        )),
                                      )
                                    : SizedBox(),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText(this.customerName, 18, kblack),
                                  // NormalText(this.customerCity, kgreyDark, 14),
                                ],
                              )
                            ],
                          ),
                          Visibility(
                              visible: this.widget.label.isArticle(),
                              child: Container(
                                  width: 340.0,
                                  child: NormalText(
                                      "Share your experience and knowledge with fish farming community",
                                      kblack,
                                      16))),
                          Visibility(
                              visible: this.widget.label.isArticle(),
                              child: Container(
                                width: 350.0,
                                child: TextFormField(
                                    // keyboardType: TextInputType.multiline,
                                    controller: titleController,
                                    style: TextStyle(
                                        fontFamily: "nunito",
                                        fontWeight: FontWeight.w500,
                                        color: kgreyDark,
                                        fontSize: 15.5),
                                    decoration: InputDecoration(
                                        // filled: true,
                                        // fillColor: Colors.grey.shade100,
                                        hintText:
                                            this.widget.label.addTextTitle,
                                        hintStyle: TextStyle(
                                            fontFamily: "nunito",
                                            fontWeight: FontWeight.w500,
                                            color: kgreyDark,
                                            fontSize: 15.5),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 12.0),
                                        focusColor: Colors.grey.shade700,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: kblack),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kgreyDark),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ))),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 350.0,
                            child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                controller: widget.label.isArticle()
                                    ? descriptionController
                                    : titleController,
                                style: TextStyle(
                                    fontFamily: "nunito",
                                    fontWeight: FontWeight.w500,
                                    color: kgreyDark,
                                    fontSize: 15.5),
                                decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Colors.grey.shade100,
                                    hintText: translate(
                                        this.widget.label.addTextDescription),
                                    hintStyle: TextStyle(
                                        fontFamily: "nunito",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 15.5),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 12.0),
                                    focusColor: Colors.grey.shade500,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (_selectedPhoto == null)
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                showPicker(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                height: 50,
                                width: 350,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton.icon(
                                    style: ButtonStyle(
                                        padding:
                                            MaterialStateProperty.resolveWith(
                                          (states) => EdgeInsets.all(15.0),
                                        ),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                    onPressed: () {
                                      showPicker(context);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.photo_on_rectangle,
                                      size: 20,
                                      color: Colors.grey.shade600,
                                    ),
                                    label: Text(
                                      "${translate("Select Photo")}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Visibility(
                            visible: (_selectedPhoto != null),
                            child: Container(
                              height: 200,
                              width: 350.0,
                              child: Stack(
                                children: [
                                  Container(
                                      decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 5)
                                    ],
                                    image: new DecorationImage(
                                      image: (_selectedPhoto == null)
                                          ? new AssetImage(
                                              'assets/images/modi_img.png')
                                          : FileImage(
                                                  File(_selectedPhoto!.path))
                                              as ImageProvider<Object>,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                  Visibility(
                                      visible: (_selectedPhoto != null),
                                      child: Positioned(
                                        top: 0,
                                        left: 0,
                                        child: InkWell(
                                          onTap: () {
                                            // print('hi');
                                            _selectedPhoto = null;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            margin:
                                                EdgeInsets.fromLTRB(5, 5, 0, 0),
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        showPicker(context);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 60,
                                        margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Center(
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Visibility(
                  //     visible: !this.widget.label.isArticle(),
                  //     child: Container(
                  //         width: 350.0,
                  //         child: NormalText(
                  //             translate(this.widget.label.addTextDescription), kblack, 16))),

                  // Container(
                  //     width: 340.0,
                  //     child: NormalText(
                  //         " " + Lang.get('Description'), Colors.black38, 18)),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    minWidth: 350.0,
                    height: 45.0,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () async {
                        if (titleController.text.isEmpty) {
                          EasyLoading.showToast(
                              "${translate("Please enter something...!")}");
                          return;
                        }
                        // if (_selectedPhoto == null) {
                        //   EasyLoading.showToast("Please select photo...!");
                        //   return;
                        // }

                        // CHECK EMPTY CONDITION ------------------------->
                        await _fetchData();
                        Get.back();
                      },
                      color: kheader,
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "${translate("Post")}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  )
                  // WideButton.bold("${translate("Post")}", () {
                  //   // CHECK EMPTY CONDITION ------------------------->
                  //   if (titleController.text.isEmpty) {
                  //     EasyLoading.showToast("${translate("Please enter something...!")}");
                  //     return;
                  //   }
                  //   // if (_selectedPhoto == null) {
                  //   //   EasyLoading.showToast("Please select photo...!");
                  //   //   return;
                  //   // }
                  //
                  //   // CHECK EMPTY CONDITION ------------------------->
                  //   _fetchData().then((responseSuccess) {
                  //     if (responseSuccess) {
                  //       Navigator.pop(context);
                  //     } else {
                  //       EasyLoading.showToast("Failed to load request.");
                  //     }
                  //   });
                  //   // REGISTRATION FINISH ------------------------->
                  // }, true),
                  ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ));
  }

  // var isLoading = false;

  _fetchData() async {
    // setState(() {
    //   isLoading = true;
    // });
    // EasyLoading.show();
    String fileName = '';
    String fileImage = '';
    if (_selectedPhoto != null) {
      fileName = basename(_selectedPhoto!.path);
      fileImage = base64Encode(_selectedPhoto!.readAsBytesSync());
    }

    final response = await http.post(Common.getURL("forumQuestionAdd"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "content-type": "application/x-www-form-urlencoded",
          'Cookie': Common.getCookie().toString()
        },
        body: jsonEncode(<String, String>{
          "customer_name": this.customerName,
          "emailid": 'info@manjha.com',
          "question": this.titleController.text,
          "description": this.descriptionController.text,
          "forum_type": this.widget.label.forumType.index.toString(),
          "fileName": fileName,
          "forum_image": fileImage,
        }));
    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      // print(resBody);

      EasyLoading.showToast(resBody["message"]);
      charCha.getMyForumApiCall();
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      throw Exception('Failed to load request');
    }
  }

  File? _selectedPhoto;
  final ImagePicker _picker = ImagePicker();
  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 50);

    if (mounted)
      setState(() {
        if (image!.path.isNotEmpty) _selectedPhoto = File(image.path);
        // fileListThumb = thumbs;
      });
  }

  Future _pickFile() async {
    // List<Widget> thumbs = new List<Widget>();
    // fileListThumb.forEach((element) {
    //   thumbs.add(element);
    // });

    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'], //, 'pdf', 'doc', 'docx'
    ).then((file) {
      if (file != null) {
        if (mounted)
          setState(() {
            _selectedPhoto = File(file.files.first.path ?? "");
            // _uploadCustomerPhoto(file);
          });
      }
    });
  }

  Future showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('${translate("Photo Library")}'),
                    onTap: () {
                      _pickFile();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('${translate("Camera")}'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
