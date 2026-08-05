import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/screens/languagescreen.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/AddressModel.dart';
import '../../model/getloginresponse.dart';
import '../../services/apiconst.dart';
import '../../shared_pref/shared_pref.dart';
import '../authscreens/login.dart';
import '../cartscreens/storeaddresslist.dart';
import '../charchascreens/charcha_profile.dart';
import '../charchascreens/charchaadd.dart';
import '../charchascreens/charchascreen.dart';
import '../const.dart';
import '../localconst.dart';
import 'MyFavoritePage.dart';
import 'MyListingPage.dart';
import 'ProfileUpdateScreen.dart';
import 'StoreOrderPage.dart';
import 'cmspage.dart';

class StoreProfilePage extends StatefulWidget {
  @override
  _StoreProfilePageState createState() => _StoreProfilePageState();
}

class _StoreProfilePageState extends State<StoreProfilePage>
    with SingleTickerProviderStateMixin {
  String _textCustImageUrl = "";
  @override
  void initState() {
    super.initState();

    setState(() {
      if (saveUser()?.data?.customerPhoto != "")
        _textCustImageUrl = saveUser()?.data?.customerPhoto ?? "";
    });
  }

  void cleanSession() {
    // LoginModel.logout();
  }
  void changeLanguage(Locale newLocale) {
    Get.updateLocale(newLocale);
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows dismissing dialog by tapping outside
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Background blur
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: themecolor,
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Are you sure you want to sign out?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            SharedPref.deleteAll();
                            Get.delete();
                            Get.offAll(LoginScreen());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey, width: 0.4),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Yes",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.4),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            child: VerticalDivider(
                                thickness: 0.4, color: Colors.grey),
                          )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey, width: 0.4),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "No",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> showLogoutPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Logout',
                style: TextStyle(fontSize: 25, color: Colors.red)),
            content: const Text('Do you really want to Logout?'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(kheader),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'No',
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(kheader),
                ),
                onPressed: () {
                  SharedPref.deleteAll();
                  Get.delete();
                  Get.offAll(LoginScreen());
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  final ImagePicker _picker = ImagePicker();
  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 50);

    if (mounted)
      setState(() {
        if (image?.path != null) _uploadCustomerPhoto(photo: File(image!.path));
        // fileListThumb = thumbs;
      });
  }

  Future _pickFile() async {
    // List<Widget> thumbs = new List<Widget>();
    // fileListThumb.forEach((element) {
    //   thumbs.add(element);
    // });

    await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'], //, 'pdf', 'doc', 'docx'
    ).then((file) {
      // FilePickerResult? file;
      if (file != null) {
        if (mounted)
          setState(() {
            _uploadCustomerPhoto(photo: new File(file.paths[0]!));
          });
      }
    });
  }

  Future showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(Lang.get('Photo Library')),
                      onTap: () {
                        _pickFile();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(Lang.get('Camera')),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  if (_textCustImageUrl.isNotEmpty)
                    ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(Lang.get('Remove Photo')),
                      onTap: () {
                        _uploadCustomerPhoto();
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
          );
        });
  }

  _uploadCustomerPhoto({File? photo}) async {
    // setState(() {
    //isLoading = true;
    // });
    bool removePhoto = true;
    if (photo != null) {
      removePhoto = false;
    }
    // EasyLoading.show();

    print('cookie:' + Common.getCookie());
    final response = await http.post(Common.getURL("updateprofilephoto"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "content-type": "application/x-www-form-urlencoded",
          'Cookie': Common.getCookie().toString()
        },
        body: (removePhoto)
            ? jsonEncode(<String, String>{
                "customer_id": saveUser()?.data?.id.toString() ?? "",
                "fileName": 'remove',
                "customer_photo": 'remove',
              })
            : jsonEncode(<String, String>{
                "customer_id": saveUser()?.data?.id.toString() ?? "",
                "fileName": "profilephoto",
                "customer_photo": base64Encode(photo!.readAsBytesSync()),
              }));
    EasyLoading.dismiss();
    // Common.updateCookie(response);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      if (resBody["success"] as bool == false) {
        var listMsg = resBody["message"] as List<dynamic>;

        EasyLoading.showToast(listMsg.join("\n"));
        return false;
      }

      print(resBody["data"]);
      // var customerId = parsed["id"];
      if (mounted)
        setState(() {
          _textCustImageUrl = resBody["data"];
        });
      Getloginresponse? saveuser = saveUser();

      saveuser?.data?.customerPhoto = _textCustImageUrl;

      SharedPref.save(
          value: jsonEncode(saveuser?.toJson()), prefKey: PrefKey.loginDetails);

      EasyLoading.showToast((resBody["message"].toString()));

      // setState(() {
      // isLoading = false;
      // });
      return true;
    } else {
      EasyLoading.showError('Failed to load request');
      // throw Exception('Failed to load request');
    }
    return false;
  }

  ForumTypeLabel label = ForumTypeLabel(ForumType.Forum);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundcolorcart,
        //   resizeToAvoidBottomPadding: true,
        // appBar: AppBar(
        //   backgroundColor: kColorAppDefault,
        //   elevation: 0,
        //   automaticallyImplyLeading: true,
        //   centerTitle: true,
        //   title: Text(
        //     "Account".tr,
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   // leading: Padding(
        //   //   padding: const EdgeInsets.all(8.0),
        //   //   child: Container(
        //   //     height: 40,
        //   //     width: 40,
        //   //     decoration: BoxDecoration(
        //   //         color: Colors.white,
        //   //         border: Border.all(color: Colors.transparent),
        //   //         borderRadius: BorderRadius.all(Radius.circular(200))),
        //   //     child: InkWell(
        //   //       onTap: () {
        //   //         Navigator.of(context).pop();
        //   //       },
        //   //       child: Icon(
        //   //         Icons.chevron_left_sharp,
        //   //         color: kColorAppDefault,
        //   //         size: 35,
        //   //       ),
        //   //     ),
        //   //   ),
        //   // ),
        // ),
        // extendBodyBehindAppBar: true,
        body: Builder(builder: (context) {
          return ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                    // fit: StackFit.loose,
                                    // alignment: Alignment.,
                                    children: <Widget>[
                                      // Image.asset(
                                      //   'assets/profile-back.png',
                                      //   fit: BoxFit.fitWidth,
                                      //   alignment: Alignment.topRight,
                                      //   // height: 175,
                                      // ),
                                      CircleAvatar(
                                        backgroundColor: kgreyDark,
                                        radius: 40,
                                        child: _textCustImageUrl.isNotEmpty
                                            ? ClipOval(
                                                child: Image.network(
                                                image_customer_url +
                                                    _textCustImageUrl,
                                                fit: BoxFit.cover,
                                                height: 80.0,
                                                width: 80.0,
                                              ))
                                            : Icon(
                                                Icons.person,
                                                size: 65,
                                              ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 45.0, left: 60.0),
                                          child: new InkWell(
                                              onTap: () {
                                                showPicker(context);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: kblack,
                                                radius: 20.0,
                                                child: new Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                              )))
                                    ]),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      saveUser()?.data?.fullName ?? "",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      saveUser()?.data?.mobileno ?? "",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    //   SizedBox(height: 5,),
                                    // Text("${saveUser()?.data?.emailid}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.to(ProfileUpdateScreen());
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //       builder: (context) =>
                          //     //           WishListScreen()),
                          //     // );
                          //   },
                          //   child: ListTile(
                          //     title: Text("My Wishlist"),
                          //     leading: Icon(Icons.favorite),
                          //   ),
                          // ),

                          Card(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 26, vertical: 4),
                                  child: BoldText('${translate('Profile')}', 18,
                                      kColorLabel),
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),
                                  title: NormalText("${translate('Profile')}",
                                      kitemlabel, 18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.person_outline_rounded),
                                  onTap: () {
                                    Get.to(CharchaProfile(label));
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (_) {
                                    //   return ProfileUpdateScreen();
                                    // }));
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('My Listing')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.list_alt_outlined),
                                  onTap: () {
                                    Get.to(MyListingPage());
                                    // Fluttertoast.showToast(
                                    //     msg:
                                    //         "My Listing in progress.....");
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('My Favorite')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.favorite_border_outlined),
                                  onTap: () {
                                    Get.to(MyFavoritePage());

                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (_) {
                                    //   return MyFavoritePage();
                                    // }));
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),
                                  title: NormalText(
                                      "${translate('Change Language')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.language),
                                  onTap: () {
                                    Get.to(() => LanguageScreen(
                                          isback: 1,
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Divider(),
                          SizedBox(
                            height: 8,
                          ),
                          Card(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 26, vertical: 4),
                                  child: BoldText(
                                      '${translate('Store')}', 18, kColorLabel),
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('My Address')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.location_on),
                                  onTap: () async {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             StoreAddressPage()),
                                    //   );
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoreAddressPage()),
                                    );
                                    // Navigator.of(context).pop();
                                    _fetchAddress();
                                  },
                                ),

                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText("${translate('My Orders')}",
                                      kitemlabel, 18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.shopping_bag_rounded),
                                  onTap: () {
                                    Get.to(() => StoreOrderPage());
                                  },
                                ),
                                // Divider(),
                                // Container(
                                //   alignment: Alignment.centerLeft,
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: 26, vertical: 4),
                                //   child: BoldText(
                                //       '${translate('Sawal Jawab')}',
                                //       18,
                                //       kColorLabel),
                                // ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('My Sawal Jawab')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.forum),
                                  onTap: () async {
                                    ForumTypeLabel label =
                                        ForumTypeLabel(ForumType.Forum);
                                    label.setProfilePhoto(
                                        await saveUser()?.data?.customerPhoto ??
                                            "");
                                    bool blnResult =
                                        await Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                      // return ForumMy(label);
                                      return CharchaProfile(label);
                                    }));
                                    if (blnResult != '' && blnResult) {
                                      // _fetchData();
                                    }
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText("${translate('Post Add')}",
                                      kitemlabel, 18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.forum),
                                  onTap: () async {
                                    Get.to(() => ForumAdd(label));
                                  },
                                ),
                              ],
                            ),
                          ),
                          // ListTile(
                          //   title: NormalText(
                          //       "${translate('My Videos')}",
                          //       kitemlabel,
                          //       18),
                          //   dense: true,
                          //   visualDensity:
                          //       VisualDensity.compact,
                          //   leading: Icon(Icons
                          //       .video_collection_outlined),
                          //   onTap: () async {
                          //     // ForumTypeLabel label =
                          //     //     new ForumTypeLabel(
                          //     //         ForumType.Forum);
                          //     // label.setProfilePhoto(await Session
                          //     //     .getCustomerPhotoUrl());
                          //     // Navigator.push(context,
                          //     //     MaterialPageRoute(builder: (_) {
                          //     //   return ForumMy(label);
                          //     // }));
                          //   },
                          // ),
                          SizedBox(
                            height: 8,
                          ),

                          Card(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 26, vertical: 4),
                                  child: BoldText('${translate('Information')}',
                                      18, kColorLabel),
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('Contact Us')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.contact_phone_outlined),
                                  onTap: () {
                                    Get.to(CmsPage("contact-us-mobile"));
                                    // showDialogDisclaimer();
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText("${translate('About Us')}",
                                      kitemlabel, 18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.group),
                                  onTap: () {
                                    Get.to(CmsPage("about-mobile"));

                                    // showDialogDisclaimer();
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('Disclaimer')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.assignment_turned_in_outlined),
                                  onTap: () {
                                    showDialogDisclaimer();
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('Terms and Conditions')}",
                                      kitemlabel,
                                      18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.library_books_outlined),
                                  onTap: () {
                                    Get.to(CmsPage("terms-mobile"));

                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (_) {
                                    //   return CmsPage("terms-mobile");
                                    // }));
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText("${translate('Share App')}",
                                      kitemlabel, 18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.share_outlined),
                                  onTap: () async {
                                    try {
                                      var response = await http.get(Uri.parse(
                                          "https://manjha.in/public/news/1620992246.png"));
                                      final documentDirectory =
                                          (await getExternalStorageDirectory())
                                              ?.path;
                                      File imgFile = new File(
                                          '$documentDirectory/manjha.png');
                                      imgFile
                                          .writeAsBytesSync(response.bodyBytes);
                                      //
                                      // ignore: deprecated_member_use
                                      Share.shareFiles(
                                          ['$documentDirectory/manjha.png'],
                                          text: "भारत की पहली मुफ्त ऑनलाइन मत्स्य बीज मण्डी 'मांझा'- मत्स्य किसानों की एक नई उड़ान। जिसके माध्यम से किसान अपनी पसंद और बजट के अनुसार नजदीकी हैचरी और मत्स्य किसानों से मछली बीज खरीद या बेच सकते हैं। " +
                                              "\nअभी डाउनलोड करे Manjha App - $app_link" +
                                              "\nवेबसाइट विजिट करे - www.manjha.in");
                                    } catch (e) {
                                      print(e);
                                      Share.share("भारत की पहली मुफ्त ऑनलाइन मत्स्य बीज मण्डी 'मांझा'- मत्स्य किसानों की एक नई उड़ान। जिसके माध्यम से किसान अपनी पसंद और बजट के अनुसार नजदीकी हैचरी और मत्स्य किसानों से मछली बीज खरीद या बेच सकते हैं। " +
                                          "\nअभी डाउनलोड करे Manjha App - $app_link" +
                                          "\nवेबसाइट विजिट करे - www.manjha.in");
                                    }
                                  },
                                ),
                                ListTile(
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),

                                  title: NormalText(
                                      "${translate('Logout')}", kitemlabel, 18),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  // leading: Icon(Icons.logout),
                                  onTap: () {
                                    _showSignOutDialog();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Divider(),
                          // Padding(
                          //   padding: const EdgeInsets.all(12),
                          //   child: SizedBox(
                          //     width: double.infinity,
                          //     height: 50,
                          //     child: FlatButton(
                          //       onPressed: () {
                          //         cleanSession();
                          //         // Navigator.pushAndRemoveUntil<
                          //         //     dynamic>(
                          //         //   context,
                          //         //   MaterialPageRoute<dynamic>(
                          //         //     builder: (BuildContext
                          //         //             context) =>
                          //         //         HomePage(),
                          //         //   ),
                          //         //   (route) =>
                          //         //       false, //if you want to disable back feature set to false
                          //         // );
                          //       },
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius:
                          //               new BorderRadius.circular(
                          //                   8.0)),
                          //       child: Text(
                          //         "Logout",
                          //         style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: 20),
                          //       ),
                          //       color: kColorButton,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  List<AddressModel> addressList = [];

  _fetchAddress() async {
    final response = await http
        .get(Common.getURL("store_addressList"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // "content-type": "application/x-www-form-urlencoded",
      'Cookie': Common.getCookie().toString()
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      print(resBody);
      final parsed = resBody["data"].cast<Map<String, dynamic>>();

      addressList = parsed
          .map<AddressModel>((json) => AddressModel.fromJson(json))
          .toList();

      if (addressList.length == 0) {
        EasyLoading.showToast(
            'No address found. Please enter delivery address.');
        // bool result =
        // await Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return ProfileScreen();
        // }));
        // _fetchAddress();
        return;
      }
      AddressModel? selectedAddress;
      String addressId = await Session.getPaymentAddressId();
      print('~~~' + addressId);
      // checked saved Address ID
      if (addressId.isNotEmpty &&
          addressId != "null" &&
          addressList.length > 0) {
        print('~~~1');
        selectedAddress = addressList.firstWhere(
            (element) => element.id.toString() == addressId,
            orElse: () => addressList[0]);
      }

      // else checked first address
      if (selectedAddress == null || !selectedAddress.getIsInitialized()) {
        print('~~~2');
        if (addressList.length > 0) {
          print('~~~3');
          selectedAddress = addressList[0];
        }
      }

      // if Address Found -> set in Local
      // if (selectedAddress != null && selectedAddress.getIsInitialized()) {
      //   print('~~~4');
      //   Session.setPaymentAddressModel(selectedAddress);
      //   intSelectedAddressIndex = addressList.indexWhere((element) => element.id == selectedAddress?.id);
      // }
      //
      // // Not found Index check Again
      // if (intSelectedAddressIndex < 0) intSelectedAddressIndex = addressList.indexOf(selectedAddress!);
      //
      // this.loadPaymentDefault();
      // this.refreshCart();
      // setState(() {
      //   // isLoading = false;
      // });
    } else {
      // refreshCart();
      // throw Exception('Failed to load request');
    }
  }

  showDialogDisclaimer() async {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Lang.get("Disclaimer")),
          content: new Text(Lang.get(
                  "Please do not give any amount to the seller without meeting.") +
              '\n' +
              Lang.get(
                  "Refuse for demanding for any advance payment for tempo or any.") +
              '\n' +
              Lang.get(
                  "Yourself will be only responsible for any transaction.")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(Lang.get("I Agree")),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));
}
