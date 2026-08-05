import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/screens/helper.dart';
import 'package:manjha/model/fishmasterresponse.dart';
import 'package:manjha/screens/localconst.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textfieldscreen.dart';
import 'package:manjha/widget/textstyle.dart';
import '../../getxcontrollers/salefishcontroller.dart';
import '../../widget/button.dart';
import '../../widget/common.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SellFishScreen extends StatefulWidget {
  final SaleItem? saleitem;
  const SellFishScreen({super.key, this.saleitem});

  @override
  State<SellFishScreen> createState() => _SellFishScreenState();
}

class _SellFishScreenState extends State<SellFishScreen> {
  SaleFishController saleFishController = Get.put(SaleFishController());

  @override
  void initState() {
    saleFishController.clearcontroller();

    saleFishController.getfishmaster();
    saleFishController.sellerNameController.text =
        saveUser()?.data?.fullName ?? "";
    saleFishController.sellerphonenumber.text =
        saveUser()?.data?.mobileno ?? "";
    saleFishController.selleradress.text = saveUser()?.data?.address ?? "";

    saleFishController.citynamecontroller.text = "";
    saleFishController.addressoffishfarming.text = "";

    if (widget.saleitem != null) {
      saleFishController.sellerNameController.text =
          widget.saleitem?.seller_name ?? "";
      saleFishController.sellerphonenumber.text =
          widget.saleitem?.contactno ?? "";
      saleFishController.selleradress.text = widget.saleitem?.address ?? "";
      saleFishController.citynamecontroller.text =
          widget.saleitem?.cityname ?? "";
      saleFishController.addressoffishfarming.text =
          widget.saleitem?.farm_address ?? "";
      saleFishController.fishTypeController.text =
          widget.saleitem?.fish_type_name ?? "";
      saleFishController.weightPerPcsController.text =
          widget.saleitem?.weight_per_pcs.toString() ?? "";
      saleFishController.fishpricecontroller.text =
          widget.saleitem?.price ?? "";
      // saleFishController.selectedFishType = Fishtype(
      //     id: widget.saleitem?.fish_type_id,
      //     fishTypeName: widget.saleitem?.fish_type_name);
      // String index = "";
      // saleFishController.listfishsizes.map((element) {
      //   element.fishSizeTypeName == widget.saleitem?.fish_size_type;
      //   index = element.id ?? '';
      // });
      // selectedFishSize = Fishsize(
      //     id: index, fishSizeTypeName: widget.saleitem?.fish_size_type);
    }
    // TODO: implement initState
    super.initState();
  }

  void showOtherFishType(bool visibility) {
    setState(() {
      _isVisibleFishTypeOther = visibility;
    });
  }

  List<File> fileList = [];
  bool _isVisibleFishTypeOther = false;
  bool _isVisibleWeight = true;
  int isSelected = 1;

