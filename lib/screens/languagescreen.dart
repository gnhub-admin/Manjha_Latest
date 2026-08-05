import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/screens/mainscreen.dart';
import 'package:manjha/services/apiconst.dart';
import '../getxcontrollers/locationcontroller.dart';
import '../getxcontrollers/mixpanelcontroller.dart';
import '../languagetranslation/apptranslation.dart';
import '../shared_pref/shared_pref.dart';
import 'localconst.dart';

class LanguageScreen extends StatefulWidget {
  final int? isback;

  const LanguageScreen({super.key, this.isback});
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  //AnimationController controller;
  //Animation<double> animation;

  //AlignmentGeometry _alignment = Alignment.bottomLeft;
  //AlignmentGeometry _geometry = Alignment.bottomRight;
  // double _footerPositionLeft = 400.0;

  LocationController locationController = Get.put(LocationController());

  // double _footerPositionRight = -200.0;
  bool _animate = false;
  // void _changeAlignment() {
  //   setState(() {
  //     // _footerPositionLeft = 400.0;
  //     // _alignment = _alignment == Alignment.bottomLeft
  //     //     ? Alignment.bottomLeft
  //     //     : Alignment.bottomLeft;
  //     // _geometry = _geometry == Alignment.bottomRight
  //     //     ? Alignment.bottomLeft
  //     //     : Alignment.bottomRight;
  //     // (_footerPositionLeft == 0)
  //     //     ? _footerPositionLeft = 400
  //     //     : _footerPositionLeft = 0;
  //
  //     // _footerPositionRight = 0;
  //     _animate = !_animate;
  //   });
  // }

  String? selectedLanguage;

  void fetchSelectedLanguage() async {
    selectedLanguage = await languagecode();
    setState(() {});
  }

  List languagelist = [
    "${translate("English")}",
    "${translate("Bangla")}",
    "${translate("Hindi")}",
    "${translate("Odia")}"
  ];

  List imgList = [
    "A",
    "ক",
    "अ",
    "କ",
  ];

  @override
  void initState() {
    var userItem = saveUser()?.data;
    if (userItem != null) {
      MixpanelController.initMixpanel(
        userItem.id.toString(),
        userItem.emailid ?? "Not-Set",
        userItem.mobileno ?? "Not-Set",
      );
    }
    MixpanelController.logScreen(MixpanelController.PageLanguage);
    super.initState();
    fetchSelectedLanguage();
  }

