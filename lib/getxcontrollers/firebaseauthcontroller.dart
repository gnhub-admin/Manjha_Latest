import 'dart:convert';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/authscreens/otp_verify.dart';
import 'logincontroler.dart';

class FirebaseAuthContrller extends GetxController {
  String verificationid = "";
  LoginController loginController = Get.put(LoginController());

  Future<void> sendOTP(String phoneNumber) async {
        EasyLoading.show();

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithPhoneNumber(phoneNumber);
    await auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) {
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: e.message ?? "");
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        EasyLoading.dismiss();
        verificationid = verificationId;
        Fluttertoast.showToast(msg: "OTP sent Successfully");
        Get.to(() => OTPVerify(mobileNumber: phoneNumber));
        print('Verification ID: $verificationId');
        print('Verification ID: $resendToken');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        EasyLoading.dismiss();
        log(verificationId);
      },
    );
  }

  Future<void> ResendOTP(String phoneNumber) async {
        EasyLoading.show();

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) {
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: e.message ?? "");
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        EasyLoading.dismiss();
        verificationid = verificationId;
        Fluttertoast.showToast(msg: "OTP sent Successfully");
        // Get.to(VerifyOtpScreen(phonenumber: phoneNumber));
        print('Verification ID: $verificationId');
        print('Verification ID: $resendToken');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        EasyLoading.dismiss();
        log(verificationId);
      },
    );
  }

  Future<void> verifyOTP(String smsCode, widget,) async {
        EasyLoading.show();

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationid,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Fluttertoast.showToast(msg: 'OTP verified');
        loginController.LoginApiCall(
            mobilenumber: widget.mobileNumber);
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'OTP verification failed');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'OTP verification failed');
      print('Error verifying OTP: $e');
      // Handle error while verifying OTP
    }
  }
}
