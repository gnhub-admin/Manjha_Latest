import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:manjha/screens/Product/newproductlisting.dart';
import '../../getxcontrollers/productlistingcontroller.dart';
import '../../languagetranslation/apptranslation.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../helper.dart';
import 'listingproduct.dart';
import 'newproductlisting.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroller = TextEditingController();
  ProductListingController productListingController =
      Get.put(ProductListingController());
  @override
  void initState() {
    productListingController.fetchKeyword("");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cartbackgroundcolor,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            // decoration: BoxDecoration(color: themecolor),
            height: 100,
            width: screenwidth(context, dividedby: 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: kgreyDark,
                        //       blurRadius: 3,
                        //       spreadRadius: 0.4,
                        //       offset: const Offset(0, 1)),
                        // ],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2.0,
                          ),
                        ],
                        color: kwhite,
                        border: Border.all(width: 0, color: kheader),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  // color: Color(0xffFDC379),

                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              )),
                          Expanded(
                            child: TextField(
                              controller: searchcontroller,
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 0.9,
                              ),
                              onChanged: (value) {
                                productListingController.fetchKeyword(value);
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  // disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: kgreyDark.withOpacity(0.5),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18),
                                  fillColor: Colors.purple,
                                  border: InputBorder.none,
                                  hintText: '${translate('Search Feed')}'),
                            ),
                          ),
                          searchcontroller.text.isEmpty
                              ? SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchcontroller.clear();
                                    });
                                    productListingController.fetchKeyword("");
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Obx(() => ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    padding: EdgeInsets.zero,
                    itemCount: productListingController.keywordList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ListingProducts(
                              keyword: productListingController
                                  .keywordList[index]['keyword_name']));
                        },
                        title: Row(
                          children: [
                            Text(
                                productListingController.keywordList[index]
                                    ['keyword_name'],
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_outlined, size: 20),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
