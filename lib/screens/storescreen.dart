import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:manjha/getxcontrollers/logincontroler.dart';
import 'package:manjha/getxcontrollers/productcontroller.dart';
import 'package:manjha/getxcontrollers/storescreencontroller.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/screens/charchascreens/charchascreen.dart';
import 'package:manjha/screens/discover/discoverscreen.dart';
import 'package:manjha/screens/helper.dart';
import 'package:manjha/model/getstorebannerresponse.dart';
import 'package:manjha/model/productresponse.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/screens/mainscreen.dart';
import 'package:manjha/screens/product/listingproduct.dart';
import 'package:manjha/screens/product/productdetailsscreen.dart';
import 'package:manjha/screens/product/searchscreen.dart';
import 'package:manjha/screens/seddpages/seeddetailpage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../getxcontrollers/cartcontroller.dart';
import '../getxcontrollers/homecotroller.dart';
import '../getxcontrollers/locationcontroller.dart';
import '../getxcontrollers/maincontroller.dart';
import '../getxcontrollers/mixpanelcontroller.dart';
import '../getxcontrollers/videocontroller.dart';
import '../model/gethitcheryresponse.dart';
import '../services/apiconst.dart';
import 'cartscreens/StoreCheckoutPage.dart';
import 'chatgpt_section/screens/chat_screen.dart';
import 'discover/videoblogscreens.dart';
import 'homescreeen/hatchery_listing.dart';
import 'homescreeen/homescreen.dart';
import 'localconst.dart';
import '../model/getcatogoriesresponse.dart';
import '../widget/textstyle.dart';

class StoreScreen extends StatefulWidget {
  // int? currentTab;
  StoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

getcity() async {}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  StoreScreenController storecontroller = Get.put(StoreScreenController());
  ProductController _productController = Get.put(ProductController());
  LoginController loginController = Get.put(LoginController());
  ScrollController _scrollController = ScrollController();
  MainController m = Get.put(MainController());

  bool showBottomArrow = false;
  List<Categorys> subCategoryList = [];
  List<Brand> brandList = [];
  int selectedCategoryIndex = 0;

  List imageList = [
    {
      "imgPath":
          "https://manjhaimages.s3.ap-south-1.amazonaws.com/category/1656071267.jpeg",
      "seedName": "Fish Feed",
      "id": "5"
    },
    {
      "imgPath":
          "https://manjha.in/public//manjha-assets/images/manjha-svg/shrimp-feed.png",
      "seedName": "Shrimp Feed",
      "id": "6"
    },
    {
      "imgPath":
          "https://manjhaimages.s3.ap-south-1.amazonaws.com/category/1656071317.jpeg",
      "seedName": "Healthcare",
      "id": "2"
    },
    {
      "imgPath":
          "https://manjhaimages.s3.ap-south-1.amazonaws.com/category/1657019964.jpeg",
      "seedName": "Testing kit",
      "id": "3"
    },
  ];
  List imageList2 = [
    {
      "imgPath":
          "https://manjhaimages.s3.ap-south-1.amazonaws.com/category/1657019983.jpeg",
      "seedName": "Equipment",
      "id": "4"
    },
    {
      "imgPath":
          "https://manjha.in/public//manjha-assets/images/manjha-svg/fish-seed.png",
      "seedName": "Fish Seed",
      "id": "7"
    },
    {
      "imgPath":
          "https://manjha.in/public//manjha-assets/images/manjha-svg/shrimp-seed.png",
      "seedName": "Shrimp Seed",
      "id": "8"
    },
    {
      "imgPath":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg/1024px-ChatGPT_logo.svg.png",
      "seedName": "ChatGPT",
      // "id": "1"
    }
  ];
  List imageList3 = [
    {
      "imgPath":
          "https://w7.pngwing.com/pngs/523/896/png-transparent-youtube-logo-youtube-red-logo-sunny-leone-angle-rectangle-brand-thumbnail.png",
      "seedName": "Videos",
      // "id": "9"
    },
    {
      "imgPath":
          "https://st2.depositphotos.com/6789684/12262/v/450/depositphotos_122620866-stock-illustration-illustration-of-flat-icon.jpg",
      "seedName": "Blog",
      // "id": "10"
    },
    {
      "imgPath":
          "https://img.freepik.com/premium-vector/questions-answers-icon-question-support-icon-logo-isolated-sign-symbol-vector_662353-283.jpg",
      "seedName": "Matsya Charcha",
      // "id": "11"
    },
    {
      "imgPath":
          "https://manjha.in/public//manjha-assets/images/manjha-svg/shrimp-seed.png",
      "seedName": "Shrimp Seed",
      // "id": "12"
    }
  ];

  loadBrand(index) {
    selectedCategoryIndex = index;
    brandList.clear();

    setState(() {
      brandList.addAll(subCategoryList[index].brands!);
    });
  }

