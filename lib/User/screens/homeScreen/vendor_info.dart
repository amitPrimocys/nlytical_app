// ignore_for_file: must_be_immutable, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/vendor_info_contro.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class VendorInfo extends StatefulWidget {
  String? oppositeid;
  VendorInfo({super.key, required this.oppositeid});

  @override
  State<VendorInfo> createState() => _VendorInfoState();
}

class _VendorInfoState extends State<VendorInfo> {
  VendorInfoContro vendorcontro = Get.put(VendorInfoContro());
  LikeContro likecontro = Get.put(LikeContro());
  @override
  void initState() {
    vendorcontro.vendorApi(toUSerID: widget.oppositeid);
    super.initState();
  }

  // @override
  // void dispose() {
  //   timer!.cancel();
  //     streamController.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.white
          : AppColors.darkMainBlack,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: getProportionateScreenHeight(150),
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(AppAsstes.line_design)),
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
                    sizeBoxWidth(80),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Vendor Info",
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
            Positioned.fill(
                top: 100,
                child: Container(
                  width: Get.width,
                  height: getProportionateScreenHeight(800),
                  decoration: BoxDecoration(
                      color: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkMainBlack,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Obx(() {
                    return vendorcontro.isfav.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.blue,
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                sizeBoxHeight(27),
                                Container(
                                  height: 130,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: AppColors.blue)),
                                  child: Row(
                                    children: [
                                      sizeBoxWidth(15),
                                      Container(
                                        height: 66,
                                        width: 66,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                              vendorcontro.vendorlistmodel.value
                                                  .vendordetails!.image
                                                  .toString(),
                                            ))),
                                      ),
                                      sizeBoxWidth(15),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          sizeBoxHeight(7),
                                          label(
                                              "${vendorcontro.vendorlistmodel.value.vendordetails!.firstName.toString()} ${vendorcontro.vendorlistmodel.value.vendordetails!.lastName.toString()}",
                                              fontSize: 16,
                                              textColor:
                                                  themeContro.isLightMode.value
                                                      ? Colors.black
                                                      : AppColors.white,
                                              fontWeight: FontWeight.w500),
                                          sizeBoxHeight(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RatingBar.builder(
                                                initialRating: vendorcontro
                                                            .vendorlistmodel
                                                            .value
                                                            .vendordetails!
                                                            .averageRating
                                                            .toString() !=
                                                        ''
                                                    ? double.parse(vendorcontro
                                                        .vendorlistmodel
                                                        .value
                                                        .vendordetails!
                                                        .averageRating
                                                        .toString())
                                                    : 0.0,
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
                                                '(${vendorcontro.vendorlistmodel.value.vendordetails!.totalReviews.toString()} Review)',
                                                // '(${2} Review)',
                                                fontSize: 10,
                                                textColor: themeContro
                                                        .isLightMode.value
                                                    ? Colors.black
                                                    : AppColors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          sizeBoxHeight(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.black12
                                                        : AppColors.white),
                                                child: Image.asset(
                                                    'assets/images/location2.png'),
                                              ),
                                              sizeBoxWidth(10),
                                              SizedBox(
                                                width: 180,
                                                child: label(
                                                  vendorcontro
                                                      .vendorlistmodel
                                                      .value
                                                      .vendordetails!
                                                      .address
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 11,
                                                      color: themeContro
                                                              .isLightMode.value
                                                          ? Colors.black
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              )
                                            ],
                                          ),
                                          sizeBoxHeight(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.black12
                                                        : AppColors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Image.asset(
                                                      'assets/images/call.png'),
                                                ),
                                              ),
                                              sizeBoxWidth(10),
                                              label(
                                                  vendorcontro
                                                      .vendorlistmodel
                                                      .value
                                                      .vendordetails!
                                                      .mobile
                                                      .toString(),
                                                  fontSize: 11,
                                                  textColor: themeContro
                                                          .isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w400)
                                            ],
                                          ),
                                          sizeBoxHeight(5),
                                        ],
                                      )
                                    ],
                                  ),
                                ).paddingSymmetric(horizontal: 20),
                                sizeBoxHeight(20),
                                store()
                              ],
                            ),
                          );
                  }),
                ))
          ],
        ),
      ),
    );
  }

  Widget store() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label(
              'Store ',
              fontSize: 14,
              textColor: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        sizeBoxHeight(10),
        alllist().paddingAll(20)
        // SizedBox(
        //   height: Get.height * 0.7,
        //   child: GridView.builder(
        //     itemCount: 4,
        //     padding: EdgeInsets.zero,
        //     physics: const NeverScrollableScrollPhysics(),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2, // 2 items in a row
        //       childAspectRatio: 0.65, // Adjust for image and text ratio
        //       crossAxisSpacing: 10,
        //       mainAxisSpacing: 10,
        //     ),
        //     itemBuilder: (context, index) {
        //       return alllist();
        //     },
        //   ).paddingSymmetric(horizontal: 15),
        // ),
        // : Center(
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 70),
        //       child: SizedBox(
        //         height: 100,
        //         child: label("No Perfect Store Found",
        //             fontSize: 16,
        //             textColor: AppColors.brown,
        //             fontWeight: FontWeight.w500),
        //       ),
        //     ),
        //   )
        // ;
      ],
    );
  }

  // Widget storelist() {
  //   return GestureDetector(
  //     onTap: () {
  //       // Get.to(
  //       //     Details(
  //       //       serviceid: allServices.id.toString(),
  //       //     ),
  //       //     transition: Transition.rightToLeft);
  //     },
  //     child: Card(
  //       color: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         // side: BorderSide(color: Colors.grey.shade100),
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(15),
  //             topRight: Radius.circular(15),
  //             bottomLeft: Radius.circular(9),
  //             bottomRight: Radius.circular(9)),
  //       ),
  //       child: Stack(
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               Expanded(
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(15),
  //                       topRight: Radius.circular(15),
  //                       bottomLeft: Radius.circular(0),
  //                       bottomRight: Radius.circular(0)),
  //                   child: Image.network(
  //                     'https://images.pexels.com/photos/28638641/pexels-photo-28638641/free-photo-of-dramatic-view-of-manhattan-bridge-from-brooklyn-street.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     label(
  //                       'kk',
  //                       fontSize: 11,
  //                       textColor: AppColors.brown,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                     SizedBox(height: 5),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         RatingBar.builder(
  //                           itemPadding: const EdgeInsets.only(left: 1.5),
  //                           // initialRating: allServices.totalAvgReview != ''
  //                           //     ? double.parse(allServices.totalAvgReview!)
  //                           //     : 0.0,
  //                           initialRating: 2,
  //                           minRating: 0,
  //                           direction: Axis.horizontal,
  //                           allowHalfRating: true,
  //                           itemCount: 5,
  //                           itemSize: 10.5,
  //                           ignoreGestures: true,
  //                           unratedColor: Colors.grey.shade400,
  //                           itemBuilder: (context, _) => Image.asset(
  //                             'assets/images/Star.png',
  //                             height: 6,
  //                           ),
  //                           onRatingUpdate: (rating) {},
  //                         ),
  //                         SizedBox(width: 5),
  //                         label(
  //                           '(${2} Review)',
  //                           fontSize: 8,
  //                           textColor: AppColors.black,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 5),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Positioned(
  //             top: 8,
  //             right: 8,
  //             child: GestureDetector(
  //               // onTap: () {
  //               //   // Call the API to like/unlike the service
  //               //   if (homecontro.homemodel.value!.guestUser == 1) {
  //               //     snackBar('Please login to like this service');
  //               //   } else {
  //               //     likecontro.likeApi(allServices.id.toString());

  //               //     // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
  //               //     setState(() {
  //               //       allServices.isLike = allServices.isLike == 0 ? 1 : 0;
  //               //     });
  //               //   }
  //               // },
  //               child: Container(
  //                 height: 26,
  //                 width: 26,
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   color: Colors.white,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(6.0),
  //                   child: Image.asset(AppAsstes.fill_heart), // Liked
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             top: 8,
  //             left: 8,
  //             child: Container(
  //               height: 15,
  //               decoration: BoxDecoration(
  //                 color: AppColors.blue,
  //                 borderRadius: BorderRadius.circular(3),
  //               ),
  //               child: Center(
  //                 child: SizedBox(
  //                   width: 38,
  //                   child: label(
  //                     'category',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 8,
  //                     ),
  //                   ).paddingOnly(left: 4, right: 1),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 45,
  //             right: 8,
  //             child: Container(
  //               height: 15,
  //               decoration: BoxDecoration(
  //                 color: AppColors.blue,
  //                 borderRadius: BorderRadius.circular(3),
  //               ),
  //               child: Center(
  //                 child: label(
  //                   'Featured',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 8,
  //                   ),
  //                 ).paddingOnly(left: 4, right: 4),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget alllist() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: Get.height * 0.38,
          width: Get.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 0,
                color: themeContro.isLightMode.value
                    ? Colors.grey.shade300
                    : AppColors.darkGray,
                offset: const Offset(0.0, 3.0),
              ),
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            child: Image.network(
              vendorcontro
                  .vendorlistmodel.value.serviceDetails![0].serviceImages![0]
                  .toString(),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: themeContro.isLightMode.value
                  ? Colors.white
                  : AppColors.darkGray,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, top: 5, right: 12, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sizeBoxHeight(5),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(vendorcontro.vendorlistmodel
                                    .value.serviceDetails![0].vendorImage
                                    .toString()),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(width: 5),
                      label(
                        vendorcontro.vendorlistmodel.value.serviceDetails![0]
                            .vendorFirstName
                            .toString(),
                        fontSize: 11,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  label(
                    vendorcontro
                        .vendorlistmodel.value.serviceDetails![0].serviceName
                        .toString(),
                    fontSize: 12,
                    textColor: themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        itemPadding: EdgeInsets.only(left: 1.5),
                        //     initialRating: vendorcontro
                        // .vendorlistmodel.value.serviceDetails![0].averageRating
                        // .toString()= ''
                        //         ? double.parse(vendorcontro
                        // .vendorlistmodel.value.serviceDetails![0].averageRating
                        // .toString())
                        //         : 0.0,
                        initialRating: vendorcontro.vendorlistmodel.value
                                    .serviceDetails![0].averageRating
                                    .toString() !=
                                ''
                            ? double.parse(vendorcontro.vendorlistmodel.value
                                .serviceDetails![0].averageRating
                                .toString())
                            : 0.0,
                        // initialRating: 2,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 12,
                        ignoreGestures: true,
                        unratedColor: Colors.grey.shade400,
                        itemBuilder: (context, _) => Image.asset(
                          'assets/images/Star.png',
                          height: 6,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      SizedBox(width: 5),
                      label(
                        '(${vendorcontro.vendorlistmodel.value.serviceDetails![0].totalReviews.toString()} Review)',
                        fontSize: 10,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/location.png',
                          height: 13,
                          width: 13,
                          color: themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white),
                      SizedBox(width: 5),
                      SizedBox(
                        width: Get.width * 0.60,
                        child: label(
                          vendorcontro
                              .vendorlistmodel.value.serviceDetails![0].address
                              .toString(),
                          fontSize: 11,
                          maxLines: 2,
                          textColor: themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 32,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blue),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Center(
                      child: label(
                        vendorcontro
                            .vendorlistmodel.value.serviceDetails![0].priceRange
                            .toString(),
                        fontSize: 12,
                        textColor: AppColors.blue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              // Call the API to like/unlike the service
              if (SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID)
                  .isEmpty) {
                snackBar('Please login to like this service');
              } else {
                likecontro.likeApi(vendorcontro
                    .vendorlistmodel.value.serviceDetails![0].id
                    .toString());

                // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                setState(() {
                  vendorcontro.vendorlistmodel.value.serviceDetails![0].isLike =
                      vendorcontro.vendorlistmodel.value.serviceDetails![0]
                                  .isLike ==
                              0
                          ? 1
                          : 0;
                });
              }
            },
            child: Container(
              height: 26,
              width: 26,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: vendorcontro
                            .vendorlistmodel.value.serviceDetails![0].isLike ==
                        0
                    ? Image.asset(AppAsstes.heart) // Unlike
                    : Image.asset(AppAsstes.fill_heart), // Liked
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            height: 15,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: label(
                vendorcontro
                    .vendorlistmodel.value.serviceDetails![0].categoryName
                    .toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ).paddingOnly(left: 4, right: 4),
            ),
          ),
        ),
        Positioned(
          bottom: 133,
          right: 8,
          child: vendorcontro
                      .vendorlistmodel.value.serviceDetails![0].isFeatured ==
                  0
              ? SizedBox.shrink()
              : Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/energy.png',
                          height: 9,
                          width: 9,
                        ),
                        sizeBoxWidth(3),
                        label(
                          'Featured',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 4, right: 4),
                  ),
                ),
        ),
      ],
    ).paddingSymmetric(horizontal: 15);
  }
}
