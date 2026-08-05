import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../getxcontrollers/firebaseauthcontroller.dart';
import '../../getxcontrollers/logincontroler.dart';
import '../const.dart';
import '../helper.dart';

class OTPVerify extends StatefulWidget {
  final String mobileNumber;
  const OTPVerify({super.key, required this.mobileNumber});

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseAuthContrller firebaseAuthContrller = Get.put(FirebaseAuthContrller());
  LoginController lcontrller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 10.0, top: screenwidth(context, dividedby: 10)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: themecolor,
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Verify OTP",
                    textScaleFactor: 1.8,
                    style:
                        TextStyle(color: themecolor, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/verification-screen.png",
                      height: screenwidth(context,dividedby: 5),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Enter Verification code",
                      textScaleFactor: 1.4,
                      style: TextStyle(color: Color(0xff042B33)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        textAlign: TextAlign.center,
                        "We are send SMS to your mobile number ${widget.mobileNumber}",
                        textScaleFactor: 1,
                        style: TextStyle(color: Color(0xff737373)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Pinput(
                        defaultPinTheme: PinTheme(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(30, 60, 87, 1),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        length: 6,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp('[\\.]')),
                        ],
                        onCompleted: (pin) async {
                           firebaseAuthContrller.verifyOTP(pin, widget,);
                          // if (pin == "123456") {
                          //   lcontrller.LoginApiCall(
                          //       mobilenumber: widget.mobileNumber);
                          // } else {
                          //   EasyLoading.showToast("Wrong OTP");
                          // }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Dont receive the OTP ?",
                          textScaleFactor: 1.2,
                        ),
                        TextButton(
                            onPressed: () {
                              firebaseAuthContrller.ResendOTP(widget.mobileNumber);
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(color: kheader),
                              textScaleFactor: 1.2,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
