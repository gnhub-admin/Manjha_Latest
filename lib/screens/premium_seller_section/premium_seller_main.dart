import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manjha/screens/helper.dart';
import 'package:manjha/screens/premium_seller_section/manage_seed_screen.dart';
import 'package:manjha/screens/premium_seller_section/user_detail_screen.dart';
import 'package:manjha/shared_pref/shared_pref.dart';
import '../../getxcontrollers/premium_seller_section/premium_seller_controller.dart';
import '../../model/premium_seller_models/hatcheryloginmodel.dart';
import '../../services/apiconst.dart';
import '../../widget/button.dart';
import '../../widget/textfieldscreen.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../localconst.dart';
import 'galleries_screen.dart';

class PremiumSellerMain extends StatefulWidget {
  const PremiumSellerMain({super.key});

  @override
  State<PremiumSellerMain> createState() => _PremiumSellerMainState();
}

class _PremiumSellerMainState extends State<PremiumSellerMain> {
  List<String> imgList = [
    "assets/fish-hatcheries.jpg",
    "assets/fish-hatcheries.jpg",
    "assets/fish-hatcheries.jpg",
    "assets/fish-hatcheries.jpg",
    "assets/fish-hatcheries.jpg",
  ];
  int _current = 0;

  final CarouselController _controller = CarouselController();

  PremiumSellerController premiumSellerController =
      Get.put(PremiumSellerController());

