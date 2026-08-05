import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/shared_pref/shared_pref.dart';
import '../getxcontrollers/mixpanelcontroller.dart';
import '../widget/textfieldscreen.dart';
import 'authscreens/login.dart';
import 'helper.dart';
import '../widget/textstyle.dart';
import 'localconst.dart';

const themecolor = Color(0xFF006C83);
// const themecolor = Color(0xFF00203F);
const themecolor2 = Color(0xFFEF7F1A);
const backgroundcolor = Color(0xffF9FAFF);
const cartbackgroundcolor =  Color(0xffF1F0F5);
const korange = Color(0xFFFF9933);
const korangelite = Color(0xFFFFBE83);
const kwhite = Color(0xFFFFFFFF);
const kdeletecolor = Color(0xffAE2F09);
final kbuttoncolorred = Colors.redAccent.withOpacity(0.5);
const kdarkBlue = Color(0xFF333366);
const kblack = Color(0xFF000000);
final kgreyDark = Colors.grey.shade700;
final kgreyDivider = Colors.grey.shade400;
final kgreyFill = cartbackgroundcolor;
const kheader = Color(0xFF006C83);
// const kheader = Color(0xFF00203F);
const kitembg = Color(0xFFE1FFFC);
const kitemlabel = Color(0xFF0E5C6D);
const kitemlabelselected = Color(0xFFdd5512);
const kWhatsApp = Color(0xFF4fce5d);
const kLocation = Color(0xFF560000);
const kCallNow = Color(0xFF008dab);
const backgroundcolorcart = Color(0xffF1F0F5);
const kColorButtonCart = Color(0xFF008CAB);
const kColorButton = Color(0xFF006C83);
const kColorAppDefault = Color(0xFF006C83); //Color(0xFF882066);
final kColorLabel = Colors.grey.shade700; //Colors.grey[900];
const kColorNote = Colors.black54;
const kColorDivider = Colors.black12;
final kColorPrice = Colors.green.shade800;
Color scaffoldBackgroundColor = const Color(0xFF343541);
Color cardColor = const Color(0xFF444654);
Color green = const Color(0XFF16A281);

// final String api_url = "$mainlink/api/v1/${languagecode()}/";
// final String api_url = "$mainlink/api/";
const String main_url = "https://manjhaimages.s3.ap-south-1.amazonaws.com";
const String image_fish_url = "$main_url/fish/";
const String image_news_url = "$main_url/news/";
const String image_banner_url = "$main_url/banner/";
const String image_brand_url = "$main_url/brand/";
const String image_category_url = "$main_url/category/";
const String image_product_url = "$main_url/product/";
const String image_customer_url = "$main_url/customer/";
const String image_charcha_url = "$main_url/charcha/";
const String image_hatchery_url = "$main_url/hatchery/";
const String image_hatcheryseed_url = "$main_url/hatcheryseed/";
const String app_link =
    "https://play.google.com/store/apps/details?id=com.gnhub.manjha";
const String app_ios_link = "https://apps.apple.com/fi/app/manjha/id1607387435";

//ChatGPT Links

String BASE_URL = "https://api.openai.com/v1";
String API_KEY =
    "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";

