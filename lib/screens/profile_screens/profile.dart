import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/widget/common_textfield.dart';

import '../const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  File? _image;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    } else {
      print('No Image Selected');
    }
    // setState(() {
    //   _image = pickedFile as File;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundcolor,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      gradient: LinearGradient(
                        colors: [
                          backgroundcolor.withOpacity(1),
                          backgroundcolor.withOpacity(0.75),
                          backgroundcolor.withOpacity(0.5),
                          themecolor.withOpacity(0.5),
                          themecolor.withOpacity(0.75),
                          themecolor.withOpacity(1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [
                          0.0,
                          0.20,
                          0.40,
                          0.65,
                          0.70,
                          1.0
                        ], // Adjust stops based on your preference
                      ),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.keyboard_arrow_left_rounded,
                                size: 30,
                              ),
                            ),
                            Text(
                              "My Profile",
                              textScaleFactor: 1.5,
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints:
                            const BoxConstraints(maxWidth: 200, maxHeight: 200),
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Material(
                                    elevation: 10,
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            width: 4, color: themecolor)),
                                    clipBehavior: Clip.antiAlias,
                                    color: backgroundcolor,
                                    child: _image == null
                                        ? Ink.image(
                                            image: const AssetImage(
                                                "assets/images/user.png"),
                                            fit: BoxFit.contain,
                                            width: 220,
                                            height: 220,
                                            child: InkWell(
                                              radius: 0,
                                              onTap: () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (_) => Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 50,
                                                              right: 50),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/user.png"),
                                                              fit: BoxFit
                                                                  .contain),
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Ink.image(
                                            image: FileImage(
                                                File(_image!.path).absolute),
                                            fit: BoxFit.contain,
                                            width: 220,
                                            height: 220,
                                            child: InkWell(
                                              radius: 0,
                                              onTap: () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (_) => Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 50,
                                                              right: 50),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  File(_image!
                                                                          .path)
                                                                      .absolute),
                                                              fit: BoxFit
                                                                  .contain),
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: -40,
                              left: 70,
                              child: Tooltip(
                                message: 'Pick Image',
                                child: RawMaterialButton(
                                  onPressed: () {
                                    // print("Button Pressed");
                                    getImage();
                                  },
                                  elevation: 2,
                                  fillColor: Colors.white,
                                  padding: const EdgeInsets.all(7.5),
                                  shape: CircleBorder(
                                      side: BorderSide(color: themecolor)),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: themecolor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CommonTextField(
                        controller: nameController,
                        labelText: "Name :",
                        keyboardType: TextInputType.text,
                        hintText: "Enter Your Name",
                        inputAction: TextInputAction.next,
                        addValidation: (value) {
                          if (value!.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CommonTextField(
                        controller: emailController,
                        labelText: "Email :",
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Enter Your Email",
                        inputAction: TextInputAction.next,
                        addValidation: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CommonTextField(
                        controller: addressController,
                        labelText: "Shipping Address :",
                        keyboardType: TextInputType.text,
                        hintText: "Enter Shipping Address",
                        maxLine: 3,
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CommonTextField(
                        controller: phoneController,
                        labelText: "Parent Mobile No :",
                        keyboardType: TextInputType.number,
                        hintText: "Enter Parent Mobile Number",
                        labelTextOption: "(Optional)",
                        numberLength: 10,
                        inputAction: TextInputAction.next,
                        inputFormatter: [
                          FilteringTextInputFormatter.deny(RegExp(r'[\-, .]'))
                        ],
                        addValidation: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          } else if (value.length < 10) {
                            return 'Enter a valid mobile number (minimum 10 digits)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all((Colors.black45)),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "Update Profile",
                              textScaleFactor: 1.17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
