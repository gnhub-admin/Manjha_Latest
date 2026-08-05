import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/getxcontrollers/premium_seller_section/premium_seller_controller.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import 'package:path_provider/path_provider.dart';

class GalleriesScreen extends StatefulWidget {
  const GalleriesScreen({super.key});

  @override
  State<GalleriesScreen> createState() => _GalleriesScreenState();
}

class _GalleriesScreenState extends State<GalleriesScreen> {
  PremiumSellerController premiumSellerController =
      Get.put(PremiumSellerController());

  List<File> selectedImages = [];

  @override
  void initState() {
    super.initState();
    // loadDefaultImages();
    premiumSellerController.fetchGalleryList();
    // premiumSellerController.clearUploadController();
  }

  Future<void> loadDefaultImages() async {
    List<String> assetPaths = [
      'assets/adrar.jpg',
      'assets/alger.jpg',
      'assets/bedjaia.jpg',
      'assets/burger.jpeg',
      'assets/odia-language.jpeg',
      'assets/sheraton.jpg',
    ];

    for (String path in assetPaths) {
      final byteData = await rootBundle.load(path);
      final buffer = byteData.buffer;
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${path.split('/').last}');
      await tempFile.writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      selectedImages.add(tempFile);
    }

    setState(() {});
  }

  // Future<void> loadDefaultImages() async {
  //   List<String> assetPaths = [
  //     'assets/adrar.jpg',
  //     'assets/alger.jpg',
  //     'assets/bedjaia.jpg',
  //     'assets/burger.jpeg',
  //     'assets/odia-language.jpeg',
  //     'assets/sheraton.jpg',
  //   ];
  //
  //   for (String assetPath in assetPaths) {
  //     final file = await DefaultCacheManager().getSingleFile(assetPath);
  //     selectedImages.add(file);
  //   }
  //
  //   setState(() {});
  // }

  checkFileCount() {
    if (selectedImages.length >= 10) {
      EasyLoading.showError("You can upload maximum 10 photos.");
      return false;
    }
    return true;
  }