void showSnackBar(String message, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

logoutfuntion() {
  SharedPref.deleteAll();
  Get.offAll(LoginScreen());
}

String getHindiNumber(String digit) {
  switch (digit) {
    case '0':
      return '०';
    case '1':
      return '१';
    case '2':
      return '२';
    case '3':
      return '३';
    case '4':
      return '४';
    case '5':
      return '५';
    case '6':
      return '६';
    case '7':
      return '७';
    case '8':
      return '८';
    case '9':
      return '९';
    default:
      return digit;
  }
}

String getOdiaNumber(String digit) {
  switch (digit) {
    case '0':
      return '୦';
    case '1':
      return '୧';
    case '2':
      return '୨';
    case '3':
      return '୩';
    case '4':
      return '୪';
    case '5':
      return '୫';
    case '6':
      return '୬';
    case '7':
      return '୭';
    case '8':
      return '୮';
    case '9':
      return '୯';
    default:
      return digit;
  }
}

// imagecall(imageurl) {
//   return CachedNetworkImage(
//     fit: BoxFit.cover,
//     fadeInCurve: Curves.bounceIn,
//     imageUrl: imageurl,
//     placeholder: (context, url) => Image.asset('assets/no-photo.png'),
//     errorWidget: (context, url, error) => Image.asset('assets/no-photo.png'),
//   );
// }

Widget imageCall(String? imageUrl) {
  if (imageUrl != null && imageUrl.isNotEmpty) {
    return CachedNetworkImage(
      cacheKey: imageUrl,
      fit: BoxFit.cover,
      fadeInCurve: Curves.bounceIn,
      imageUrl: imageUrl,
      placeholder: (context, url) => Image.asset('assets/no-photo.png'),
      errorWidget: (context, url, error) => Image.asset('assets/no-photo.png'),
    );
  } else {
    return Image.asset('assets/no-photo.png');
  }
}

Widget seeAllView(
    BuildContext context, String name, void Function()? onTapFunction,
    {Color? color, textColor, bool? isPadding}) {
  return Padding(
    padding: isPadding == false
        ? EdgeInsets.all(0)
        : EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name.tr,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.black),
        ),
        GestureDetector(
          onTap: onTapFunction,
          child: Container(
            alignment: Alignment.centerRight,
            width: 100,
            child: Text(
              "View all".tr,
              style: TextStyle(
                  fontSize: 15,
                  color: color ?? themecolor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget cardWidget(context, product, setState, cartController) {
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
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => kbuttoncolorred)),
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
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => themecolor.withOpacity(0.5))),
              icon: Icon(Icons.add_shopping_cart, color: kColorButtonCart),
              label: BoldText(
                  (Lang.get(addNew ? "Add" : "Update")), 14, kColorButtonCart),
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

  return Card(
    elevation: 2,
    child: Container(
      margin: const EdgeInsets.all(10),
      width: screenwidth(context, dividedby: 2.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                // fadeInCurve: Curves.bounceIn,
                imageUrl: product.imageUrl ?? "",
                cacheKey: product.imageUrl ?? "",
                placeholder: (context, url) =>
                    Image.asset('assets/no-photo.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/no-photo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: themecolor2),
                    child: Text("${product.discount}% Off",
                        style: TextStyle(
                            fontSize: 10,
                            color: kwhite,
                            fontWeight: FontWeight.w600)),
                  ),
                  Icon(
                    Icons.share,
                    size: 20,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          BoldText(
              overflow: TextOverflow.ellipsis,
              "${product.productNameLang}",
              16,
              kblack),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.isTestingkit == true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    TextCustomRow(
                      product.noOfTest.toString(),
                      kColorLabel,
                      12,
                      text2: '${translate("No of Test")}: ',
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextCustomRow(
                      "${product.parametersCovered} ",
                      kgreyDark,
                      12,
                      fonntweight: FontWeight.w400,
                      text2: "${translate("Parameters Covered")} : ",
                    ),
                  ],
                ),
              if (product.isFeed == true || product.isMedicine == true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    TextCustomRow(
                      "${product.itemSize} ${product.itemSizeUnit}",
                      kgreyDark,
                      12,
                      fonntweight: FontWeight.w500,
                      text2: "${translate("Size")}: ",
                    ),
                  ],
                ),
              if (product.isFeed == true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    TextCustomRow(
                      "${product.bagSize} Kg",
                      kgreyDark,
                      12,
                      fonntweight: FontWeight.w500,
                      text2: "${translate("Bag Size")}: ",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              if (product.isFeed == true && !product.getIsPrawnFeed())
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustomRow(
                      "${product.proteinPerFat} Kg",
                      kgreyDark,
                      12,
                      fonntweight: FontWeight.w500,
                      text2: "${translate("Protein/fat")}: ",
                    ),
                  ],
                ),
              if (product.isFeed == true && product.getIsPrawnFeed())
                TextCustom(
                  "(${translate("Rs")}.${product.pricePerKg}/Kg)",
                  kgreyDark,
                  12,
                  fonntweight: FontWeight.w400,
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: TextCustom(
                            "${translate('Rs')}.${product.specialPrice}",
                            kblack,
                            // product.specialPrice.toString().length > 4 ? 14 : 16,
                            16,
                            fonntweight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        TextCustom("${translate('Rs')}.${product.price}",
                            kgreyDark, 12,
                            fonntweight: FontWeight.w500, cancel: true),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: product.quantity != 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () async {
                                  if (product.isFeed) {
                                    _quantityController.text =
                                        product.quantity.toString();
                                    bool result =
                                        await showQuanityBox(context, false);
                                    if (result == false ||
                                        _quantityController.text.isEmpty) {
                                      _quantityController.text = '';
                                      print('Quantity dialog cancelled...');

                                      return;
                                    } else {
                                      setState(() {
                                        product.quantity =
                                            int.parse(_quantityController.text);
                                        _quantityController.text = '';
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      if (product.quantity <=
                                          product.getQtyLot()) {
                                        //1
                                        // REMOVE
                                        print('remove' +
                                            product.quantity.toString());
                                        product.quantity = 0;
                                        print('remove' +
                                            product.quantity.toString());
                                      } else if (product.quantity <=
                                          product.getQtyLot()) {
                                        // REMOVE
                                        product.quantity = 1;
                                      } else {
                                        product.quantity -= product.getQtyLot();
                                      }
                                    });
                                  }
                                  MixpanelController.logScreen(
                                      MixpanelController.PageProductDetail,
                                      properties: {
                                        "Item Remove to Cart":
                                            "${product.productNameLang}",
                                        "Quantity": product.quantity.toString()
                                      });
                                  cartController.fetchCartupdate(
                                      product.id, product.quantity);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 3),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    size: 15,
                                  ),
                                )),
                            // (product.quantity.toString().length > 10) ?
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(product.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: kblack,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            //     :Expanded(
                            //   child: FittedBox(
                            //     fit: BoxFit.scaleDown,
                            //     child: Text(product.quantity.toString(),
                            //         style: TextStyle(fontSize: 14, color: kblack, fontWeight: FontWeight.w500)),
                            //   ),
                            // ),
                            InkWell(
                                onTap: () async {
                                  if (product.isFeed) {
                                    _quantityController.text =
                                        product.quantity.toString();
                                    bool result =
                                        await showQuanityBox(context, false);
                                    if (result == false ||
                                        _quantityController.text.isEmpty) {
                                      _quantityController.text = '';
                                      print('Quantity dialog cancelled...');

                                      return;
                                    } else {
                                      setState(() {
                                        product.quantity =
                                            int.parse(_quantityController.text);
                                        _quantityController.text = '';
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      product.quantity += product.getQtyLot();
                                    });
                                  }
                                  MixpanelController.logScreen(
                                      MixpanelController.PageProductDetail,
                                      properties: {
                                        "Item Added to Cart":
                                            "${product.productNameLang}",
                                        "Quantity": product.quantity.toString()
                                      });
                                  cartController.fetchCartupdate(
                                      product.id, product.quantity);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 3),
                                  child: Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ))
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          if (product.isFeed) {
                            _quantityController.text =
                                product.quantity.toString();
                            bool result = await showQuanityBox(context, false);
                            if (result == '' ||
                                result == false ||
                                _quantityController.text.isEmpty) {
                              _quantityController.text = '';
                              print('Quantity dialog cancelled...');

                              return;
                            } else {
                              setState(() {
                                product.quantity =
                                    int.parse(_quantityController.text);
                                _quantityController.text = '';
                              });
                            }
                          } else {
                            setState(() {
                              product.quantity += product.getQtyLot();
                            });
                          }
                          cartController.fetchCartAddd(
                              product.id, product.quantity);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: themecolor),
                          child: Text("Add".tr,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: kwhite,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
              )
              // MaterialButton(color: themecolor,onPressed: () {
              //
              // },child: Row(children: [
              //   TextCustom("Add +",kwhite,16)
              // ],),)
            ],
          )
        ],
      ),
    ),
  );
}

