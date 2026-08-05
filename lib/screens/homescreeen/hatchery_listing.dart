import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/model/gethitcheryresponse.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../helper.dart';
import '../seddpages/seeddetailpage.dart';

class HatcheryListing extends StatefulWidget {
  final List<Fish> fishseed;
  const HatcheryListing({super.key, required this.fishseed});

  @override
  State<HatcheryListing> createState() => _HatcheryListingState();
}

class _HatcheryListingState extends State<HatcheryListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kblack),
        backgroundColor: kwhite,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: NormalText("Seed Listing", kblack, 25.0),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: List.generate(
                widget.fishseed.length,
                (index) {
                  Fish fishseed = widget.fishseed[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => SeedDetailsPage(hatchery: fishseed));
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              fishseed.imageUrl ?? ""),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
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
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: screenwidth(context,
                                                  dividedby: 1.5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    fishseed.hatcheryName ?? '',
                                                    style: TextStyle(
                                                        color: kwhite,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    fishseed.address ??
                                                        'Unnao, Uttar Pradesh',
                                                    style: TextStyle(
                                                        color: kwhite,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: GestureDetector(
                                                  onTap: () {},
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .ellipsis_vertical,
                                                    color: kwhite,
                                                  )),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0)),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0))),
                                margin: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 20, right: 20),
                                elevation: 0,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0))),
                                  // height: 110,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Availability',
                                              style: TextStyle(
                                                  color: kgreyDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Size',
                                              style: TextStyle(
                                                  color: kgreyDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Line',
                                              style: TextStyle(
                                                  color: kgreyDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        children: List.generate(
                                          fishseed.seeds?.length ?? 0,
                                          (indexseed) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                    fishseed.seeds![indexseed]
                                                            .seedName ??
                                                        'Pangas(parlour property of the functionality)',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: kheader,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: Text(
                                                      '${fishseed.seeds![indexseed].seedSize}',
                                                      style: TextStyle(
                                                          color: kheader,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Center(
                                                    child: Text(
                                                      '${fishseed.seeds![indexseed].seedWeight}.0 pc/kg',
                                                      style: TextStyle(
                                                          color: kheader,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
