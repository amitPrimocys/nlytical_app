// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/controllers/vendor_controllers/business_review_controller.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/shimmer_Loader/business_review.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

import '../../../auth/splash.dart';

class MyReviewScreen extends StatefulWidget {
  const MyReviewScreen({super.key});

  @override
  State<MyReviewScreen> createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  BusinessReviewController businessreviewcontro =
      Get.put(BusinessReviewController());

  @override
  void initState() {
    businessreviewcontro.businessReviewApi();
    // Load initial data

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        backgroundColor: Colors.white,
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
                      sizeBoxWidth(80),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "Business Reviews",
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
                    decoration: BoxDecoration(
                        color: themeContro.isLightMode.value
                            ? Colors.white
                            : AppColors.darkMainBlack,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        sizeBoxHeight(20),
                        Expanded(child: Obx(() {
                          return businessreviewcontro.isLoading.value
                              ?
                              //  reviewlistLoader(context)
                              BusinessLoader(context)
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      storeContainer()
                                          .paddingSymmetric(
                                            horizontal: 20,
                                          )
                                          .paddingOnly(top: 30),
                                      Text(
                                        "User Review",
                                        style: poppinsFont(
                                            15,
                                            themeContro.isLightMode.value
                                                ? AppColors.darkMainBlack
                                                : Colors.white,
                                            FontWeight.w600),
                                      ).paddingSymmetric(horizontal: 25),
                                      sizeBoxHeight(20),
                                      reviewContainer().paddingSymmetric(
                                          horizontal: 20, vertical: 5),
                                    ],
                                  ),
                                );
                        }))
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget reviewContainer() {
    return businessreviewcontro
            .businessriviewmodel.value!.userReviews!.isNotEmpty
        ? ListView.builder(
            itemCount: businessreviewcontro
                .businessriviewmodel.value!.userReviews!.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${businessreviewcontro.businessriviewmodel.value!.userReviews![index].firstName}  ${businessreviewcontro.businessriviewmodel.value!.userReviews![index].lastName}",
                    style: poppinsFont(
                        11,
                        themeContro.isLightMode.value
                            ? AppColors.darkMainBlack
                            : Colors.white,
                        FontWeight.w600),
                  ).paddingSymmetric(horizontal: 85, vertical: 5),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: themeContro.isLightMode.value
                          //       ? AppColors.darkMainBlack
                          //       : Colors.white,
                          // ),
                          color: themeContro.isLightMode.value
                              ? Colors.white
                              : AppColors.darkGray,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 14.4,
                              spreadRadius: 0,
                              color: Colors.black12,
                              offset: Offset(2.0, 4.0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sizeBoxHeight(8),
                            RatingBar.builder(
                              initialRating: businessreviewcontro
                                          .businessriviewmodel
                                          .value!
                                          .userReviews![index]
                                          .reviewStar !=
                                      ''
                                  ? double.parse(businessreviewcontro
                                      .businessriviewmodel
                                      .value!
                                      .userReviews![index]
                                      .reviewStar
                                      .toString())
                                  : 0.0, // Start with 3 stars selected
                              minRating:
                                  0, // The minimum rating the user can give is 1 star
                              direction: Axis
                                  .horizontal, // Stars are laid out horizontally
                              allowHalfRating:
                                  false, // Full stars only, no half-star ratings
                              unratedColor: const Color.fromARGB(255, 241, 210,
                                  162), // Color for unselected stars
                              itemCount: 5, // Total number of stars is 5
                              itemSize: 14,
                              ignoreGestures: true,
                              itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 2), // Space between stars
                              itemBuilder: (context, _) => Image.asset(
                                'assets/images/star1.png',
                                color: const Color(0xffFFA41C),
                              ),
                              onRatingUpdate: (rating) {},
                            ).paddingSymmetric(horizontal: 60),
                            sizeBoxHeight(20),
                            Text(
                              businessreviewcontro.businessriviewmodel.value!
                                  .userReviews![index].reviewMessage
                                  .toString(),
                              style: poppinsFont(
                                  11,
                                  themeContro.isLightMode.value
                                      ? AppColors.darkMainBlack
                                      : Colors.white,
                                  FontWeight.w500),
                            ),
                            sizeBoxHeight(20),
                          ],
                        ).paddingSymmetric(horizontal: 22),
                      ),
                      Positioned(
                        top: -23,
                        left: 23,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    businessreviewcontro.businessriviewmodel
                                        .value!.userReviews![index].image
                                        .toString(),
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      )
                    ],
                  ).paddingOnly(bottom: 20),
                ],
              );
            })
        : reviewempty();
  }

  Widget storeContainer() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: themeContro.isLightMode.value
                      ? Colors.white
                      : AppColors.darkMainBlack,
                ),
                color: themeContro.isLightMode.value
                    ? Colors.white
                    : AppColors.darkGray,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 14.4,
                    spreadRadius: 0,
                    color: themeContro.isLightMode.value
                        ? const Color.fromARGB(33, 33, 33, 1)
                        : Colors.black12,
                    offset: const Offset(2.0, 4.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizeBoxHeight(50),
                  Text(
                    businessreviewcontro
                        .businessriviewmodel.value!.serviceDetails!.serviceName!
                        .toString(),
                    style: poppinsFont(
                        13,
                        themeContro.isLightMode.value
                            ? AppColors.darkMainBlack
                            : Colors.white,
                        FontWeight.w600),
                  ),
                  sizeBoxHeight(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: businessreviewcontro.businessriviewmodel
                                    .value!.serviceDetails!.totalAvgReview!
                                    .toString() !=
                                ''
                            ? double.parse(businessreviewcontro
                                .businessriviewmodel
                                .value!
                                .serviceDetails!
                                .totalAvgReview!
                                .toString())
                            : 0.0, // Start with 3 stars selected
                        minRating:
                            0, // The minimum rating the user can give is 1 star
                        direction:
                            Axis.horizontal, // Stars are laid out horizontally
                        allowHalfRating:
                            false, // Full stars only, no half-star ratings
                        unratedColor: const Color.fromARGB(
                            255, 241, 210, 162), // Color for unselected stars
                        itemCount: 5, // Total number of stars is 5
                        itemSize: 12,
                        ignoreGestures: true,
                        itemPadding: const EdgeInsets.symmetric(
                            horizontal: 2), // Space between stars
                        itemBuilder: (context, _) => Image.asset(
                          'assets/images/star1.png',
                          color: const Color(0xffFFA41C),
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(width: 5),
                      label(
                        '(${businessreviewcontro.businessriviewmodel.value!.serviceDetails!.totalReviewCount!.toString()} Review)',
                        fontSize: 8,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.darkMainBlack
                            : Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  sizeBoxHeight(20),
                ],
              ).paddingSymmetric(horizontal: 12),
            ),
            Positioned(
              top: -30,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    image: DecorationImage(
                        image: NetworkImage(businessreviewcontro
                            .businessriviewmodel
                            .value!
                            .serviceDetails!
                            .serviceImages![0]
                            .toString()),
                        fit: BoxFit.fill)),
              ),
            )
          ],
        ).paddingOnly(bottom: 25),
      ],
    );
  }

  Widget reviewempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(Get.height * 0.2),
          Image.asset(
            "assets/images/empty_image.png",
            height: 75,
          ),
          sizeBoxHeight(10),
          label("User Review Not Found",
              fontSize: 17,
              textColor: themeContro.isLightMode.value
                  ? AppColors.darkMainBlack
                  : Colors.white,
              fontWeight: FontWeight.w500)
        ],
      ),
    );
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
              label(
                "Business Reviews",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }
}
