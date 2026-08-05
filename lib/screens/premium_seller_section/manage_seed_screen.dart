import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/premium_seller_section/add_seed_screen.dart';
import '../../getxcontrollers/premium_seller_section/premium_seller_controller.dart';
import '../../model/premium_seller_models/premium_seed_response_model.dart';
import '../../services/apiconst.dart';
import '../../widget/button.dart';
import '../const.dart';
import '../localconst.dart';

class ManageSeedScreen extends StatefulWidget {
  const ManageSeedScreen({super.key});

  @override
  State<ManageSeedScreen> createState() => _ManageSeedScreenState();
}

class _ManageSeedScreenState extends State<ManageSeedScreen> {
  void _removeOverlay(BuildContext context) {
    _EllipsisMenuState state =
        context.findAncestorStateOfType<_EllipsisMenuState>()!;
    state._removeOverlay();
  }

  PremiumSellerController premiumSellerController =
      Get.put(PremiumSellerController());

  @override
  void initState() {
    premiumSellerController.fetchPremiumSeedList(hatcheryId: 13.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeeeeee),
        bottomSheet: Container(
            height: 60,
            alignment: Alignment.center,
            // color: Colors.red,
            child: WideButton.bold(Lang.get("Add Seed"), () async {
              Get.to(() => AddSeedScreen());
            }, true)),
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: true,
            backgroundColor: themecolor,
            title: const Text("Manage Seed"),
            centerTitle: false),
        // body:
        // ScrollConfiguration(
        //   behavior: ScrollBehavior().copyWith(overscroll: false),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         Container(
        //             padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
        //             child: Card(
        //               elevation: 5,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(12.0),
        //               ),
        //               child: ListTile(
        //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        //                 minVerticalPadding: 0,
        //                 onTap: () async {},
        //                 contentPadding: EdgeInsets.all(8),
        //                 leading:
        //                 Stack(
        //                   alignment: Alignment.center,
        //                   children: [
        //                     Container(
        //                       height: 120,
        //                       width: 80,
        //                       padding: EdgeInsets.zero,
        //                       margin: EdgeInsets.zero,
        //                       decoration: BoxDecoration(
        //                         shape: BoxShape.rectangle,
        //                         borderRadius: BorderRadius.circular(12),
        //                         border: Border.all(color: Colors.transparent),
        //                       ),
        //                       child: ClipRRect(
        //                         borderRadius: BorderRadius.circular(12),
        //                         child: Stack(
        //                           children: [
        //                             FadeInImage.assetNetwork(
        //                               fadeInCurve: Curves.easeInOut,
        //                               fadeInDuration: Duration(milliseconds: 100),
        //                               imageErrorBuilder: (context, error, stackTrace) => Image.asset("assets/fish-hatcheries.jpg",
        //                                 height: 120,
        //                                 width: 85,
        //                                 fit: BoxFit.cover,),
        //                               placeholder: 'assets/fish-hatcheries.jpg',
        //                               image: "assets/fish-hatcheries.jpg",
        //                               height: 120,
        //                               width: 85,
        //                               fit: BoxFit.cover,
        //                             ),
        //                             Container(
        //                               decoration: BoxDecoration(
        //                                 borderRadius: BorderRadius.circular(10),
        //                                 gradient: LinearGradient(
        //                                   begin: Alignment.topCenter,
        //                                   end: Alignment.bottomCenter,
        //                                   colors: [
        //                                     Colors.black.withOpacity(0.5),
        //                                     Colors.black.withOpacity(0.5),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                     MaterialButton(
        //                       child: Icon(
        //                         FontAwesomeIcons.play,
        //                         color: Colors.white,
        //                         size: 15,
        //                       ),
        //                       minWidth: 45,
        //                       height: 35,
        //                       // color: kheader.withAlpha(150),
        //                       shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(5),
        //                         side: BorderSide(color: Colors.transparent),
        //                       ),
        //                       onPressed: () {
        //                         // showVideo(widget._hatchery.getVideoUrl());
        //                       },
        //                     ),
        //                   ],
        //                 ),
        //                 title: Padding(
        //                   padding: const EdgeInsets.only(bottom: 0),
        //                   child: Text("Grass carp",textScaleFactor: 1.5,style: TextStyle(fontWeight: FontWeight.bold),),
        //                 ),
        //                 subtitle:  Column(
        //                   children: [
        //                     Row(
        //                       children: [
        //                         Expanded(
        //                           flex: 1,
        //                           child: Text(
        //                             'Size:',
        //                             style: TextStyle(
        //                                 color: kgreyDark, fontSize: 10, fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Expanded(
        //                           flex: 1,
        //                           child: Text(
        //                             'Line:',
        //                             style: TextStyle(
        //                                 color: kgreyDark, fontSize: 10, fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Expanded(
        //                           child: Text(
        //                             'Price:',
        //                             style: TextStyle(
        //                                 color: kgreyDark, fontSize: 10, fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     Row(
        //                       children: [
        //                         Expanded(
        //                           flex: 1,
        //                           child: Text(
        //                             'Zero',
        //                             softWrap: true,
        //                             overflow: TextOverflow.fade,
        //                             style: TextStyle(
        //                                 color: Colors.grey.shade500,
        //                                 fontSize: 10,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Expanded(
        //                           flex: 1,
        //                           child: Text(
        //                             '0.0 pc/kg',
        //                             style: TextStyle(
        //                                 color: Colors.grey.shade500,
        //                                 fontSize: 10,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Expanded(
        //                           child: Text(
        //                             '0.2/pcs',
        //                             style: TextStyle(
        //                                 color: Colors.grey.shade500,
        //                                 fontSize: 10,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //                 trailing: Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //
        //                   ],
        //                 ),
        //               ),
        //             ))
        //       ],
        //     ),
        //   ),
        // ),
        body: Obx(
          () => premiumSellerController.premiumSeedLoader.isTrue
              ? SizedBox()
              : ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        _removeOverlay(context);
                      },
                      child: Column(
                        children: [
                          ...List.generate(
                              premiumSellerController.premiumSeedData.length,
                              (index) => buildListItem(
                                  context,
                                  premiumSellerController
                                      .premiumSeedData[index])),
                          SizedBox(height: 75),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }

  Widget buildListItem(BuildContext context, PremiumSeedData premiumSeedData) {
    return Container(
      height: 120,
      padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Get.to(() => PremiumSellerDetail());
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeInImage.assetNetwork(
                          fadeInCurve: Curves.easeInOut,
                          fadeInDuration: Duration(milliseconds: 100),
                          imageErrorBuilder: (context, error, stackTrace) =>
                              premiumSeedData.seedImage != null
                                  ? Image.network(
                                      // "assets/fish-hatcheries.jpg",
                                      "$local_image_seed${premiumSeedData.seedImage}",
                                      height: 80,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/logo.png",
                                      height: 80,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                          placeholder: 'assets/logo.png',
                          image: "assets/logo.png",
                          height: 80,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.black.withOpacity(0.5),
                              ],
                            ),
                          ),
                        ),
                        if(premiumSeedData.seedVideo != null)
                        MaterialButton(
                          child: Icon(
                            FontAwesomeIcons.play,
                            color: Colors.white,
                            size: 15,
                          ),
                          minWidth: 45,
                          height: 35,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.transparent),
                          ),
                          onPressed: () {
                            // showVideo(widget._hatchery.getVideoUrl());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${premiumSeedData.seedName}",
                              textScaleFactor: 1.5,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: EllipsisMenu(),
                            //   // GestureDetector(
                            //   //     onTap: () {
                            //   //       print("Done");
                            //   //     },
                            //   //       child: Icon(CupertinoIcons.ellipsis,color: kheader,)),
                            // ),
                          ],
                        ),
                        // SizedBox(height: 8),
                        // Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Size:',
                                    style: TextStyle(
                                        color: kgreyDark,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Line:',
                                    style: TextStyle(
                                        color: kgreyDark,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Price:',
                                    style: TextStyle(
                                        color: kgreyDark,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${premiumSeedData.seedSize}',
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${premiumSeedData.seedWeight} pc/kg',
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${premiumSeedData.seedPrice}/pcs',
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      CupertinoIcons.ellipsis_vertical,
                      color: kheader,
                      size: 18,
                    ),
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.none,
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        height: 0,
                        padding: EdgeInsets.zero,
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(
                            Icons.edit,
                            color: kheader.withOpacity(0.7),
                          ),
                          title: Text('Edit'),
                        ),
                      ),
                      PopupMenuItem<String>(
                        height: 0,
                        padding: EdgeInsets.zero,
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.red.withOpacity(0.5),
                          ),
                          title: Text('Delete'),
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      if (value == 'edit') {
                        Get.to(() =>
                            AddSeedScreen(premiumSeedId: premiumSeedData));
                      } else if (value == 'delete') {
                        premiumSellerController.deletePremiumSeedData(
                            premiumSeedId: premiumSeedData.id.toString());
                      }
                    },
                  ),
                  // EllipsisMenu(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EllipsisMenu extends StatefulWidget {
  @override
  _EllipsisMenuState createState() => _EllipsisMenuState();
}