  CartController cartController = Get.put(CartController());

  Future<void> fetchData() async {
    // if (_productController.fishproductlist.isEmpty) {
    await _productController.fishproductApiCall(
      categoryid: "5",
    );
    // } else if (_productController.shimpyproductlist.isEmpty) {
    await _productController.shimpyproductApiCall(
      categoryid: "6",
    );
    // } else if (_productController.helthproductlist.isEmpty) {
    await _productController.helthcareproductApiCall(
      categoryid: "2",
    );
    // } else if (_productController.testingproductlist.isEmpty) {
    await _productController.testingproductApiCall(
      categoryid: "3",
    );
    // } else if (_productController.equipmentproductlist.isEmpty) {
    await _productController.equipmentproductApiCall(
      categoryid: "4",
    );
    // } else {
    print("no data found");
    // }
  }

  LocationController locationController = Get.put(LocationController());
  VideoController videoController = Get.put(VideoController());
  MixpanelController mixpanelController = Get.put(MixpanelController());
  HomePageController homePageController = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();

    // _scrollController.addListener(_onScroll);
    getcity();
    if (m.fristscreen.isFalse) {
      if (homePageController.seedloading.isFalse) {
        homePageController.gethitcheryCall();
      }
      if (storecontroller.getbannerapi.isFalse) {
        storecontroller.getbanner();
        fetchData();
      }
      _scrollController.addListener(() {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          setState(() {
            showBottomArrow = false;
          });
        } else {
          setState(() {
            showBottomArrow = true;
          });
        }
      });
      // _fetchCategory();
      cartController.fetchCart();
      // locationController.getSessionapi();

