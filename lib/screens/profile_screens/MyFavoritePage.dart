import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manjha/services/apiconst.dart';
import '../../widget/common.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../localconst.dart';

class MyFavoritePage extends StatefulWidget {
  @override
  _MyFavoritePageState createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  late Position position;

  @override
  void initState() {
    super.initState();

    this.myFavorite();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < listFish.length; i++) {
      widgets.add(searchresult(listFish[i]));
    }
    if (listFish.length == 0) {
      widgets.add(Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: NormalText("No favorite found", kblack, 16.0),
            ),
          )));
    }

    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          backgroundColor: kwhite,
          title: BoldText(
              Lang.get("Favorite" + (listFish.length > 0 ? (" (" + widgets.length.toString() + ")") : "")), 25, kblack),
          centerTitle: false,
          elevation: 0.0,
          actions: [],
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: RaisedButton(
        //     child: new Text("Fetch Data"),
        //     onPressed: _fetchData,
        //   ),
        // ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(color: kheader),
              )
            : SingleChildScrollView(
                child: Column(children: widgets
                    //     <Widget>[
                    //   searchresult(null),
                    //   searchresult(null),
                    //   // searchresult()
                    // ],
                    ),
              ));
  }

  Padding searchresult(SaleItem saleitem) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0), //const EdgeInsets.all(8.0),
      child: Container(
          //height: 100,
          child: Card(
        elevation: 6,
        // color: kitembg,
        child: InkWell(
          onTap: () {
            print(saleitem.seller_name);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Orders(saleitem, hideFavorite: true),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Image.network(
                      saleitem.getImageURL(),
                      fit: BoxFit.cover,
                      height: 140.0,
                      width: 100.0,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BoldText(saleitem.seller_name, 16.0, kblack),
                          Row(children: [
                            BoldText("Fish Seed: ", 12.0, kblack),
                            NormalText(saleitem.fish_type_name, kblack, 12.0),
                          ]),
                          Row(children: [
                            BoldText("Price: ", 12.0, kblack),
                            NormalText(saleitem.getPrice(), kblack, 12.0),
                          ]),
                          Row(children: [
                            BoldText("Size: ", 12.0, kblack),
                            NormalText(saleitem.fish_size_type, kblack, 12.0),
                          ]),
                          Row(children: [
                            BoldText("Weight: ", 12.0, kblack),
                            NormalText(saleitem.getWeight(), kblack, 12.0),
                          ]),
                          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            MaterialButton(
                                child: Icon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.trashAlt,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                minWidth: 40,
                                color: Colors.white,
                                elevation: 6,
                                shape: CircleBorder(),
                                onPressed: () {
                                  myFavoriteDelete(saleitem.id);
                                }),
                          ]),
                        ],
                      ),
                    )), //"Lorem ipsum"
                    // Container(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //           padding: EdgeInsets.all(25.0),
                    //           decoration: BoxDecoration(
                    //             color: Colors.transparent,
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: BoldText(
                    //               saleitem.getDistance(), 14.0, kitembg)),
                    //       SizedBox(height: 10),
                    //       Row(
                    //         children: [
                    //           //phone_in_talk
                    //           IconButton(
                    //               icon: Icon(
                    //                 FontAwesomeIcons.trashAlt,
                    //                 color: korange,
                    //               ),
                    //               onPressed: () {
                    //                 myFavoriteDelete(saleitem.id);
                    //               }),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  List<SaleItem> listFish = [];
  var isLoading = false;

  myFavorite() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final response = await http.post(Common.getURL('myFavorite'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          "customer_id": saveUser()?.data?.id.toString()??"",
          "lat": "21.1430431",
          "lng": "72.7896692",
          "limit": "100",
        }));

    if (mounted)
      setState(() {
        isLoading = false;
      });
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      final parsed = resBody["data"]["data"].cast<Map<String, dynamic>>();
      print(parsed);

      listFish = parsed.map<SaleItem>((json) => SaleItem.fromJson(json)).toList();
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      throw Exception('Failed to load request');
    }
  }

  myFavoriteDelete(saleItemId) async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final response = await http.post(Common.getURL('favoriteRemove'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          "rawid": saleItemId.toString(),
          "customer_id": saveUser()?.data?.id.toString()??"",
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"]["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      EasyLoading.showToast(resBody["message"].toString());
      if (mounted)
        setState(() {
          isLoading = false;
          myFavorite();
        });
    } else {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      throw Exception('Failed to load request');
    }
  }
}