  FishCategoryItem? selectedFishCategory;
  bool isLoading = false;
  List<Map<String, dynamic>> places = [];
  // String fishtypename = "";
  // String fishsizename = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: themecolor,
          title: const Text("Sell your fish seeds"),
          centerTitle: true),
      body:
          // Obx(
          //   () =>
          // saleFishController.getfishbool.isFalse
          //     ? const Center(
          //         child: CircularProgressIndicator(color: kheader),
          //       )
          //     :
          ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              // Container(
              //     // width: 300.0,
              //     padding: EdgeInsets.symmetric(horizontal: 10),
              //     child: Container(
              //         decoration: BoxDecoration(
              //           color: kheader,
              //           // border: Border(
              //           //     bottom: BorderSide(color: kgreyDivider, width: 3),
              //           //     top: BorderSide(color: kgreyDivider, width: 3)),
              //           border: Border.all(color: kheader, width: 1),
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //         // elevation: 2,
              //         child: Theme(
              //           data: ThemeData(
              //             splashColor: Colors.transparent,
              //             highlightColor: Colors.transparent,
              //           ),
              //           child: ListTile(
              //             title: const Text(
              //               "My Listing",
              //               style: TextStyle(color: kwhite),
              //             ),
              //             // leading: Icon(FontAwesomeIcons.list,
              //             //     size: 18, color: kblack),
              //             // leading: SizedBox(),
              //             trailing: const Icon(FontAwesomeIcons.arrowRight,
              //                 size: 18, color: kwhite),
              //             onTap: () {
              //               Fluttertoast.showToast(
              //                   msg: "My Listing in progress.....");
              //             },
              //           ),
              //         ))),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   // width: 300.0,
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: kheader,
              //       // border: Border(
              //       //     bottom: BorderSide(color: kgreyDivider, width: 3),
              //       //     top: BorderSide(color: kgreyDivider, width: 3)),
              //       border: Border.all(color: kheader, width: 1),
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     // elevation: 2,
              //     child: Theme(
              //       data: ThemeData(
              //         splashColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //       ),
              //       child: ListTile(
              //         title: const Text(
              //           "Premium Seller",
              //           style: TextStyle(color: kwhite),
              //         ),
              //         // leading: Icon(FontAwesomeIcons.list,
              //         //     size: 18, color: kblack),
              //         // leading: SizedBox(),
              //         trailing: const Icon(FontAwesomeIcons.arrowRight,
              //             size: 18, color: kwhite),
              //         onTap: () {
              //
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText("Name", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalForm(
                      FontAwesomeIcons.user,
                      "",
                      controller: saleFishController.sellerNameController,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText("Mobile No.", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalForm(
                      // FontAwesomeIcons.mobileAlt,
                      FontAwesomeIcons.mobileScreenButton,
                      "",
                      controller: saleFishController.sellerphonenumber,
                      textInputType: TextInputType.phone,
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText("Address", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    NormalForm(
                      // FontAwesomeIcons.mapMarkerAlt,
                      FontAwesomeIcons.locationDot,
                      "",
                      controller: saleFishController.selleradress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText("City Name", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: screenwidth(context, dividedby: 1),
                      child: MaterialButton(
                        color: Colors.white,
                        textColor: Colors.black87,
                        splashColor: Colors.white,
                        onPressed: () {
                          _showBottomSheet(1);
                        },
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        // shape: Border(
                        //     bottom: BorderSide(
                        //         color: Colors.grey.shade300)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.grey.shade400)),

                        child: Row(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            saleFishController.citynamecontroller.text,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                fontFamily: "nunito",
                                color: kgreyDark),
                          ),
                          const Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Icon(Icons.location_on_outlined,
                              color: Colors.grey.shade700),
                          const SizedBox(
                            width: 10,
                          )
                        ]),
                      ),
                      // NormalForm(Icons.location_city, "City Name",
                      //     controller: citynameController)
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText("Address of fish farm*", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: screenwidth(context, dividedby: 1),
                      child: MaterialButton(
                        color: Colors.white,
                        textColor: Colors.black87,
                        splashColor: Colors.white,
                        onPressed: () {
                          _showBottomSheet(2);
                        },
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        // shape: Border(
                        //     bottom: BorderSide(
                        //         color: Colors.grey.shade300)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.grey.shade400)),

                        child: Row(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            saleFishController.addressoffishfarming.text,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                fontFamily: "nunito",
                                color: kgreyDark),
                          ),
                          const Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Icon(Icons.location_on_outlined,
                              color: Colors.grey.shade700),
                          const SizedBox(
                            width: 10,
                          )
                        ]),
                      ),
                      // NormalForm(Icons.location_city, "City Name",
                      //     controller: citynameController)
                    ),
                    SizedBox(
                      width: screenwidth(context, dividedby: 1),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                          )),
                          onPressed: () async {
                            List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    Common.position?.latitude ?? 0.0,
                                    Common.position?.longitude ?? 0.0);
                            Placemark placemark = placemarks.first;
                            saleFishController.citynamecontroller.text =
                                "${placemark.locality}";
                            saleFishController.addressoffishfarming.text =
                                "${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}";
                            setState(() {});
                          },
                          icon: const Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 14,
                            color: kheader,
                          ),
                          // color: kitembg,
                          label: const FittedBox(
                            child: Text(
                              "Get Current Location",
                              style: TextStyle(
                                  height: 1.5, fontSize: 13, color: kheader),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BoldText("Type of fish*", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Container(
                        height: 50,
                        // width: screenwidth(context, dividedby: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Center(
                          child: DropdownButton<Fishtype>(
                            value: saleFishController.selectedFishType,
                            // value: Fishtype(fishTypeName: widget.saleitem?.fish_type_name,id:widget.saleitem?.fish_type_id ),
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
                            onChanged: (Fishtype? newValue) {
                              setState(() {
                                // fishtypename = newValue!.fishTypeName ?? "";

                                saleFishController.selectedFishType = newValue;
                                saleFishController.fishTypeController.text =
                                    saleFishController
                                            .selectedFishType?.fishTypeName ??
                                        "";
                                showOtherFishType(saleFishController
                                    .selectedFishType!.fishTypeName!
                                    .toLowerCase()
                                    .contains("other"));
                                if (saleFishController
                                    .selectedFishType!.fishTypeName!
                                    .toLowerCase()
                                    .contains("other")) {
                                  saleFishController.fishTypeController.text =
                                      '';
                                }
                              });
                            },
                            items: saleFishController.listfishtype.value
                                .map<DropdownMenuItem<Fishtype>>(
                                    (Fishtype fishTypeItem) {
                              return DropdownMenuItem<Fishtype>(
                                value: fishTypeItem,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text(
                                    fishTypeItem.fishTypeName ?? '',
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
                    Visibility(
                      visible: _isVisibleFishTypeOther,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Container(
                              // width: screenwidth(context, dividedby: 1),
                              padding: const EdgeInsets.only(left: 0),
                              child: BoldText("Other Fish Type", 16, kheader)),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: screenwidth(context, dividedby: 1),
                              child: NormalForm.plain(
                                "Other Fish Type",
                                controller:
                                    saleFishController.fishTypeController,
                              )),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText("Size of fish*", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Container(
                        height: 50,
                        width: screenwidth(context, dividedby: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Center(
                          child: DropdownButton<Fishsize>(
                            value: saleFishController.selectedFishSize,
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
                            onChanged: (Fishsize? newValue) {
                              setState(() {
                                saleFishController.selectedFishSize = newValue!;
                                if (saleFishController
                                        .selectedFishSize!.fishSizeTypeName!
                                        .toLowerCase()
                                        .contains("spawn") ||
                                    saleFishController
                                        .selectedFishSize!.fishSizeTypeName!
                                        .toLowerCase()
                                        .contains("zero")) {
                                  _isVisibleWeight = false;
                                  saleFishController
                                      .weightPerPcsController.text = "0";
                                  isSelected = 1;
                                } else {
                                  _isVisibleWeight = true;
                                  if (saleFishController
                                          .weightPerPcsController.text ==
                                      "0")
                                    saleFishController
                                        .weightPerPcsController.text = "";
                                }
                              });
                            },
                            items: saleFishController.listfishsizes
                                .map<DropdownMenuItem<Fishsize>>(
                                    (Fishsize fishTypeItem) {
                              return DropdownMenuItem<Fishsize>(
                                value: fishTypeItem,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text(
                                    fishTypeItem.fishSizeTypeName ?? '',
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
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: _isVisibleWeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldText("Weight Per Pcs*", 16, kheader),
                          const SizedBox(
                            height: 5,
                          ),
                          NormalForm(
                            FontAwesomeIcons.fish,
                            "",
                            controller:
                                saleFishController.weightPerPcsController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText("Price*", 16, kheader),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: NormalForm(
                          Icons.currency_rupee,
                          "",
                          controller: saleFishController.fishpricecontroller,
                          textInputType: TextInputType.number,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                            visible: _isVisibleWeight,
                            child: ToggleButtons(
                              borderColor: Colors.grey.shade400,
                              selectedColor: kwhite,
                              focusColor: kwhite,
                              fillColor: kheader,
                              selectedBorderColor: Colors.grey.shade400,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              isSelected: [isSelected == 1, isSelected == 0],
                              onPressed: (int index) {
                                setState(() {
                                  isSelected = index == 0 ? 1 : 0;
                                });
                              },
                              children: const [
                                Text("Pcs"),
                                Text("Kg"),
                              ],
                            )),
                      ],
                    ),
                    Visibility(
                        visible: !_isVisibleWeight,
                        child:
                            NormalText("(Price / lakh pcs)", Colors.black, 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    _myListView(context),
                    SizedBox(
                        width: screenwidth(context, dividedby: 1),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => kitembg),
                                    shape: MaterialStateProperty.resolveWith(
                                        (states) => RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)))),
                                onPressed: () {
                                  showPicker(context);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.camera,
                                  color: kheader,
                                ),
                                label: const FittedBox(
                                    child: Text(
                                  "Select Photos",
                                  style: TextStyle(height: 1, color: kheader),
                                ))))),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: screenwidth(context, dividedby: 1),
                        child: WideButton.bold(("Submit"), () {
                          widget.saleitem != null ? saleFishController.updatebecomeseller(isSelected, fileList,widget.saleitem?.id.toString()):
                          saleFishController.getbecomeseller(
                              isSelected, fileList);
                        }, true)),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }

  checkFileCount() {
    if (fileList.length >= 3) {
      EasyLoading.showError("You can upload maximum 3 photos.");
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
                      pickFile();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  ImagePicker _picker = ImagePicker();
  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 50);

    setState(() {
      // List<Widget> thumbs = new List<Widget>();
      // fileListThumb.forEach((element) {
      //   thumbs.add(element);
      // });

      // var element = image;
      // thumbs.add(Padding(
      //     padding: EdgeInsets.all(1),
      //     child: Stack(
      //       children: <Widget>[
      //         Container(
      //             decoration: new BoxDecoration(color: Colors.white),
      //             alignment: Alignment.center,
      //             height: 240,
      //             child: new Image.file(File(element.path))),
      //         Align(
      //           alignment: Alignment.bottomRight,
      //           child: IconButton(
      //               icon: Icon(
      //                 // FontAwesomeIcons.heart,
      //                 Icons.highlight_off,
      //                 color: korange,
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   Fluttertoast.showToast(msg: "delete");
      //                   // files.remove(element);
      //                   thumbs.remove(element);
      //                 });
      //               }),
      //         )
      //       ],
      //     )));
      if (image?.path != null) fileList.add(File(image!.path));
      // fileListThumb = thumbs;
    });
  }

  Future pickFile() async {
    // List<Widget> thumbs = new List<Widget>();
    // fileListThumb.forEach((element) {
    //   thumbs.add(element);
    // });

    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'], //, 'pdf', 'doc', 'docx'
    ).then((files) {
      if (files != null) {
        setState(() {
          fileList.add(File(files.files.first.path ?? ""));
        });
      }
    });
  }

  Widget _myListView(BuildContext context) {
    return fileList.length == 0
        ? Center(
            child: null) //Center(child: Text(Lang.get("No Photo Selected")))
        : Container(
            width: screenwidth(context, dividedby: 1),
            height: 100.0,
            color: kitembg,
            child: Padding(
                padding: EdgeInsets.all(5),
                child:
                    // GridView.count(
                    //   crossAxisCount: 4,
                    //   children: fileListThumb,
                    // ),

                    ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fileList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Stack(
                          children: <Widget>[
                            Container(
                                // decoration: new BoxDecoration(color: Colors.white),
                                alignment: Alignment.center,
                                height: 100,
                                width: 100,
                                child: new Image.file(
                                  File(fileList[index].path),
                                  fit: BoxFit.cover,
                                  width: 85,
                                  height: 85,
                                )),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  icon: Icon(
                                    // FontAwesomeIcons.heart,
                                    Icons.highlight_off,
                                    color: korange,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      fileList.removeAt(index);
                                      Fluttertoast.showToast(
                                          msg: "Photo removed");
                                      // files.remove(element);
                                      //thumbs.remove(element);
                                    });
                                  }),
                            )
                          ],
                        ));
                  },
                )));
  }

  void _showBottomSheet(int type) {
    places.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 25,
                ),
                NormalForm(
                  onChanged: (value) async {
                    await fetchPlaces(value, setModalState);
                  },

                  // FontAwesomeIcons.mapMarkerAlt,
                  FontAwesomeIcons.locationDot,
                  "",
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Search Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final locationapi = places[index];
                        return ListTile(
                          onTap: () async {
                            if (type == 1) {
                              saleFishController.citynamecontroller.text =
                                  locationapi['city_name'].toString();
                            } else {
                              saleFishController.addressoffishfarming.text =
                                  locationapi['place_name'].toString();
                            }
                            Get.back();
                          },
                          title: Text(locationapi['place_name']),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<List<Map<String, dynamic>>> getPlacesData(String searchText) async {
    final String accessToken =
        'pk.eyJ1IjoiZGl2eWFtZ2wyNyIsImEiOiJja2pzNmxsNjYyZms1MzBtancyaHh6OHYzIn0.jAm9YQFTmfCus68C1HtvHw';
    final String url =
        'https://api.mapbox.com/search/geocode/v6/forward?access_token=$accessToken&q=$searchText&country=IN';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);
        if (data['features'] != null && data['features'].isNotEmpty) {
          // Extract the list of places
          List<Map<String, dynamic>> places = [];
          for (var feature in data['features']) {
            final placeName = feature['properties']["full_address"];
            final cityname = feature['properties']["name"];
            final statename =
                feature['properties']['context']['region']['name'];
            final coordinates = feature['properties']['coordinates'];
            final double longitude = coordinates["longitude"];
            final double latitude = coordinates["latitude"];

            places.add({
              'place_name': placeName,
              'city_name': cityname,
              'state_name': statename,
              'latitude': latitude,
              'longitude': longitude,
            });
          }
          return places;
        }
      } else {
        print('Failed to load places');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }

  Future<void> fetchPlaces(String searchText, setState) async {
    setState(() {
      isLoading = true;
    });

    final List<Map<String, dynamic>> data = await getPlacesData(searchText);

    setState(() {
      places = data;
      isLoading = false;
    });
  }
}
