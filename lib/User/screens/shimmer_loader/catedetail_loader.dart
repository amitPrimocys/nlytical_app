// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/subcate_service_contro.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;

SubcateserviceContro subcateservicecontro = Get.put(SubcateserviceContro());

Widget catedetail_Loader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Column(
      children: [
        sizeBoxHeight(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label(
              'Featured Stores',
              fontSize: 14,
              textColor: Colors.grey.shade300,
              fontWeight: FontWeight.w600,
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        sizeBoxHeight(15),
        storelist(),
        sizeBoxHeight(15),
        Align(
          alignment: Alignment.topLeft,
          child: label(
            'All Stores',
            fontSize: 14,
            textColor: Colors.grey.shade300,
            fontWeight: FontWeight.w600,
          ).paddingSymmetric(horizontal: 20),
        ),
        allstore(context)
      ],
    ),
  );
}

Widget storelist() {
  return SizedBox(
    height: 240,
    child: ListView.builder(
      itemCount: subcateservicecontro.subcatelist.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Shimmer.fromColors(
            baseColor: !themeContro.isLightMode.value
                ? Colors.white12
                : Colors.grey.shade300,
            highlightColor: !themeContro.isLightMode.value
                ? Colors.white24
                : Colors.grey.shade100,
            child: SizedBox(
              width: 290,
              // Set the width for each Card
              child: GestureDetector(
                onTap: () {
                  // Get.to(Details(), transition: Transition.rightToLeft);
                },
                child: Card(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                label(
                                  '',
                                  fontSize: 11,
                                  textColor: AppColors.brown,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                      itemPadding:
                                          const EdgeInsets.only(left: 1.5),
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 10.5,
                                      ignoreGestures: true,
                                      unratedColor: Colors.grey.shade400,
                                      itemBuilder: (context, _) => Image.asset(
                                        'assets/images/Star.png',
                                        height: 6,
                                        color: Colors.grey,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    SizedBox(width: 5),
                                    label(
                                      '(Review)',
                                      fontSize: 8,
                                      textColor: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 40,
                        right: 8,
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(AppAsstes.heart)),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          height: 13,
                          width: 45,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget allstore(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;

  double screenWidth = MediaQuery.of(context).size.width;

  // Determine the maxCrossAxisExtent based on the screen width
  double maxCrossAxisExtent =
      screenWidth / 2; // You can adjust this value as needed

  var size = MediaQuery.of(context).size;

  /*24 is for notification bar on Android*/
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;
  return SizedBox(
    height: Get.height,
    child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 15),

        // physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
          childAspectRatio: (itemWidth / itemHeight * 1.6),
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
        ),
        itemCount: subcateservicecontro.allcatelist.length,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            // baseColor: Theme.of(context).brightness == Brightness.dark
            //     ? Colors.white12
            //     : Colors.grey.shade200,
            // highlightColor:
            //     Theme.of(context).brightness == Brightness.dark
            //         ? Colors.white24
            //         : Colors.grey.shade100,
            baseColor: !themeContro.isLightMode.value
                ? Colors.white12
                : Colors.grey.shade300,
            highlightColor: !themeContro.isLightMode.value
                ? Colors.white24
                : Colors.grey.shade100,
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                // side: BorderSide(color: Colors.grey.shade100),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9)),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            label(
                              '',
                              fontSize: 11,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  itemPadding: const EdgeInsets.only(left: 1.5),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 10.5,
                                  ignoreGestures: true,
                                  unratedColor: Colors.grey.shade400,
                                  itemBuilder: (context, _) => Image.asset(
                                    'assets/images/Star.png',
                                    height: 6,
                                    color: Colors.grey.shade200,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                const SizedBox(width: 5),
                                label(
                                  '(${''} Review)',
                                  fontSize: 8,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 40,
                      right: 8,
                      child: Container(
                          height: 26,
                          width: 26,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              'assets/images/fill_heart.png',
                              color: Colors.grey.shade200,
                            ),
                          ))),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      height: 13,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColors.blue1),
                      child: const Center(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.grey, fontSize: 5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).paddingSymmetric(
      horizontal: 15,
    ),
  );
}
