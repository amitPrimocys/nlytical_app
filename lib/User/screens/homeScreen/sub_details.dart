// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/service_contro.dart';
import 'package:nlytical_app/User/screens/homeScreen/chat_screen.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class SubDetails extends StatefulWidget {
  int? index;
  SubDetails({
    super.key,
    this.index,
  });

  @override
  State<SubDetails> createState() => _SubDetailsState();
}

class _SubDetailsState extends State<SubDetails> {
  ServiceContro servicecontro = Get.put(ServiceContro());
  @override
  void initState() {
    super.initState();
    print("😀😀😀😀USER_ID:$userID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: AppColors.white,
        bottomNavigationBar: BottomAppBar(
          height: 73,
          elevation: 0,
          color: Colors.white,
          child: bottam(),
        ),
        // appBar: AppBar(
        //   backgroundColor: AppColors.white,
        //   automaticallyImplyLeading: false,
        //   scrolledUnderElevation: 0,
        //   shadowColor: Colors.white,
        //   elevation: 5,
        //   title: Row(
        //     children: [
        //       GestureDetector(
        //           onTap: () {
        //             Navigator.pop(context);
        //           },
        //           child: Image.asset(
        //             'assets/images/arrow-left1.png',
        //             height: 24,
        //           )),
        //       sizeBoxWidth(10),
        //       SizedBox(
        //         width: 250,
        //         child: label(
        //           servicecontro
        //               .servicemodel.value!.stores![widget.index!].storeName
        //               .toString(),

        //           // servicecontro.servicemodel.value!.stores![0].storeName
        //           //     .toString(),
        //           fontSize: 20,
        //           maxLines: 1,
        //           textColor: Colors.black,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: SizedBox(
          height: Get.height,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Container(
                width: Get.width,
                height: getProportionateScreenHeight(150),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAsstes.line_design)),
                    color: AppColors.blue),
              ),
              Positioned(
                top: getProportionateScreenHeight(60),
                left:
                    0, // Ensures alignment is calculated across the entire width
                right: 0,
                child: Container(
                  // Aligns content to the center
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/arrow-left1.png',
                            color: AppColors.white,
                            height: 24,
                          )),
                      sizeBoxWidth(20),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          servicecontro.servicemodel.value!
                              .stores![widget.index!].storeName
                              .toString(),
                          textAlign: TextAlign.center,
                          fontSize: 20,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Uncomment and use if required
                      // sizeBoxWidth(240),
                      // Image.asset(
                      //   AppAsstes.search,
                      //   scale: 3.5,
                      //   color: Colors.white,
                      // ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
              Positioned(
                top: 100,
                child: Container(
                  width: Get.width,
                  height: getProportionateScreenHeight(800),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      sizeBoxHeight(10),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Color.fromRGBO(0, 0, 0, 0.12),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black54,
                      //         blurRadius: 10,
                      //         spreadRadius: 0,
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Expanded(
                        child: Column(
                          children: [
                            sizeBoxHeight(15),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: Get.height * 0.28,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          color: Colors.grey.shade300,
                                          offset: const Offset(0.0, 3.0),
                                        ),
                                      ],
                                      image: DecorationImage(
                                          image: NetworkImage(servicecontro
                                                  .servicemodel
                                                  .value!
                                                  .stores![widget.index!]
                                                  .storeImages![0]
                                                  .toString()
                                              // servicecontro
                                              //     .servicemodel.value!.stores![0].storeImages![0]
                                              //     .toString(),
                                              ),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    bottom: -1,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 70,
                                      width: Get.width,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 240,
                                              child: label(
                                                servicecontro
                                                    .servicemodel
                                                    .value!
                                                    .serviceDetail!
                                                    .serviceName!
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 18,
                                                textColor: AppColors.brown,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: servicecontro
                                                              .servicemodel
                                                              .value!
                                                              .serviceDetail!
                                                              .totalAvgReview!
                                                              .toString() !=
                                                          ''
                                                      ? double.parse(
                                                          servicecontro
                                                              .servicemodel
                                                              .value!
                                                              .serviceDetail!
                                                              .totalAvgReview!
                                                              .toString())
                                                      : 0.0,
                                                  // initialRating: ratingCount,
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 12.5,
                                                  ignoreGestures: true,
                                                  unratedColor:
                                                      Colors.grey.shade400,
                                                  itemBuilder: (context, _) =>
                                                      Image.asset(
                                                    'assets/images/Star.png',
                                                    height: 16,
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                                const SizedBox(width: 5),
                                                label(
                                                  '(${servicecontro.servicemodel.value!.serviceDetail!.totalReviewCount!.toString()} Review)',
                                                  fontSize: 10,
                                                  textColor: AppColors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ).paddingOnly(right: 14),
                                          ],
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  top: 14,
                                  child: Container(
                                    height: 18,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(3),
                                          bottomRight: Radius.circular(3)),
                                      color: AppColors.blue,
                                    ),
                                    child: Center(
                                      child: label(
                                        servicecontro.servicemodel.value!
                                            .stores![widget.index!].category
                                            .toString(),
                                        // servicecontro.servicemodel.value!.stores![0].category
                                        //     .toString(),
                                        fontSize: 8,
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ).paddingSymmetric(horizontal: 8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            sizeBoxHeight(15),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12)),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ExpandableText(
                                      servicecontro
                                          .servicemodel
                                          .value!
                                          .stores![widget.index!]
                                          .storeDescription
                                          .toString(),
                                      // servicecontro
                                      //     .servicemodel.value!.stores![0].storeDescription
                                      //     .toString(),
                                      expandText: 'Read More',
                                      collapseText: 'Show Less',
                                      maxLines: 3,
                                      linkColor: AppColors.blue,
                                      linkStyle: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            sizeBoxHeight(15),
                            Container(
                              height: 50,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  label(
                                    'Price',
                                    fontSize: 12,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  label(
                                    '\$${servicecontro.servicemodel.value!.stores![widget.index!].price.toString()}',
                                    fontSize: 12,
                                    textColor: AppColors.blue,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ).paddingSymmetric(horizontal: 20),
                            ),
                            sizeBoxHeight(15),
                            Container(
                              height: Get.height * 0.2,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  label(
                                    'Attachment',
                                    fontSize: 12,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    height: 50,
                                    child: servicecontro
                                            .servicemodel
                                            .value!
                                            .stores![widget.index!]
                                            .storeAttachments!
                                            .isNotEmpty
                                        ? ListView.builder(
                                            itemCount: servicecontro
                                                .servicemodel
                                                .value!
                                                .stores![widget.index!]
                                                .storeAttachments!
                                                .length, // Replace with the actual number of attachments
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              String attachmentUrl =
                                                  servicecontro
                                                      .servicemodel
                                                      .value!
                                                      .stores![widget.index!]
                                                      .storeAttachments![index];

                                              bool isImage = attachmentUrl
                                                      .endsWith('.jpg') ||
                                                  attachmentUrl
                                                      .endsWith('.jpeg') ||
                                                  attachmentUrl
                                                      .endsWith('.png');

                                              return Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      if (isImage) {
                                                        // Open image viewer directly with the URL
                                                        Get.to(() =>
                                                            ImageViewerScreen(
                                                                imageUrl:
                                                                    attachmentUrl));
                                                      } else {
                                                        // Download PDF then open it
                                                        Get.to(() =>
                                                            PDFViewerScreen(
                                                                attachmentUrl));

                                                        // PDF(
                                                        //   swipeHorizontal: true,
                                                        // ).cachedFromUrl(
                                                        // 'https://ontheline.trincoll.edu/images/bookdown/sample-local-pdf.pdf');
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Image(
                                                        image: isImage
                                                            ? NetworkImage(servicecontro
                                                                    .servicemodel
                                                                    .value!
                                                                    .stores![widget
                                                                        .index!]
                                                                    .storeAttachments![
                                                                0])
                                                            : const AssetImage(
                                                                'assets/images/pdf.png'),
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : Center(
                                            child: label(
                                              'No attachments available',
                                              fontSize: 12,
                                              textColor: AppColors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ),
                                ],
                              ).paddingSymmetric(horizontal: 20),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget appBarWidget() {
    return Container(
      height: getProportionateScreenHeight(100),
      width: Get.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
            color: Colors.grey.shade300)
      ], color: Colors.white),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              SizedBox(
                width: 250,
                child: label(
                  servicecontro
                      .servicemodel.value!.stores![widget.index!].storeName
                      .toString(),

                  // servicecontro.servicemodel.value!.stores![0].storeName
                  //     .toString(),
                  fontSize: 20,
                  maxLines: 1,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }

  Widget bottam() {
    return Row(children: [
      Expanded(
        child: GestureDetector(
          // onTap: onTapcall,
          onTap: () async {
            if (userID.isEmpty) {
              snackBar("Login must need for see mobile number");
            } else {
              String phoneNum = Uri.encodeComponent(servicecontro
                  .servicemodel.value!.serviceDetail!.servicePhone!
                  .toString());
              Uri tel = Uri.parse("tel:$phoneNum");
              if (await launchUrl(tel)) {
                //phone dail app is opened
              } else {
                //phone dail app is not opened
                snackBar('Phone dail not opened');
              }
            }
          },
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/call.png',
                  height: 12,
                  color: AppColors.white,
                ),
                sizeBoxWidth(5),
                label(
                  'Call',
                  fontSize: 10,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
      sizeBoxWidth(10),
      Expanded(
        child: GestureDetector(
          onTap: () {
            if (userID.isEmpty) {
              snackBar("Login must need for chat with vendor");
            } else {
              Get.to(
                  ChatScreen(
                    toUserID: servicecontro
                        .servicemodel.value!.vendorDetails!.id
                        .toString(),
                    isRought: true,
                    fname: servicecontro
                        .servicemodel.value!.vendorDetails!.firstName,
                    lname: servicecontro
                        .servicemodel.value!.vendorDetails!.lastName,
                    profile:
                        servicecontro.servicemodel.value!.vendorDetails!.image,
                    lastSeen: servicecontro
                        .servicemodel.value!.vendorDetails!.lastSeen,
                  ),
                  transition: Transition.rightToLeft);
            }
          },
          // onTap: onTapcall,
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/message-2.png',
                  height: 12,
                  color: AppColors.white,
                ),
                sizeBoxWidth(5),
                label(
                  'Chat',
                  fontSize: 10,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
      sizeBoxWidth(10),
      Expanded(
        child: GestureDetector(
          onTap: () async {
            if (userID.isEmpty) {
              snackBar("Login must need for see what's app number");
            } else {
              whatsapp();
            }
          },

          // onTap: onTapwhatsup,
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/whatsapp.png',
                  height: 12,
                ),
                sizeBoxWidth(5),
                label(
                  'Whatsapp',
                  fontSize: 10,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
      //    InkWell(
      //     // onTap: () {
      //     //   if (servicecontro.servicemodel.value!.guestUser == 1) {
      //     //     snackBar("Login must need for chat with vendor");
      //     //   } else {
      //     //     Get.to(
      //     //         ChatScreen(
      //     //           toUserID: servicecontro
      //     //               .servicemodel.value!.vendorDetails!.id
      //     //               .toString(),
      //     //           isRought: true,
      //     //           fname: servicecontro
      //     //               .servicemodel.value!.vendorDetails!.firstName,
      //     //           lname: servicecontro
      //     //               .servicemodel.value!.vendorDetails!.lastName,
      //     //           profile: servicecontro
      //     //               .servicemodel.value!.vendorDetails!.image,
      //     //           lastSeen: servicecontro
      //     //               .servicemodel.value!.vendorDetails!.lastSeen,
      //     //         ),
      //     //         transition: Transition.rightToLeft);
      //     //   }
      //     // },
      //     child: Container(
      //       height: getProportionateScreenHeight(50),
      //       //width: getProportionateScreenWidth(150),
      //       decoration: BoxDecoration(
      //           border: Border.all(color: AppColors.blue),
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(30)),
      //       child: Center(
      //         child: label(
      //           'Chat',
      //           fontSize: 15,
      //           textColor: AppColors.blue,
      //           fontWeight: FontWeight.w400,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // sizeBoxWidth(20),
      // Expanded(
      //   child: GestureDetector(
      //     onTap: () {
      //       // Call the API to like/unlike the service
      //       if (servicecontro.servicemodel.value!.guestUser == 1) {
      //         snackBar('Please login to review this service');
      //       } else {
      //         _confirmReview();
      //       }
      //     },
      //     child: Container(
      //       height: getProportionateScreenHeight(50),
      //       //width: getProportionateScreenWidth(150),
      //       decoration: BoxDecoration(
      //           color: AppColors.blue,
      //           borderRadius: BorderRadius.circular(30)),
      //       child: Center(
      //         child: label(
      //           'Add Review',
      //           fontSize: 15,
      //           textColor: Colors.white,
      //           fontWeight: FontWeight.w400,
      //         ),
      //       ),
      //     ),
      //   ),
    ]);
  }

  whatsapp() async {
    var contact = servicecontro.servicemodel.value!.serviceDetail!.servicePhone!
        .toString();

    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {}
  }
}
