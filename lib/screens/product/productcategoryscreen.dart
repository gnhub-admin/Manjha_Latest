import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/model/getcatogoriesresponse.dart';
import 'package:manjha/screens/Product/newproductlisting.dart';
import 'package:manjha/widget/textstyle.dart';
import '../../services/custom_api.dart';
import '../localconst.dart';
import 'listingproduct.dart';

//ignore: must_be_immutable
class StoreCategoryPage extends StatefulWidget {
  Categorys? category;
  StoreCategoryPage(this.category);
  @override
  _StoreCategoryPageState createState() => _StoreCategoryPageState();
}

class _StoreCategoryPageState extends State<StoreCategoryPage> with SingleTickerProviderStateMixin {
  int _selectedCategoryIndex = 0;

  List<Categorys> subCategoryList = [];
  List<Brand> brandList = [];

  @override
  void initState() {
    super.initState();

    this._fetchData();
  }

  _fetchData() async {
    // this._fetchBrand();
    _fetchCategory();
  }

  loadBrand(index) {
    _selectedCategoryIndex = index;
    brandList.clear();

    setState(() {
      brandList.addAll(subCategoryList[index].brands!);
    });
  }

  _fetchCategory() async {
    WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

    final response = await http.get(
        Uri.parse("${webService.baseurl}/store_subcategory?test=1&id=${widget.category?.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        });
    // print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);

      subCategoryList = parsed.map<Categorys>((json) => Categorys.fromJson(json)).toList();
      if (subCategoryList.length > 0) {
        loadBrand(0);
      }

      if (mounted)
        setState(() {
          // isLoading = false;
        });
    } else {
      throw Exception('Failed to load request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: navDrawer(context),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kheader,
        title: NormalText(widget.category?.categoryNameLang ?? "", kwhite, 25),
        elevation: 1.0,
        // leading: Container(),
        actions: <Widget>[
          Common.getSupportButton(context),
          SizedBox(
            width: 5,
          ),
          Common.getCartButton(context, refreshCallback: () {
            setState(() {
              print(Common.cartCount);
              setState(() {});
            });
          }),
        ],
      ),
      body:
          // Center(
          //   // color: Colors.red,
          //   //   child: new Column(
          //   //     children: <Widget>[
          //   child:
          SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              height: 150.0,
              child: ListView.builder(
                  shrinkWrap: true,
                  // primary: true,
                  // padding: EdgeInsets.all(8),
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  // gridDelegate:
                  //     const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  // ),
                  itemCount: subCategoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          // if (subCategoryList[index].isFeeds()) {
                          loadBrand(index);
                          // } else {
                          // TODO: NOT COMING HERE...

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return StoreProductPage(
                          //       category: subCategoryList[index]);
                          // }));
                          // }
                        },
                        child: Container(
                            // margin: EdgeInsets.all(4),
                            // padding: EdgeInsets.all(8),
                            // decoration: BoxDecoration(
                            //     color: kwhite,
                            //     borderRadius: BorderRadius.circular(8),
                            //     boxShadow: [
                            //       BoxShadow(color: Colors.grey, blurRadius: 2)
                            //     ]),
                            // elevation: 4,
                            // color: kitembg,
                            // margin: EdgeInsets.all(10),
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: (_selectedCategoryIndex == index
                                        ? kheader.withOpacity(0.65)
                                        : kwhite), //kgreyFill, //kitembg,
                                    borderRadius: BorderRadius.circular(100)),
                                alignment: Alignment.center,
                                width: 110,
                                child: ClipOval(
                                  child: Image.network(
                                    subCategoryList[index].imageUrl ?? "",
                                    fit: BoxFit.cover,
                                    height: 120.0,
                                    width: 120.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.amber,
                              alignment: Alignment.center,
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: NormalText(subCategoryList[index].categoryNameLang ?? "", kblack, 16,
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        )),
                      ),
                    );
                  }),
            ),
            const Divider(),

            // SizedBox(height: 16),
            // Container(
            //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //     alignment: Alignment.centerLeft,
            //     child: Row(
            //       children: [
            //         Text(
            //           'Category',
            //           style: TextStyle(fontSize: 16, color: kColorNote),
            //         ),
            //         Expanded(
            //             child: Container(
            //           margin: EdgeInsets.symmetric(horizontal: 12),
            //           color: kColorDivider,
            //           height: 1,
            //         ))
            //       ],
            //     )),
            ListView.builder(
                shrinkWrap: true,
                primary: true,
                padding: const EdgeInsets.all(12),
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                // gridDelegate:
                //     const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                // ),
                itemCount: brandList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => ListingProducts(
                            categoryname: subCategoryList[_selectedCategoryIndex].categoryNameLang.toString(),
                            categoryid: subCategoryList[_selectedCategoryIndex].id.toString(),
                            brandid: brandList[index].id.toString(),
                          ));
                      // await Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //       return StoreProductPage(
                      //         category: subCategoryList[_selectedCategoryIndex],
                      //         brand: brandList[index],
                      //       );
                      //     }));
                      // setState(() {
                      //   print(Common.cartCount);
                      // });
                    },
                    child: Container(
                        margin: const EdgeInsets.all(8),
                        // padding: EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: kwhite,
                            // borderRadius: BorderRadius.circular(8),
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
                        // elevation: 4,
                        // color: kitembg,
                        // margin: EdgeInsets.all(10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            // Expanded(
                            // child:
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 70,
                              child: Image.network(
                                brandList[index].imageUrl ?? "",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                // height: 80.0,
                                // width: 80.0,
                              ),
                            ),
                            // ),
                            Container(
                              // color: Colors.amber,
                              alignment: Alignment.center,
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: NormalText(brandList[index].brandNameLang ?? "", kblack, 16,
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        )),
                  );
                }),
            // SizedBox(height: 16),

            const SizedBox(height: 50),
          ],
        ),
        //     ),
        //   ],
      ),
      // )
    );
  }
}
