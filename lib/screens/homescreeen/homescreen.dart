import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/getxcontrollers/homecotroller.dart';
import 'package:manjha/model/gethitcheryresponse.dart';
import 'package:manjha/model/searchfishresponse.dart';
import 'package:manjha/screens/fishlistscreen.dart';
import 'package:manjha/screens/seddpages/seeddetailpage.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../getxcontrollers/maincontroller.dart';
import '../../shared_pref/shared_pref.dart';
import '../../widget/common.dart';
import '../../widget/textfieldscreen.dart';
import '../helper.dart';
import '../localconst.dart';
import '../premium_seller_section/premium_seller_main.dart';
import '../profile_screens/MyListingPage.dart';
import '../seddpages/fishdetailsscreen.dart';
import 'sellfishscreen.dart';
import 'hatchery_listing.dart';

class MyModel {
  final String text;
  final IconData icon;

  MyModel({required this.text, required this.icon});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  HomePageController homePageController = Get.put(HomePageController());
  MainController m = Get.put(MainController());

  // List<String> _selectedFish = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List<bool> tappedStates = List.generate(, (index) => false);
  CustomLocation? location;
  @override
  void initState() {
    Map<String, dynamic> item =
        jsonDecode(SharedPref.get(prefKey: PrefKey.location) ?? '');
    location = CustomLocation.fromJson(item);

    if (m.secondscreen.isFalse) {
      homePageController.fishtype();
      if (homePageController.seedloading.isFalse) {
        homePageController.gethitcheryCall();
      }
      if (homePageController.fidhloading.isFalse) {
        homePageController.getsalefishCall(location: location);
      }
      ;

      m.secondscreen.value = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  List<MyModel> name = [
    MyModel(text: "Premium seed", icon: Icons.star),
    MyModel(text: "Add seed", icon: Icons.add),
    MyModel(text: "My listing", icon: Icons.list),
    MyModel(text: "Contact Us", icon: FontAwesomeIcons.headset)
  ];

  final CarouselController _controller = CarouselController();
  bool isLoading = false;
  List<Map<String, dynamic>> places = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        // backgroundColor: kgreyFill,
        // drawer: Drawer(
        //   child: MenuDrawer(),
        // ),m
        body: GetBuilder<HomePageController>(
          builder: (controller) => ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _showBottomSheet();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  "${location?.city} ",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(MyListingPage());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: themecolor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: kwhite,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Sell Seed",
                                    style:
                                        TextStyle(color: kwhite, fontSize: 20),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  seeAllView(context, "Fish Hatchery", () {
                    // Get.to(() => SeedDetailsPage());
                    Get.to(
                        () => HatcheryListing(fishseed: controller.fishseed));
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                            aspectRatio: 16 / 11,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                          items: List.generate(controller.fishseed.length,
                              (index) {
                            Fish fishseed = controller.fishseed[index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                    () => SeedDetailsPage(hatchery: fishseed));
                                // Get.to(() => SeedListing());
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      fishseed.imageUrl ?? ""),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: screenwidth(
                                                            context,
                                                            dividedby: 1.6),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              fishseed.hatcheryName ??
                                                                  '',
                                                              style: TextStyle(
                                                                  color: kwhite,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              fishseed.address ??
                                                                  'Unnao, Uttar Pradesh',
                                                              style: TextStyle(
                                                                  color: kwhite,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Visibility(
                                                                  visible: fishseed
                                                                          .isManjhaTrusted ??
                                                                      false,
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            kheader,
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(3),
                                                                    child: Text(
                                                                        "Trusted by Manjha",
                                                                        style: TextStyle(
                                                                            color:
                                                                                kwhite,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Visibility(
                                                                  visible: fishseed
                                                                          .isNfbdApproved ??
                                                                      false,
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .teal,
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(3),
                                                                    child: Text(
                                                                        "NFBD Approved",
                                                                        style: TextStyle(
                                                                            color:
                                                                                kwhite,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  child: Align(
                                                    child:
                                                        PopupMenuButton<String>(
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder: (BuildContext
                                                              context) =>
                                                          <
                                                              PopupMenuEntry<
                                                                  String>>[
                                                        PopupMenuItem<String>(
                                                          height: 0,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          value: 'phone',
                                                          child: ListTile(
                                                            leading: Icon(
                                                              Icons.phone,
                                                              color: kheader
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            title:
                                                                Text('Phone'),
                                                          ),
                                                        ),
                                                        PopupMenuItem<String>(
                                                          height: 0,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          value: 'whatsapp',
                                                          child: ListTile(
                                                            leading: Icon(
                                                              Icons
                                                                  .message_outlined,
                                                              color: Colors
                                                                  .green
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            title: Text(
                                                                'WhatsApp'),
                                                          ),
                                                        ),
                                                        PopupMenuItem<String>(
                                                          height: 0,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          value: 'share',
                                                          child: ListTile(
                                                            leading: Icon(
                                                              Icons
                                                                  .share_outlined,
                                                              color: kdarkBlue,
                                                            ),
                                                            title:
                                                                Text('Share'),
                                                          ),
                                                        ),
                                                      ],
                                                      onSelected:
                                                          (String value) async {
                                                        switch (value) {
                                                          case 'phone':
                                                            controller.hatcheryLog(
                                                                fishseed.id,
                                                                controller
                                                                    .ACTION_CALL);
                                                            // ignore: deprecated_member_use
                                                            launch(
                                                                "tel:+91${fishseed.mobileno}");
                                                            break;
                                                          case 'whatsapp':
                                                            controller.hatcheryLog(
                                                                fishseed.id,
                                                                controller
                                                                    .ACTION_WHATSAPP);
                                                            String strUserName =
                                                                await saveUser()
                                                                        ?.data
                                                                        ?.fullName ??
                                                                    "";
                                                            String strCity =
                                                                await saveUser()
                                                                        ?.data
                                                                        ?.cityname ??
                                                                    "";

                                                            String strMessage =
                                                                Common.getWhtapAppMessage(
                                                                    strUserName,
                                                                    strCity);
                                                            // ignore: deprecated_member_use
                                                            launch(Uri.encodeFull(
                                                                "https://wa.me/91${fishseed.mobileno}?text=$strMessage"));

                                                            break;
                                                          case 'share':
                                                            controller.hatcheryLog(
                                                                fishseed.id,
                                                                controller
                                                                    .ACTION_SHARE);
                                                            Share.share(fishseed
                                                                .getShareText());

                                                            break;
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.more_vert_rounded,
                                                        color: kwhite,
                                                      ),
                                                    ),
                                                    // Icon(CupertinoIcons.ellipsis_vertical),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Card(
                                    margin: EdgeInsets.only(
                                        top: 50,
                                        bottom: 10,
                                        left: 15,
                                        right: 15),
                                    elevation: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // height: 110,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Availability',
                                                  style: TextStyle(
                                                      color: kgreyDark,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Size',
                                                  style: TextStyle(
                                                      color: kgreyDark,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Line',
                                                  style: TextStyle(
                                                      color: kgreyDark,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Column(
                                            children: List.generate(
                                              fishseed.seeds?.length ?? 0,
                                              (indexseed) => Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                        fishseed
                                                                .seeds![
                                                                    indexseed]
                                                                .seedName ??
                                                            'Pangas(parlour property of the functionality)',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: kheader,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Center(
                                                        child: Text(
                                                          '${fishseed.seeds![indexseed].seedSize}',
                                                          style: TextStyle(
                                                              color: kheader,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child: Text(
                                                          '${fishseed.seeds![indexseed].seedWeight}.0 pc/kg' ??
                                                              '100.0 pc/kg',
                                                          style: TextStyle(
                                                              color: kheader,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 75),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(left: 10),
                      //         child: Align(
                      //           alignment: Alignment.centerLeft,
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               _controller.previousPage();
                      //             },
                      //             child: Container(
                      //               width: 50,
                      //               height: 50,
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 color: kheader.withOpacity(0.5),
                      //               ),
                      //               child: Icon(Icons.keyboard_arrow_left_rounded,color: Colors.white,),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(right: 10),
                      //         child: Align(
                      //           alignment: Alignment.centerRight,
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               _controller.nextPage();
                      //               // print("tapped");
                      //             },
                      //             child: Container(
                      //               width: 50,
                      //               height: 50,
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 color: Colors.white.withOpacity(0.5),
                      //               ),
                      //               child: Icon(Icons.keyboard_arrow_right_rounded,color: Colors.white,),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20.0, vertical: 10),
                  //   child: Row(
                  //     children: List.generate(
                  //         name.length,
                  //         (index) => Expanded(
                  //               child: InkWell(
                  //                 onTap: () {
                  //                   switch (index) {
                  //                     case 0:
                  //                       Get.to(() => PremiumSellerMain());
                  //                       break;
                  //                     case 1:
                  //                       Get.to(() => SellFishScreen());
                  //                       break;
                  //                     case 2:
                  //                       Get.to(() => MyListingPage());
                  //                       break;
                  //                     default:
                  //                       break;
                  //                   }
                  //                 },
                  //                 child: Column(
                  //                   children: [
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5.0),
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                           color: Colors.white,
                  //                           borderRadius:
                  //                               BorderRadius.circular(10),
                  //                           border: Border.all(
                  //                               width: 2,
                  //                               color: Colors.grey.shade300),
                  //                         ),
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.all(15.0),
                  //                           child: Icon(name[index].icon),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(height: 0),
                  //                     Text(
                  //                       name[index].text,
                  //                       style: const TextStyle(
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.w500,
                  //                           color: Colors.black),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             )),
                  //   ),
                  // ),
                  // Expanded(
                  //     child: Container(
                  //   // height: 30,
                  //   margin: EdgeInsets.symmetric(horizontal: 10),
                  //   decoration: BoxDecoration(
                  //       color: themecolor,
                  //       borderRadius: BorderRadius.circular(5)),
                  //   child: TextButton.icon(
                  //       onPressed: () {
                  //         Get.to(() => PremiumSellerMain());
                  //       },
                  //       icon: Icon(
                  //         Icons.star,
                  //         color: kwhite,
                  //       ),
                  //       label: Text(
                  //         "Premium Seed",
                  //         style: TextStyle(color: kwhite),
                  //       )),
                  // )),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "Fish Categories",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 180,
                        child: GridView.builder(
                          scrollDirection: Axis
                              .horizontal, // Set the scroll direction to horizontal
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            childAspectRatio: 1, // Aspect ratio for each item
                            mainAxisSpacing:
                                10, // Spacing between items in main axis
                            crossAxisSpacing:
                                10, // Spacing between items in cross axis
                          ),
                          itemCount: homePageController
                              .fishtypelist.length, // Total num`ber of items
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                homePageController.getsalefishCalltype(
                                    fishtypeid: homePageController
                                        .fishtypelist[index].id
                                        .toString());
                                Get.to(FishScreenList(
                                    fishname: homePageController
                                        .fishtypelist[index].fishTypeName));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://manjha.in/public//manjha-assets/images/manjha-svg/fish-seed.png"),
                                    backgroundColor: kgreyFill,
                                    radius: 25,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    homePageController
                                            .fishtypelist[index].fishTypeName ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sellers near by you",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 10,
                          endIndent: 20,
                          indent: 20,
                          color: Colors.grey,
                        );
                      },
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.fishlist.length,
                      itemBuilder: (context, index) {
                        Fishes fish = controller.fishlist[index];

                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      () => FishDetailsScreen(saleItem: fish));
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          height: 150,
                                          width: 130,
                                          imageUrl: fish.getImageURL(),
                                          cacheKey: fish.getImageURL(),
                                          // imageUrl: newsItem?.getImageUrl() ?? "",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 130,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    fish.getImageURL()),
                                              ),
                                            ),
                                            // child: Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           top: 10, right: 10),
                                            //   child: GestureDetector(
                                            //     onTap: () {
                                            //       setState(() {
                                            //         fish.setFavorite(!fish
                                            //             .is_favorite());
                                            //       });
                                            //       homePageController
                                            //           .myFavoriteAdd(
                                            //               fish.id,
                                            //               isRemove: fish
                                            //                   .is_favorite());
                                            //     },
                                            //     child: Align(
                                            //       alignment:
                                            //           Alignment.topRight,
                                            //       child: Icon(
                                            //         fish.isFavorite == 1
                                            //             ? CupertinoIcons
                                            //                 .heart_fill
                                            //             : CupertinoIcons
                                            //                 .heart,
                                            //         color:
                                            //             fish.isFavorite == 1
                                            //                 ? Colors.red
                                            //                 : Colors.white,
                                            //       ),
                                            //     ),
                                            //     // child: Align(
                                            //     //     alignment: Alignment.topRight,
                                            //     //     child: Icon(tapped ? CupertinoIcons.heart_fill : CupertinoIcons.heart, color: tapped ? Colors.red : Colors.white,)),
                                            //   ),
                                            // ),
                                          ),
                                          placeholder: (context, url) => Center(
                                              child: Image.asset(
                                            'assets/no-photo.png',
                                            fit: BoxFit.cover,
                                          )),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                                  child: Image.asset(
                                            'assets/no-photo.png',
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  softWrap: true,
                                                  textScaleFactor: 1.3,
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${fish.fishTypeName} ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      // TextSpan(
                                                      //   text: 'fish',
                                                      //   style: TextStyle(
                                                      //       color: Colors.black,
                                                      //       fontWeight:
                                                      //           FontWeight.w400),
                                                      // ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${fish.sellerName}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .location_solid,
                                                      color: kheader,
                                                      size: 20,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          "${fish.address} | ${fish.distance?.toStringAsFixed(0)}km",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: kgreyDark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    )
                                                  ],
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.symmetric(
                                                //       vertical: 5),
                                                //   child: RichText(
                                                //     softWrap: true,
                                                //     textScaleFactor: 1.5,
                                                //     textAlign: TextAlign.start,
                                                //     text: TextSpan(
                                                //       children: [
                                                //         TextSpan(
                                                //           text: '₹ ',
                                                //           style: TextStyle(
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .w400,
                                                //               color:
                                                //                   Colors.black,
                                                //               fontSize: 18),
                                                //         ),
                                                //         TextSpan(
                                                //           text:
                                                //               '${fish.getPrice()}',
                                                //           style: TextStyle(
                                                //               color:
                                                //                   Colors.black,
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .w400),
                                                //         ),
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Price:',
                                                            style: TextStyle(
                                                                color:
                                                                    kgreyDark,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            '${fish.getPrice()}',
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Size:',
                                                            style: TextStyle(
                                                                color:
                                                                    kgreyDark,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            '${fish.fishSizeType}',
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                color:
                                                                    themecolor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Weight:',
                                                            style: TextStyle(
                                                                color:
                                                                    kgreyDark,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            fish.getWeight(),
                                                            style: TextStyle(
                                                                color:
                                                                    themecolor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            homePageController
                                                                .saleitemLog(
                                                                    fish.id,
                                                                    homePageController
                                                                        .ACTION_CALL);
                                                            launch(
                                                                "tel:+91${fish.contactno}");
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    themecolor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Center(
                                                              child: Icon(
                                                                  Icons.call,
                                                                  color: kwhite,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            homePageController
                                                                .saleitemLog(
                                                                    fish.id,
                                                                    homePageController
                                                                        .ACTION_WHATSAPP);
                                                            String strUserName =
                                                                await saveUser()
                                                                        ?.data
                                                                        ?.fullName ??
                                                                    "";
                                                            String strCity =
                                                                await saveUser()
                                                                        ?.data
                                                                        ?.cityname ??
                                                                    "";

                                                            String strMessage =
                                                                Common.getWhtapAppMessage(
                                                                    strUserName,
                                                                    strCity);
                                                            launch(Uri.encodeFull(
                                                                "https://wa.me/91${fish.contactno}?text=$strMessage"));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Center(
                                                              child: Icon(
                                                                  FontAwesomeIcons
                                                                      .whatsapp,
                                                                  color: kwhite,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              fish.setFavorite(!fish
                                                                  .is_favorite());
                                                            });
                                                            homePageController
                                                                .myFavoriteAdd(
                                                                    fish.id,
                                                                    isRemove: fish
                                                                        .is_favorite());
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 1.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Center(
                                                              child: Icon(
                                                                  fish.isFavorite ==
                                                                          1
                                                                      ? CupertinoIcons
                                                                          .heart_fill
                                                                      : CupertinoIcons
                                                                          .heart,
                                                                  // FontAwesomeIcons
                                                                  //     .heart,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            'Updated at:',
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          Text(
                                                            fish.getLastUpdateDate(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  clipBehavior: Clip.none,
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      height: 0,
                                      padding: EdgeInsets.zero,
                                      value: 'phone',
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.phone,
                                          color: kheader.withOpacity(0.7),
                                        ),
                                        title: Text('Phone'),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      height: 0,
                                      padding: EdgeInsets.zero,
                                      value: 'whatsapp',
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.message_outlined,
                                          color: Colors.green.withOpacity(0.5),
                                        ),
                                        title: Text('WhatsApp'),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      height: 0,
                                      padding: EdgeInsets.zero,
                                      value: 'share',
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.share_outlined,
                                          color: kdarkBlue,
                                        ),
                                        title: Text('Share'),
                                      ),
                                    ),
                                  ],
                                  onSelected: (String value) async {
                                    switch (value) {
                                      case 'phone':
                                        homePageController.saleitemLog(fish.id,
                                            homePageController.ACTION_CALL);
                                        launch("tel:+91${fish.contactno}");
                                        break;
                                      case 'whatsapp':
                                        homePageController.saleitemLog(fish.id,
                                            homePageController.ACTION_WHATSAPP);
                                        String strUserName =
                                            await saveUser()?.data?.fullName ??
                                                "";
                                        String strCity =
                                            await saveUser()?.data?.cityname ??
                                                "";

                                        String strMessage =
                                            Common.getWhtapAppMessage(
                                                strUserName, strCity);
                                        launch(Uri.encodeFull(
                                            "https://wa.me/91${fish.contactno}?text=$strMessage"));

                                        break;
                                      case 'share':
                                        homePageController.saleitemLog(fish.id,
                                            homePageController.ACTION_SHARE);
                                        if (fish.hasImage()) {
                                          final box = context.findRenderObject()
                                              as RenderBox?;

                                          var response = await http.get(
                                              Common.getURL(
                                                  fish.getImageURL()));
                                          final documentDirectory =
                                              (await getExternalStorageDirectory())!
                                                  .path;
                                          File imgFile = new File(
                                              '$documentDirectory/manjha.png');
                                          imgFile.writeAsBytesSync(
                                              response.bodyBytes);
                                          Share.shareFiles(
                                              ['$documentDirectory/manjha.png'],
                                              text: fish.getShareText(),
                                              // text: subject,
                                              sharePositionOrigin: box!
                                                      .localToGlobal(
                                                          Offset.zero) &
                                                  box.size);
                                        } else {
                                          final ByteData bytes =
                                              await rootBundle
                                                  .load('assets/no-photo.png');
                                          final Uint8List list =
                                              bytes.buffer.asUint8List();

                                          final tempDir =
                                              await getTemporaryDirectory();
                                          final file = await new File(
                                                  '${tempDir.path}/no-photo.png')
                                              .create();
                                          file.writeAsBytesSync(list);

                                          Share.shareFiles(['${file.path}'],
                                              text: fish.getShareText());
                                          //Share.share(saleitem.getShareText());
                                        }
                                        break;
                                    }
                                  },
                                ),
                                // Icon(CupertinoIcons.ellipsis_vertical),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    places.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 25,
                ),
                NormalForm(
                  onChanged: (value) async {
                    await fetchPlaces(value, setModalState);
                  },

                  // FontAwesomeIcons.mapMarkerAlt,
                  FontAwesomeIcons.locationDot,
                  "",
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Search Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final locationapi = places[index];
                        return ListTile(
                          onTap: () async {
                            CustomLocation addlocation = CustomLocation();
                            addlocation.city =
                                locationapi['city_name'].toString();
                            addlocation.state =
                                locationapi['state_name'].toString();
                            addlocation.lat =
                                locationapi['latitude'].toString();
                            addlocation.long =
                                locationapi['longitude'].toString();
                            location = addlocation;
                            // EasyLoading.show();
                            await homePageController.getsalefishCall(
                                location: addlocation);
                            EasyLoading.dismiss();

                            Get.back();
                          },
                          title: Text(locationapi['place_name']),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<List<Map<String, dynamic>>> getPlacesData(String searchText) async {
    final String accessToken =
        'pk.eyJ1IjoiZGl2eWFtZ2wyNyIsImEiOiJja2pzNmxsNjYyZms1MzBtancyaHh6OHYzIn0.jAm9YQFTmfCus68C1HtvHw';
    final String url =
        'https://api.mapbox.com/search/geocode/v6/forward?access_token=$accessToken&q=$searchText&country=IN';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);
        if (data['features'] != null && data['features'].isNotEmpty) {
          // Extract the list of places
          List<Map<String, dynamic>> places = [];
          for (var feature in data['features']) {
            final placeName = feature['properties']["full_address"];
            final cityname = feature['properties']["name"];
            final statename =
                feature['properties']['context']['region']['name'];
            final coordinates = feature['properties']['coordinates'];
            final double longitude = coordinates["longitude"];
            final double latitude = coordinates["latitude"];

            places.add({
              'place_name': placeName,
              'city_name': cityname,
              'state_name': statename,
              'latitude': latitude,
              'longitude': longitude,
            });
          }
          return places;
        }
      } else {
        print('Failed to load places');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }

  Future<void> fetchPlaces(String searchText, setState) async {
    setState(() {
      isLoading = true;
    });

    final List<Map<String, dynamic>> data = await getPlacesData(searchText);

    setState(() {
      places = data;
      isLoading = false;
    });
  }
}