  Future showPicker(context) async {
    if (!checkFileCount()) return false;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      // pickFile(ImageSource.gallery);
                      premiumSellerController.pickFile(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    // pickFile(ImageSource.camera);
                    premiumSellerController.pickFile(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  ImagePicker _picker = ImagePicker();

  Future pickFile(ImageSource source) async {
    // await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'],
    // ).then((files) {
    //   if (files != null) {
    //     setState(() {
    //       selectedImages.add(files as File);
    //     });
    //   }
    // });
    final pickedGallery =
        await _picker.pickImage(source: source, imageQuality: 100);

    setState(() {
      if (pickedGallery != null) {
        // parcelImage = File(pickedGallery.path);
        selectedImages.add(File(pickedGallery.path));
        setState(() {});
      } else if (pickedGallery == null) {
        print('No Image Selected');
      }
    });
  }

  // Widget buildImageList() {
  //   return ScrollConfiguration(
  //     behavior: ScrollBehavior().copyWith(overscroll: false),
  //     child: GridView.builder(
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 8,
  //         mainAxisSpacing: 8,
  //         mainAxisExtent: 230,
  //       ),
  //       itemCount: selectedImages.length,
  //       itemBuilder: (context, index) {
  //         return InkWell(
  //           onTap: () async {
  //             double screenHeight = MediaQuery.of(context).size.height;
  //             double targetHeight = screenHeight * 0.75;
  //             await showDialog(
  //               context: context,
  //               builder: (_) => Center(
  //                 child: Container(
  //                   height: targetHeight,
  //                   width: double.infinity,
  //                   margin: EdgeInsets.symmetric(horizontal: 25),
  //                   color: Colors.transparent,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: PhotoViewGallery.builder(
  //                       itemCount: selectedImages.length,
  //                       builder: (context, innerIndex) {
  //                         // Use innerIndex here
  //                         return PhotoViewGalleryPageOptions(
  //                           imageProvider: FileImage(selectedImages[innerIndex]), // Use innerIndex here
  //                           minScale: PhotoViewComputedScale.contained * 1,
  //                           maxScale: PhotoViewComputedScale.covered * 2,
  //                         );
  //                       },
  //                       scrollPhysics: BouncingScrollPhysics(),
  //                       backgroundDecoration: BoxDecoration(
  //                         color: Colors.transparent,
  //                       ),
  //                       pageController: PageController(initialPage: index), // Set initialPage to the tapped index
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           child: Container(
  //             margin: EdgeInsets.all(8),
  //             // width: 100,
  //             height: MediaQuery.of(context).size.height * 0.25,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(12),
  //               child: Stack(
  //                 children: [
  //                   Positioned.fill(
  //                     child: Image.file(
  //                       selectedImages[index],
  //                       // width: double.infinity,
  //                       // height: double.infinity,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.topRight,
  //                     child: Container(
  //                       width: 24,
  //                       height: 24,
  //                       decoration: BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         color: Colors.white.withOpacity(0.25),
  //                       ),
  //                       child: IconButton(
  //                         padding: EdgeInsets.zero,
  //                         icon: Icon(Icons.cancel_outlined, color: Colors.redAccent.shade700),
  //                         onPressed: () {
  //                           deleteImage(index);
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  // void deleteImage(int index) {
  //   setState(() {
  //     selectedImages.removeAt(index);
  //   });
  // }

  Widget buildImageList() {
    // return Obx(() {
    // if (premiumSellerController.galleryLoader.value) {
    //   return Center(child: CircularProgressIndicator());
    // }
    //
    //
    // });

    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(overscroll: false),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 230,
        ),
        itemCount: premiumSellerController.galleryDataList.length,
        itemBuilder: (context, index) {
          final galleryItem = premiumSellerController.galleryDataList[index];
          final imageUrl = galleryItem.mediaName != null
              ? '$local_image_gallery${galleryItem.mediaName}'
              : '';

          return InkWell(
            onTap: () async {
              double screenHeight = MediaQuery.of(context).size.height;
              double targetHeight = screenHeight * 0.75;
              await showDialog(
                context: context,
                builder: (_) => Center(
                  child: Container(
                    height: targetHeight,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: PhotoViewGallery.builder(
                        itemCount:
                            premiumSellerController.galleryDataList.length,
                        builder: (context, innerIndex) {
                          final innerImageUrl = premiumSellerController
                                      .galleryDataList[innerIndex].mediaName !=
                                  null
                              ? '$local_image_gallery${premiumSellerController.galleryDataList[innerIndex].mediaName}'
                              : '';

                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(innerImageUrl),
                            minScale: PhotoViewComputedScale.contained * 1,
                            maxScale: PhotoViewComputedScale.covered * 2,
                          );
                        },
                        scrollPhysics: BouncingScrollPhysics(),
                        backgroundDecoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        pageController: PageController(initialPage: index),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Container(color: Colors.grey),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.25),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.cancel_outlined,
                              color: Colors.redAccent.shade700),
                          onPressed: () async {
                            // deleteImage(premiumSellerController.galleryDataList[index].mediaName);
                            // premiumSellerController.deleteGalleryImage(galleryMediaId: galleryItem.id ?? 0);
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Logout'),
                                content: const Text(
                                    'Do you really want to Delete this Image? It remove from Gallery Lists.'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(kheader),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      'No',
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(kheader),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      premiumSellerController
                                          .deleteGalleryImage(
                                              galleryMediaId: galleryItem.id);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // void deleteImage(int index) {
  //   setState(() {
  //     premiumSellerController.galleryDataList.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: themecolor,
          title: const Text("Galleries"),
          centerTitle: false),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // color: kwhite,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kwhite,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Media to Upload",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showPicker(context);
                    },
                    child: Container(
                      width: double.infinity,
                      // height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff7e7e7e), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Color(0xff7e7e7e),
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Select Photo",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                    color: Color(0xff7e7e7e),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ),
                  ),
                  // SizedBox(height: 10,),
                  // Container(
                  //     height: 60,
                  //     alignment: Alignment.center,
                  //     child: ButtonTheme(
                  //         height: 45.0,
                  //         child: MaterialButton(
                  //           padding: EdgeInsets.symmetric(horizontal: 20),
                  //           color: kheader,
                  //           shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  //           child: BoldText("Upload", 18, kwhite),
                  //           onPressed: () {
                  //
                  //           },
                  //         ))),
                ],
              ),
            ),
          ),
          // selectedImages.isNotEmpty ?
          // Expanded(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //       width: double.infinity,
          //       // height: 150,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: buildImageList()),
          // )
          //     : SizedBox.shrink(),
          /**/
          // Obx(() => premiumSellerController.galleryDataList.isNotEmpty
          //     ? Expanded(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     width: double.infinity,
          //     child: buildImageList(),
          //   ),
          // )
          //     : SizedBox.shrink()),
          // Divider(color: Colors.grey,thickness: 2.5,),
          Container(
              height: 60,
              alignment: Alignment.center,
              child: ButtonTheme(
                  height: 45.0,
                  child: MaterialButton(
                    elevation: 0,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: kheader,
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: BoldText("Uploaded Galleries", 18, kwhite),
                    onPressed: () {},
                  ))),
          // Container(
          //   height: 50,
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   decoration: BoxDecoration(
          //       border: Border.all(color: kheader)
          //   ),
          //   child: CupertinoButton(
          //     padding: EdgeInsets.zero,
          //     onPressed: () {
          //
          //     },
          //     child: Text("Uploaded Galleries",style: TextStyle(color: kheader,fontWeight: FontWeight.w600),),
          //   ),
          // ),
          Obx(() => premiumSellerController.galleryDataList.isNotEmpty
              ? Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: buildImageList(),
                  ),
                )
              : SizedBox.shrink()),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

// SizedBox(
//     child: Align(
//         alignment: Alignment.centerRight,
//         child: ElevatedButton.icon(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateColor.resolveWith((states) => kitembg),
//                 shape: MaterialStateProperty.resolveWith((states) =>
//                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)))),
//             onPressed: () {
//               showPicker(context);
//             },
//             icon: const Icon(
//               FontAwesomeIcons.camera,
//               color: kheader,
//             ),
//             label: const FittedBox(
//                 child: Text(
//                   "Select Photos",
//                   style: TextStyle(height: 1, color: kheader),
//                 ))))),
