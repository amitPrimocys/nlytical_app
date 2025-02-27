// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/nearby_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;
NearbyContro nearcontro = Get.find();

Widget nearbyListLoader(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(vertical: 15),

        // physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
          childAspectRatio: (itemWidth / itemHeight * 1.6),
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
        ),
        itemCount: nearcontro.nearbylist.length,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
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
                                  '(${''} \Review)',
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
