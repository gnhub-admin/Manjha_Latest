import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/product/productdetailsscreen.dart';

import '../../getxcontrollers/cartcontroller.dart';
import '../../getxcontrollers/mixpanelcontroller.dart';
import '../../getxcontrollers/productlistingcontroller.dart';
import '../../languagetranslation/apptranslation.dart';
import '../../model/getbrandresponse.dart';
import '../../model/getcatogoriesresponse.dart';
import '../../widget/button.dart';
import '../../widget/textfieldscreen.dart';
import '../../widget/textstyle.dart';
import '../cartscreens/StoreCheckoutPage.dart';
import '../const.dart';
import '../helper.dart';
import '../localconst.dart';

class ListingProducts extends StatefulWidget {
  final String? categoryid;
  final String? categoryname;
  final String? brandid;
  final String? keyword;
  const ListingProducts(
      {super.key,
      this.categoryid,
      this.categoryname,
      this.brandid,
      this.keyword});

  @override
  State<ListingProducts> createState() => _ListingProductsState();
}

class _ListingProductsState extends State<ListingProducts> {
  ProductListingController prductlist = Get.put(ProductListingController());
  CartController cartController = Get.put(CartController());
  Getbrandresponse brand = Get.put(Getbrandresponse());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int indexSelectedBrand = 0;
  int indexSelectedSize = 0;
  List<String> listSize = ['All', 'Dust', 'Crumble', 'Micron', 'MM'];
  @override
  void initState() {
    print(widget.categoryname);
    if (widget.categoryid != null) {
      prductlist.listcategory.add(Categorys(
          id: int.tryParse(widget.categoryid ?? "2"),
          imageUrl:
              "https://manjhaimages.s3.ap-south-1.amazonaws.com/product/1686555705.jpg",
          categoryNameLang: "${translate("All")}"));

      prductlist.getcategories(categoryid: widget.categoryid ?? "2");
      prductlist.getbrand(categoryId: widget.categoryid ?? "2");
    }
    if (widget.categoryid == "5" || widget.categoryid == "6") {
      listSortBy = [
        // 'Size',
        //'Protein/Fat High to Low',
        //'Protein/Fat Low to Hight',
        'Default',
        'Size High to Low',
        'Size Low to High',
        'Price/kg Low to High',
        'Price/kg High to Low',
      ];

      listSortColumBy = [
        // 'sproduct.item_size asc',
        // 'sproduct.protein_per_fat asc',
        // 'sproduct.protein_per_fat desc',
        'sproduct.sort_order desc',
        'sproduct.item_size desc',
        'sproduct.item_size asc',
        'sproduct.price_per_kg asc',
        'sproduct.price_per_kg desc'
      ];
    } else {
      listSortBy = [
        'Latest',
        'Discount',
        'Price Low to High',
        'Price High to Low',
      ];
      listSortColumBy = [
        'sproduct.sort_order desc', //sproduct.created_at
        'sproduct.discount desc', // TODO: ???
        'sproduct.price asc',
        'sproduct.price desc'
      ];
    }
    prductlist.productApiCall(
        categoryid: widget.categoryid,
        index: 0,
        brandid: widget.brandid,
        keyword: widget.keyword);
    cartController.fetchCart();
    super.initState();

    // MixpanelController.logScreen(MixpanelController.PageProductList,
    //     properties: {'CategoryID': 1});
    // MixpanelController.logScreen(MixpanelController.PageProductList,
    //     properties: {'Event': 'Add To Cart', 'Model': '12345'});
    // MixpanelController.logScreen(MixpanelController.PageProductList,
    //     properties: {'Event': 'Add To Cart', 'Model': '12345'});
  }