      videoController.CategoryApiCall();
      videoController.videoApiCall();
      homePageController.gethitcheryCall();
      m.fristscreen.value = true;
    }
  }
  //
  // void _onScroll() {
  //   if (_scrollController.position.atEdge) {
  //     bool isBottom = _scrollController.position.pixels ==
  //         _scrollController.position.maxScrollExtent;
  //     if (isBottom) {
  //       fetchData();
  //       print("Reached the end of the scroll!");
  //     }
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  int _current = 0;
  // final _controller = PageController(
  //   initialPage: 0,
  //   viewportFraction: 1,
  //   keepPage: true,
  // );

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() => cartController.showcart.isTrue
          ? Common.cartCount > 0
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                          backgroundColor: kWhatsApp,
                          foregroundColor: Colors.white,
                          onPressed: () {
                            // Respond to button press
                            // ignore: deprecated_member_use
                            MixpanelController.logScreen(
                                MixpanelController.PageStore,
                                properties: {"Whatsapp": "917071270718"});

                            launch(("https://wa.me/917071270718" + "?text="));
                          },
                          child: Icon(FontAwesomeIcons.whatsapp)),
                      SizedBox(height: 10),
                      ButtonTheme(
                          minWidth: 300.0,
                          height: 45.0,
                          child: MaterialButton(
                            color: kheader,
                            elevation: 6,
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                BoldText(
                                    "${Common.cartCount} ${translate('Item')}" +
                                        (Common.cartCount > 1 ? "s" : ""),
                                    16,
                                    kwhite),
                                NormalText(
                                    " | ${translate('Rs')}.${Common.cartTotal}/-",
                                    kwhite,
                                    16),
                                Spacer(),
                                BoldText(translate("View Cart"), 16, kwhite),
                              ],
                            ),
                            onPressed: () async {
                              MixpanelController.logScreen(
                                MixpanelController.PageCart,
                              );

                              dynamic result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreCheckoutPage()),
                              );
                              print('helloworld...');
                              // if (result != null && result == true)
                              cartController.fetchCart();
                              // _productController.allproductsnull();
                              fetchData();
                              setState(() {});
                              // refreshCallback.call();
                              print('helloworld...2');
                            },
                          )),
                    ],
                  ),
                )
              : Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FloatingActionButton(
                        backgroundColor: kWhatsApp,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          // Respond to button press
                          // ignore: deprecated_member_use
                          MixpanelController.logScreen(
                              MixpanelController.PageStore,
                              properties: {"Whatsapp": "917071270718"});

                          launch(("https://wa.me/917071270718" + "?text="));
                        },
                        child: Icon(FontAwesomeIcons.whatsapp)),
                  ),
                )
          : Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                    backgroundColor: kWhatsApp,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      // Respond to button press
                      // ignore: deprecated_member_use
                      MixpanelController.logScreen(MixpanelController.PageStore,
                          properties: {"Whatsapp": "917071270718"});

                      launch(("https://wa.me/917071270718" + "?text="));
                    },
                    child: Icon(FontAwesomeIcons.whatsapp)),
              ),
            )),
      // floatingActionButton: Container(
      //   alignment: Alignment.bottomRight,
      //   padding: EdgeInsets.only(right: 15),
      //   child: FloatingActionButton(
      //       tooltip: 'Connect with WhatsApp',
      //       backgroundColor: kWhatsApp,
      //       foregroundColor: Colors.white,
      //       elevation: 5,
      //       onPressed: () {
      //         // Respond to button press
      //         // ignore: deprecated_member_use
      //         launch(("https://wa.me/917071270718" + "?text="));
      //       },
      //       child: Icon(FontAwesomeIcons.whatsapp)),
      // ),
      // backgroundColor: kgreyFill,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: getFloatingButton(),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            // Container(
            //   color: kheader,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            //     child: Column(
            //       children: [
            //         // Row(
            //         //   children: [
            //         //     const Icon(
            //         //       Icons.location_on_outlined,
            //         //       color: Colors.white,
            //         //     ),
            //         //     const SizedBox(
            //         //       width: 5,
            //         //     ),
            //         //     Column(
            //         //       mainAxisAlignment: MainAxisAlignment.start,
            //         //       crossAxisAlignment: CrossAxisAlignment.start,
            //         //       children: const [
            //         //         Text(
            //         //           "Current Location",
            //         //           style: TextStyle(
            //         //               color: Colors.white,
            //         //               fontSize: 16,
            //         //               fontWeight: FontWeight.w600),
            //         //         ),
            //         //         SizedBox(
            //         //           height: 4,
            //         //         ),
            //         //         Text(
            //         //           "Surat, Gujarat",
            //         //           style: TextStyle(
            //         //               color: Colors.white,
            //         //               fontSize: 12,
            //         //               fontWeight: FontWeight.w500),
            //         //         ),
            //         //       ],
            //         //     )
            //         //   ],
            //         // ),
            //         // SizedBox(
            //         //   height: 10,
            //         // ),
            //         // Padding(
            //         //   padding: const EdgeInsets.symmetric(vertical: 10.0),
            //         //   child: TextField(
            //         //       scrollPadding: EdgeInsets.zero,
            //         //       textAlignVertical: TextAlignVertical.center,
            //         //       decoration: InputDecoration(
            //         //         border: OutlineInputBorder(
            //         //             borderSide: const BorderSide(width: 1), borderRadius: BorderRadius.circular(4)),
            //         //         hintText: "Search Product",
            //         //         hintStyle:
            //         //             const TextStyle(fontSize: 14, color: Color(0xff979899), fontWeight: FontWeight.w500),
            //         //         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //         //         prefixIcon: const Icon(
            //         //           CupertinoIcons.search,
            //         //           color: Color(0xff23AA49),
            //         //         ),
            //         //       )),
            //         // ),
            //         Container(
            //             margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
            //             padding: EdgeInsets.all(8),
            //             decoration: BoxDecoration(
            //               color: kwhite,
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.black.withOpacity(0.3),
            //                   blurRadius: 2.0,
            //                 ),
            //               ],
            //               border: Border.all(color: kheader, width: 0),
            //               borderRadius: new BorderRadius.circular(10.0),
            //             ),
            //             child: InkWell(
            //               onTap: () {
            //                 // _showMapboxSearch();
            //                 // showLocationSheet();\
            //                 // showSearchSheet();
            //               },
            //               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            //                 SizedBox(
            //                   width: 10,
            //                 ),
            //                 Icon(
            //                   // ignore: deprecated_member_use
            //                   FontAwesomeIcons.search,
            //                   size: 20.0,
            //                   color: kgreyDark.withOpacity(0.5),
            //                 ),
            //                 SizedBox(
            //                   width: 10,
            //                 ),
            //                 NormalText('${translate('Search bazar...!')}', kgreyDark.withOpacity(0.5), 20.0),
            //                 Flexible(fit: FlexFit.tight, child: SizedBox()),
            //                 // Padding(
            //                 //   padding: EdgeInsets.only(right: 10.0),
            //                 //   child: Icon(
            //                 //     FontAwesomeIcons.paperPlane,
            //                 //     size: 20.0,
            //                 //     color: kblack,
            //                 //   ),
            //                 // ),
            //               ]),
            //             )),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
                margin: EdgeInsets.fromLTRB(15, 40, 15, 8),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                    ),
                  ],
                  border: Border.all(color: kheader, width: 0),
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(SearchScreen());
                    // _showMapboxSearch();
                    // showLocationSheet();\
                    // showSearchSheet();
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.search,
                          size: 20.0,
                          color: kgreyDark.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        NormalText('${translate('Search Feed')}',
                            kgreyDark.withOpacity(0.5), 20.0),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        // Padding(
                        //   padding: EdgeInsets.only(right: 10.0),
                        //   child: Icon(
                        //     FontAwesomeIcons.paperPlane,
                        //     size: 20.0,
                        //     color: kblack,
                        //   ),
                        // ),
                      ]),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Obx(() => storecontroller.getbannerapi.isTrue
                      ? CarouselSlider(
                          items: storecontroller.listbanners
                              .map((banner) => GestureDetector(
                                    onTap: () {
                                      MixpanelController.logScreen(
                                          MixpanelController.PageProductDetail,
                                          properties: {
                                            "Product":
                                                "${banner.product?.productNameLang}"
                                          });

                                      Get.to(() => ProductDetailScreen(
                                          product:
                                              banner.product ?? Product()));
                                    },
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fitHeight,
                                      repeat: ImageRepeat.noRepeat,
                                      cacheKey: banner.imageUrl ?? "",
                                      width: double.infinity,
                                      // fadeInCurve: Curves.bounceIn,
                                      imageUrl: banner.imageUrl ?? "",
                                      // placeholder: (context, url) =>
                                      //     Image.asset('assets/no-photo.png'),
                                      // errorWidget: (context, url, error) =>
                                      //     Image.asset('assets/no-photo.png'),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              //       options: CarouselOptions(
                              height: 170,
                              // aspectRatio: 0.5,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              enlargeFactor: 0.5,
                              viewportFraction: 1,
                              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                        )

                  // Image.asset(
                  //   "assets/images/banner.png",
                  //   scale: 4.0,
                  // ),
                  ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories".tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  //         },
                  //         icon: const Icon(
                  //           Icons.arrow_back_ios_new_rounded,
                  //           color: Colors.black,
                  //         )),
                  //     IconButton(
                  //         onPressed: () {
                  //           _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  //         },
                  //         icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black)),
                  //   ],
                  // )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 110,
              child: Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: InkWell(
                      onTap: () async {
                        MixpanelController.logScreen(
                            MixpanelController.PageProductList,
                            properties: {
                              "Product List":
                                  "${translate(imageList[index]['seedName'])}"
                            });
                        await Get.to(() => ListingProducts(
                              categoryid: imageList[index]['id'],
                              categoryname:
                                  translate(imageList[index]['seedName']),
                            ));
                        cartController.fetchCart();
                        // _productController.allproductsnull();
                        fetchData();
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade300),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CachedNetworkImage(
                                  cacheKey: imageList[index]['imgPath'],
                                  fadeInCurve: Curves.bounceIn,
                                  imageUrl: imageList[index]['imgPath'],
                                  // placeholder: (context, url) =>
                                  //     Image.asset('assets/no-photo.png'),
                                  // errorWidget: (context, url, error) =>
                                  //     Image.asset('assets/no-photo.png'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 0),
                          Text(
                            translate(imageList[index]['seedName']),
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 110,
              child: Row(
                children: List.generate(
                  4,
                  (index) => index == 3
                      ? Expanded(
                          child: InkWell(
                            onTap: () {
                              MixpanelController.logScreen(
                                MixpanelController.PageChatGPT,
                              );
                              print("chatGPT screen");
                              Get.to(() => ChatGPTScreen());
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Image.asset("assets/chatgpt-icon-green-and-white-icon-free-png.png"),
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Text(
                                  translate(imageList2[index]['seedName']),
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: InkWell(
                            onTap: () {
                              MixpanelController.logScreen(
                                  MixpanelController.PageProductList,
                                  properties: {
                                    "Product List":
                                        "${translate(imageList2[index]['seedName'])}"
                                  });
                              imageList2[index]['id'] == "7" ||
                                      imageList2[index]['id'] == "8"
                                  ? imageList2[index]['id'] == "7"
                                      ?  { m.currentScreen.value = HomeScreen(),
                              m.currentTab.value = 2}
                                      : Get.to(() => HatcheryListing(
                                          fishseed:
                                              homePageController.shrimpyseed))
                                  : Get.to(() => ListingProducts(
                                        categoryid: imageList2[index]['id'],
                                        categoryname: translate(
                                            imageList2[index]['seedName']),
                                      ));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(

                                    height: 80,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CachedNetworkImage(
                                        cacheKey: imageList2[index]['imgPath'],
                                        fadeInCurve: Curves.bounceIn,
                                        imageUrl: imageList2[index]['imgPath'],
                                        // placeholder: (context, url) =>
                                        //     Image.asset('assets/no-photo.png'),
                                        // errorWidget: (context, url, error) =>
                                        //     Image.asset('assets/no-photo.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 0),
                                Text(
                                  translate(imageList2[index]['seedName']),
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 110,
              child: Row(
                children: List.generate(
                  4,
                  (index) => (index == 3)
                      ? Expanded(
                          child: SizedBox(),
                        )
                      : Expanded(
                          child: InkWell(
                            onTap: () {
                              if (index == 0) {
                                MixpanelController.logScreen(
                                  MixpanelController.PageVideoBlog,
                                );
                                Get.to(() => videoblogScreens(
                                    videos: videoController.video));
                              } else if (index == 1) {
                                // Get.to(() => MainScreens(initialIndex: 4));
                                MixpanelController.logScreen(
                                  MixpanelController.PageDiscover,
                                );
                                m.currentScreen.value = DiscoverScreen();
                                m.currentTab.value = 4;
                              } else {
                                MixpanelController.logScreen(
                                  MixpanelController.PageCharcha,
                                );
                                // Get.to(() => videoblogScreens(videos: videoController.video));
                                m.currentScreen.value =
                                    CharchaScreen(ForumType.Forum);
                                m.currentTab.value = 3;
                              }
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.grey.shade300),
                                    ),
                                    child:index == 0 ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset("assets/cda.png"),
                                    ) : index ==1 ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset("assets/online-blog-3d-icon-download-in-png-blend-fbx-gltf-file-formats--blogging-writing-influencer-pack-business-icons-4897960.png"),
                                    ): Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CachedNetworkImage(
                                        cacheKey: imageList3[index]['imgPath'],
                                        fadeInCurve: Curves.bounceIn,
                                        imageUrl: imageList3[index]['imgPath'],
                                        // placeholder: (context, url) =>
                                        //     Image.asset('assets/no-photo.png'),
                                        // errorWidget: (context, url, error) =>
                                        //     Image.asset('assets/no-photo.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 0),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${translate(imageList3[index]['seedName'])}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Brands".tr,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => storecontroller.getbarandapi.isFalse
                  ? Container(
                      height: 150,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            3,
                            (index) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 150,
                                width: screenwidth(context, dividedby: 3.5),
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ).toList()),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: List.generate(
                                  storecontroller.listbrand.length, (index) {
                                return Card(
                                  elevation: 2,
                                  // shape: CircleBorder(),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                      onTap: () async {
                                        MixpanelController.logScreen(
                                            MixpanelController.PageProductList,
                                            properties: {
                                              "Brand":
                                                  "${storecontroller.listbrand[index].brandNameLang}"
                                            });
                                        await Get.to(() => ListingProducts(
                                              brandid: storecontroller
                                                  .listbrand[index].id
                                                  .toString(),
                                              categoryname: storecontroller
                                                  .listbrand[index]
                                                  .brandNameLang
                                                  .toString(),
                                            ));
                                        cartController.fetchCart();
                                        // _productController.allproductsnull();
                                        fetchData();
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              storecontroller.listbrand[index]
                                                  .getImageUrl(),
                                              fit: BoxFit.cover,
                                              height: 110.0,
                                              width: 110.0,
                                            ),
                                          ),
                                          // Container(
                                          //   // color: Colors.amber,
                                          //   alignment: Alignment.center,
                                          //   height: 40,
                                          //   padding:
                                          //       EdgeInsets.symmetric(horizontal: 10),
                                          //   child: NormalText(
                                          //       brandList[index].brandName,
                                          //       kblack,
                                          //       16,
                                          //       textAlign: TextAlign.center),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       decoration: const BoxDecoration(
                      //           // border: Border.all(width: 0, color: kheader),
                      //
                      //           // color: kgreyFill,
                      //           ),
                      //       height: 150.0,
                      //       child: ListView.builder(
                      //           shrinkWrap: true,
                      //           // primary: true,
                      //           // padding: EdgeInsets.all(8),
                      //           // physics: NeverScrollableScrollPhysics(),
                      //           scrollDirection: Axis.horizontal,
                      //           // gridDelegate:
                      //           //     const SliverGridDelegateWithFixedCrossAxisCount(
                      //           //   crossAxisCount: 2,
                      //           // ),
                      //           itemCount: storecontroller.listbrand.length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             return Card(
                      //               elevation: 5,
                      //               // shape: CircleBorder(),
                      //               child: Container(
                      //                 padding: const EdgeInsets.all(4),
                      //                 child: GestureDetector(
                      //                   onTap: () {
                      //                     Get.to(ProductListingPage(
                      //                       brandid: storecontroller.listbrand[index].id.toString(),
                      //                       categoryname: storecontroller.listbrand[index].brandName.toString(),
                      //                     ));
                      //                   },
                      //                   child: Column(
                      //                     mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: [
                      //                       ClipOval(
                      //                         child: Image.network(
                      //                           storecontroller.listbrand[index].getImageUrl(),
                      //                           fit: BoxFit.cover,
                      //                           height: 110.0,
                      //                           width: 110.0,
                      //                         ),
                      //                       ),
                      //                       // Container(
                      //                       //   // color: Colors.amber,
                      //                       //   alignment: Alignment.center,
                      //                       //   height: 40,
                      //                       //   padding:
                      //                       //       EdgeInsets.symmetric(horizontal: 10),
                      //                       //   child: NormalText(
                      //                       //       brandList[index].brandName,
                      //                       //       kblack,
                      //                       //       16,
                      //                       //       textAlign: TextAlign.center),
                      //                       // ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             );
                      //           }),
                      //     ),
                      //   ],
                      // ),
                    ),
            ),
            //products list
            Obx(
              () => _productController.fishproductlist.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        seeAllView(context, "Aqua Fish Feed", () async {
                          MixpanelController.logScreen(
                              MixpanelController.PageProductList,
                              properties: {"Category": "Fish Feed"});
                          dynamic result = await Get.to(() => ListingProducts(
                                categoryid: "5",
                                categoryname: "Fish Feed",
                              ));
                          _productController.fishproductApiCall(
                            categoryid: "5",
                          );
                        }),
                        ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                children: List.generate(5, (index) {
                                  Productdetails product =
                                      _productController.fishproductlist[index];
                                  return InkWell(
                                      onTap: () => Get.to(() =>
                                          ProductDetailScreen(
                                              product: product)),
                                      child: cardWidget(context, product,
                                          setState, Get.put(CartController())));
                                }),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 15),
                        //     height: 280,
                        //     child: ListView.builder(
                        //       itemBuilder: (context, index) {
                        //         Productdetails product = _productController.fishproductlist[index];
                        //         return InkWell(
                        //             onTap: () => Get.to(ProductDetailScreen(product: product)),
                        //             child: cardWidget(context, product));
                        //       },
                        //       itemCount: 5,
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.horizontal,
                        //     )),
                      ],
                    ),
            ),
            Obx(
              () => _productController.shimpyproductlist.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        seeAllView(context, "Aqua Shrimp Feed", () async {
                          MixpanelController.logScreen(
                              MixpanelController.PageProductList,
                              properties: {"Category": "Shrimp Feed"});
                          await Get.to(() => const ListingProducts(
                                categoryid: "6",
                                categoryname: "Shrimp Feed",
                              ));
                          _productController.shimpyproductApiCall(
                            categoryid: "6",
                          );
                        }),
                        ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                children: List.generate(5, (index) {
                                  Productdetails product = _productController
                                      .shimpyproductlist[index];
                                  return InkWell(
                                    onTap: () => Get.to(() =>
                                        ProductDetailScreen(product: product)),
                                    child: cardWidget(context, product,
                                        setState, Get.put(CartController())),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 15),
                        //     height: 280,
                        //     child: ListView.builder(
                        //       itemBuilder: (context, index) {
                        //         Productdetails product = _productController.shimpyproductlist[index];
                        //         return InkWell(
                        //           onTap: () => Get.to(ProductDetailScreen(product: product)),
                        //           child: cardWidget(context, product),
                        //         );
                        //       },
                        //       itemCount: 5,
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.horizontal,
                        //     )),
                      ],
                    ),
            ),
            Obx(
              () => _productController.helthproductlist.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        seeAllView(context, "Aqua Healthcare", () async {
                          MixpanelController.logScreen(
                              MixpanelController.PageProductList,
                              properties: {"Category": "Healthcare"});
                          await Get.to(() => const ListingProducts(
                                categoryid: "2",
                                categoryname: "Healthcare",
                              ));
                          _productController.helthcareproductApiCall(
                            categoryid: "2",
                          );
                        }),
                        ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                children: List.generate(
                                  5,
                                  (index) {
                                    Productdetails product = _productController
                                        .helthproductlist[index];
                                    return InkWell(
                                      onTap: () => Get.to(() =>
                                          ProductDetailScreen(
                                              product: product)),
                                      child: cardWidget(context, product,
                                          setState, Get.put(CartController())),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 15),
                        //     height: 250,
                        //     child: Expanded(
                        //       child: ListView.builder(
                        //         itemBuilder: (context, index) {
                        //           Productdetails product = _productController.productlist[index];
                        //           return InkWell(
                        //             onTap: () => Get.to(ProductDetailScreen(product: product)),
                        //             child: cardWidget(context, product),
                        //           );
                        //         },
                        //         itemCount: 5,
                        //         shrinkWrap: true,
                        //         scrollDirection: Axis.horizontal,
                        //       ),
                        //     )),
                      ],
                    ),
            ),
            Obx(
              () => _productController.testingproductlist.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        seeAllView(context, "Aqua Testing Kit", () async {
                          MixpanelController.logScreen(
                              MixpanelController.PageProductList,
                              properties: {"Category": "Testing Kit"});
                          await Get.to(() => const ListingProducts(
                                categoryid: "3",
                                categoryname: "Testing Kit",
                              ));
                          _productController.testingproductApiCall(
                            categoryid: "3",
                          );
                          cartController.fetchCart();
                        }),
                        ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                children: List.generate(5, (index) {
                                  Productdetails product = _productController
                                      .testingproductlist[index];
                                  return InkWell(
                                    onTap: () => Get.to(() =>
                                        ProductDetailScreen(product: product)),
                                    child: cardWidget(context, product,
                                        setState, Get.put(CartController())),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 15),
                        //     height: 275,
                        //     child: ListView.builder(
                        //       itemBuilder: (context, index) {
                        //         Productdetails product = _productController.testingproductlist[index];
                        //         return InkWell(
                        //           onTap: () => Get.to(ProductDetailScreen(product: product)),
                        //           child: cardWidget(context, product),
                        //         );
                        //       },
                        //       itemCount: 5,
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.horizontal,
                        //     )),
                      ],
                    ),
            ),
            Obx(
              () => _productController.equipmentproductlist.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        seeAllView(context, "Aqua Equipments", () async {
                          MixpanelController.logScreen(
                              MixpanelController.PageProductList,
                              properties: {"Category": "Equipments"});
                          await Get.to(() => const ListingProducts(
                                categoryid: "4",
                                categoryname: "Equipments",
                              ));
                          _productController.equipmentproductApiCall(
                            categoryid: "4",
                          );
                        }),
                        ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                children: List.generate(5, (index) {
                                  Productdetails product = _productController
                                      .equipmentproductlist[index];
                                  return InkWell(
                                    onTap: () {
                                      MixpanelController.logScreen(
                                          MixpanelController.PageProductDetail,
                                          properties: {
                                            "Product":
                                                "${product.productNameLang}"
                                          });
                                      Get.to(() => ProductDetailScreen(
                                          product: product));
                                    },
                                    child: cardWidget(context, product,
                                        setState, Get.put(CartController())),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 15),
                        //     height: 225,
                        //     child: ListView.builder(
                        //       itemBuilder: (context, index) {
                        //         Productdetails product = _productController.equipmentproductlist[index];
                        //         return InkWell(
                        //           onTap: () => Get.to(ProductDetailScreen(product: product)),
                        //           child: cardWidget(context, product),
                        //         );
                        //       },
                        //       itemCount: 5,
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.horizontal,
                        //     )),
                      ],
                    ),
            ),

            // SizedBox(
            //   height: 10,
            // ),
            // Obx(() => _productController.isloading.isTrue
            //     ? CircularProgressIndicator(
            //         color: kheader,
            //       )
            //     : SizedBox.shrink()),

            GetBuilder<HomePageController>(
              builder: (controller) => _productController
                      .equipmentproductlist.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        seeAllView(context, "Fish Hatchery", () {
                          // Get.to(() => SeedDetailsPage());
                          Get.to(() =>
                              HatcheryListing(fishseed: controller.fishseed));
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
                                      Get.to(() =>
                                          SeedDetailsPage(hatchery: fishseed));
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
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            fishseed.imageUrl ??
                                                                ""),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenwidth(
                                                                      context,
                                                                      dividedby:
                                                                          1.6),
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
                                                                        color:
                                                                            kwhite,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Text(
                                                                    fishseed.address ??
                                                                        'Unnao, Uttar Pradesh',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kwhite,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Visibility(
                                                                        visible:
                                                                            fishseed.isManjhaTrusted ??
                                                                                false,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: kheader,
                                                                              borderRadius: BorderRadius.circular(4)),
                                                                          padding:
                                                                              EdgeInsets.all(3),
                                                                          child: Text(
                                                                              "Trusted by Manjha",
                                                                              style: TextStyle(color: kwhite, fontSize: 10, fontWeight: FontWeight.w500)),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            fishseed.isNfbdApproved ??
                                                                                false,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.teal,
                                                                              borderRadius: BorderRadius.circular(4)),
                                                                          padding:
                                                                              EdgeInsets.all(3),
                                                                          child: Text(
                                                                              "NFBD Approved",
                                                                              style: TextStyle(color: kwhite, fontSize: 10, fontWeight: FontWeight.w500)),
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
                                                              PopupMenuButton<
                                                                  String>(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            itemBuilder: (BuildContext
                                                                    context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        String>>[
                                                              PopupMenuItem<
                                                                  String>(
                                                                height: 0,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                value: 'phone',
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                    Icons.phone,
                                                                    color: kheader
                                                                        .withOpacity(
                                                                            0.7),
                                                                  ),
                                                                  title: Text(
                                                                      'Phone'),
                                                                ),
                                                              ),
                                                              PopupMenuItem<
                                                                  String>(
                                                                height: 0,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                value:
                                                                    'whatsapp',
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
                                                              PopupMenuItem<
                                                                  String>(
                                                                height: 0,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                value: 'share',
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                    Icons
                                                                        .share_outlined,
                                                                    color:
                                                                        kdarkBlue,
                                                                  ),
                                                                  title: Text(
                                                                      'Share'),
                                                                ),
                                                              ),
                                                            ],
                                                            onSelected: (String
                                                                value) async {
                                                              switch (value) {
                                                                case 'phone':
                                                                  controller.hatcheryLog(
                                                                      fishseed
                                                                          .id,
                                                                      controller
                                                                          .ACTION_CALL);
                                                                  // ignore: deprecated_member_use
                                                                  launch(
                                                                      "tel:+91${fishseed.mobileno}");
                                                                  break;
                                                                case 'whatsapp':
                                                                  controller.hatcheryLog(
                                                                      fishseed
                                                                          .id,
                                                                      controller
                                                                          .ACTION_WHATSAPP);
                                                                  String
                                                                      strUserName =
                                                                      await saveUser()
                                                                              ?.data
                                                                              ?.fullName ??
                                                                          "";
                                                                  String
                                                                      strCity =
                                                                      await saveUser()
                                                                              ?.data
                                                                              ?.cityname ??
                                                                          "";

                                                                  String
                                                                      strMessage =
                                                                      Common.getWhtapAppMessage(
                                                                          strUserName,
                                                                          strCity);
                                                                  // ignore: deprecated_member_use
                                                                  launch(Uri
                                                                      .encodeFull(
                                                                          "https://wa.me/91${fishseed.mobileno}?text=$strMessage"));

                                                                  break;
                                                                case 'share':
                                                                  controller.hatcheryLog(
                                                                      fishseed
                                                                          .id,
                                                                      controller
                                                                          .ACTION_SHARE);
                                                                  Share.share(
                                                                      fishseed
                                                                          .getShareText());

                                                                  break;
                                                              }
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .more_vert_rounded,
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
                                                                FontWeight
                                                                    .w500),
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
                                                                FontWeight
                                                                    .w500),
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
                                                                FontWeight
                                                                    .w500),
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
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color:
                                                                      kheader,
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
                                                                    color:
                                                                        kheader,
                                                                    fontSize:
                                                                        12,
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
                                                                    color:
                                                                        kheader,
                                                                    fontSize:
                                                                        12,
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
                      ],
                    ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => themecolor)),
                onPressed: () {
                  launch("tel:+917071270718");
                },
                child: Text("For any assistance:+91 70712 70718")),
            SizedBox(
              height: 100,
            ),
            // Container(
            //   color: kitemlabel,
            //   padding: EdgeInsets.all(10),
            //   child: Container(
            //       // color: kgreyFill,
            //       padding: EdgeInsets.all(16),
            //       alignment: Alignment.center,
            //       width: double.infinity,
            //       child: InkWell(
            //         onTap: () {
            //           showDialogIfFirstLoaded(context, bypass: true);
            //         },
            //         child: Column(children: [
            //           Text(
            //             "We are delivering products in following states only,".tr,
            //             style: TextStyle(
            //               fontSize: 14,
            //               color: kwhite,
            //             ),
            //             textAlign: TextAlign.center,
            //           ),
            //           SizedBox(height: 4),
            //           Text(
            //             "Haryana, Punjab, Uttar Pradesh, Rajasthan, Gujarat, Bihar".tr,
            //             style: TextStyle(fontSize: 18, color: kwhite, fontWeight: FontWeight.bold),
            //             textAlign: TextAlign.center,
            //           ),
            //         ]),
            //       )),
            // ),
          ]),
        ),
      ),
    );
  }

  showDialogIfFirstLoaded(BuildContext context, {bypass = true}) async {
    Session.shippingPopupSeenNow();
    if (await Session.isShippingPopupSeen() && !bypass) {
      return false;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          insetPadding: EdgeInsets.all(25),
          // backgroundColor: Colors.transparent,
          // contentPadding: EdgeInsets.all(10),
          // title: new Text(Lang.get("Shipping")),
          content: Image(
            image: AssetImage('assets/popup2.png'),
            fit: BoxFit.contain,
            // width: MediaQuery.of(context).size.width - 40,
            // width: 225, //_animate ? 225 : 10,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            MaterialButton(
              child: new Text(Lang.get("Okay")),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                Session.shippingPopupSeenNow();
              },
            ),
          ],
        );
      },
    );
  }

  bool get wantKeepAlive => true;
}

// if (_showBottomArrow) Align(
//   alignment: Alignment.bottomRight,
//   child: Positioned(
//     bottom: 20,
//     right: 20,
//     child: GestureDetector(
//       onTap: () {
//         _scrollController.animateTo(
//           _scrollController.position.minScrollExtent,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       },
//       child: Icon(Icons.keyboard_arrow_up, size: 40, color: Colors.black,),
//     ),
//   ),
// ),
