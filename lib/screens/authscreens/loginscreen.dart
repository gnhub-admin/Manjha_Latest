import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/getxcontrollers/logincontroler.dart';
import 'package:manjha/widget/button.dart';
import '../const.dart';
import '../../widget/textstyle.dart';

class UserItem {
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  String googleUid;
  String facebookUid;

  UserItem(
      {required this.firstName,
      required this.lastName,
      required this.emailId,
      required this.phoneNo,
      required this.googleUid,
      required this.facebookUid});
}

//ignore: must_be_immutable
class LoginMobilePage extends StatefulWidget {
  @override
  _LoginMobilePageState createState() => _LoginMobilePageState();

  UserItem? userItem;

  LoginMobilePage({this.userItem});
// LoginMobilePage({this.userItem});
}

class _LoginMobilePageState extends State<LoginMobilePage> {
  TextEditingController phoneController = TextEditingController();
  // final TextEditingController _smsController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final SmsAutoFill _autoFill = SmsAutoFill();
  // late String _verificationId;

  @override
  void initState() {
    // phoneController.text = "7600015403";

    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        title: NormalText("OTP Verification", kblack, 20.0),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 75),
              Image(
                image: AssetImage('assets/mobile-1.png'),
                width: 250,
              ),
              SizedBox(height: 20),
              NormalText(
                  "We will send you a OTP Message", Colors.black38, 16.0),
              SizedBox(height: 20),
              Container(
                  // height: 75,
                  // constraints: const BoxConstraints(maxWidth: 500),
                  width: 300,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    color: kgreyFill,
                    borderOnForeground: true,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CupertinoTextField(
                        cursorHeight: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            // color: Colors.black12,
                            // borderRadius:
                            //     const BorderRadius.all(Radius.circular(4)),
                            ),
                        controller: phoneController,
                        clearButtonMode: OverlayVisibilityMode.editing,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        placeholder: 'Enter your mobile number',
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 300,
                  child: WideButton.bold("Send OTP", () async {
                    loginController.LoginApiCall(
                        mobilenumber: phoneController.text);
                  }, true)),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // String _deviceIdentity = "";
  // final DeviceInfoPlugin _deviceInfoPlugin = new DeviceInfoPlugin();
  // Future<String> _getDeviceIdentity() async {
  //   if (_deviceIdentity == '') {
  //     try {
  //       if (Platform.isAndroid) {
  //         AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;
  //         // _deviceIdentity = "${info.device}-${info.androidId}"; //info.id
  //         _deviceIdentity = info.androidId; //info.id
  //       } else if (Platform.isIOS) {
  //         IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;
  //         _deviceIdentity = "${info.model}-${info.identifierForVendor}";
  //       }
  //     } on PlatformException {
  //       _deviceIdentity = "unknown";
  //     }
  //   }
  //
  //   return _deviceIdentity;
  // }
}
