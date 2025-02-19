// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;

Widget location_list_loader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Column(
      children: [sizeBoxHeight(15), allstore()],
    ),
  );
}

Widget allstore() {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            sizeBoxHeight(10),
            Shimmer.fromColors(
              baseColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white12
                  : Colors.grey.shade300,
              highlightColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white24
                  : Colors.grey.shade100,
              child: Container(
                height: getProportionateScreenHeight(120),
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Row(
                  children: [
                    Container(
                      height: getProportionateScreenHeight(120),
                      width: getProportionateScreenWidth(130),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(9),
                            bottomLeft: Radius.circular(9)),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizeBoxHeight(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            sizeBoxWidth(10),
                            Container(
                              height: 13,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 5),
                                ),
                              ),
                            ),
                            sizeBoxWidth(130),
                            Container(
                                height: 26,
                                width: 26,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blue1),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset(AppAsstes.fill_heart),
                                ))
                          ],
                        ),
                        label(
                          '',
                          fontSize: 11,
                          textColor: AppColors.brown,
                          fontWeight: FontWeight.w600,
                        ).paddingOnly(left: 10),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            sizeBoxWidth(10),
                            Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blue1),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset(
                                    'assets/images/location1.png',
                                    color: Colors.black,
                                  ),
                                )),
                            sizeBoxWidth(10),
                            SizedBox(
                              width: 155,
                              child: label(
                                '',
                                maxLines: 1,
                                fontSize: 9,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        sizeBoxHeight(6),
                        Row(
                          children: [
                            sizeBoxWidth(10),
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
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            SizedBox(width: 5),
                            label(
                              '(Review)',
                              fontSize: 8,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ).paddingSymmetric(horizontal: 20),
            )
          ],
        );
      });
}
