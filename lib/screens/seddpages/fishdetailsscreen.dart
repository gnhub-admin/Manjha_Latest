import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manjha/screens/const.dart';
import 'package:manjha/model/searchfishresponse.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

class FishDetailsScreen extends StatefulWidget {
  final Fishes saleItem;
  const FishDetailsScreen({super.key, required this.saleItem});

  @override
  State<FishDetailsScreen> createState() => _FishDetailsScreenState();
}

class _FishDetailsScreenState extends State<FishDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: kwhite,
        title: NormalText("Seller Details", kblack, 25),
        elevation: 1.0,
        actions: [
          Visibility(
            visible: false,
            child: Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => kitemlabel),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        )),
                    icon: const Icon(Icons.check_rounded),
                    label: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: kwhite),
                    ),
                    // color: kitemlabel,
                    // textColor: kwhite,
                    onPressed: () {
                      Navigator.pop(context);
                    })),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 4,
                color: kitembg,
                clipBehavior: Clip.antiAlias,
                // child:
                // Positioned(
                //   top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: const BoxConstraints(
                      minHeight: 100,
                      minWidth: double.infinity,
                      maxHeight: 400),
                  child: (Image.network(
                    widget.saleItem.getImageURL(),
                    fit: BoxFit.cover,
                    // height: 200.0,
                    width: 100.0,
                  )),
                ),
                // )
              ),
              const SizedBox(height: 10),
              widget.saleItem.hasOtherImage() &&
                      widget.saleItem.getImageList().length > 1
                  ? SizedBox(
                      width: 400,
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for (var imgPath in widget.saleItem.getImageList())
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(color: kgreyDark, blurRadius: 2.0)
                                  ]),
                              margin: const EdgeInsets.all(6.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    image_fish_url + imgPath,
                                    fit: BoxFit.cover,
                                  )),
                            )
                          //
                        ],
                      ),
                    )
                  : const SizedBox(), //Text('No images found'),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFfcdb98),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              // FontAwesomeIcons.mapMarkerAlt,
                              FontAwesomeIcons.locationDot,
                              size: 14,
                              color: kLocation,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            NormalText(
                                (widget.saleItem.farmAddress == null ||
                                        widget.saleItem.farmAddress!.isEmpty)
                                    ? "--"
                                    : widget.saleItem.farmAddress ?? "",
                                kLocation,
                                16.0),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: false,
                          child: ElevatedButton.icon(
                              // color:
                              //     Colors.transparent, //Color(0xFF525c5e),
                              // height: 36,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.white),
                                  shape: MaterialStateProperty.resolveWith(
                                    (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: const BorderSide(
                                            color: Colors.red)),
                                  )),
                              onPressed: () async {
                                // await myFavoriteAdd(widget.saleItem.id,
                                //     isRemove: widget.saleItem
                                //         .is_favorite()); // if favorite true -> need to remove
                                // setState(() {
                                //   widget.saleItem.setFavorite(
                                //       !widget.saleItem.is_favorite());
                                // });
                                //myFavoriteAdd(widget.saleItem.id);
                              },
                              icon: widget.saleItem.is_favorite()
                                  ? const Icon(FontAwesomeIcons.solidHeart,
                                      size: 14, color: Colors.red)
                                  : const Icon(FontAwesomeIcons.heart,
                                      size: 14, color: Colors.red),
                              label: BoldText("Favorite", 14, Colors.red))),
                    ]),
              ),
              Container(
                // elevation: 1,
                // color: kitembg,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoldText(widget.saleItem.fishTypeName ?? '', 22, kblack),
                      BoldText(widget.saleItem.getPrice(), 18.0, kWhatsApp),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          NormalText("Size" ": ", kgreyDivider, 18.0),
                          NormalText(
                              widget.saleItem.fishSizeType ?? '', kblack, 18.0),
                        ],
                      ),
                      Row(
                        children: [
                          NormalText("Weight" ": ", kgreyDivider, 18.0),
                          NormalText(widget.saleItem.getWeight(), kblack, 18.0),
                        ],
                      ),
                      const SizedBox(height: 20),
                      NormalText("Sold By", kblack, 18.0),
                      BoldText(
                          widget.saleItem.sellerName ?? "", 20.0, kCallNow),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  // BoldText("  Images", 20.0, kblack),
                  // BoldText("Video >>", 16, kdarkBlue),
                  // FlatButton.icon(
                  //     onPressed: () {},
                  //     icon: Icon(FontAwesomeIcons.youtube),
                  //     label: Text("Watch Video")),
                ],
              ),
              const SizedBox(
                height: 0.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => kCallNow),
                              shape: MaterialStateProperty.resolveWith(
                                (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              )),

                          // color: kCallNow,
                          onPressed: () {
                            // getSellerContact(widget.saleItem.id);
                            // saleitemLog(widget.saleItem.id,
                            //     widget.saleItem.ACTION_CALL);
                            // ignore: deprecated_member_use
                            launch("tel:+91${widget.saleItem.contactno}");
                          },
                          icon: const Icon(
                              // FontAwesomeIcons.phoneAlt,
                              FontAwesomeIcons.phoneFlip,
                              size: 16,
                              color: kwhite),
                          label: BoldText("Call Now", 16, kwhite))),
                  const SizedBox(width: 16),
                  Expanded(
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => kWhatsApp),
                              shape: MaterialStateProperty.resolveWith(
                                (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              )),

                          // color: kWhatsApp,
                          onPressed: () async {
                            // saleitemLog(widget.saleItem.id,
                            //     widget.saleItem.ACTION_CALL);
                            // String strUserName =
                            // await Session.getCustomerName();
                            // String strCity = await Session.getCity();
                            //
                            // String strMessage = Common.getWhtapAppMessage(
                            //     strUserName, strCity);
                            // launch(Uri.encodeFull(
                            //     "https://wa.me/91${widget.saleItem.contactno}?text=$strMessage"));
                            // getSellerWhatApp(widget.saleItem.id);
                          },
                          icon: const Icon(FontAwesomeIcons.whatsapp,
                              size: 16, color: kwhite),
                          label: BoldText("WhatsApp", 16, kwhite))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