  getFilterDrawer() {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                    // alignment: Alignment.centerRight,
                    // padding: EdgeInsets.all(10),
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        'Filter by Size'.tr,
                        style: TextStyle(fontSize: 16, color: kColorNote),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        color: kColorDivider,
                        height: 1,
                      )),
                    ],
                  )),
              // if (isFeeds())
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                itemCount: listSize.length,
                itemBuilder: (context, index) {
                  var radioListTile = RadioListTile(
                    activeColor: kheader,
                    dense: true,
                    groupValue: indexSelectedSize,
                    // contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    title: NormalText(translate(listSize[index]), kblack, 14.0),
                    value: index,
                    onChanged: (val) {
                      // print(val);

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          indexSelectedSize = index;
                          // listSize[index].isChecked = val;
                        });
                      });
                    },
                  );
                  return radioListTile;
                },
              ),
              Container(
                  // width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: WideButton.bold("${translate("Search")}", () {
                    //
                    Navigator.of(context).pop();
                    String sort_by =
                        listSortColumBy[defaultSortOrder].split(' ')[0];
                    String sort_order =
                        listSortColumBy[defaultSortOrder].split(' ')[1];
                    prductlist.productApiCall(
                        filter: listSize[indexSelectedSize],
                        sortby: sort_by,
                        sortorder: sort_order,
                        categoryid: widget.categoryid,
                        index: prductlist.currentindex.value,
                        brandid: widget.brandid,
                        keyword: widget.keyword);
                  }, true)),
            ],
          )),
    );
  }

  int defaultSortOrder = 0;
  List<String> listSortBy = [
    'Latest',
    'Low Price',
    'Hight Price',
    'Discount',
    'A to Z',
    'Z to A'
  ];
  List<String> listSortColumBy = [
    'sproduct.sort_order desc', //sproduct.created_at
    'sproduct.price asc',
    'sproduct.price desc',
    'sproduct.price',
    'sproduct.product_name asc',
    'sproduct.product_name desc'
  ];

  showSortBySheet() async {
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
            itemCount: 1 + listSortBy.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  height: 5,
                );
              } else {
                return ListTile(
                  title: Text(listSortBy[index - 1].tr,
                      style: TextStyle(
                          fontWeight: (defaultSortOrder == index - 1
                              ? FontWeight.w900
                              : FontWeight.normal))),
                  trailing: (defaultSortOrder == index - 1)
                      ? Icon(
                          Icons.check_circle_sharp,
                          color: kheader,
                        )
                      : SizedBox(),
                  onTap: () {
                    defaultSortOrder = index - 1;
                    Navigator.of(context).pop();
                    String sort_by =
                        listSortColumBy[defaultSortOrder].split(' ')[0];
                    String sort_order =
                        listSortColumBy[defaultSortOrder].split(' ')[1];
                    prductlist.productApiCall(
                        filter: listSize[indexSelectedSize],
                        sortby: sort_by,
                        sortorder: sort_order,
                        categoryid: widget.categoryid,
                        index: prductlist.currentindex.value,
                        brandid: widget.brandid,
                        keyword: widget.keyword);
                  },
                );
              }
            },
          );
        });

    // SELECTED AREA
    if (result == null) return;
    setState(() {});
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text("${translate('Sorting by')} $result")));
  }

  MixpanelController mixpanelController = Get.put(MixpanelController());

  Brands? selectedbrands;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cartbackgroundcolor,
      floatingActionButton: Obx(() => cartController.showcart.isTrue
              ? Common.cartCount > 0
                  ? Container(
                      padding: EdgeInsets.only(left: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // FloatingActionButton(
                          //     backgroundColor: kWhatsApp,
                          //     foregroundColor: Colors.white,
                          //     onPressed: () {
                          //       // Respond to button press
                          //       // ignore: deprecated_member_use
                          //       launch(
                          //           ("https://wa.me/917071270718" + "?text="));
                          //     },
                          //     child: Icon(FontAwesomeIcons.whatsapp)),
                          // SizedBox(height: 10),
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
                                      BoldText(
                                          translate("View Cart"), 16, kwhite),
                                    ],
                                  ),
                                  onPressed: () async {
                                    MixpanelController.logScreen(
                                      MixpanelController.PageCart,
                                    );
                                    dynamic result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoreCheckoutPage()),
                                    );
                                    print('helloworld...');
                                    String sort_by =
                                        listSortColumBy[defaultSortOrder]
                                            .split(' ')[0];
                                    String sort_order =
                                        listSortColumBy[defaultSortOrder]
                                            .split(' ')[1];
                                    cartController.fetchCart();
                                    prductlist.productApiCall(
                                        filter: listSize[indexSelectedSize],
                                        sortby: sort_by,
                                        sortorder: sort_order,
                                        keyword: widget.keyword,
                                        categoryid:
                                            widget.categoryid.toString(),
                                        index: 0);
                                  })),
                        ],
                      ),
                    )
                  : SizedBox()
              // FloatingActionButton(
              //             backgroundColor: kWhatsApp,
              //             foregroundColor: Colors.white,
              //             onPressed: () {
              //               // Respond to button press
              //               // ignore: deprecated_member_use
              //               launch(("https://wa.me/917071270718" + "?text="));
              //             },
              //             child: Icon(FontAwesomeIcons.whatsapp))
              : SizedBox()
          // FloatingActionButton(
          //         backgroundColor: kWhatsApp,
          //         foregroundColor: Colors.white,
          //         onPressed: () {
          //           // Respond to button press
          //           // ignore: deprecated_member_use
          //           launch(("https://wa.me/917071270718" + "?text="));
          //         },
          //         child: Icon(FontAwesomeIcons.whatsapp))
          ),
      appBar: AppBar(
        backgroundColor: kwhite,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: IconThemeData(color: kblack),
        title: ListTile(
          onTap: () {
            // if (prductlist.listbrand.isNotEmpty)
            //   showDialog(
            //     context: context,
            //     builder: (context) {
            //       if (prductlist.listbrand[0].id != 0)
            //         prductlist.listbrand.insert(
            //           0,
            //           Brands(
            //             id: 0,
            //             brandNameLang: "All",
            //             brandImage:
            //                 "1651312604.jpeg", // Assuming you have an image for "All"
            //           ),
            //         );
            //
            //       return AlertDialog(
            //         title: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text("Brands".tr),
            //             IconButton(
            //                 onPressed: () {
            //                   Get.back();
            //                 },
            //                 icon: Icon(Icons.clear))
            //           ],
            //         ),
            //         content: Container(
            //           width: double.maxFinite,
            //           height: screenheight(context,
            //               dividedby: 1), // Adjust height as needed
            //           child: GridView.builder(
            //             gridDelegate:
            //                 const SliverGridDelegateWithFixedCrossAxisCount(
            //                     crossAxisCount: 3,
            //                     crossAxisSpacing: 8,
            //                     mainAxisSpacing: 8,
            //                     childAspectRatio: 0.78),
            //             itemCount: prductlist
            //                 .listbrand.length, // Replace with your item count
            //             itemBuilder: (BuildContext context, int index) {
            //               return InkWell(
            //                 onTap: () {
            //                   String sort_by = listSortColumBy[defaultSortOrder]
            //                       .split(' ')[0];
            //                   String sort_order =
            //                       listSortColumBy[defaultSortOrder]
            //                           .split(' ')[1];
            //                   MixpanelController.logScreen(
            //                       MixpanelController.PageProductList,
            //                       properties: {
            //                         "Event": "Filter",
            //                         "Brand": prductlist
            //                             .listbrand[index].brandNameLang
            //                       });
            //                   prductlist.productApiCall(
            //                       filter: listSize[indexSelectedSize],
            //                       sortby: sort_by,
            //                       sortorder: sort_order,
            //                       keyword: widget.keyword,
            //                       categoryid: widget.categoryid,
            //                       index: 0,
            //                       brandid: prductlist.listbrand[index].id
            //                           .toString());
            //                   WidgetsBinding.instance.addPostFrameCallback((_) {
            //                     setState(() {
            //                       selectedbrands = prductlist.listbrand[index];
            //                     });
            //                   });
            //
            //                   Get.back();
            //                 },
            //                 child: Padding(
            //                   padding:
            //                       const EdgeInsets.symmetric(vertical: 8.0),
            //                   child: Column(
            //                     children: [
            //                       CachedNetworkImage(
            //                         height: 50,
            //                         width: 50,
            //                         fit: BoxFit.cover,
            //                         fadeInCurve: Curves.bounceIn,
            //                         imageUrl: prductlist.listbrand[index]
            //                             .getImageUrl(),
            //                         cacheKey: prductlist.listbrand[index]
            //                             .getImageUrl(),
            //                         placeholder: (context, url) =>
            //                             Image.asset('assets/no-photo.png'),
            //                         errorWidget: (context, url, error) =>
            //                             Image.asset('assets/no-photo.png'),
            //                       ),
            //                       // Image.network(
            //                       //     height: 40,
            //                       //     width: 40,
            //                       //     prductlist.listbrand[index].getImageUrl() ??
            //                       //         ""),
            //                       Text(
            //                           maxLines: 3,
            //                           textAlign: TextAlign.center,
            //                           prductlist
            //                                   .listbrand[index].brandNameLang ??
            //                               "",
            //                           style: const TextStyle(fontSize: 12)),
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       );
            //     },
            //   );
          },
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          visualDensity: VisualDensity.compact,
          iconColor: kblack,
          title: Text(
            widget.categoryname ?? widget.keyword ?? "Product",
            style: const TextStyle(fontSize: 20, color: kblack),
          ),
          subtitle: widget.brandid == null
              ? selectedbrands != null
                  ? Row(
                      children: [
                        Text(
                          "${translate('Select Brand')}: ",
                          style: TextStyle(color: kblack),
                        ),
                        Container(
                          child: Text(
                            "${selectedbrands?.brandNameLang}",
                            style: TextStyle(
                                color: kblack, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kblack,
                          size: 14,
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "${translate('Select Brand')}: ",
                          style: TextStyle(color: kblack),
                        ),
                        Text(
                          "${translate("All")}",
                          style: TextStyle(
                              color: kblack, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kblack,
                          size: 14,
                        )
                      ],
                    )
              : null,
        ),
        actions: <Widget>[
          Obx(
            () => cartController.cartcount > 0
                ? Common.getCartButton(context, refreshCallback: () {
                    String sort_by =
                        listSortColumBy[defaultSortOrder].split(' ')[0];
                    String sort_order =
                        listSortColumBy[defaultSortOrder].split(' ')[1];
                    cartController.fetchCart();
                    prductlist.productApiCall(
                        filter: listSize[indexSelectedSize],
                        sortby: sort_by,
                        sortorder: sort_order,
                        keyword: widget.keyword,
                        categoryid: widget.categoryid.toString(),
                        index: 0);
                  }, color: themecolor)
                : Common.getCartButton2(context, refreshCallback: () {
                    String sort_by =
                        listSortColumBy[defaultSortOrder].split(' ')[0];
                    String sort_order =
                        listSortColumBy[defaultSortOrder].split(' ')[1];
                    cartController.fetchCart();
                    prductlist.productApiCall(
                        filter: listSize[indexSelectedSize],
                        sortby: sort_by,
                        sortorder: sort_order,
                        keyword: widget.keyword,
                        categoryid: widget.categoryid.toString(),
                        index: 0);
                  }, color: themecolor),
          )
        ],
      ),
      key: _scaffoldKey,
      endDrawer: Drawer(child: getFilterDrawer()),
      // bottomNavigationBar: Container(
      //   height: 40,
      //   child: Row(
      //     children: [
      //       Expanded(
      //           child: InkWell(
      //         onTap: () {
      //           showSortBySheet();
      //         },
      //         child: Container(
      //           color: themecolor,
      //           child: Center(
      //             child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Icon(FontAwesomeIcons.sort, size: 14, color: kwhite),
      //                   BoldText("${translate("Sort By")}", 16, kwhite)
      //                 ]),
      //           ),
      //         ),
      //       )),
      //       SizedBox(
      //         width: 3,
      //       ),
      //       Visibility(
      //         visible: widget.categoryid == "5" || widget.categoryid == "6"
      //             ? true
      //             : false,
      //         child: Expanded(
      //             child: InkWell(
      //           onTap: () {
      //             _scaffoldKey.currentState!.openEndDrawer();
      //           },
      //           child: Container(
      //             color: themecolor,
      //             child: Center(
      //               child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(FontAwesomeIcons.filter,
      //                         size: 14, color: kwhite),
      //                     BoldText("${translate("Filter")}", 16, kwhite)
      //                   ]),
      //             ),
      //           ),
      //         )),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 8, right: 5),
        child: Row(
          children: [
            widget.categoryid == "5" ||
                    widget.categoryid == "6" ||
                    widget.categoryid == null
                ? const SizedBox()
                : Obx(() => prductlist.getcategoriesapi.isFalse ||
                        prductlist.currentindex.value == -1
                    ? const SizedBox()
                    : Expanded(
                        flex: 1,
                        child: Card(
                          margin: EdgeInsets.only(right: 7.5, bottom: 5),
                          child: SizedBox(
                            height: double.infinity,
                            child: ScrollConfiguration(
                              behavior:
                                  ScrollBehavior().copyWith(overscroll: false),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          prductlist.listcategory.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index <
                                            prductlist.listcategory.length) {
                                          Categorys product =
                                              prductlist.listcategory[index];
                                          return GestureDetector(
                                            onTap: () {
                                              MixpanelController.logScreen(
                                                  MixpanelController
                                                      .PageProductList,
                                                  properties: {
                                                    "Category":
                                                        product.categoryNameLang
                                                  });
                                              String sort_by = listSortColumBy[
                                                      defaultSortOrder]
                                                  .split(' ')[0];
                                              String sort_order =
                                                  listSortColumBy[
                                                          defaultSortOrder]
                                                      .split(' ')[1];
                                              prductlist.productApiCall(
                                                  filter: listSize[
                                                      indexSelectedSize],
                                                  sortby: sort_by,
                                                  sortorder: sort_order,
                                                  keyword: widget.keyword,
                                                  categoryid:
                                                      product.id.toString(),
                                                  index: index);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(5),
                                              // padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: prductlist
                                                                .currentindex
                                                                .value ==
                                                            index
                                                        ? kheader
                                                        : Colors.transparent,
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Column(
                                                  children: [
                                                    CachedNetworkImage(
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.cover,
                                                      fadeInCurve:
                                                          Curves.bounceIn,
                                                      imageUrl:
                                                          product.imageUrl ??
                                                              "",
                                                      cacheKey:
                                                          product.imageUrl ??
                                                              "",
                                                      placeholder: (context,
                                                              url) =>
                                                          Image.asset(
                                                              'assets/no-photo.png'),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              'assets/no-photo.png'),
                                                    ),
                                                    // Image.network(
                                                    //     height: 40,
                                                    //     width: 40,
                                                    //     product.imageUrl ?? ""),
                                                    Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        product.categoryNameLang ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: prductlist
                                                                      .currentindex
                                                                      .value ==
                                                                  index
                                                              ? FontWeight.w600
                                                              : FontWeight.w500,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return SizedBox(
                                            height: 2.5,
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 70,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
            // SizedBox(width: 10,),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 5),
                height: double.infinity,
                padding: EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Obx(
                  () => prductlist.productapicall.isFalse
                      ? Center(
                          child:
                              const CircularProgressIndicator(color: kheader))
                      : ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 10, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTapDown: (TapDownDetails details) {
                                            // Get the global position of the tap
                                            _showBrandPopupMenu(context,
                                                details.globalPosition);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                // color: kwhite
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey)),
                                            child: Row(
                                              children: [
                                                Text("Brands",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black54,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTapDown: (TapDownDetails details) {
                                            // Get the global position of the tap
                                            _showsortbyPopupMenu(context,
                                                details.globalPosition);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                // color: kwhite
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey)),
                                            child: Row(
                                              children: [
                                                Text("Sort By",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.black54,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Visibility(
                                          visible: widget.categoryid == "5" ||
                                                  widget.categoryid == "6"
                                              ? true
                                              : false,
                                          child: GestureDetector(
                                            onTapDown:
                                                (TapDownDetails details) {
                                              // Get the global position of the tap
                                              _showFilterPopupMenu(context,
                                                  details.globalPosition);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: kwhite),
                                              child: Row(
                                                children: [
                                                  Text("Filter",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_drop_down_circle_outlined,
                                                    color: Colors.black54,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DynamicHeightGridView(
                                    itemCount:
                                        prductlist.productlist.length + 1,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    builder: (BuildContext context, int index) {
                                      if (index <
                                          prductlist.productlist.length) {
                                        return productview(
                                            prductlist.productlist[index],
                                            context,
                                            cartController,
                                            setState, () async {
                                          MixpanelController.logScreen(
                                              MixpanelController
                                                  .PageProductDetail,
                                              properties: {
                                                "Product": prductlist
                                                    .productlist[index]
                                                    .productNameLang
                                              });
                                          await Get.to(() =>
                                                  ProductDetailScreen(
                                                      product: prductlist
                                                          .productlist[index]))
                                              ?.then((value) {
                                            if (value != 0) {
                                              setState(() {
                                                prductlist.productlist[index]
                                                    .quantity = value;
                                              });
                                            }
                                          });
                                        });
                                      } else {
                                        return SizedBox(
                                          height: 2.5,
                                        );
                                      }
                                    }),
                                SizedBox(
                                  height: 110,
                                )
                              ],
                            ),
                          ),
                        ),
                ),
                // GridView.builder(
                //         shrinkWrap: true,
                //         primary: true,
                //         padding: EdgeInsets.all(8),
                //         // physics: NeverScrollableScrollPhysics(),
                //         gridDelegate:
                //             const SliverGridDelegateWithFixedCrossAxisCount(
                //
                //           crossAxisCount: 2,
                //         ),
                //         itemCount: prductlist.productlist.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return productview(
                //               prductlist.productlist[index], context);
                //         },
                //       ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  void _showBrandPopupMenu(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    if (prductlist.listbrand[0].id != 0)
      prductlist.listbrand.insert(
        0,
        Brands(
          id: 0,
          brandNameLang: "All",
          brandImage: "1651312604.jpeg", // Assuming you have an image for "All"
        ),
      );
    // Show the popup menu
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx, // X-coordinate of the tap
        position.dy, // Y-coordinate of the tap
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: prductlist.listbrand.map((Brands brand) {
        return PopupMenuItem<Brands>(
          value: brand,
          child: Text(brand.brandNameLang ?? ''),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        String sort_by = listSortColumBy[defaultSortOrder].split(' ')[0];
        String sort_order = listSortColumBy[defaultSortOrder].split(' ')[1];
        MixpanelController.logScreen(MixpanelController.PageProductList,
            properties: {"Event": "Filter", "Brand": value.brandNameLang});
        prductlist.productApiCall(
            filter: listSize[indexSelectedSize],
            sortby: sort_by,
            sortorder: sort_order,
            keyword: widget.keyword,
            categoryid: widget.categoryid,
            index: 0,
            brandid: value.id.toString() ?? '');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            selectedbrands = value;
          });
        });

        // Get.back();
      }
    });
  }

  void _showsortbyPopupMenu(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    // Add "All" option if not already present
    if (prductlist.listbrand.isNotEmpty && prductlist.listbrand[0].id != 0) {
      prductlist.listbrand.insert(
        0,
        Brands(
          id: 0,
          brandNameLang: "All",
          brandImage: "1651312604.jpeg",
        ),
      );
    }

    // Show the popup menu
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx, // X-coordinate of the tap
        position.dy, // Y-coordinate of the tap
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: [
        // Create menu items for sorting
        for (int i = 0; i < listSortBy.length; i++)
          PopupMenuItem<int>(
            value: i,
            child: ListTile(
              title: Text(
                listSortBy[i],
                style: TextStyle(
                  fontWeight: defaultSortOrder == i
                      ? FontWeight.w900
                      : FontWeight.normal,
                ),
              ),
              trailing: defaultSortOrder == i
                  ? Icon(Icons.check_circle_sharp, color: kheader)
                  : null,
            ),
          ),
      ],
    ).then((selectedIndex) {
      if (selectedIndex != null) {
        // Update sorting based on selected option
        defaultSortOrder = selectedIndex;
        String sort_by = listSortColumBy[defaultSortOrder].split(' ')[0];
        String sort_order = listSortColumBy[defaultSortOrder].split(' ')[1];

        // Log the event
        MixpanelController.logScreen(
          MixpanelController.PageProductList,
          properties: {"Event": "Filter", "Sort By": listSortBy[selectedIndex]},
        );

        // Call the API
        prductlist.productApiCall(
          filter: listSize[indexSelectedSize],
          sortby: sort_by,
          sortorder: sort_order,
          keyword: widget.keyword,
          categoryid: widget.categoryid,
          index: 0,
          brandid: selectedbrands?.id.toString() ?? '',
        );

        // Update the UI
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            // Update UI state here if needed
          });
        });
      }
    });
  }

  void _showFilterPopupMenu(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    if (prductlist.listbrand[0].id != 0)
      prductlist.listbrand.insert(
        0,
        Brands(
          id: 0,
          brandNameLang: "All",
          brandImage: "1651312604.jpeg", // Assuming you have an image for "All"
        ),
      );

    // Show the popup menu
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx, // X-coordinate of the tap
        position.dy, // Y-coordinate of the tap
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: [
        for (int i = 0; i < listSize.length; i++)
          PopupMenuItem(
            value: i,
            child: RadioListTile(
              activeColor: kheader,
              dense: true,
              groupValue: indexSelectedSize,
              title: Text(
                translate(listSize[i]),
                style: TextStyle(color: kblack, fontSize: 14),
              ),
              value: i,
              onChanged: (val) {
                setState(() {
                  indexSelectedSize = i;
                });
                // Apply filter action
                String sort_by =
                    listSortColumBy[defaultSortOrder].split(' ')[0];
                String sort_order =
                    listSortColumBy[defaultSortOrder].split(' ')[1];
                prductlist.productApiCall(
                  filter: listSize[indexSelectedSize],
                  sortby: sort_by,
                  sortorder: sort_order,
                  categoryid: widget.categoryid,
                  index: prductlist.currentindex.value,
                  brandid: widget.brandid,
                  keyword: widget.keyword,
                );

                Navigator.of(context).pop();
              },
            ),
          ),
      ],
    ).then((value) {
      if (value != null) {
        Navigator.of(context).pop();
        String sort_by = listSortColumBy[defaultSortOrder].split(' ')[0];
        String sort_order = listSortColumBy[defaultSortOrder].split(' ')[1];
        prductlist.productApiCall(
            filter: listSize[indexSelectedSize],
            sortby: sort_by,
            sortorder: sort_order,
            categoryid: widget.categoryid,
            index: prductlist.currentindex.value,
            brandid: widget.brandid,
            keyword: widget.keyword);
      }
    });
  }
}

Widget productview(dynamic product, context, cartController, setState, ontap) {
  TextEditingController _quantityController = new TextEditingController();
  showQuanityBox(BuildContext context, bool addNew) async {
    // Session.shippingPopupSeenNow();
    // if (await Session.isShippingPopupSeen() && !bypass) {
    //   return false;
    // }

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          insetPadding: EdgeInsets.all(25),
          // backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          // title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
            trailing: IconButton(
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: NormalForm(
                  FontAwesomeIcons.cartPlus,
                  Lang.get("Quantity"),
                  controller: _quantityController,
                  textInputType: TextInputType.number,
                ),
              )
            ],
          ),
          actions: <Widget>[
            if (!addNew)
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => kbuttoncolorred)),
                  icon: Icon(Icons.delete_outline, color: kdeletecolor),
                  label: BoldText(translate('Remove'), 14, kdeletecolor),
                  onPressed: () {
                    _quantityController.text = "0";
                    Navigator.of(context).pop(true);
                  }),
            // SizedBox(width: 50),
            // FlatButton(
            //     child: BoldText('Cancel', 14, kColorButtonCart),
            //     onPressed: () {
            //       Navigator.of(context).pop(false);
            //     }),
            TextButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => themecolor.withOpacity(0.5))),
              icon: Icon(Icons.add_shopping_cart, color: kColorButtonCart),
              label: BoldText(
                  (Lang.get(addNew ? "Add" : "Update")), 14, kColorButtonCart),
              onPressed: () {
                if (_quantityController.text.isEmpty) {
                  EasyLoading.showToast("Please enter quantity.");
                  return;
                }
                if (int.tryParse(_quantityController.text) != null &&
                    int.tryParse(_quantityController.text)! <= 0 &&
                    int.tryParse(_quantityController.text)! > 10000) {
                  EasyLoading.showToast("Please enter proper quantity.");
                  return;
                }
                // Close the dialog
                Navigator.of(context).pop(true);
                // Session.shippingPopupSeenNow();
              },
            ),
          ],
        );
      },
    );
  }

  return InkWell(
    onTap: ontap,
    child: Card(
      shape: InputBorder.none,
      margin: EdgeInsets.all(0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        // width: screenwidth(context, dividedby: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.scaleDown,
                  fadeInCurve: Curves.bounceIn,
                  imageUrl: product.imageUrl ?? "",
                  cacheKey: product.imageUrl ?? "",
                  placeholder: (context, url) =>
                      Image.asset('assets/no-photo.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/no-photo.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: themecolor2),
                      child: Text(
                          "${numbertranslate(product.discount ?? 0)}% ${translate("off")}",
                          style: TextStyle(
                              fontSize: 10,
                              color: kwhite,
                              fontWeight: FontWeight.w600)),
                    ),
                    Icon(
                      Icons.share,
                      size: 20,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            BoldText(
                overflow: TextOverflow.ellipsis,
                "${product.productNameLang}",
                16,
                kblack),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.isTestingkit == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        product.noOfTest.toString(),
                        kColorLabel,
                        12,
                        text2: '${translate("No of Test")}: ',
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        "${product.parametersCovered} ",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w400,
                        text2: "${translate("Parameters Covered")} : ",
                      ),
                    ],
                  ),
                if (product.isFeed == true || product.isMedicine == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        "${product.itemSize} ${product.itemSizeUnit}",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w500,
                        text2: "${translate("Size")}: ",
                      ),
                    ],
                  ),
                if (product.isFeed == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        "${product.bagSize} Kg",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w500,
                        text2: "${translate("Bag Size")}: ",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                if (product.isFeed == true && !product.getIsPrawnFeed())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustomRow(
                        "${product.proteinPerFat} Kg",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w500,
                        text2: "${translate("Protein/fat")}: ",
                      ),
                    ],
                  ),
                if (product.isFeed == true && product.getIsPrawnFeed())
                  TextCustom(
                    "(${translate("Rs")}.${product.pricePerKg}/${product.itemSizeUnit})",
                    kgreyDark,
                    12,
                    fonntweight: FontWeight.w400,
                  ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: TextCustom(
                              "${translate('Rs')}.${product.specialPrice}",
                              kblack,
                              // product.specialPrice.toString().length > 4 ? 14 : 15,
                              15,
                              fonntweight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          TextCustom("${translate('Rs')}.${product.price}",
                              kgreyDark, 12,
                              fonntweight: FontWeight.w500, cancel: true),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: product.quantity != 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    if (product.isFeed) {
                                      _quantityController.text =
                                          product.quantity.toString();
                                      bool result =
                                          await showQuanityBox(context, false);
                                      if (result == false ||
                                          _quantityController.text.isEmpty) {
                                        _quantityController.text = '';
                                        print('Quantity dialog cancelled...');

                                        return;
                                      } else {
                                        setState(() {
                                          product.quantity = int.parse(
                                              _quantityController.text);
                                          _quantityController.text = '';
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        if (product.quantity <=
                                            product.getQtyLot()) {
                                          //1
                                          // REMOVE
                                          print('remove' +
                                              product.quantity.toString());
                                          product.quantity = 0;
                                          print('remove' +
                                              product.quantity.toString());
                                        } else if (product.quantity <=
                                            product.getQtyLot()) {
                                          // REMOVE
                                          product.quantity = 1;
                                        } else {
                                          product.quantity -=
                                              product.getQtyLot();
                                        }
                                      });
                                    }
                                    MixpanelController.logScreen(
                                        MixpanelController.PageProductDetail,
                                        properties: {
                                          "Item Remove to Cart":
                                              "${product.productNameLang}",
                                          "Quantity":
                                              product.quantity.toString()
                                        });
                                    cartController.fetchCartupdate(
                                        product.id, product.quantity);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 3),
                                    child: Icon(
                                      Icons.remove_rounded,
                                      size: 15,
                                    ),
                                  )),
                              // product.quantity.toString().length > 10 ?
                              // Expanded(
                              //   child: FittedBox(
                              //     fit: BoxFit.scaleDown,
                              //     child: Text(product.quantity.toString(),
                              //         style: TextStyle(fontSize: 12, color: kblack, fontWeight: FontWeight.w500)),
                              //   ),
                              // ):Text(product.quantity.toString(),
                              //     style: TextStyle(fontSize: 12, color: kblack, fontWeight: FontWeight.w500)),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(product.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: kblack,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                              InkWell(
                                  onTap: () async {
                                    if (product.isFeed) {
                                      _quantityController.text =
                                          product.quantity.toString();
                                      bool result =
                                          await showQuanityBox(context, false);
                                      if (result == false ||
                                          _quantityController.text.isEmpty) {
                                        _quantityController.text = '';
                                        print('Quantity dialog cancelled...');

                                        return;
                                      } else {
                                        setState(() {
                                          product.quantity = int.parse(
                                              _quantityController.text);
                                          _quantityController.text = '';
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        product.quantity += product.getQtyLot();
                                      });
                                    }
                                    MixpanelController.logScreen(
                                        MixpanelController.PageProductDetail,
                                        properties: {
                                          "Item Added to Cart":
                                              "${product.productNameLang}",
                                          "Quantity":
                                              product.quantity.toString()
                                        });
                                    cartController.fetchCartupdate(
                                        product.id, product.quantity);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 3),
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                  ))
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            if (product.isFeed) {
                              _quantityController.text =
                                  product.quantity.toString();
                              bool result =
                                  await showQuanityBox(context, false);
                              if (result == false ||
                                  _quantityController.text.isEmpty) {
                                _quantityController.text = '';
                                print('Quantity dialog cancelled...');

                                return;
                              } else {
                                setState(() {
                                  product.quantity =
                                      int.parse(_quantityController.text);
                                  _quantityController.text = '';
                                });
                                log(product.quantity.toString());
                              }
                            } else {
                              setState(() {
                                product.quantity += product.getQtyLot();
                              });
                            }
                            MixpanelController.logScreen(
                                MixpanelController.PageProductDetail,
                                properties: {
                                  "Item Added to Cart":
                                      "${product.productNameLang}",
                                  "Quantity": product.quantity.toString()
                                });
                            cartController.fetchCartAddd(
                                product.id, product.quantity);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: themecolor),
                            child: Text("Add".tr,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: kwhite,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
