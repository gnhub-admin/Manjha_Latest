import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:manjha/services/apiconst.dart';

import '../../model/getloginresponse.dart';
import '../../shared_pref/shared_pref.dart';
import '../../widget/button.dart';
import '../../widget/textfieldscreen.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../localconst.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController citynameController = TextEditingController();
  TextEditingController statenameController = TextEditingController();
  String _textMobileNo = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: NormalText(Lang.get("Update Profile"), kblack, 20.0),
          backgroundColor: kwhite,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
              width: 340.0,
              child:
                  NormalText(" " + Lang.get("First Name"), Colors.black38, 18)),
          Container(
              width: 340.0,
              child: NormalText(" " + firstNameController.text, kblack, 18)),
          // NormalForm(Icons.person, "", controller: firstNameController)),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 340.0,
              child:
                  NormalText(" " + Lang.get("Last Name"), Colors.black38, 18)),
          Container(
              width: 340.0,
              child: NormalText(" " + lastNameController.text, kblack, 18)),
          // NormalForm(Icons.person, "", controller: lastNameController)),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 340.0,
              child:
                  NormalText(" " + Lang.get("Mobile No"), Colors.black38, 18)),
          Container(
              width: 340.0, child: NormalText(" " + _textMobileNo, kblack, 18)),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 340.0,
              child: NormalText(" " + Lang.get("Email"), Colors.black38, 18)),
          Container(
              width: 340.0,
              child: NormalForm(
                Icons.email,
                "",
                controller: emailController,
                textInputStyle: TextCapitalization.none,
              )),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //     width: 340.0,
          //     child: NormalText(" " + Lang.get("Address"), Colors.black38, 18)),
          // Container(
          //     width: 340.0,
          //     child: NormalForm(Icons.location_on_outlined, "",
          //         controller: addressController)),
          SizedBox(
            height: 15,
          ),
          Container(
              width: 340.0,
              child: NormalText(
                  " " + Lang.get("Location"), Colors.black38, 18)), //City Name
          Container(
            width: 340.0,
            child: MaterialButton(
              height: 40,
              color: Colors.white,
              child: Row(children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: kheader,
                    ),
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 18,
                    )),
                // Icon(Icons.location_city, color: Colors.grey.shade700),
                SizedBox(
                  width: 10,
                ),
                Text(
                  addressController.text.isEmpty
                      ? '(Not Set)'
                      : addressController.text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      fontFamily: "nunito",
                      color: kgreyDark),
                )
              ]),
              textColor: Colors.black87,
              splashColor: Colors.white,
              onPressed: () {
                print('City Name');
                _showMapboxSearch();
              },
              padding: EdgeInsets.only(top: 12, bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  side: BorderSide(color: Colors.black26)),
            ),
            // NormalForm(Icons.location_city, "City Name",
            //     controller: citynameController)
          ),
          SizedBox(
            height: 30,
          ),
          WideButton.bold(Lang.get("Update"), () {
            // CHECK EMPTY CONDITION ------------------------->
            if (!Common.isEmail(emailController.text)) {
              EasyLoading.showToast("Enter valid EmailId");
              return;
            }

            // CHECK EMPTY CONDITION ------------------------->
            _fetchData().then((responseSuccess) {
              if (responseSuccess) {
                Navigator.pop(context);
              } else {
                EasyLoading.showToast("Failed to load request.");
              }
            });
            // REGISTRATION FINISH ------------------------->
          }, true),
          SizedBox(
            height: 20,
          ),
        ]))));
  }

  void _showMapboxSearch() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileUpdateScreen(),
        ));
    // EasyLoading.showToast(result);
    // Scaffold.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text("Searching for $result")));

