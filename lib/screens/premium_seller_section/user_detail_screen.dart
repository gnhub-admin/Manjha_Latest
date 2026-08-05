import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:manjha/getxcontrollers/premium_seller_section/premium_seller_controller.dart';
import '../const.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  PremiumSellerController premiumSellerController = Get.put(PremiumSellerController());

  @override
  void initState() {
    premiumSellerController.fetchPremiumUserList();
    super.initState();
  }

  int userLength = 11;

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: themecolor,
          title: Text("User Details (${premiumSellerController.userDataList.length})"),
          centerTitle: false),
      body: Obx(() => premiumSellerController.loading.isTrue ?
      // Center(child: CircularProgressIndicator(color: kheader,))
      Center(child: SizedBox())
          : premiumSellerController.loading.isTrue ? CircularProgressIndicator(color: kheader,) : ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
              children: List.generate(premiumSellerController.userDataList.length, (index) {
                print(capitalizeFirstLetter(premiumSellerController.userDataList[index].action ?? ""));
                return Container(
                  // color: Colors.white,
                  // height: 120,
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: Card(
                    color: Colors.white,
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Get.to(() => PremiumSellerDetail());
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("Manoj Chauhan",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                                Text("${premiumSellerController.userDataList[index].fullName}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(Icons.phone,color: Color(0xff888888),size: 15,),
                                    SizedBox(width: 5,),
                                    Text("${premiumSellerController.userDataList[index].mobileno}",style: TextStyle(color: Color(0xff888888),fontWeight: FontWeight.w400,fontSize: 12),)
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${formattedDate(premiumSellerController.userDataList[index].createdAt ?? "")}",style: TextStyle(color: Color(0xff888888),fontWeight: FontWeight.w600,fontSize: 12),),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Fluttertoast.showToast(msg: "${capitalizeFirstLetter(premiumSellerController.userDataList[index].action ?? "")}");
                                        },
                                        child: Container(
                                          // width: 100,
                                          margin: EdgeInsets.zero,
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2.5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: kheader),
                                          ),
                                          child: Center(child: Text("${capitalizeFirstLetter(premiumSellerController.userDataList[index].action ?? "")}",style: TextStyle(color: kheader),)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
          ),
        ),
      )),
    );
  }
}
