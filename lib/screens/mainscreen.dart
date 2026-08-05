import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/screens/homescreeen/homescreen.dart';
import 'package:manjha/screens/product/productdetailsscreen.dart';
import 'package:manjha/screens/profile_screens/StoreProfilePage.dart';
import 'package:manjha/screens/storescreen.dart';
import 'package:shimmer/shimmer.dart';
import '../getxcontrollers/maincontroller.dart';
import '../getxcontrollers/storescreencontroller.dart';
import '../languagetranslation/apptranslation.dart';
import '../model/getstorebannerresponse.dart';
import '../widget/textstyle.dart';
import 'charchascreens/charchascreen.dart';
import 'discover/discoverscreen.dart';

class MainScreens extends StatefulWidget {
  final int? initialIndex;
  // const RootApp({super.key});
  final Function(int)? setActiveTab;
  const MainScreens({Key? key, this.initialIndex, this.setActiveTab})
      : super(key: key);
  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens>
    with SingleTickerProviderStateMixin {
  MainController m = Get.put(MainController());
  late List<Widget> screens;
  final PageStorageBucket bucket = PageStorageBucket();

  late int activeTab;
  int backPressCounter = 0;

  @override
  void initState() {
    super.initState();
    activeTab = widget.initialIndex ?? 0;
    screens = [
      StoreScreen(),
      // SellFishScreen(),
      HomeScreen(),
      CharchaScreen(ForumType.Forum),
      DiscoverScreen(),
      StoreProfilePage(),
    ];
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     activeTab = index;
  //     widget.setActiveTab?.call(index);
  //   });
  // }

  Future<bool> _onBackPress(BuildContext context) async {
    if (m.currentTab != 0) {
      setState(() {
        m.currentTab.value = 0;
        m.currentScreen.value = screens[m.currentTab.value];
      });
      return false;
    } else {
      if (backPressCounter == 0) {
        // Show the 'Tap again Back to exit' toast
        Fluttertoast.showToast(
          msg: 'Swipe back again to exit',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        backPressCounter++;

        await Future.delayed(Duration(seconds: 1));

        backPressCounter = 0;
        return false;
      } else {
        exit(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool showfab = MediaQuery.of(context).viewInsets.bottom != 0;

    return WillPopScope(
      onWillPop: () {
        return _onBackPress(context);
      },
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: Obx(
          () => PageStorage(bucket: bucket, child: m.currentScreen.value),
        ),
        // floatingActionButton: Visibility(
        //   visible: !showfab,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       // borderRadius: BorderRadius.circular(30),
        //       border: Border.all(
        //         color: currentTab == 2 ? Colors.transparent : themecolor,
        //       ),
        //       shape: BoxShape.circle,
        //     ),
        //     child: FloatingActionButton(
        //         tooltip: 'Store',
        //         elevation: 0,
        //         backgroundColor: currentTab == 2 ? themecolor : Colors.white,
        //         onPressed: () {
        //           setState(() {
        //             currentScreen = StoreScreen();
        //             currentTab = 2;
        //           });
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.all(5),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Icon(
        //                 Icons.storefront_sharp,
        //                 color: currentTab == 2 ? Colors.white : themecolor,
        //               ),
        //               SizedBox(
        //                 height: 0,
        //               ),
        //               Text(
        //                 "Store".tr,
        //                 style: TextStyle(
        //                   fontSize: 10,
        //                   color: currentTab == 2 ? Colors.white : themecolor,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         )),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(() => BottomAppBar(
              shape: const CircularNotchedRectangle(),
              // color: const Color(0xff909196).withOpacity(0.3),
              notchMargin: 6,
              // color: Color(0xff909196).withOpacity(0.3),
              child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: 'Store',
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              // currentScreen = Homepage();

                              m.currentScreen.value = StoreScreen();
                              m.currentTab.value = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                color: m.currentTab == 0
                                    ? themecolor
                                    : Colors.grey,
                                size: 23,
                              ),
                              FittedBox(
                                child: Text(
                                  'Store'.tr,
                                  style: TextStyle(
                                    fontSize: m.currentTab == 0 ? 14 : 12,
                                    color: m.currentTab == 0
                                        ? themecolor
                                        : Colors.grey,
                                    fontWeight: m.currentTab == 0
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: 'Seed',
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              // currentScreen = testclass();
                              m.currentScreen.value = HomeScreen();

                              // currentScreen = SellFishScreen();
                              m.currentTab.value = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.fishFins,
                                color: m.currentTab == 2
                                    ? themecolor
                                    : Colors.grey,
                                size: 23,
                              ),
                              FittedBox(
                                child: Text(
                                  'Seed'.tr,
                                  style: TextStyle(
                                    fontSize: m.currentTab == 2 ? 14 : 12,
                                    color: m.currentTab == 2
                                        ? themecolor
                                        : Colors.grey,
                                    fontWeight: m.currentTab == 2
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: 'Charcha',
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              // currentScreen = CharchaDesign();
                              m.currentScreen.value =
                                  CharchaScreen(ForumType.Forum);
                              m.currentTab.value = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_alt_outlined,
                                color: m.currentTab == 3
                                    ? themecolor
                                    : Colors.grey,
                                size: 23,
                              ),
                              FittedBox(
                                child: Text(
                                  'Charcha'.tr,
                                  style: TextStyle(
                                    fontSize: m.currentTab == 3 ? 14 : 12,
                                    color: m.currentTab == 3
                                        ? themecolor
                                        : Colors.grey,
                                    fontWeight: m.currentTab == 3
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: 'Discover',
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              m.currentScreen.value = DiscoverScreen();
                              m.currentTab.value = 4;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu_book_outlined,
                                color: m.currentTab == 4
                                    ? themecolor
                                    : Colors.grey,
                                size: 23,
                              ),
                              FittedBox(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Discovers'.tr,
                                  style: TextStyle(
                                    fontSize: m.currentTab == 4 ? 14 : 12,
                                    color: m.currentTab == 4
                                        ? themecolor
                                        : Colors.grey,
                                    fontWeight: m.currentTab == 4
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: 'Profile',
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              m.currentScreen.value = StoreProfilePage();
                              m.currentTab.value = 5;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: m.currentTab == 5
                                    ? themecolor
                                    : Colors.grey,
                                size: 23,
                              ),
                              FittedBox(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Profile'.tr,
                                  style: TextStyle(
                                    fontSize: m.currentTab == 5 ? 14 : 12,
                                    color: m.currentTab == 5
                                        ? themecolor
                                        : Colors.grey,
                                    fontWeight: m.currentTab == 5
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  bool get wantKeepAlive => true;
}

class testclass extends StatefulWidget {
  const testclass({super.key});

  @override
  State<testclass> createState() => _testclassState();
}

class _testclassState extends State<testclass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "In Progress.....",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      )),
    );
  }
}

// class CharchaDesign extends StatefulWidget {
//   const CharchaDesign({super.key});
//
//   @override
//   State<CharchaDesign> createState() => _CharchaDesignState();
// }
//
// class _CharchaDesignState extends State<CharchaDesign> {
//   int count = 169;
//
//   bool tapped = false;
//
//   final List<String> userName = [
//     "Alex Costa",
//     "Abdullah Fazal",
//     "Robby Jan",
//     "Manish Malhotra",
//     "Deep Patel"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffeeeeee),
//       appBar: AppBar(
//         backgroundColor: kheader,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Sawal Jawab'.tr,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kwhite),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             padding: EdgeInsets.only(right: 10),
//               tooltip: "Share",
//               onPressed: () {},
//               icon: Icon(
//                 Icons.share,
//                 color: Colors.white,
//               )),
//         ],
//       ),
//       body: ScrollConfiguration(
//         behavior: ScrollBehavior().copyWith(overscroll: false),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 15,),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 15),
//                 padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     print('press');
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Icon(Icons.edit,color: Colors.black,),
//                       Image.asset("assets/pencil.png",height: 20,),
//                       SizedBox(width: 15,),
//                       Text("Ask your Question",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),)
//                     ],
//                   ),
//                 ),
//               ),
//               ScrollConfiguration(
//                 behavior: ScrollBehavior().copyWith(overscroll: false),
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                     // physics: NeverScrollableScrollPhysics(),
//                     itemCount: userName.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Get.to(() => CharchaDetail(userName: userName[index],));
//                         },
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20)
//                           ),
//                           child: Column(
//                             children: [
//                               ListTile(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20)
//                                 ),
//                                 tileColor: Colors.white,
//                                 leading: CircleAvatar(
//                                   backgroundColor: Colors.grey,
//                                   foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi6tPF5JeRbN6KORVIAQzb3xa0r-rSzYuzvKPHMa4s6A&s"),
//                                 ),
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 5),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text("${userName[index]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
//                                           // Text(" · 1d",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
//                                         ],
//                                       ),
//                                       Align(
//                                         alignment: Alignment.topRight,
//                                         child: PopupMenuButton<String>(
//                                           icon: Icon(CupertinoIcons.ellipsis,color: kheader,),
//                                           itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                                             PopupMenuItem<String>(
//                                               value: 'report',
//                                               child: Text('Report'),
//                                             ),
//                                             PopupMenuItem<String>(
//                                               value: 'block user',
//                                               child: Text('Block User'),
//                                             ),
//                                           ],
//                                           onSelected: (String value) {
//                                             switch (value) {
//                                               case 'archive':
//                                                 break;
//                                               case 'contact':
//                                                 break;
//                                             }
//                                           },
//                                         ),
//                                         // Icon(CupertinoIcons.ellipsis_vertical),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 subtitle: Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text("Hello ! Robbi How are you?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),)
//                                         ],
//                                       ),
//                                       (index == 0 || index == 3) ?
//                                       Container(
//                                         margin: EdgeInsets.symmetric(vertical: 15),
//                                         alignment: AlignmentDirectional.centerStart,
//                                         height: 150,
//                                         width: 250,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(20),
//                                           image: DecorationImage(
//                                             image: NetworkImage("https://i.pinimg.com/736x/53/d5/77/53d577fbc7ff15fec6f6a46b161e47d8.jpg"),fit: BoxFit.cover,
//                                           )
//                                         ),
//                                       ) : SizedBox.shrink(),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 10,bottom: 10),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 tapped = !tapped;
//                                                 tapped == true ? count ++ : count --;
//                                               });
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 Icon((index == 0 || index == 3) ? tapped ? CupertinoIcons.hand_thumbsup_fill : CupertinoIcons.hand_thumbsup : CupertinoIcons.hand_thumbsup,color: kheader,size: 18,),
//                                                 SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Text("Like",style: TextStyle(color: kheader,fontWeight: FontWeight.w400,fontSize: 14),),
//                                               ],
//                                             ),
//                                           ),
//                                           Row(
//                                             children: [
//                                               Icon(CupertinoIcons.chat_bubble,color: kheader,size: 18,),
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               Text("Comment",style: TextStyle(color: kheader,fontWeight: FontWeight.w400,fontSize: 14),),
//                                             ],
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               Fluttertoast.showToast(
//                                                 msg: "Share Feature Is In Progress",
//                                                 fontSize: 12,
//                                                 textColor: Colors.white,
//                                                 backgroundColor: Colors.red,
//                                               );
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 Icon(CupertinoIcons.location,color: kheader,size: 18,),
//                                                 SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Text("Send",style: TextStyle(color: kheader,fontWeight: FontWeight.w400,fontSize: 14),),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(vertical: 5),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text("${index == 0 ? count : index == 3 ? count : 188} Like · ${index == 0 ? count : index == 3 ? count : 188} Comment",style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600,fontSize: 10),),
//                                           Text("12 Mar 2024",style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600,fontSize: 10),),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 10,bottom: 10),
//                                       child: RichText(
//                                         softWrap: true,
//                                         overflow: TextOverflow.ellipsis,
//                                         textScaleFactor: 0.9,
//                                         maxLines: 2,
//                                         text: TextSpan(
//                                           children: <TextSpan>[
//                                             TextSpan(
//                                                 text: 'Alex Costa : ',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold)),
//                                             TextSpan(
//                                                 text:
//                                                 'Your listing has been submitted to the admin for approval Your listing has been submitted to the admin for approval',
//                                                 style: TextStyle(color: kgreyDark))
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CharchaDetail extends StatefulWidget {
//   final String? userName;
//   const CharchaDetail({super.key,this.userName});
//
//   @override
//   State<CharchaDetail> createState() => _CharchaDetailState();
// }
//
// class _CharchaDetailState extends State<CharchaDetail> {
//
//   final List<String> userName = [
//     "Abdullah Fazal",
//     "Robby Jan",
//     "Manish Malhotra",
//     "Deep Patel"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffeeeeee),
//       appBar: AppBar(
//         backgroundColor: kheader,
//         automaticallyImplyLeading: false,
//         title: Text(
//           '${widget.userName}',
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kwhite),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//               padding: EdgeInsets.only(right: 10),
//               tooltip: "Share",
//               onPressed: () {},
//               icon: Icon(
//                 Icons.share,
//                 color: Colors.white,
//               )),
//         ],
//       ),
//       body: ScrollConfiguration(
//         behavior: ScrollBehavior().copyWith(overscroll: false),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 100),
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//               padding: EdgeInsets.zero,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20)
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)
//                     ),
//                     tileColor: Colors.white,
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.grey,
//                       foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi6tPF5JeRbN6KORVIAQzb3xa0r-rSzYuzvKPHMa4s6A&s"),
//                     ),
//                     title: Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               Text("${widget.userName}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
//                               // Text(" · 1d",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
//                             ],
//                           ),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: PopupMenuButton<String>(
//                               icon: Icon(CupertinoIcons.ellipsis,color: kheader,),
//                               itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                                 PopupMenuItem<String>(
//                                   value: 'report',
//                                   child: Text('Report'),
//                                 ),
//                                 PopupMenuItem<String>(
//                                   value: 'block user',
//                                   child: Text('Block User'),
//                                 ),
//                               ],
//                               onSelected: (String value) {
//                                 switch (value) {
//                                   case 'archive':
//                                     break;
//                                   case 'contact':
//                                     break;
//                                 }
//                               },
//                             ),
//                             // Icon(CupertinoIcons.ellipsis_vertical),
//                           ),
//                         ],
//                       ),
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text("Hello ! Robbi How are you?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),)
//                             ],
//                           ),
//                           Container(
//                             margin: EdgeInsets.symmetric(vertical: 15),
//                             alignment: AlignmentDirectional.centerStart,
//                             height: 150,
//                             width: 250,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 image: DecorationImage(
//                                   image: NetworkImage("https://i.pinimg.com/736x/53/d5/77/53d577fbc7ff15fec6f6a46b161e47d8.jpg"),fit: BoxFit.cover,
//                                 )
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 20),
//                     child: ListView.separated(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                         padding: EdgeInsets.only(left: 10),
//                         itemCount: userName.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               ListTile(
//                                 dense: true,
//                                 minVerticalPadding: 0,
//                                 minLeadingWidth: -5,
//                                 tileColor: Colors.white,
//                                 leading: CircleAvatar(
//                                   radius: 13,
//                                   backgroundColor: Colors.grey,
//                                   foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi6tPF5JeRbN6KORVIAQzb3xa0r-rSzYuzvKPHMa4s6A&s"),
//                                 ),
//                                 title: Padding(
//                                   padding: const EdgeInsets.only(top: 5),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text("${userName[index]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text("12 Mar 2024",style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600,fontSize: 10),),
//                                           Align(
//                                             alignment: Alignment.topRight,
//                                             child: PopupMenuButton<String>(
//                                               icon: Icon(CupertinoIcons.ellipsis_vertical,color: Colors.black,size: 18,),
//                                               itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                                                 PopupMenuItem<String>(
//                                                   value: 'report',
//                                                   child: Text('Report'),
//                                                 ),
//                                                 PopupMenuItem<String>(
//                                                   value: 'block user',
//                                                   child: Text('Block User'),
//                                                 ),
//                                               ],
//                                               onSelected: (String value) {
//                                                 switch (value) {
//                                                   case 'archive':
//                                                     break;
//                                                   case 'contact':
//                                                     break;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 subtitle: Padding(
//                                   padding: const EdgeInsets.only(right: 5),
//                                   child: Text('Your listing has been submitted to the admin for approval Your listing has been submitted to the admin for approval',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10),),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       separatorBuilder: (context, index) {
//                         return Divider(color: Colors.grey,endIndent: 15,);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Container(
//         margin: EdgeInsets.symmetric(horizontal: 15),
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: CircleAvatar(
//                 radius: 15,
//                 backgroundColor: Colors.grey,
//                 foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi6tPF5JeRbN6KORVIAQzb3xa0r-rSzYuzvKPHMa4s6A&s"),
//               ),
//             ),
//             SizedBox(width: 10,),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Write your message...',
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 Fluttertoast.showToast(
//                   msg: "Comment Feature Is In Developing",
//                   fontSize: 12,
//                   textColor: Colors.white,
//                   backgroundColor: Colors.red,
//                 );
//               },
//               icon: Icon(CupertinoIcons.location),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _current = 0;
  StoreScreenController storecontroller = Get.put(StoreScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cartbackgroundcolor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        leadingWidth: 39,
        // leadingWidth: 40,
        title: Row(
          children: [
            Image.asset(height: 40, width: 100, 'assets/pattern4a.png'),
            Text(
              "  Bazar".tr,
              style: TextStyle(color: kheader),
            ),
          ],
        ),
        backgroundColor: kwhite,
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(Icons.person_outline, color: kheader),
              onPressed: () {
                // this._login();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // return Profile();
                  return StoreProfilePage();
                }));
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart_rounded, color: kheader),
              onPressed: () {
                // this._login();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // return Profile();
                  return StoreProfilePage();
                }));
              }),
        ],
      ),
      // floatingActionButton: getFloatingButton(),
      body: Column(children: [
        Container(
          color: kwhite,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kgreyFill,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 2.0,
                        ),
                      ],
                      border: Border.all(color: kheader, width: 0),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        // _showMapboxSearch();
                        // showLocationSheet();\
                        // showSearchSheet();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              // ignore: deprecated_member_use
                              FontAwesomeIcons.search,
                              size: 20.0,
                              color: kgreyDark.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            NormalText('${translate('Search bazar...!')}',
                                kgreyDark.withOpacity(0.5), 20.0),
                            Flexible(fit: FlexFit.tight, child: SizedBox()),
                            // Padding(
                            //   padding: EdgeInsets.only(right: 10.0),
                            //   child: Icon(
                            //     FontAwesomeIcons.paperPlane,
                            //     size: 20.0,
                            //     color: kblack,
                            //   ),
                            // ),
                          ]),
                    )),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Obx(() => storecontroller.getbannerapi.isTrue
                  ? Stack(alignment: Alignment.bottomCenter, children: [
                      CarouselSlider(
                        items: storecontroller.listbanners
                            .map((banner) => GestureDetector(
                                  onTap: () {
                                    Get.to(() => ProductDetailScreen(
                                        product: banner.product ?? Product()));
                                  },
                                  child: CachedNetworkImage(
                                    width: double.infinity,
                                    fadeInCurve: Curves.bounceIn,
                                    imageUrl: banner.imageUrl ?? "",
                                    cacheKey: banner.imageUrl ?? "",
                                    placeholder: (context, url) =>
                                        Image.asset('assets/no-photo.png'),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-photo.png'),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            //       options: CarouselOptions(
                            height: 165,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            enlargeFactor: 0,
                            viewportFraction: 1,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: storecontroller.listbanners.map((banner) {
                            int index =
                                storecontroller.listbanners.indexOf(banner);
                            return Container(
                              width: 6.0,
                              height: 6.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? const Color.fromRGBO(0, 0, 0, 0.9)
                                    : const Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ])
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                    )

              // Image.asset(
              //   "assets/images/banner.png",
              //   scale: 4.0,
              // ),
              ),
        ),
      ]),
    );
  }
}
