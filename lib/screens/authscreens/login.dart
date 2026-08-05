import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/authscreens/otp_verify.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/screens/helper.dart';

import '../../getxcontrollers/firebaseauthcontroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  // String _selectedCountryCode = '+91';
  // String _phoneNumber = '';

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
  FirebaseAuthContrller firebaseAuthContrller = Get.put(FirebaseAuthContrller());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   height: screenheight(context,dividedby: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   color: kheader,
            //   width: screenwidth(context,dividedby: 1),
            //   alignment: Alignment.centerLeft,
            //   child:
            // ),
            // Text(
            //   "Login",
            //   textScaleFactor: 2,
            //   style:
            //   TextStyle(color: themecolor, fontWeight: FontWeight.w500),
            // ),
            SizedBox(
              height: screenheight(context, dividedby: 15),
            ),
            Image(
              image: AssetImage("assets/logo.png"),
              height: 150,
              width: 150,
            ),

            Container(
              width: double.infinity,
              // padding: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/login-screen.png",
                      height: screenheight(context, dividedby: 8),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Enter Your Mobile Number",
                      textScaleFactor: 1.4,
                      style: TextStyle(color: Color(0xff042B33)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "We Will send you a Confirmation Code",
                      textScaleFactor: 1,
                      style: TextStyle(color: Color(0xff737373)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("+91  "),
                          Expanded(
                            child: TextFormField(
                              // cursorHeight: 20,
                              scrollPadding: EdgeInsets.zero,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Valid Mobile Number";
                                } else if (value.length < 10) {
                                  return "Please Enter Valid Mobile Number";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              maxLength: 10,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  counterText: '',
                                  hintText: "Phone Number",
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: kheader))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kheader),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)))),
                        onPressed: () {
                          String phoneNumber =
                          phoneController.text.toString();
                          if (_formKey.currentState!.validate()) {
                            firebaseAuthContrller.sendOTP(phoneNumber);
                          }
                          // if (phoneNumber.isNotEmpty) {
                          //   Get.to(OTPVerify(mobileNumber: phoneNumber));
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('Please enter a valid 10-digit phone number')),
                          //   );
                          // }
                        },
                        child: Text('Send OTP'),
                      ),
                    ),
                    SizedBox(
                      height: 100,
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