class _EllipsisMenuState extends State<EllipsisMenu> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height - 5,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print("Edit tapped");
                  _removeOverlay();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.green.shade900,
                    size: 15,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Delete tapped");
                  _removeOverlay();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.delete,
                    color: Colors.red,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry == null) {
          _showOverlay(context);
        } else {
          _removeOverlay();
        }
      },
      child: Icon(CupertinoIcons.ellipsis, color: kheader),
    );
  }
}

// class EllipsisMenu extends StatefulWidget {
//   @override
//   _EllipsisMenuState createState() => _EllipsisMenuState();
// }
//
// class _EllipsisMenuState extends State<EllipsisMenu> {
//   OverlayEntry? _overlayEntry;
//
//   void _showOverlay(BuildContext context) {
//     if (_overlayEntry == null) {
//       _overlayEntry = _createOverlayEntry(context);
//       Overlay.of(context).insert(_overlayEntry!);
//     }
//   }
//
//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }
//
//   OverlayEntry _createOverlayEntry(BuildContext context) {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;
//     var offset = renderBox.localToGlobal(Offset.zero);
//
//     var screenWidth = MediaQuery.of(context).size.width;
//     var overlayWidth = 150.0; // Width of the overlay
//
//     var leftPosition = offset.dx;
//     if (offset.dx + overlayWidth > screenWidth) {
//       leftPosition = screenWidth - overlayWidth - 16; // 16 is a margin from the right edge
//     }
//
//     return OverlayEntry(
//       builder: (context) => Positioned(
//         left: leftPosition,
//         top: offset.dy + size.height,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             width: overlayWidth,
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     print("Edit tapped");
//                     _removeOverlay();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     child: Row(
//                       children: [
//                         Icon(Icons.edit, color: Colors.blue),
//                         SizedBox(width: 8),
//                         Text('Edit'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     print("Delete tapped");
//                     _removeOverlay();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     child: Row(
//                       children: [
//                         Icon(Icons.delete, color: Colors.red),
//                         SizedBox(width: 8),
//                         Text('Delete'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (_overlayEntry == null) {
//           _showOverlay(context);
//         } else {
//           _removeOverlay();
//         }
//       },
//       child: Icon(CupertinoIcons.ellipsis, color: Colors.blue), // Replace kheader with your color
//     );
//   }
// }