String formatDate(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}

String formattedDate(String dateStr) {
  if (dateStr == '' || dateStr.isEmpty) {
    return '';
  }

  try {
    DateTime parsedDate = DateTime.parse(dateStr);
    DateFormat formatter = DateFormat('dd MMM yyyy');
    String formattedDate = formatter.format(parsedDate);
    return formattedDate;
  } catch (e) {
    print('Error parsing date: $e');
    return '';
  }
}

String formatTime(String timeStr) {
  if (timeStr == '' || timeStr.isEmpty) {
    return '';
  }

  try {
    DateTime parsedTime = DateTime.parse('1970-01-01 $timeStr');

    DateFormat formatter = DateFormat('hh:mm a');
    String formattedTime = formatter.format(parsedTime);

    return formattedTime;
  } catch (e) {
    print('Error parsing time: $e');
    return '';
  }
}

String formatMobileNumber(String mobileNumber) {
  if (mobileNumber.length != 10) {
    return 'Invalid number';
  }

  String countryCode = '+91';
  String formattedNumber =
      '${mobileNumber.substring(0, 3)} ${mobileNumber.substring(3, 6)} ${mobileNumber.substring(6, 10)}';

  return '$countryCode $formattedNumber';
}

String formattedMobileNumber(String mobileNumber) {
  String cleanedNumber = mobileNumber.replaceAll(RegExp(r'\D'), '');

  String countryCode = '+91';

  String part1 =
      cleanedNumber.length > 3 ? cleanedNumber.substring(0, 3) : cleanedNumber;
  String part2 = cleanedNumber.length > 6
      ? cleanedNumber.substring(3, 6)
      : cleanedNumber.length > 3
          ? cleanedNumber.substring(3)
          : '';
  String part3 = cleanedNumber.length > 6 ? cleanedNumber.substring(6) : '';

  String formattedNumber = '$part1 $part2 $part3'.trim();

  return '$countryCode $formattedNumber';
}
