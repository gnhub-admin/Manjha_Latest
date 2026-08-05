import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import '../../model/AddressModel.dart';
import '../../services/apiconst.dart';
import '../../widget/button.dart';
import '../../widget/textstyle.dart';
import '../cartscreens/storeaddadress.dart';
import '../const.dart';
import '../localconst.dart';

class StoreAddressPage extends StatefulWidget {
  @override
  _StoreAddressPageState createState() => _StoreAddressPageState();
}

class _StoreAddressPageState extends State<StoreAddressPage> {
  @override
  void initState() {
    this._fetchData();
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cartbackgroundcolor,
        bottomSheet: Container(
            height: 60,
            alignment: Alignment.center,
            // color: Colors.red,
            child: WideButton.bold(Lang.get("Add Address"), () async {
              // bool result =
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return StoreAddressAddPage();
              }));
              this._fetchData();
            }, true)),
        appBar: AppBar(
          backgroundColor: kheader,
          title: BoldText(
              "${translate('Addresses') + " (${list.length})"}", 25, kwhite),
          centerTitle: false,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  // this._login();
                  // bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return StoreAddressAddPage();
                  // }));
                  // if (result != null) {
                  // this._fetchData();
                  // }
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return StoreAddressAddPage();
                  }));
                }),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(color: kheader),
              )
            : list.length == 0
                ? Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: NormalText(
                            "${translate('No address saved.')}", kblack, 16.0),
                      ),
                    ))
                : SingleChildScrollView(
                    child: Column(
                        children: list.map((e) {
                      return populateItem(e);
                    }).toList()),
                  ));
  }

  Widget populateItem(
    AddressModel item,
  ) {
    return Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 4), //const EdgeInsets.all(8.0),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            // print(item.firstname);
            // bool result =
            // await Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return StoreAddressAddPage(address: item);
            // }));

            // if (result != null) {
            // this._fetchData();
            // }
          },
          child: Container(
            child: Card(
              color: kwhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  tileColor: Colors.transparent,
                  selectedTileColor: Colors.transparent,
                  onTap: () async {
                    // print(item.firstname);
                    // bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return StoreAddressAddPage(address: item);
                    // }));

                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StoreAddressAddPage(address: item);
                    }));

                    // if (result != null) {
                    // this._fetchData();
                    // }
                  },
                  contentPadding: EdgeInsets.all(8),
                  title: Text(
                    item.getName(),
                    textScaleFactor: 1.1,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    item.getAddress(),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            // this._login();
                            // this._fetchAddressDelete(item.id.toString());
                            await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return StoreAddressAddPage(address: item);
                            }));
                          }),
                      IconButton(
                          icon: Icon(CupertinoIcons.delete),
                          onPressed: () async {
                            // this._login();
                            showLogoutPopup(() {
                              print("data");
                              // this._fetchAddressDelete(item.id.toString());
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> showLogoutPopup(onpress) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Delete',
                style: TextStyle(color: Colors.red, fontSize: 20)),
            content: const Text('Do you really want to Delete Adress?'),
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
                onPressed: onpress,
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  List<AddressModel> list = [];
  var isLoading = false;

  _fetchData() async {
    // await Common.analytics.setCurrentScreen(screenName: 'MyAddressScreen');
    setState(() {
      isLoading = true;
    });
    print(isLoading);
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

      list = parsed
          .map<AddressModel>((json) => AddressModel.fromJson(json))
          .toList();

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load request');
    }
  }

  _fetchAddressDelete(String id) async {
    EasyLoading.show(status: translate('Deleting...'));

    final response = await http.post(Common.getURL('store_addressDelete'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Common.getCookie().toString()
          // "content-type": "application/x-www-form-urlencoded",
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'customer_id': saveUser()?.data?.id.toString() ?? "",
        }));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);
      EasyLoading.showToast(resBody["message"].toString());

      _fetchData();
      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);

      // setState(() {});
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to load request');
    }
  }
}
