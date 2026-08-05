import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/screens/helper.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../getxcontrollers/cartcontroller.dart';
import '../../getxcontrollers/mixpanelcontroller.dart';
import '../../widget/textfieldscreen.dart';
import '../cartscreens/StoreCheckoutPage.dart';
import '../localconst.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic product;
  // final Productdetails product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String ras = "";

  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    if (widget.product.quantity != 0) _quantityController.text = widget.product.quantity.toString();
    ras = languagecode() != "en" ? "৳" : "Rs.";
    super.initState();
  }

  TextEditingController _quantityController = new TextEditingController();
  showQuanityBox(BuildContext context, bool addNew) async {
    // Session.shippingPopupSeenNow();
    // if (await Session.isShippingPopupSeen() && !bypass) {
    //   return false;
    // }

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          insetPadding: EdgeInsets.all(25),
          // backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          // title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            title: new BoldText(Lang.get("Enter Quantity"), 20, kblack),
            trailing: IconButton(
              visualDensity: VisualDensity.compact,
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: NormalForm(
                  FontAwesomeIcons.cartPlus,
                  Lang.get("Quantity"),
                  controller: _quantityController,
                  textInputType: TextInputType.number,
                ),
              )
            ],
          ),
          actions: <Widget>[
            if (!addNew)
              TextButton.icon(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => kbuttoncolorred)),
                  icon: Icon(Icons.delete_outline, color: kdeletecolor),
                  label: BoldText(translate('Remove'), 14, kdeletecolor),
                  onPressed: () {
                    _quantityController.text = "0";
                    Navigator.of(context).pop(true);
                  }),
            // SizedBox(width: 50),
            // FlatButton(
            //     child: BoldText('Cancel', 14, kColorButtonCart),
            //     onPressed: () {
            //       Navigator.of(context).pop(false);
            //     }),
            TextButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => themecolor.withOpacity(0.5))),
              icon: Icon(Icons.add_shopping_cart, color: kColorButtonCart),
              label: BoldText((Lang.get(addNew ? "Add" : "Update")), 14, kColorButtonCart),
              onPressed: () {
                if (_quantityController.text.isEmpty) {
                  EasyLoading.showToast("Please enter quantity.");
                  return;
                }
                if (int.tryParse(_quantityController.text) != null &&
                    int.tryParse(_quantityController.text)! <= 0 &&
                    int.tryParse(_quantityController.text)! > 10000) {
                  EasyLoading.showToast("Please enter proper quantity.");
                  return;
                }
                // Close the dialog
                Navigator.of(context).pop(true);
                // Session.shippingPopupSeenNow();
              },
            ),
          ],
        );
      },
    );
  }

  void onConfirm() {
    // Pass the updated quantity or any other data back
    Navigator.pop(context,  widget.product.quantity);
  }

  Future<bool> _onWillPop() async {
    // Call onConfirm when navigating back
    onConfirm();
    // Return true to allow the pop action
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            backgroundColor: kWhatsApp,
            foregroundColor: Colors.white,
            onPressed: () {
              // Respond to button press
              // ignore: deprecated_member_use
              launch(("https://wa.me/917071270718" + "?text="));
            },
            child: Icon(FontAwesomeIcons.whatsapp)),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kblack,
          ),
          backgroundColor: kwhite,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: kblack),
            onPressed: () {
              onConfirm();
              // Get.back(); // Navigate back using GetX
            },
          ),
          title: NormalText("Product Detail", kblack, 25),
          elevation: 0,
          // leading: Container(),
          actions: <Widget>[
            Obx(
              () => cartController.cartcount > 0
                  ? Common.getCartButton(context, countpage: 2, refreshCallback: () {
                      setState(() {
                        print(Common.cartCount);
                        setState(() {});
                      });
                    },color: themecolor)
                  : Common.getCartButton2(context, countpage: 2, refreshCallback: () {
                      setState(() {
                        print(Common.cartCount);
                        setState(() {});
                      });
                    },color: themecolor),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.share,color: themecolor,)),
          ],
        ),
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenwidth(context, dividedby: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.vertical(
                    //   bottom: Radius.elliptical(MediaQuery.of(context).size.width, 140.0),
                    // ),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 16,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       InkWell(
                    //         onTap: () => Navigator.pop(context),
                    //         child: Image.asset(
                    //           "assets/images/back_icon.png",
                    //           width: 44,
                    //           height: 44,
                    //         ),
                    //       ),
                    //
                    //       // Image.asset(
                    //       //   "assets/images/search_icon.png",
                    //       //   width: 44,
                    //       //   height: 44,
                    //       // )
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 0,
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.center,
                      widthFactor: 0.6,
                      child: Container(child: imageCall(widget.product.imageUrl)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.productNameLang ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Text(
                        "${translate("Code")}: ${widget.product.productCode == null ? "${translate("Not Available")}" : widget.product.productCode}"),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    const SizedBox(
                      height: 0,
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.product.getStockStatus() == 'Out of Stock'
                          ? Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Visit after sometime because currently product is Out of Stock",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(color: kheader, fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          :
                          // Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               TextCustom(
                          //                 "${ras} ${widget.product.specialPrice == null ? "${translate("Not Available")}" : widget.product.specialPrice}",
                          //                 kColorPrice,
                          //                 25,
                          //                 fonntweight: FontWeight.w600,
                          //               ),
                          //               const SizedBox(
                          //                 height: 5,
                          //               ),
                          //               Row(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     padding: const EdgeInsets.all(5),
                          //                     decoration:
                          //                         BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                          //                     child: Text(
                          //                         "${numbertranslate(widget.product.discount ?? 0)}% ${translate("off")}",
                          //                         style: TextStyle(fontSize: 14, color: kwhite, fontWeight: FontWeight.w500)),
                          //                   ),
                          //                   const SizedBox(
                          //                     width: 10,
                          //                   ),
                          //                   TextCustom(
                          //                     "${ras} ${widget.product.price == null ? "${translate("Not Available")}" : widget.product.price}",
                          //                     kgreyDark,
                          //                     16,
                          //                     cancel: widget.product.price == null ? false : true,
                          //                   )
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //           Center(
                          //             child: widget.product.quantity != 0
                          //                 ? Container(
                          //                     padding: EdgeInsets.all(10),
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.transparent,
                          //                       border: Border.all(color: Colors.grey),
                          //                       borderRadius: BorderRadius.circular(10),
                          //                     ),
                          //                     child: Row(
                          //                       mainAxisSize: MainAxisSize.min,
                          //                       mainAxisAlignment: MainAxisAlignment.center,
                          //                       children: [
                          //                         GestureDetector(
                          //                           onTap: () async {
                          //                             if (widget.product.isFeed) {
                          //                               bool result = await showQuanityBox(context, false);
                          //                               if (result == '' ||
                          //                                   result == false ||
                          //                                   _quantityController.text.isEmpty) {
                          //                                 _quantityController.text = '';
                          //                                 print('Quantity dialog cancelled...');
                          //
                          //                                 return;
                          //                               } else {
                          //                                 setState(() {
                          //                                   widget.product.quantity = int.parse(_quantityController.text);
                          //                                   _quantityController.text = '';
                          //                                 });
                          //                               }
                          //                             } else {
                          //                               setState(() {
                          //                                 if (widget.product.quantity > 0) widget.product.quantity--;
                          //                               });
                          //                             }
                          //                             cartController.fetchCartupdate(
                          //                                 widget.product.id, widget.product.quantity);
                          //                           },
                          //                           child: Image.asset(
                          //                             "assets/images/remove_icon.png",
                          //                             width: 25,
                          //                             height: 25,
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 20,
                          //                         ),
                          //                         Text(
                          //                           "${widget.product.quantity}",
                          //                           style: const TextStyle(
                          //                               fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 20,
                          //                         ),
                          //                         GestureDetector(
                          //                           onTap: () async {
                          //                             if (widget.product.isFeed) {
                          //                               bool result = await showQuanityBox(context, false);
                          //                               if (result == false ||
                          //                                   _quantityController.text.isEmpty) {
                          //                                 _quantityController.text = '';
                          //                                 print('Quantity dialog cancelled...');
                          //
                          //                                 return;
                          //                               } else {
                          //                                 setState(() {
                          //                                   widget.product.quantity = int.parse(_quantityController.text);
                          //                                   _quantityController.text = '';
                          //                                 });
                          //                               }
                          //                             } else {
                          //                               setState(() {
                          //                                 widget.product.quantity++;
                          //                               });
                          //                             }
                          //                             cartController.fetchCartupdate(
                          //                                 widget.product.id, widget.product.quantity);
                          //                           },
                          //                           child: Image.asset(
                          //                             "assets/images/add_icon.png",
                          //                             width: 25,
                          //                             height: 25,
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   )
                          //                 : InkWell(
                          //                     onTap: () async {
                          //                       if (widget.product.isFeed) {
                          //                         bool result = await showQuanityBox(context, true);
                          //                         if (result == false || _quantityController.text.isEmpty) {
                          //                           _quantityController.text = '';
                          //                           print('Quantity dialog cancelled...');
                          //
                          //                           return;
                          //                         } else {
                          //                           setState(() {
                          //                             widget.product.quantity = int.parse(_quantityController.text);
                          //                             _quantityController.text = '';
                          //                           });
                          //                         }
                          //                       } else {
                          //                         setState(() {
                          //                           widget.product.quantity++;
                          //                         });
                          //                       }
                          //                       cartController.fetchCartAddd(widget.product.id, widget.product.quantity);
                          //                     },
                          //                     borderRadius: BorderRadius.circular(10),
                          //                     child: Container(
                          //                       padding: EdgeInsets.all(10),
                          //                       decoration: BoxDecoration(
                          //                         color: Colors.transparent,
                          //                         border: Border.all(color: Colors.grey),
                          //                         borderRadius: BorderRadius.circular(10),
                          //                       ),
                          //                       child: Row(
                          //                         mainAxisSize: MainAxisSize.min,
                          //                         mainAxisAlignment: MainAxisAlignment.center,
                          //                         children: [
                          //                           Icon(
                          //                             CupertinoIcons.cart_fill_badge_plus,
                          //                             color: kheader,
                          //                             size: 25,
                          //                           ),
                          //                           SizedBox(
                          //                             width: 10,
                          //                           ),
                          //                           Text(
                          //                             "${translate("Add to Cart")}",
                          //                             style: TextStyle(color: kheader, fontSize: 15),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //           ),
                          //         ],
                          //       ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextCustom(
                                      "${ras} ${widget.product.specialPrice == null ? "${translate("Not Available")}" : widget.product.specialPrice}",
                                      Colors.black,
                                      25,
                                      fonntweight: FontWeight.w600,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(3), color: korange),
                                          child: Text(
                                              "${numbertranslate(widget.product.discount ?? 0)}% ${translate("off")}",
                                              style: TextStyle(fontSize: 14, color: kwhite, fontWeight: FontWeight.w500)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextCustom(
                                          "${ras} ${widget.product.price == null ? "${translate("Not Available")}" : widget.product.price}",
                                          kgreyDark,
                                          16,
                                          cancel: widget.product.price == null ? false : true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: widget.product.quantity != 0
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (widget.product.isFeed) {
                                                    bool result = await showQuanityBox(context, false);
                                                    if (result == '' ||
                                                        result == false ||
                                                        _quantityController.text.isEmpty) {
                                                      _quantityController.text = '';
                                                      print('Quantity dialog cancelled...');

                                                      return;
                                                    } else {
                                                      setState(() {
                                                        widget.product.quantity = int.parse(_quantityController.text);
                                                        _quantityController.text = '';
                                                      });
                                                    }
                                                  } else {
                                                    setState(() {
                                                      if (widget.product.quantity > 0) widget.product.quantity--;
                                                    });
                                                  }
                                                  MixpanelController.logScreen(MixpanelController.PageProductDetail,
                                                      properties: {
                                                        "Item Remove to Cart": "${widget.product.productNameLang}",
                                                        "Quantity": widget.product.quantity.toString()
                                                      });
                                                  cartController.fetchCartupdate(
                                                      widget.product.id, widget.product.quantity);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.grey, width: 1.5),
                                                  ),
                                                  child: Center(
                                                    child: Icon(CupertinoIcons.minus, color: Colors.black),
                                                  ),
                                                ),
                                                // Image.asset(
                                                //   "assets/images/remove_icon.png",
                                                //   width: 50,
                                                //   height: 50,
                                                // ),
                                              ),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              Text(
                                                "${widget.product.quantity}",
                                                style: const TextStyle(
                                                    fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (widget.product.isFeed) {
                                                    bool result = await showQuanityBox(context, false);
                                                    if (result == false || _quantityController.text.isEmpty) {
                                                      _quantityController.text = '';
                                                      print('Quantity dialog cancelled...');

                                                      return;
                                                    } else {
                                                      setState(() {
                                                        widget.product.quantity = int.parse(_quantityController.text);
                                                        _quantityController.text = '';
                                                      });
                                                    }
                                                  } else {
                                                    setState(() {
                                                      widget.product.quantity++;
                                                    });
                                                  }
                                                  MixpanelController.logScreen(MixpanelController.PageProductDetail,
                                                      properties: {
                                                        "Item Added to Cart": "${widget.product.productNameLang}",
                                                        "Quantity": widget.product.quantity.toString()
                                                      });
                                                  cartController.fetchCartupdate(
                                                      widget.product.id, widget.product.quantity);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.grey, width: 1.5),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      CupertinoIcons.plus,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                // Image.asset(
                                                //   "assets/images/add_icon.png",
                                                //   width: 50,
                                                //   height: 50,
                                                // ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                if (widget.product.isFeed) {
                                                  bool result = await showQuanityBox(context, true);
                                                  if (result == false || _quantityController.text.isEmpty) {
                                                    _quantityController.text = '';
                                                    print('Quantity dialog cancelled...');

                                                    return;
                                                  } else {
                                                    setState(() {
                                                      widget.product.quantity = int.parse(_quantityController.text);
                                                      _quantityController.text = '';
                                                    });
                                                  }
                                                } else {
                                                  setState(() {
                                                    widget.product.quantity++;
                                                  });
                                                }
                                                MixpanelController.logScreen(MixpanelController.PageProductDetail,
                                                    properties: {
                                                      "Item Added to Cart": "${widget.product.productNameLang}",
                                                      "Quantity": widget.product.quantity.toString()
                                                    });
                                                cartController.fetchCartAddd(widget.product.id, widget.product.quantity);
                                              },
                                              borderRadius: BorderRadius.circular(10),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.cart_fill_badge_plus,
                                                      color: kheader,
                                                      size: 25,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "${translate("Add to Cart")}",
                                                      style: TextStyle(color: kheader, fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                if (widget.product.isFeed) {
                                                  bool result = await showQuanityBox(context, true);
                                                  if (result == false || _quantityController.text.isEmpty) {
                                                    _quantityController.text = '';
                                                    print('Quantity dialog cancelled...');

                                                    return;
                                                  } else {
                                                    setState(() {
                                                      widget.product.quantity = int.parse(_quantityController.text);
                                                      _quantityController.text = '';
                                                    });
                                                  }
                                                } else {
                                                  setState(() {
                                                    widget.product.quantity++;
                                                  });
                                                }
                                                MixpanelController.logScreen(MixpanelController.PageProductDetail,
                                                    properties: {
                                                      "Item Added to Cart": "${widget.product.productNameLang}",
                                                      "Quantity": widget.product.quantity.toString()
                                                    });
                                                cartController
                                                    .fetchCartAddd(widget.product.id, widget.product.quantity)
                                                    .then((value) {
                                                  Get.to(() => StoreCheckoutPage(

                                                  ));
                                                });
                                              },
                                              borderRadius: BorderRadius.circular(10),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.cart_fill_badge_plus,
                                                      color: kheader,
                                                      size: 25,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "${translate("Buy Now")}",
                                                      style: TextStyle(color: kheader, fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                widget.product.quantity > 0
                                    ? Obx(() => cartController.cartcount > 0
                                        ? Center(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(horizontal: 75),
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: themecolor,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () async {
                                                  MixpanelController.logScreen(
                                                    MixpanelController.PageCart,
                                                  );
                                                  // dynamic result =
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => StoreCheckoutPage()),
                                                  );
                                                  // print('helloworld...');
                                                  setState(() {
                                                    print(Common.cartCount);
                                                    setState(() {});
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        Image.asset(
                                                          "assets/cart-white.png",
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                        Visibility(
                                                          visible: (Common.cartCount > 0),
                                                          child: Positioned(
                                                            bottom: 22,
                                                            left: 32,
                                                            child: Align(
                                                              alignment: Alignment.topRight,
                                                              child: Container(
                                                                padding: EdgeInsets.zero,
                                                                alignment: Alignment.center,
                                                                height: 18,
                                                                width: 18,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(100),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                        // Common.cartCount.toString(),
                                                                        widget.product.quantity.toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 12,
                                                                            color: kColorPrice,
                                                                            fontWeight: FontWeight.w600))),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      "Go to Cart",
                                                      style: TextStyle(
                                                          color: kwhite,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "nunito"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink())
                                    : SizedBox.shrink(),
                              ],
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              listwidget(
                                  text1: "Brand",
                                  text2:
                                      "${widget.product.brandName == null ? "Not Available" : widget.product.brandName}"),
                              if (widget.product.isFeed == true || widget.product.isMedicine == true)
                                listwidget(text1: "Size", text2: "${widget.product.getItmSize()}"),
                              if (widget.product.isFeed == true)
                                listwidget(text1: "Bag Size", text2: "${widget.product.bagSize} KG"),
                              if (widget.product.isFeed == true)
                                listwidget(text1: "Nature of Feed", text2: "${widget.product.feedNature} "),
                              if (widget.product.isFeed == true && !widget.product.getIsPrawnFeed())
                                listwidget(text1: "Protein/Fat", text2: "${widget.product.proteinPerFat} "),
                              if (widget.product.isFeed == true)
                                listwidget(
                                    text1: "Price/kg", text2: "${translate("Rs")}.${widget.product.pricePerKg}/KG"),
                              if (widget.product.isTestingkit == true)
                                listwidget(text1: "No of Test", text2: "${widget.product.noOfTest}"),
                              if (widget.product.isTestingkit == true)
                                listwidget(text1: "Parameters Covered", text2: "${widget.product.parametersCovered}"),
                              if (widget.product.isTestingkit == true)
                                listwidget(text1: "Range Covered", text2: "${widget.product.rangeCovered}"),
                              if (widget.product.isEquipmentAerator())
                                listwidget(text1: "Voltage/Frequency", text2: "${widget.product.voltage}"),
                              if (widget.product.isEquipmentAerator())
                                listwidget(text1: "Motor Power", text2: "${widget.product.getMotorPower()}"),
                              if (widget.product.isEquipmentAerator())
                                listwidget(text1: "Weight", text2: "${widget.product.getWeight()}"),
                              if (widget.product.isEquipmentAerator())
                                listwidget(text1: "Number of fans/Paddles", text2: "${widget.product.noOfFans}"),
                              if (widget.product.isEquipmentAerator())
                                listwidget(text1: "Phase", text2: "${widget.product.motorPhase}"),
                              if (widget.product.isEquipmentAerator())
                                listwidget(text1: "PhaseSpeed", text2: "${widget.product.getMotorSpeed()}"),
                              if (widget.product.isEquipmentMudPumps())
                                listwidget(text1: "Pump Size", text2: "${widget.product.pumpSize}"),
                              if (widget.product.isEquipmentMudPumps())
                                listwidget(text1: "Motor Horsepower", text2: "${widget.product.getMotorPower()}"),
                              if (widget.product.isEquipmentMudPumps())
                                listwidget(text1: "Motor Phase", text2: "${widget.product.motorPhase}"),
                              if (widget.product.isEquipmentMudPumps())
                                listwidget(text1: "Speed", text2: "${widget.product.getMotorSpeed()}"),
                              if (widget.product.isEquipmentMudPumps())
                                listwidget(text1: "Max Flow Rate", text2: "${widget.product.getMaxFlowRate()}"),
                              if (widget.product.isEquipmentFishingNet())
                                listwidget(text1: "Color", text2: "${widget.product.netColor}"),
                              if (widget.product.isEquipmentFishingNet())
                                listwidget(text1: "Weight", text2: "${widget.product.getWeight()}"),
                              if (widget.product.isEquipmentFishingNet())
                                listwidget(text1: "Size of net", text2: "${widget.product.getNetSize()}"),
                              if (widget.product.isEquipmentFishingNet())
                                listwidget(text1: "Mesh Size", text2: "${widget.product.netMeshSize}"),
                              listwidget(text1: "Availability", text2: "${widget.product.getStockStatus()}"),
                            ],
                          ),
                        ),
                      ),
                      if (widget.product.isEquipment == true && widget.product.hasYoutubeLink())
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            visualDensity: VisualDensity.comfortable,
                            title: const Text('Watch on Youtube'),
                            trailing: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    // color: kwhite,
                                    shape: BoxShape.rectangle,

                                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    fadeInCurve: Curves.easeInOut,
                                    fadeInDuration: const Duration(milliseconds: 100),
                                    imageErrorBuilder: (context, error, stackTrace) => Image.asset("assets/no-photo.png"),
                                    placeholder: 'assets/no-photo.png',
                                    image: widget.product.getYoutuebImage(),
                                    height: 100.0,
                                    width: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 45,
                                  height: 35,
                                  color: kheader.withAlpha(150),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(color: Colors.transparent)),
                                  onPressed: () {
                                    launchUrl(Uri.parse(widget.product.getYoutuebImage()));
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              launchUrl(widget.product.youtubeLink);
                            },
                          ),
                        ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 3,
                        // margin: const EdgeInsets.all(10),
                        child: Container(
                            // color: ,
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                // Common.pushPage(context, CheckoutCancel('7122'));
                                // ignore: deprecated_member_use
                                launch("tel:+917071270718");
                              },
                              child: Text(
                                "For any assistance: +91 70712 70718".tr,
                                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            iconTheme: IconThemeData(color: Colors.blue),
                            dividerColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                              collapsedIconColor: kheader,
                              iconColor: kheader,
                              title: Text(
                                (widget.product.isEquipment == true) ? "Package Details".tr : "Description".tr,
                                style: TextStyle(color: kheader),
                              ),
                              initiallyExpanded: true,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: HtmlWidget(widget.product.productDescriptionLang ?? ""),
                                ),
                                const SizedBox(height: 10)
                              ]),
                        ),
                      ),
                      if (widget.product.isMedicine == true)
                        Card(
                          elevation: 3,
                          // margin: const EdgeInsets.only(
                          //     bottom: 10, left: 4, right: 4),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              iconTheme: IconThemeData(color: Colors.blue),
                              dividerColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                                collapsedIconColor: kheader,
                                iconColor: kheader,
                                title: Text(
                                  "Benefits".tr,
                                  style: TextStyle(color: kheader),
                                ),
                                initiallyExpanded: true,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: HtmlWidget(widget.product.benefitsLang ?? ""),
                                  ),
                                  const SizedBox(height: 10)
                                ]),
                          ),
                        ),

                      if (widget.product.isMedicine == true)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Card(
                              elevation: 3,
                              margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  iconTheme: IconThemeData(color: Colors.blue),
                                  dividerColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                    collapsedIconColor: kheader,
                                    iconColor: kheader,
                                    title: Text(
                                      "Direction For Use".tr,
                                      style: TextStyle(color: kheader),
                                    ),
                                    initiallyExpanded: true,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: HtmlWidget(widget.product.directionForUseLang ?? ""),
                                      ),
                                      const SizedBox(height: 10)
                                    ]),
                              ),
                            ),
                          ],
                        ),

                      if (widget.product.isTestingkit == true)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Card(
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  iconTheme: IconThemeData(color: Colors.blue),
                                  dividerColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                    collapsedIconColor: kheader,
                                    iconColor: kheader,
                                    title: Text(
                                      "How to Conduct the test".tr,
                                      style: TextStyle(color: kheader),
                                    ),
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: HtmlWidget(widget.product.directionForUseLang ?? ""),
                                      ),
                                      const SizedBox(height: 10)
                                    ]),
                              ),
                            ),
                          ],
                        ),

                      if (widget.product.isEquipmentAerator() || widget.product.isEquipmentMudPumps())
                        Column(
                          children: [
                            // const SizedBox(height: 10),
                            Card(
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  iconTheme: IconThemeData(color: Colors.blue),
                                  dividerColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                    collapsedIconColor: kheader,
                                    iconColor: kheader,
                                    title: Text(
                                      "Warranty".tr,
                                      style: TextStyle(color: kheader),
                                    ),
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: HtmlWidget(widget.product.directionForUseLang ?? ""),
                                      ),
                                      const SizedBox(height: 10)
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      // FractionallySizedBox(
                      //   widthFactor: 1,
                      //   child: ElevatedButton(
                      //       onPressed: () {
                      //        Get.to(CartScreen());
                      //       },
                      //       style: TextButton.styleFrom(
                      //         padding: const EdgeInsets.symmetric(vertical: 16),
                      //         textStyle: TextStyle(
                      //             fontSize: 14, fontWeight: FontWeight.w500),
                      //         shape: StadiumBorder(),
                      //         backgroundColor: Color(0xff23AA49),
                      //       ),
                      //       child: Text("Add to cart")),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _itemKeyPointsView(String imagePath, String title, String desc) {
  //   return Expanded(
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //       decoration: BoxDecoration(
  //           borderRadius: const BorderRadius.all(Radius.circular(16)),
  //           border: Border.all(color: const Color(0xffF1F1F5))),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Image.asset(
  //             imagePath,
  //             width: 40,
  //             height: 40,
  //           ),
  //           const SizedBox(
  //             width: 16,
  //           ),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                     color: Color(0xff23AA49)),
  //               ),
  //               const SizedBox(
  //                 height: 8,
  //               ),
  //               Text(desc,
  //                   style: const TextStyle(
  //                       fontSize: 14, color: Color(0xff979899))),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

Widget listwidget({required String text1, required String text2}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, top: 8, left: 8),
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: TextCustom(
              text1,
              kgreyDark,
              15,
              fonntweight: FontWeight.w600,
            )),
        TextCustom(
          " :   ",
          kblack,
          15,
          fonntweight: FontWeight.w600,
        ),
        Expanded(
            flex: 4,
            child: TextCustom(
              text2.tr,
              kblack,
              15,
              fonntweight: FontWeight.w600,
            )),
      ],
    ),
  );
}
