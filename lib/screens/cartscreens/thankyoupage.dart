import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/Screens/const.dart';
import 'package:manjha/screens/mainscreen.dart';

import '../profile_screens/StoreOrderPage.dart';

class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cartbackgroundcolor,
      // appBar: AppBar(
      //   title: Text('Thank You'),
      //   backgroundColor: Colors.teal,
      //   automaticallyImplyLeading: false,
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the network image
              Image.network(
                // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc5pIPFoQ6sDJcuaHfoSM_vg0cBbneGdF7SQ&s',
                'https://media.tenor.com/WsmiS-hUZkEAAAAj/verify.gif',
                height: 150.0,
                width: 150.0,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100.0,
                  );
                },
              ),
              SizedBox(height: 20),
              // Display the thank you message
              Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 30,
                  color: themecolor2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Your order has been placed successfully. Please check the status on the order page.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: themecolor),
              ),
              SizedBox(height: 30),

              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //       return StoreOrderPage();
                      //     },
                      //   ),
                      // );
                      Get.offAll(() => MainScreens(initialIndex: 0));
                    },
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        backgroundColor:
                            MaterialStatePropertyAll(themecolor),
                        foregroundColor:
                            MaterialStatePropertyAll(themecolor)),
                    child: Text("Continue Shopping",style: TextStyle(color: kwhite,fontSize: 16,fontWeight: FontWeight.w500),)),
              ),

              // ElevatedButton(
              //     onPressed: () {
              //       Get.offAll(() => MainScreens(initialIndex: 0));
              //       Get.to(StoreOrderPage());
              //     },
              //     child: Text("Let's Show Order"))
            ],
          ),
        ),
      ),
    );
  }
}