  // https://github.com/flutter/website/blob/master/examples/animation/animate5/lib/main.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cartbackgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // BoldText("Aight",35.0,kdarkBlue),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Row(
                    children: [
                      if (widget.isback == 1)
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    width: 175,
                  ),
                ),
                //),
                SizedBox(height: 20),
                // NormalText(Lang.get("${translate("Please Select Language")}"), Colors.black38, 16.0),
                Text(Lang.get("${translate("Please Select Language")}"),
                    textScaleFactor: 1.25,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500)),
                // _dropDown(context),
              ],
            ),
            Container(
                // height: 500,

                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (index == 0) {
                          MixpanelController.logScreen(
                              MixpanelController.PageLanguage,
                              properties: {"Language": "English"});
                          Get.updateLocale(const Locale("en", "US"));
                          SharedPref.save(
                              value: "en", prefKey: PrefKey.languagecode);
                          SharedPref.save(
                              value: "US", prefKey: PrefKey.langcontry);
                          Get.offAll(MainScreens(
                            initialIndex: 0,
                          ));
                        } else if (index == 1) {
                          MixpanelController.logScreen(
                              MixpanelController.PageLanguage,
                              properties: {"Language": "Bangla"});

                          Get.updateLocale(const Locale("bn", "IN"));
                          SharedPref.save(
                              value: "bn", prefKey: PrefKey.languagecode);
                          SharedPref.save(
                              value: "IN", prefKey: PrefKey.langcontry);
                          Get.offAll(MainScreens(
                            initialIndex: 0,
                          ));
                        } else if (index == 2) {
                          MixpanelController.logScreen(
                              MixpanelController.PageLanguage,
                              properties: {"Language": "Hindi"});

                          Get.updateLocale(const Locale("hi", "IN"));
                          SharedPref.save(
                              value: "hi", prefKey: PrefKey.languagecode);
                          SharedPref.save(
                              value: "IN", prefKey: PrefKey.langcontry);
                          Get.offAll(MainScreens(
                            initialIndex: 0,
                          ));
                        } else if (index == 3) {
                          MixpanelController.logScreen(
                              MixpanelController.PageLanguage,
                              properties: {"Language": "Odia"});

                          Get.updateLocale(const Locale("or", "IN"));
                          SharedPref.save(
                              value: "or", prefKey: PrefKey.languagecode);
                          SharedPref.save(
                              value: "IN", prefKey: PrefKey.langcontry);
                          Get.offAll(MainScreens(
                            initialIndex: 0,
                          ));
                        }
                        // else if (index == 2) {
                        //   Fluttertoast.showToast(
                        //     msg: "This Language is in Development Phase, will Update in sometime...",
                        //     fontSize: 12,
                        //     textColor: Colors.white,
                        //     backgroundColor: Colors.red,
                        //   );
                        // } else if (index == 3) {
                        //   Fluttertoast.showToast(
                        //     msg: "This Language is in Development Phase, will Update in sometime...",
                        //     fontSize: 12,
                        //     textColor: Colors.white,
                        //     backgroundColor: Colors.red,
                        //   );
                        // }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.all(5),
                        height: 80,
                        child: Card(
                          color: index == 2 || index == 3
                              ? /*Colors.grey.shade300*/ kwhite
                              : kwhite,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: index == 0
                                        ? themecolor
                                        : index == 1
                                            ? Colors.orange
                                            : index == 2
                                                ? Colors.purple
                                                : Colors.blue,
                                    // foregroundImage: AssetImage(imgList[index]),
                                    child: Text(
                                      imgList[index],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: kwhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  title: Text(
                                    languagelist[index],
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_rounded)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            // _langListView(context),
            // SizedBox(
            //   height: 10,
            // ),
            // _langListView2(context),
          ],
        ),
      ),
    );
  }

  void updateLanguage(int index) {
    // if (index == 2 || index == 3) {
    //   Fluttertoast.showToast(
    //     msg: "This Language is in Development Phase, will Update in sometime...",
    //     fontSize: 12,
    //     textColor: Colors.white,
    //     backgroundColor: Colors.red,
    //   );
    //   return;
    // }
    setState(() {
      selectedLanguage = index.toString();
    });
    String? languageCode;
    if (index == 0) {
      languageCode = "en";
    } else if (index == 1) {
      languageCode = "bn";
    } else if (index == 2) {
      languageCode = "hi";
    } else if (index == 3) {
      languageCode = "or";
    }
    SharedPref.save(value: languageCode ?? "", prefKey: PrefKey.languagecode);
    Get.updateLocale(Locale(languageCode ?? "", "IN"));
    SharedPref.save(value: "IN", prefKey: PrefKey.langcontry);
    Get.offAll(MainScreens(
      initialIndex: 0,
    ));
  }

  int? selectedLanguageIndex() {
    if (selectedLanguage == "en") {
      return 0;
    } else if (selectedLanguage == "bn") {
      return 1;
    } else if (selectedLanguage == "hi") {
      return 2;
    } else if (selectedLanguage == "or") {
      return 3;
    }
    return null;
  }

  Widget getFooter(BuildContext context) {
    return new Positioned(
        child: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        AnimatedPositioned(
          // alignment: _geometry,
          left: 0,
          bottom: _animate ? -200 : 0,
          curve: Curves.easeOutCubic,
          duration: Duration(seconds: 1),
          child: Image.asset(
            'assets/bgfooter-1.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomLeft,
            height: 275,
          ),
        ),
        AnimatedPositioned(
          // alignment: _geometry,
          left: _animate ? -250 : 0,
          bottom: 0.0,
          curve: Curves.easeInOutCubic,
          duration: Duration(seconds: 3),
          child: Image.asset(
            'assets/bgfooter-12.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomLeft,
            height: 275,
          ),
        ),
        AnimatedPositioned(
          // alignment: _geometry,
          left: _animate ? 400 : 0,
          bottom: 0.0,
          curve: Curves.easeInOutCubic,
          duration: Duration(seconds: 2),
          child: Image.asset(
            'assets/bgfooter-11.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomLeft,
            height: 275,
          ),
        ),
        // Center(
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(primary: Colors.black),
        //     onPressed: () => _changeAlignment(),
        //     child: Text('START'),
        //   ),
        // )
      ],
    ));
  }

  Widget getHeader(BuildContext context) {
    return new Positioned(
        child: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        AnimatedPositioned(
          // alignment: _geometry,
          left: 0,
          top: _animate ? -200 : 0,
          curve: Curves.easeOutCubic,
          duration: Duration(seconds: 1),
          child: Image.asset(
            'assets/bgheader-1.png',
            fit: BoxFit.contain,
            alignment: Alignment.topRight,
            height: 275,
          ),
        ),
        AnimatedPositioned(
          // alignment: _geometry,
          right: _animate ? -200 : 0,
          top: 0.0,
          curve: Curves.easeInOutCubic,
          duration: Duration(seconds: 2),
          child: Image.asset(
            'assets/bgheader-12.png',
            fit: BoxFit.contain,
            alignment: Alignment.topRight,
            height: 275,
          ),
        ),
        AnimatedPositioned(
          // alignment: _geometry,
          right: _animate ? 300 : 0,
          top: 0.0,
          curve: Curves.easeInOutCubic,
          duration: Duration(seconds: 2),
          child: Image.asset(
            'assets/bgheader-11.png',
            fit: BoxFit.contain,
            alignment: Alignment.topRight,
            height: 275,
          ),
        )
      ],
    ));
  }

  // _showLogin() {
  //   Navigator.push(context, MaterialPageRoute(builder: (_) {
  //     return LocationScreen();
  //     // return LoginScreen();
  //   }));
  // }

  /**/

  // Widget _langListView(BuildContext context) {
  //   return Container(
  //       height: 45,
  //       width: 200,
  //       child: Center(
  //         child: ListView(
  //           scrollDirection: Axis.horizontal, //Axis.vertical
  //           children: <Widget>[
  //             MaterialButton(
  //               color: Colors.white,
  //               child: Text(
  //                 Lang.get('English'),
  //                 style: TextStyle(fontSize: 16, fontFamily: "nunito"),
  //               ),
  //               textColor: Colors.black87,
  //               splashColor: Colors.white,
  //               onPressed: () {
  //                 Get.updateLocale(const Locale("en", "US"));
  //                 SharedPref.save(value: "en", prefKey: PrefKey.languagecode);
  //                 SharedPref.save(value: "US", prefKey: PrefKey.langcontry);
  //                 Get.offAll(MainScreens(
  //                   initialIndex: 0,
  //                 ));
  //               },
  //               padding: EdgeInsets.only(top: 12, bottom: 12),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: Colors.black26)),
  //             ),
  //             Padding(padding: EdgeInsets.all(5.00)),
  //             MaterialButton(
  //               color: Colors.white,
  //               child: Text(
  //                 Lang.get('Bangla'),
  //                 style: TextStyle(fontSize: 16, fontFamily: "nunito"),
  //               ),
  //               textColor: Colors.black87,
  //               splashColor: Colors.white,
  //               onPressed: () {
  //                 Get.updateLocale(const Locale("bn", "IN"));
  //                 SharedPref.save(value: "bn", prefKey: PrefKey.languagecode);
  //                 SharedPref.save(value: "IN", prefKey: PrefKey.langcontry);
  //                 Get.offAll(MainScreens(
  //                   initialIndex: 0,
  //                 ));
  //               },
  //               padding: EdgeInsets.only(top: 12, bottom: 12),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: Colors.black26)),
  //             ),
  //           ],
  //         ),
  //       ));
  // }
  //
  // Widget _langListView2(BuildContext context) {
  //   return Container(
  //       height: 45,
  //       width: 200,
  //       child: Center(
  //         child: ListView(
  //           scrollDirection: Axis.horizontal, //Axis.vertical
  //           children: <Widget>[
  //             MaterialButton(
  //               color: Colors.grey.shade300,
  //               child: Text(
  //                 Lang.get('Hindi'),
  //                 style: TextStyle(fontSize: 16, fontFamily: "nunito"),
  //               ),
  //               textColor: Colors.black87,
  //               splashColor: Colors.white,
  //               onPressed: () {},
  //               padding: EdgeInsets.only(top: 12, bottom: 12),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: Colors.black26)),
  //             ),
  //             Padding(padding: EdgeInsets.all(5.00)),
  //             MaterialButton(
  //               color: Colors.grey.shade300,
  //               child: Text(
  //                 Lang.get('Odia'),
  //                 style: TextStyle(fontSize: 16, fontFamily: "nunito"),
  //               ),
  //               textColor: Colors.black87,
  //               splashColor: Colors.white,
  //               onPressed: () {},
  //               padding: EdgeInsets.only(top: 12, bottom: 12),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: Colors.black26)),
  //             ),
  //           ],
  //         ),
  //       ));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // locationController.getSessionapi();
  //   // // controller =
  //   // //     new AnimationController(duration: Duration(seconds: 3), vsync: this)
  //   // //       ..addListener(() => setState(() {}));
  //   // // animation = Tween(begin: -500.0, end: 0.0).animate(controller);
  //   // // controller.forward();
  //   //
  //   // Timer(Duration(seconds: 1), () => _changeAlignment());
  //   //
  //   // setState(() {
  //   //   this._animate = true;
  //   //   // _changeAlignment();
  //   // });
  //   // // Future.delayed(Duration(seconds: 4), () {
  //   // //   Navigator.push(context, MaterialPageRoute(builder: (_) {
  //   // //     return LandingPage();
  //   // //   }));
  //   // // });
  // }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }
}