  void _goToPage(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  TextEditingController phonenumber = TextEditingController(text: "9813489000");

  @override
  void initState() {
    if (hatcherylogin() != null) {
      phonenumber.text = hatcherylogin()?.hatchery?.mobileno ?? "";
      premiumSellerController.gethatcharylogin(
        mobileno: phonenumber.text,
      );
    } else {
      premiumSellerController.loginbool.value = true;
    }
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeeeeee),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: themecolor,
          title: const Text("Premium Seller"),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () {
                  SharedPref.deleteSpecific(prefKey: PrefKey.premiumseller);
                  premiumSellerController.hatcherydetail.value = Hatchery();
                  Get.back();
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ))
          ],
        ),
        body: Obx(
          () => premiumSellerController.loginbool.isFalse
              ? Center(
                  child:
                      CircularProgressIndicator(color: kheader, strokeWidth: 2),
                )
              : premiumSellerController.hatcherydetail.value.mobileno != null
                  ? Stack(
                      children: [
                        ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CupertinoButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            color: kheader,
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.edit_rounded,
                                                  color: kwhite,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                          child: Text(
                                                        "Valid Till",
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                      FittedBox(
                                                          child: Text(
                                                        DateFormat(
                                                                "d'th' MMM yyyy")
                                                            .format(premiumSellerController
                                                                    .hatcherydetail
                                                                    .value
                                                                    .expiryDate ??
                                                                DateTime.now()),
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CupertinoButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            color: kheader,
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: kwhite,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                          child: Text(
                                                        "Total Amount Paid",
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                      FittedBox(
                                                          child: Text(
                                                        "Rs. ${premiumSellerController.hatcherydetail.value.amountPaid}/-",
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CupertinoButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            color: kheader,
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.verified_rounded,
                                                  color: kwhite,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                          child: Text(
                                                        "NFDB Approved",
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                      FittedBox(
                                                          child: Text(
                                                        premiumSellerController
                                                                    .hatcherydetail
                                                                    .value
                                                                    .isNfbdApproved ==
                                                                true
                                                            ? "Yes"
                                                            : "No",
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CupertinoButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            color: kheader,
                                            onPressed: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.currency_rupee,
                                                  color: kwhite,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                          child: Text(
                                                        "Trusted By Manjha",
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                      FittedBox(
                                                          child: Text(
                                                        premiumSellerController
                                                                    .hatcherydetail
                                                                    .value
                                                                    .isManjhaTrusted ==
                                                                true
                                                            ? "Yes"
                                                            : "No",
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                            color: kwhite),
                                                      )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: CarouselSlider(
                                            carouselController: _controller,
                                            options: CarouselOptions(
                                              // aspectRatio: 16 / 10,
                                              viewportFraction: 1,
                                              animateToClosest: true,
                                              enlargeCenterPage: false,
                                              enableInfiniteScroll: true,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  _current = index;
                                                });
                                              },
                                            ),
                                            items: List.generate(
                                                imgList.length,
                                                (index) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: InkWell(
                                                        onTap: () {
                                                          print(
                                                              "$index tapped");
                                                        },
                                                        child: Stack(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  height: 190,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image:
                                                                                NetworkImage(premiumSellerController.hatcherydetail.value.imageUrl ?? ''),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
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
                                                    )).toList()),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (int i = 0;
                                              i < imgList.length;
                                              i++)
                                            GestureDetector(
                                              onTap: () {
                                                _goToPage(i);
                                              },
                                              child: Container(
                                                width: _current == i ? 10 : 10,
                                                height: _current == i ? 10 : 10,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _current == i
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: screenwidth(
                                                          context,
                                                          dividedby: 1.3),
                                                      child: Text(
                                                        "${premiumSellerController.hatcherydetail.value.hatcheryName}",
                                                        textScaleFactor: 1.5,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text("Sold By: ",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xffA6A7A7),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                        Text(
                                                          "${premiumSellerController.hatcherydetail.value.ownerName}",
                                                          style: TextStyle(
                                                              color: kheader,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${premiumSellerController.hatcherydetail.value.address}",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff929797),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                // Stack(
                                                //   alignment: Alignment.center,
                                                //   children: [
                                                //     Container(
                                                //       decoration: BoxDecoration(
                                                //         // color: kwhite,
                                                //         shape: BoxShape.rectangle,
                                                //
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //               color: Colors.grey, blurRadius: 2)
                                                //         ],
                                                //         borderRadius: BorderRadius.all(
                                                //           Radius.circular(5.0),
                                                //         ),
                                                //       ),
                                                //       height: 100,
                                                //       width: 60,
                                                //       child: FadeInImage.assetNetwork(
                                                //         fadeInCurve: Curves.easeInOut,
                                                //         fadeInDuration:
                                                //         Duration(milliseconds: 100),
                                                //         imageErrorBuilder: (context, error,
                                                //             stackTrace) =>
                                                //             Image.asset("assets/no-photo.png"),
                                                //         placeholder: 'assets/no-photo.png',
                                                //         image: widget._hatchery.getImageUrl(),
                                                //         height: 50.0,
                                                //         width: 50.0,
                                                //         fit: BoxFit.cover,
                                                //       ),
                                                //     ),
                                                //     MaterialButton(
                                                //         child: Icon(
                                                //           FontAwesomeIcons.play,
                                                //           color: Colors.white,
                                                //           size: 15,
                                                //         ),
                                                //         // color: kWhatsApp,
                                                //         minWidth: 45,
                                                //         height: 35,
                                                //         color: kheader.withAlpha(150),
                                                //         shape: RoundedRectangleBorder(
                                                //             borderRadius:
                                                //             BorderRadius.circular(5),
                                                //             side: BorderSide(
                                                //                 color: Colors.transparent)),
                                                //         onPressed: () {
                                                //           // TODO: LOG EVENTS
                                                //           showVideo(
                                                //               widget._hatchery.getVideoUrl());
                                                //         })
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 150,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      // color: Colors.red,
                                      child: ButtonTheme(
                                          height: 45,
                                          child: MaterialButton(
                                            color: kheader,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: BoldText(
                                                "Manage Seed", 18, kwhite),
                                            onPressed: () {
                                              Get.to(() => ManageSeedScreen());
                                            },
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      // color: Colors.red,
                                      child: ButtonTheme(
                                          height: 45,
                                          child: MaterialButton(
                                            color: kheader,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: BoldText(
                                                "User Details", 18, kwhite),
                                            onPressed: () {
                                              Get.to(() => UserDetailScreen());
                                            },
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  // color: Colors.red,
                                  child: WideButton.bold(Lang.get("Galleries"),
                                      () async {
                                    Get.to(() => GalleriesScreen());
                                  }, true)),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BoldText("Phone Number :", 16, kheader),
                                const SizedBox(
                                  height: 5,
                                ),
                                NormalForm(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Enter phone number";
                                    }
                                    return null;
                                  },
                                  maxLength: 10,
                                  // FontAwesomeIcons.mapMarkerAlt,
                                  null,
                                  "Phone Number",
                                  customHintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                  textInputType: TextInputType.number,
                                  controller: phonenumber,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    // color: Colors.red,
                                    child: WideButton.bold(Lang.get("Submit"),
                                        () async {
                                      if (_formKey.currentState!.validate()) {
                                        premiumSellerController
                                            .gethatcharylogin(
                                          mobileno: phonenumber.text,
                                        );
                                      }
                                    }, true)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