// I/flutter (11746): locality.6663140808677440 > Piplod
// I/flutter (11746): place.16724959941422080 > Surat
// I/flutter (11746): district.17232676498422080 > Surat
// I/flutter (11746): region.11420597151576720 > Gujarat
// I/flutter (11746): country.14770391688208260 > India
//
    setState(() {
      var placeName = result.text;
      result.context.forEach((element) {
        print('${element.id} > ${element.text}');
        if (element.id.contains("district") && result.context.length > 3) {
          placeName += ", " + element.text;
        }
        if (element.id.contains("region") && result.context.length == 3) {
          placeName += ", " + element.text;
        }

        if (element.id.contains("district")) {
          citynameController.text = element.text;
        }
        if (element.id.contains("region")) {
          statenameController.text = element.text;
        }
      });
      addressController.text = placeName;
      // statenameController.text = placeName;
    });
  }

  // bool isLoading = false;
  Future<bool> _fetchData() async {
    // setState(() {
    // isLoading = true;
    // });
    // EasyLoading.show();

    print('cookie:' + Common.getCookie());
    final response = await http.post(Common.getURL("updateprofile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "content-type": "application/x-www-form-urlencoded",
          'Cookie': Common.getCookie().toString()
        },
        body: jsonEncode(<String, String>{
          "full_name": firstNameController.text + " " + lastNameController.text,
          "emailid": emailController.text,
          "address": addressController.text,
          "cityname": citynameController.text,
          "statename": statenameController.text
        }));
    EasyLoading.dismiss();

    // Common.updateCookie(response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      Map<String, dynamic> custItem = resBody["data"];
      print(custItem["id"].toString());
      // var customerId = parsed["id"];

      Getloginresponse? saveuser = saveUser();

      saveuser?.data?.id = custItem["id"];
      saveuser?.data?.fullName = custItem["full_name"];
      saveuser?.data?.emailid = custItem["emailid"];
      saveuser?.data?.customerPhoto = custItem["customer_photo"];
      saveuser?.data?.address = custItem["address"];
      saveuser?.data?.cityname = custItem["cityname"];

      SharedPref.save(
          value: jsonEncode(saveuser?.toJson()), prefKey: PrefKey.loginDetails);

      EasyLoading.showToast(resBody["message"].toString());
      setState(() {
        //   isLoading = false;
      });
      return true;
    } else {
      // throw Exception('Failed to load request');
      EasyLoading.showToast('Failed to load request',
          duration: Duration(seconds: 3));
    }
    return false;
  }

  Future<bool> _loadData() async {
    setState(() {
      //   isLoading = true;
    });
    // EasyLoading.show();
    print('cookie:' + Common.getCookie());
    final response = await http.get(
      Common.getURL("customer/" + (saveUser()?.data?.id.toString() ?? "")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // "content-type": "application/x-www-form-urlencoded",
        'Cookie': Common.getCookie().toString()
      },
      // body: jsonEncode(<String, String>{
      //   "first_name": firstNameController.text,
      //   "last_name": lastNameController.text,
      //   "emailid": emailController.text,
      // })
    );
    EasyLoading.dismiss();
    // Common.updateCookie(response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      Map<String, dynamic> custItem = resBody["data"];
      List<String> fullNameArray = custItem["full_name"].split(" ");

      print(custItem["id"].toString());
      setState(() {
        this.firstNameController.text = fullNameArray[0];
        if (fullNameArray.length > 1)
          this.lastNameController.text = fullNameArray[1];
        this.emailController.text = custItem["emailid"];
        this.addressController.text = custItem["address"];
        this.citynameController.text = custItem["cityname"];
        this.statenameController.text = custItem["statename"];
        this._textMobileNo = "+91 " + custItem["mobileno"];
        if (custItem["address"] == null || custItem["address"] == 'null') {
          addressController.text = custItem["cityname"];
        }

        Session.updateUser(
            custItem["id"].toString(),
            custItem["full_name"],
            custItem["emailid"],
            custItem["customer_photo"],
            custItem["address"]);

        //   isLoading = false;
      });
      return true;
    } else {
      // throw Exception('Failed to load request');
      EasyLoading.showToast('Failed to load request',
          duration: Duration(seconds: 3));
    }
    return false;
  }
}
