// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;

Widget BusinessLoader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white12
          : Colors.grey.shade300,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          storeContainer(context)
              .paddingSymmetric(
                horizontal: 20,
              )
              .paddingOnly(top: 30),
          Text(
            "User Review",
            style: poppinsFont(15, AppColors.black, FontWeight.w600),
          ).paddingSymmetric(horizontal: 25),
          sizeBoxHeight(20),
          reviewContainer().paddingSymmetric(horizontal: 20, vertical: 5),
        ],
      ),
    ),
  );
}

Widget reviewContainer() {
  return ListView.builder(
      itemCount: 0,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white12
              : Colors.grey.shade300,
          highlightColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white24
              : Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '',
                style: poppinsFont(11, AppColors.black, FontWeight.w600),
              ).paddingSymmetric(horizontal: 85, vertical: 5),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                      // boxShadow: const [
                      //   BoxShadow(
                      //     blurRadius: 14.4,
                      //     spreadRadius: 0,
                      //     offset: Offset(2.0, 4.0),
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sizeBoxHeight(8),
                        RatingBar.builder(
                          initialRating: 0, // Start with 3 stars selected
                          minRating:
                              0, // The minimum rating the user can give is 1 star
                          direction: Axis
                              .horizontal, // Stars are laid out horizontally
                          allowHalfRating:
                              false, // Full stars only, no half-star ratings
                          unratedColor: const Color.fromARGB(
                              255, 241, 210, 162), // Color for unselected stars
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
                          '(${0} Review)',
                          style: poppinsFont(
                              10, AppColors.color535353, FontWeight.w500),
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
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 14.4,
                            spreadRadius: 0,
                            color: Colors.black12,
                            offset: Offset(2.0, 4.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ).paddingOnly(bottom: 20),
            ],
          ),
        );
      });
}

Widget storeContainer(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.white12
        : Colors.grey.shade300,
    highlightColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.white24
        : Colors.grey.shade100,
    child: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
                // color: Colors.white,
                // boxShadow: const [
                //   BoxShadow(
                //     blurRadius: 14.4,
                //     spreadRadius: 0,
                //     color: Colors.black12,
                //     offset: Offset(2.0, 4.0),
                //   ),
                // ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizeBoxHeight(50),
                  Text(
                    '',
                    style: poppinsFont(13, AppColors.black, FontWeight.w600),
                  ),
                  sizeBoxHeight(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 0, // Start with 3 stars selected
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
                        '(${0} Review)',
                        fontSize: 8,
                        textColor: AppColors.black,
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
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 14.4,
                      spreadRadius: 0,
                      color: Colors.black12,
                      offset: Offset(2.0, 4.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ).paddingOnly(bottom: 25),
      ],
    ),
  );
}
