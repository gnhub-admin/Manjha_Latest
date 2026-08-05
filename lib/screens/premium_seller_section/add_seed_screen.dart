import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/model/premium_seller_models/premium_seed_response_model.dart';
import 'package:manjha/screens/helper.dart';
import '../../getxcontrollers/premium_seller_section/premium_seller_controller.dart';
import '../../widget/button.dart';
import '../../widget/textfieldscreen.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../localconst.dart';

class AddSeedScreen extends StatefulWidget {
  final PremiumSeedData? premiumSeedId;
  const AddSeedScreen({super.key, this.premiumSeedId});

  @override
  State<AddSeedScreen> createState() => _AddSeedScreenState();
}

class _AddSeedScreenState extends State<AddSeedScreen> {
  PremiumSellerController premiumSellerController =
      Get.put(PremiumSellerController());

  Future showPicker(context) async {
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
                      pickFile(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    // pickFile(ImageSource.camera);
                    pickFile(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  ImagePicker _picker = ImagePicker();

  String? selectedImages;

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
        selectedImages = pickedGallery.path;
        setState(() {});
      } else if (pickedGallery == null) {
        print('No Image Selected');
      }
    });
  }

  @override
  void initState() {
    if (widget.premiumSeedId != null) {
      premiumSellerController.seedname.text =
          widget.premiumSeedId?.seedName ?? "";
      premiumSellerController.seedweight.text =
          widget.premiumSeedId?.seedWeight.toString() ?? "";
      premiumSellerController.seedsize.text =
          widget.premiumSeedId?.seedSize ?? "";
      premiumSellerController.seedprice.text =
          widget.premiumSeedId?.seedPrice.toString() ?? "";
      premiumSellerController.seedbonus.text =
          widget.premiumSeedId?.seedBonus.toString() ?? "";
      premiumSellerController.description.text =
          widget.premiumSeedId?.description ?? "";
      premiumSellerController.sortorder.text =
          widget.premiumSeedId?.sortOrder.toString() ?? "";
      premiumSellerController.isrtpcrtrsted.value =
          widget.premiumSeedId?.isRtpcrTested ?? false;
      premiumSellerController.isactive.value =
          widget.premiumSeedId?.isActive ?? false;
    } else {
      premiumSellerController.clearfunction();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: themecolor,
          title: Text(widget.premiumSeedId != null ? "Edit Seed" : "Add Seed"),
          centerTitle: false),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                BoldText("Name :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  // width: screenwidth(context, dividedby: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Center(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          value: premiumSellerController.seedname.text.isEmpty
                              ? null
                              : premiumSellerController.seedname.text,
                          isExpanded: true,
                          underline: const SizedBox(),
                          // isDense: false,
                          // icon: Icon(Icons.arrow_downward),
                          // iconSize: 24,
                          // elevation: 16,
                          // style: TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   width: double.infinity,
                          //   color: Colors.deepPurpleAccent,
                          // ),
                          hint: Text(
                            "Select",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              premiumSellerController.seedname.text =
                                  newValue ?? "";
                            });
                          },
                          items: <String>[
                            "Pangas(पंगास )",
                            "Rohu (रोहू)",
                            "Jayanti Rohu (जयंती रोहू)",
                            "Catla (कतला)",
                            "Hybrid catla (Dogula) (डोगुला)"
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: "nunito",
                                      fontWeight: FontWeight.w500,
                                      color: kgreyDark,
                                      fontSize: 15.5),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Size :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  // width: screenwidth(context, dividedby: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade400)),
                  child: Center(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          value: premiumSellerController.seedsize.text.isEmpty
                              ? null
                              : premiumSellerController.seedsize.text,
                          isExpanded: true,
                          underline: const SizedBox(),
                          // isDense: false,
                          // icon: Icon(Icons.arrow_downward),
                          // iconSize: 24,
                          // elevation: 16,
                          // style: TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   width: double.infinity,
                          //   color: Colors.deepPurpleAccent,
                          // ),
                          hint: Text(
                            "Select",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              premiumSellerController.seedsize.text =
                                  newValue ?? "";
                            });
                          },
                          items: <String>[
                            "1 Inches",
                            "2 Inches",
                            "3 Inches",
                            "4 Inches",
                            "5 Inches",
                            "5+ Inches"
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: "nunito",
                                      fontWeight: FontWeight.w500,
                                      color: kgreyDark,
                                      fontSize: 15.5),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Line :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                NormalForm(
                  // FontAwesomeIcons.mapMarkerAlt,
                  null,
                  "Weight",
                  customHintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                  controller: premiumSellerController.seedweight,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Price :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                NormalForm(
                  // FontAwesomeIcons.mapMarkerAlt,
                  null,
                  "Price",
                  customHintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                  textInputType: TextInputType.number,
                  controller: premiumSellerController.seedprice,
                ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Seed Photo :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    showPicker(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Color(0xff7e7e7e),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: screenwidth(context, dividedby: 1.5),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            selectedImages != null
                                ? selectedImages ?? ""
                                : "Select Photo",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Seed Video (Optional) :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.video_collection_outlined,
                        size: 25,
                        color: Color(0xff7e7e7e),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select Video",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // BoldText("Active :", 16, kheader),
                // const SizedBox(
                //   height: 5,
                // ),
                // NormalForm(
                //   // FontAwesomeIcons.mapMarkerAlt,
                //   null,
                //   "Active",
                //   customHintStyle: TextStyle(
                //       color: Colors.grey, fontWeight: FontWeight.w600),
                //   controller: seedActiveController,
                // ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Bonus :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                NormalForm(
                  // FontAwesomeIcons.mapMarkerAlt,
                  null,
                  "Bonus",
                  customHintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                  textInputType: TextInputType.number,
                  controller: premiumSellerController.seedbonus,
                ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Sort Order :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                NormalForm(
                  // FontAwesomeIcons.mapMarkerAlt,
                  null,
                  "Sort Order",
                  customHintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                  textInputType: TextInputType.number,
                  controller: premiumSellerController.sortorder,
                ),
                SizedBox(
                  height: 20,
                ),
                BoldText("Description :", 16, kheader),
                const SizedBox(
                  height: 5,
                ),
                NormalForm(
                  // FontAwesomeIcons.mapMarkerAlt,
                  null,
                  "description",
                  customHintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                  textInputType: TextInputType.number,
                  controller: premiumSellerController.description,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoldText("Is RTPCR Tested :", 16, kheader),
                    Obx(() => Switch(
                          value: premiumSellerController.isrtpcrtrsted.value,
                          onChanged: (value) {
                            premiumSellerController.isrtpcrtrsted.value =
                                !premiumSellerController.isrtpcrtrsted.value;
                          },
                        ))
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoldText("Is Active :", 16, kheader),
                    Obx(() => Switch(
                          value: premiumSellerController.isactive.value,
                          onChanged: (value) {
                            premiumSellerController.isactive.value =
                                !premiumSellerController.isactive.value;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 60,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    child: WideButton.bold(Lang.get("Submit"), () async {
                      widget.premiumSeedId != null
                          ? premiumSellerController.EditPremiumSeedapifunction(
                              hetcheryseedid:
                                  widget.premiumSeedId?.id.toString() ?? "",
                              image: selectedImages)
                          : premiumSellerController
                              .createPremiumSeedapifunction(
                                  image: selectedImages);
                    }, true)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
