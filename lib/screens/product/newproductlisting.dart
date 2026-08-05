// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:manjha/getxcontrollers/cartcontroller.dart';
// import 'package:manjha/getxcontrollers/productlistingcontroller.dart';
// import 'package:manjha/languagetranslation/apptranslation.dart';
// import 'package:manjha/screens/helper.dart';
// import 'package:manjha/model/getbrandresponse.dart';
// import 'package:manjha/screens/product/productdetailsscreen.dart';
// import 'package:manjha/widget/textstyle.dart';
// import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../getxcontrollers/mixpanelcontroller.dart';
// import '../../model/getcatogoriesresponse.dart';
// import '../../model/productresponse.dart';
// import '../../widget/button.dart';
// import '../../widget/textfieldscreen.dart';
// import '../cartscreens/StoreCheckoutPage.dart';
// import '../const.dart';
// import '../localconst.dart';
//
// class ProductListingPage extends StatefulWidget {
//   final String? categoryid;
//   final String? categoryname;
//   final String? brandid;
//   final String? keyword;
//   const ProductListingPage(
//       {super.key,
//       this.categoryid,
//       this.categoryname,
//       this.brandid,
//       this.keyword});
//
//   @override
//   State<ProductListingPage> createState() => _ProductListingPageState();
// }
//
// class _ProductListingPageState extends State<ProductListingPage> {
//   ProductListingController prductlist = Get.put(ProductListingController());
//   Getbrandresponse brand = Get.put(Getbrandresponse());
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   List<Brand> brandList = [];
//   int indexSelectedBrand = 0;
//   int indexSelectedSize = 0;
//   List<String> listSize = ['All', 'Dust', 'Crumble', 'Micron', 'MM'];
//
//   @override
//   void initState() {
//     print(widget.categoryname);
//     if (widget.categoryid != null) {
//       prductlist.listcategory.add(Categorys(
//           id: int.tryParse(widget.categoryid ?? "2"),
//           imageUrl:
//               "https://manjhaimages.s3.ap-south-1.amazonaws.com/product/1686555705.jpg",
//           categoryNameLang: "${translate("All")}"));
//
//       prductlist.getcategories(categoryid: widget.categoryid ?? "2");
//       prductlist.getbrand(categoryId: widget.categoryid ?? "2");
//     }
//     prductlist.productApiCall(
//         categoryid: widget.categoryid,
//         index: 0,
//         brandid: widget.brandid,
//         keyword: widget.keyword);
//     Get.put(CartController()).fetchCart();
//     super.initState();
//
//     // MixpanelController.logScreen(MixpanelController.PageProductList,
//     //     properties: {'CategoryID': 1});
//     // MixpanelController.logScreen(MixpanelController.PageProductList,
//     //     properties: {'Event': 'Add To Cart', 'Model': '12345'});
//     // MixpanelController.logScreen(MixpanelController.PageProductList,
//     //     properties: {'Event': 'Add To Cart', 'Model': '12345'});
//   }
//
//   getFilterDrawer() {
//     return SingleChildScrollView(
//       child: Container(
//           padding: EdgeInsets.only(top: 50),
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.centerRight,
//                 child: IconButton(
//                     // alignment: Alignment.centerRight,
//                     // padding: EdgeInsets.all(10),
//                     icon: Icon(Icons.close),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     }),
//               ),
//               // if (isMedicine())
//               //   Container(
//               //       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               //       alignment: Alignment.centerLeft,
//               //       child: Row(
//               //         children: [
//               //           Text(
//               //             'Filter by Brand',
//               //             style: TextStyle(fontSize: 16, color: kColorNote),
//               //           ),
//               //           Expanded(
//               //               child: Container(
//               //                 margin: EdgeInsets.symmetric(horizontal: 12),
//               //                 color: kColorDivider,
//               //                 height: 1,
//               //               )),
//               //           TextButton(
//               //               child: Text('Clear'),
//               //               onPressed: () {
//               //                 // Navigator.of(context).pop();
//               //                 // setState(() {
//               //                 //   this.indexSelectedBrand = 0;
//               //                 //   _fetchProduct();
//               //                 //   //   brandList[index].isChecked = val;
//               //                 // });
//               //               })
//               //         ],
//               //       )),
//               // if (isMedicine())
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 primary: false,
//                 padding: EdgeInsets.all(0),
//                 itemCount: brandList.length,
//                 itemBuilder: (context, index) {
//                   return RadioListTile(
//                     activeColor: kheader,
//                     dense: true,
//                     groupValue: indexSelectedBrand,
//                     // contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
//
//                     title: NormalText(
//                         brandList[index].brandNameLang ?? "", kblack, 14.0),
//                     value: index, //brandList[index].isChecked,
//                     onChanged: (val) {
//                       // print(val);
//                       WidgetsBinding.instance.addPostFrameCallback((_) {
//                         setState(() {
//                           indexSelectedBrand = index;
//                         });
//                       });
//                     },
//                   );
//                 },
//               ),
//               // if (isFeeds())
//               Container(
//                   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                     children: [
//                       Text(
//                         'Filter by Size'.tr,
//                         style: TextStyle(fontSize: 16, color: kColorNote),
//                       ),
//                       Expanded(
//                           child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 12),
//                         color: kColorDivider,
//                         height: 1,
//                       )),
//                     ],
//                   )),
//               // if (isFeeds())
//               ListView.builder(
//                 shrinkWrap: true,
//                 primary: false,
//                 physics: NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.all(0),
//                 itemCount: listSize.length,
//                 itemBuilder: (context, index) {
//                   var radioListTile = RadioListTile(
//                     activeColor: kheader,
//                     dense: true,
//                     groupValue: indexSelectedSize,
//                     // contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
//                     title: NormalText(translate(listSize[index]), kblack, 14.0),
//                     value: index,
//                     onChanged: (val) {
//                       // print(val);
//
//                       WidgetsBinding.instance.addPostFrameCallback((_) {
//                         setState(() {
//                           indexSelectedSize = index;
//                           // listSize[index].isChecked = val;
//                         });
//                       });
//                     },
//                   );
//                   return radioListTile;
//                 },
//               ),
//               Container(
//                   // width: 300,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: WideButton.bold("${translate("Search")}", () {
//                     //
//                     Navigator.of(context).pop();
//                     // _fetchProduct();
//                   }, true)),
//             ],
//           )),
//     );
//   }
//
//   int defaultSortOrder = 0;
//
//   List<String> listSortBy = [
//     'Default',
//     'Size High to Low',
//     'Size Low to High',
//     'Price/kg Low to High',
//     'Price/kg High to Low',
//   ];
//
//   showSortBySheet() async {
//     final result = await showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         enableDrag: true,
//         isDismissible: true,
//         useRootNavigator: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//         ),
//         builder: (BuildContext context) {
//           // return object of type Dialog
//           return ListView.builder(
//             shrinkWrap: true,
//             primary: false,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: 1 + listSortBy.length,
//             itemBuilder: (context, index) {
//               if (index == 0) {
//                 return SizedBox(
//                   height: 5,
//                 );
//               } else {
//                 return ListTile(
//                   title: Text(listSortBy[index - 1].tr,
//                       style: TextStyle(
//                           fontWeight: (defaultSortOrder == index - 1
//                               ? FontWeight.w900
//                               : FontWeight.normal))),
//                   trailing: (defaultSortOrder == index - 1)
//                       ? Icon(
//                           Icons.check_circle_sharp,
//                           color: kheader,
//                         )
//                       : SizedBox(),
//                   onTap: () {
//                     defaultSortOrder = index - 1;
//                     Navigator.of(context).pop();
//                     // _fetchProduct();
//                   },
//                 );
//               }
//             },
//           );
//         });
//
//     // SELECTED AREA
//     if (result == null) return;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {});
//     });
//     ScaffoldMessenger.of(context)
//       ..removeCurrentSnackBar()
//       ..showSnackBar(
//           SnackBar(content: Text("${translate('Sorting by')} $result")));
//   }
//
//   CartController cartController = Get.put(CartController());
//   MixpanelController mixpanelController = Get.put(MixpanelController());
//
//   Brands? selectedbrands;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Obx(() => cartController.showcart.isTrue
//               ? Common.cartCount > 0
//                   ? Container(
//                       padding: EdgeInsets.only(left: 35),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           // FloatingActionButton(
//                           //     backgroundColor: kWhatsApp,
//                           //     foregroundColor: Colors.white,
//                           //     onPressed: () {
//                           //       // Respond to button press
//                           //       // ignore: deprecated_member_use
//                           //       launch(
//                           //           ("https://wa.me/917071270718" + "?text="));
//                           //     },
//                           //     child: Icon(FontAwesomeIcons.whatsapp)),
//                           // SizedBox(height: 10),
//                           ButtonTheme(
//                               minWidth: 300.0,
//                               height: 45.0,
//                               child: MaterialButton(
//                                 color: kheader,
//                                 elevation: 6,
//                                 shape: new RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: Row(
//                                   children: [
//                                     BoldText(
//                                         "${Common.cartCount} ${translate('Item')}" +
//                                             (Common.cartCount > 1 ? "s" : ""),
//                                         16,
//                                         kwhite),
//                                     NormalText(
//                                         " | ${translate('Rs')}.${Common.cartTotal}/-",
//                                         kwhite,
//                                         16),
//                                     Spacer(),
//                                     BoldText(
//                                         translate("View Cart"), 16, kwhite),
//                                   ],
//                                 ),
//                                 onPressed: () async {
//                                   MixpanelController.logScreen(
//                                     MixpanelController.PageCart,
//                                   );
//                                   dynamic result = await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             StoreCheckoutPage()),
//                                   );
//                                   print('helloworld...');
//                                   if (result != null && result == true)
//                                     WidgetsBinding.instance
//                                         .addPostFrameCallback((_) {
//                                       setState(() {});
//                                     });
//                                   // refreshCallback.call();
//                                   print('helloworld...2');
//                                 },
//                               )),
//                         ],
//                       ),
//                     )
//                   : SizedBox()
//               // FloatingActionButton(
//               //             backgroundColor: kWhatsApp,
//               //             foregroundColor: Colors.white,
//               //             onPressed: () {
//               //               // Respond to button press
//               //               // ignore: deprecated_member_use
//               //               launch(("https://wa.me/917071270718" + "?text="));
//               //             },
//               //             child: Icon(FontAwesomeIcons.whatsapp))
//               : SizedBox()
//           // FloatingActionButton(
//           //         backgroundColor: kWhatsApp,
//           //         foregroundColor: Colors.white,
//           //         onPressed: () {
//           //           // Respond to button press
//           //           // ignore: deprecated_member_use
//           //           launch(("https://wa.me/917071270718" + "?text="));
//           //         },
//           //         child: Icon(FontAwesomeIcons.whatsapp))
//           ),
//       appBar: AppBar(
//         backgroundColor: kheader,
//         // centerTitle: true,
//         automaticallyImplyLeading: true,
//         // leading: IconButton(
//         //     onPressed: () {
//         //       Get.back();
//         //     },
//         //     icon: Icon(
//         //       Icons.arrow_back,
//         //       color: kblack,
//         //     )),
//         elevation: 0,
//         title: ListTile(
//           onTap: () {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 if (prductlist.listbrand[0].id != 0)
//                   prductlist.listbrand.insert(
//                     0,
//                     Brands(
//                       id: 0,
//                       brandNameLang: "All",
//                       brandImage:
//                           "1651312604.jpeg", // Assuming you have an image for "All"
//                     ),
//                   );
//
//                 return AlertDialog(
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Brands".tr),
//                       IconButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon: Icon(Icons.clear))
//                     ],
//                   ),
//                   content: Container(
//                     width: double.maxFinite,
//                     height: screenheight(context,
//                         dividedby: 1), // Adjust height as needed
//                     child: GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 8,
//                               mainAxisSpacing: 8,
//                               childAspectRatio: 0.78),
//                       itemCount: prductlist
//                           .listbrand.length, // Replace with your item count
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           onTap: () {
//                             MixpanelController.logScreen(
//                                 MixpanelController.PageProductList,
//                                 properties: {
//                                   "Event": "Filter",
//                                   "Brand":
//                                       prductlist.listbrand[index].brandNameLang
//                                 });
//                             prductlist.productApiCall(
//                                 keyword: widget.keyword,
//                                 categoryid: widget.categoryid,
//                                 index: 0,
//                                 brandid:
//                                     prductlist.listbrand[index].id.toString());
//                             WidgetsBinding.instance.addPostFrameCallback((_) {
//                               setState(() {
//                                 selectedbrands = prductlist.listbrand[index];
//                               });
//                             });
//
//                             Get.back();
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Column(
//                               children: [
//                                 CachedNetworkImage(
//                                   height: 50,
//                                   width: 50,
//                                   fit: BoxFit.cover,
//                                   fadeInCurve: Curves.bounceIn,
//                                   imageUrl:
//                                       prductlist.listbrand[index].getImageUrl(),
//                                   placeholder: (context, url) =>
//                                       Image.asset('assets/no-photo.png'),
//                                   errorWidget: (context, url, error) =>
//                                       Image.asset('assets/no-photo.png'),
//                                 ),
//                                 // Image.network(
//                                 //     height: 40,
//                                 //     width: 40,
//                                 //     prductlist.listbrand[index].getImageUrl() ??
//                                 //         ""),
//                                 Text(
//                                     maxLines: 3,
//                                     textAlign: TextAlign.center,
//                                     prductlist.listbrand[index].brandNameLang ??
//                                         "",
//                                     style: const TextStyle(fontSize: 12)),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//           contentPadding: EdgeInsets.zero,
//           minVerticalPadding: 0,
//           visualDensity: VisualDensity.compact,
//           title: Text(
//             widget.categoryname ?? "Product",
//             style: const TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           subtitle: selectedbrands != null
//               ? Row(
//                   children: [
//                     Text(
//                       "${translate('Select Brand')}: ",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     Container(
//                       child: Text(
//                         "${selectedbrands?.brandNameLang}",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: kwhite,
//                       size: 14,
//                     )
//                   ],
//                 )
//               : Row(
//                   children: [
//                     Text(
//                       "${translate('Select Brand')}: ",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     Text(
//                       "${translate("All")}",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: kwhite,
//                       size: 14,
//                     )
//                   ],
//                 ),
//         ),
//         actions: <Widget>[
//           Obx(
//             () => cartController.cartcount > 0
//                 ? Common.getCartButton(context, refreshCallback: () {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       setState(() {
//                         print(Common.cartCount);
//                       });
//                     });
//                   })
//                 : Common.getCartButton2(context, refreshCallback: () {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       setState(() {
//                         print(Common.cartCount);
//                       });
//                     });
//                   }),
//           )
//         ],
//       ),
//       key: _scaffoldKey,
//       endDrawer: Drawer(child: getFilterDrawer()),
//       bottomNavigationBar: Container(
//         height: 40,
//         child: Row(
//           children: [
//             Expanded(
//                 child: InkWell(
//               onTap: () {
//                 showSortBySheet();
//               },
//               child: Container(
//                 color: themecolor,
//                 child: Center(
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(FontAwesomeIcons.sort, size: 14, color: kwhite),
//                         BoldText("${translate("Sort By")}", 16, kwhite)
//                       ]),
//                 ),
//               ),
//             )),
//             SizedBox(
//               width: 3,
//             ),
//             Expanded(
//                 child: InkWell(
//               onTap: () {
//                 _scaffoldKey.currentState!.openEndDrawer();
//               },
//               child: Container(
//                 color: themecolor,
//                 child: Center(
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(FontAwesomeIcons.filter, size: 14, color: kwhite),
//                         BoldText("${translate("Filter")}", 16, kwhite)
//                       ]),
//                 ),
//               ),
//             )),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
//         child: Row(
//           children: [
//             widget.categoryid == "5" ||
//                     widget.categoryid == "6" ||
//                     widget.categoryid == null
//                 ? const SizedBox()
//                 : Obx(() => prductlist.getcategoriesapi.isFalse ||
//                         prductlist.currentindex.value == -1
//                     ? const SizedBox()
//                     : Expanded(
//                         flex: 1,
//                         child: Card(
//                           margin: EdgeInsets.only(right: 7.5, bottom: 5),
//                           child: SizedBox(
//                             height: double.infinity,
//                             child: ScrollConfiguration(
//                               behavior:
//                                   ScrollBehavior().copyWith(overscroll: false),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     ListView.builder(
//                                       physics: NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount:
//                                           prductlist.listcategory.length + 1,
//                                       itemBuilder: (context, index) {
//                                         if (index <
//                                             prductlist.listcategory.length) {
//                                           Categorys product =
//                                               prductlist.listcategory[index];
//                                           return GestureDetector(
//                                             onTap: () {
//                                               MixpanelController.logScreen(
//                                                   MixpanelController
//                                                       .PageProductList,
//                                                   properties: {
//                                                     "Category":
//                                                         product.categoryNameLang
//                                                   });
//                                               prductlist.productApiCall(
//                                                   keyword: widget.keyword,
//                                                   categoryid:
//                                                       product.id.toString(),
//                                                   index: index);
//                                             },
//                                             child: Container(
//                                               margin: const EdgeInsets.all(5),
//                                               // padding: EdgeInsets.all(3),
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   border: Border.all(
//                                                     width: 2,
//                                                     color: prductlist
//                                                                 .currentindex
//                                                                 .value ==
//                                                             index
//                                                         ? Colors.green
//                                                         : Colors.transparent,
//                                                   )),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 8.0),
//                                                 child: Column(
//                                                   children: [
//                                                     CachedNetworkImage(
//                                                       height: 40,
//                                                       width: 40,
//                                                       fit: BoxFit.cover,
//                                                       fadeInCurve:
//                                                           Curves.bounceIn,
//                                                       imageUrl:
//                                                           product.imageUrl ??
//                                                               "",
//                                                       placeholder: (context,
//                                                               url) =>
//                                                           Image.asset(
//                                                               'assets/no-photo.png'),
//                                                       errorWidget: (context,
//                                                               url, error) =>
//                                                           Image.asset(
//                                                               'assets/no-photo.png'),
//                                                     ),
//                                                     // Image.network(
//                                                     //     height: 40,
//                                                     //     width: 40,
//                                                     //     product.imageUrl ?? ""),
//                                                     Text(
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         product.categoryNameLang ??
//                                                             "",
//                                                         style: const TextStyle(
//                                                             fontSize: 12)),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         } else {
//                                           return SizedBox(
//                                             height: 2.5,
//                                           );
//                                         }
//                                       },
//                                     ),
//                                     SizedBox(
//                                       height: 70,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )),
//             // SizedBox(width: 10,),
//             Expanded(
//               flex: 4,
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 5),
//                 height: double.infinity,
//                 padding: EdgeInsets.only(bottom: 0),
//                 decoration: BoxDecoration(
//                   // color: Colors.white,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Obx(
//                   () => prductlist.productapicall.isFalse
//                       ? Center(
//                           child:
//                               const CircularProgressIndicator(color: kheader))
//                       : ScrollConfiguration(
//                           behavior:
//                               ScrollBehavior().copyWith(overscroll: false),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 DynamicHeightGridView(
//                                     itemCount:
//                                         prductlist.productlist.length + 1,
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: 0,
//                                     mainAxisSpacing: 0,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     builder: (BuildContext context, int index) {
//                                       if (index <
//                                           prductlist.productlist.length) {
//                                         return productview(
//                                             prductlist.productlist[index],
//                                             context,
//                                             Get.put(CartController()),
//                                             setState);
//                                       } else {
//                                         return SizedBox(
//                                           height: 2.5,
//                                         );
//                                       }
//                                     }),
//                                 SizedBox(
//                                   height: 110,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                 ),
//                 // GridView.builder(
//                 //         shrinkWrap: true,
//                 //         primary: true,
//                 //         padding: EdgeInsets.all(8),
//                 //         // physics: NeverScrollableScrollPhysics(),
//                 //         gridDelegate:
//                 //             const SliverGridDelegateWithFixedCrossAxisCount(
//                 //
//                 //           crossAxisCount: 2,
//                 //         ),
//                 //         itemCount: prductlist.productlist.length,
//                 //         itemBuilder: (BuildContext context, int index) {
//                 //           return productview(
//                 //               prductlist.productlist[index], context);
//                 //         },
//                 //       ),
//               ),
//             ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget productview(dynamic product, context, cartController, setState) {
//   TextEditingController _quantityController = new TextEditingController();
//   showQuanityBox(BuildContext context, bool addNew) async {
//     // Session.shippingPopupSeenNow();
//     // if (await Session.isShippingPopupSeen() && !bypass) {
//     //   return false;
//     // }
//
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           insetPadding: EdgeInsets.all(25),
//           // backgroundColor: Colors.transparent,
//           contentPadding: EdgeInsets.all(10),
//           titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//           // title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
//           title: ListTile(
//             contentPadding: EdgeInsets.zero,
//             visualDensity: VisualDensity.compact,
//             title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
//             trailing: IconButton(
//               visualDensity: VisualDensity.compact,
//               icon: Icon(Icons.close),
//               onPressed: () => Navigator.of(context).pop(false),
//             ),
//           ),
//           content: new Row(
//             children: <Widget>[
//               new Expanded(
//                 child: NormalForm(
//                   FontAwesomeIcons.cartPlus,
//                   Lang.get("Quantity"),
//                   controller: _quantityController,
//                   textInputType: TextInputType.number,
//                 ),
//               )
//             ],
//           ),
//           actions: <Widget>[
//             if (!addNew)
//               TextButton.icon(
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.resolveWith(
//                           (states) => kbuttoncolorred)),
//                   icon: Icon(Icons.delete_outline, color: kdeletecolor),
//                   label: BoldText(translate('Remove'), 14, kdeletecolor),
//                   onPressed: () {
//                     _quantityController.text = "0";
//                     Navigator.of(context).pop(true);
//                   }),
//             // SizedBox(width: 50),
//             // FlatButton(
//             //     child: BoldText('Cancel', 14, kColorButtonCart),
//             //     onPressed: () {
//             //       Navigator.of(context).pop(false);
//             //     }),
//             TextButton.icon(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.resolveWith(
//                       (states) => themecolor.withOpacity(0.5))),
//               icon: Icon(Icons.add_shopping_cart, color: kColorButtonCart),
//               label: BoldText(
//                   (Lang.get(addNew ? "Add" : "Update")), 14, kColorButtonCart),
//               onPressed: () {
//                 if (_quantityController.text.isEmpty) {
//                   EasyLoading.showToast("Please enter quantity.");
//                   return;
//                 }
//                 if (int.tryParse(_quantityController.text) != null &&
//                     int.tryParse(_quantityController.text)! <= 0 &&
//                     int.tryParse(_quantityController.text)! > 10000) {
//                   EasyLoading.showToast("Please enter proper quantity.");
//                   return;
//                 }
//                 // Close the dialog
//                 Navigator.of(context).pop(true);
//                 // Session.shippingPopupSeenNow();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   return InkWell(
//     onTap: () {
//       MixpanelController.logScreen(MixpanelController.PageProductDetail,
//           properties: {"Product": product.productNameLang});
//       Get.to(() => ProductDetailScreen(product: product))?.then((value) {
//         _quantityController.text = value;
//       });
//     },
//     child: Card(
//       child: Container(
//         margin: const EdgeInsets.all(10),
//         // width: screenwidth(context, dividedby: 3),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 CachedNetworkImage(
//                   fit: BoxFit.scaleDown,
//                   fadeInCurve: Curves.bounceIn,
//                   imageUrl: product.imageUrl ?? "",
//                   placeholder: (context, url) =>
//                       Image.asset('assets/no-photo.png'),
//                   errorWidget: (context, url, error) =>
//                       Image.asset('assets/no-photo.png'),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: themecolor2),
//                       child: Text(
//                           "${numbertranslate(product.discount ?? 0)}% ${translate("off")}",
//                           style: TextStyle(
//                               fontSize: 10,
//                               color: kwhite,
//                               fontWeight: FontWeight.w600)),
//                     ),
//                     Icon(
//                       Icons.share,
//                       size: 20,
//                     )
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             BoldText(
//                 overflow: TextOverflow.ellipsis,
//                 "${product.productNameLang}",
//                 16,
//                 kblack),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (product.isTestingkit == true)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       TextCustomRow(
//                         product.noOfTest.toString(),
//                         kColorLabel,
//                         12,
//                         text2: '${translate("No of Test")}: ',
//                       ),
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       TextCustomRow(
//                         "${product.parametersCovered} ",
//                         kgreyDark,
//                         12,
//                         fonntweight: FontWeight.w400,
//                         text2: "${translate("Parameters Covered")} : ",
//                       ),
//                     ],
//                   ),
//                 if (product.isFeed == true || product.isMedicine == true)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       TextCustomRow(
//                         "${product.itemSize} ${product.itemSizeUnit}",
//                         kgreyDark,
//                         12,
//                         fonntweight: FontWeight.w500,
//                         text2: "${translate("Size")}: ",
//                       ),
//                     ],
//                   ),
//                 if (product.isFeed == true)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       TextCustomRow(
//                         "${product.bagSize} Kg",
//                         kgreyDark,
//                         12,
//                         fonntweight: FontWeight.w500,
//                         text2: "${translate("Bag Size")}: ",
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                     ],
//                   ),
//                 if (product.isFeed == true && !product.getIsPrawnFeed())
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextCustomRow(
//                         "${product.proteinPerFat} Kg",
//                         kgreyDark,
//                         12,
//                         fonntweight: FontWeight.w500,
//                         text2: "${translate("Protein/fat")}: ",
//                       ),
//                     ],
//                   ),
//                 if (product.isFeed == true && product.getIsPrawnFeed())
//                   TextCustom(
//                     "(${translate("Rs")}.${product.pricePerKg}/${product.itemSizeUnit})",
//                     kgreyDark,
//                     12,
//                     fonntweight: FontWeight.w400,
//                   ),
//               ],
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Flexible(
//                   flex: 3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           FittedBox(
//                             fit: BoxFit.scaleDown,
//                             child: TextCustom(
//                               "${translate('Rs')}.${product.specialPrice}",
//                               kblack,
//                               // product.specialPrice.toString().length > 4 ? 14 : 15,
//                               15,
//                               fonntweight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 3,
//                           ),
//                           TextCustom("${translate('Rs')}.${product.price}",
//                               kgreyDark, 12,
//                               fonntweight: FontWeight.w500, cancel: true),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: product.quantity != 0
//                       ? Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 0, vertical: 0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(width: 1),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               InkWell(
//                                   onTap: () async {
//                                     if (product.isFeed) {
//                                       _quantityController.text =
//                                           product.quantity.toString();
//                                       bool result =
//                                           await showQuanityBox(context, false);
//                                       if (result == false ||
//                                           _quantityController.text.isEmpty) {
//                                         _quantityController.text = '';
//                                         print('Quantity dialog cancelled...');
//
//                                         return;
//                                       } else {
//                                         WidgetsBinding.instance
//                                             .addPostFrameCallback((_) {
//                                           setState(() {
//                                             product.quantity = int.parse(
//                                                 _quantityController.text);
//                                             _quantityController.text = '';
//                                           });
//                                         });
//                                       }
//                                     } else {
//                                       WidgetsBinding.instance
//                                           .addPostFrameCallback((_) {
//                                         setState(() {
//                                           if (product.quantity <=
//                                               product.getQtyLot()) {
//                                             //1
//                                             // REMOVE
//                                             print('remove' +
//                                                 product.quantity.toString());
//                                             product.quantity = 0;
//                                             print('remove' +
//                                                 product.quantity.toString());
//                                           } else if (product.quantity <=
//                                               product.getQtyLot()) {
//                                             // REMOVE
//                                             product.quantity = 1;
//                                           } else {
//                                             product.quantity -=
//                                                 product.getQtyLot();
//                                           }
//                                         });
//                                       });
//                                     }
//                                     MixpanelController.logScreen(
//                                         MixpanelController.PageProductDetail,
//                                         properties: {
//                                           "Item Remove to Cart":
//                                               "${product.productNameLang}",
//                                           "Quantity":
//                                               product.quantity.toString()
//                                         });
//                                     cartController.fetchCartupdate(
//                                         product.id, product.quantity);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 5.0, vertical: 3),
//                                     child: Icon(
//                                       Icons.remove_rounded,
//                                       size: 15,
//                                     ),
//                                   )),
//                               // product.quantity.toString().length > 10 ?
//                               // Expanded(
//                               //   child: FittedBox(
//                               //     fit: BoxFit.scaleDown,
//                               //     child: Text(product.quantity.toString(),
//                               //         style: TextStyle(fontSize: 12, color: kblack, fontWeight: FontWeight.w500)),
//                               //   ),
//                               // ):Text(product.quantity.toString(),
//                               //     style: TextStyle(fontSize: 12, color: kblack, fontWeight: FontWeight.w500)),
//                               Expanded(
//                                 child: FittedBox(
//                                   fit: BoxFit.scaleDown,
//                                   child: Text(product.quantity.toString(),
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: kblack,
//                                           fontWeight: FontWeight.w500)),
//                                 ),
//                               ),
//                               InkWell(
//                                   onTap: () async {
//                                     if (product.isFeed) {
//                                       _quantityController.text =
//                                           product.quantity.toString();
//                                       bool result =
//                                           await showQuanityBox(context, false);
//                                       if (result == false ||
//                                           _quantityController.text.isEmpty) {
//                                         _quantityController.text = '';
//                                         print('Quantity dialog cancelled...');
//
//                                         return;
//                                       } else {
//                                         WidgetsBinding.instance
//                                             .addPostFrameCallback((_) {
//                                           setState(() {
//                                             product.quantity = int.parse(
//                                                 _quantityController.text);
//                                             _quantityController.text = '';
//                                           });
//                                         });
//                                       }
//                                     } else {
//                                       WidgetsBinding.instance
//                                           .addPostFrameCallback((_) {
//                                         setState(() {
//                                           product.quantity +=
//                                               product.getQtyLot();
//                                         });
//                                       });
//                                     }
//                                     MixpanelController.logScreen(
//                                         MixpanelController.PageProductDetail,
//                                         properties: {
//                                           "Item Added to Cart":
//                                               "${product.productNameLang}",
//                                           "Quantity":
//                                               product.quantity.toString()
//                                         });
//                                     cartController.fetchCartupdate(
//                                         product.id, product.quantity);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 5.0, vertical: 3),
//                                     child: Icon(
//                                       Icons.add,
//                                       size: 15,
//                                     ),
//                                   ))
//                             ],
//                           ),
//                         )
//                       : InkWell(
//                           onTap: () async {
//                             if (product.isFeed) {
//                               _quantityController.text =
//                                   product.quantity.toString();
//                               bool result =
//                                   await showQuanityBox(context, false);
//                               if (result == false ||
//                                   _quantityController.text.isEmpty) {
//                                 _quantityController.text = '';
//                                 print('Quantity dialog cancelled...');
//
//                                 return;
//                               } else {
//                                 WidgetsBinding.instance
//                                     .addPostFrameCallback((_) {
//                                   setState(() {
//                                     product.quantity =
//                                         int.parse(_quantityController.text);
//                                     _quantityController.text = '';
//                                   });
//                                 });
//                               }
//                             } else {
//                               WidgetsBinding.instance.addPostFrameCallback((_) {
//                                 setState(() {
//                                   product.quantity += product.getQtyLot();
//                                 });
//                               });
//                             }
//                             MixpanelController.logScreen(
//                                 MixpanelController.PageProductDetail,
//                                 properties: {
//                                   "Item Added to Cart":
//                                       "${product.productNameLang}",
//                                   "Quantity": product.quantity.toString()
//                                 });
//                             cartController.fetchCartAddd(
//                                 product.id, product.quantity);
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: themecolor),
//                             child: Text("Add".tr,
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: kwhite,
//                                     fontWeight: FontWeight.w600)),
//                           ),
//                         ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
//
