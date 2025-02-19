import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/review_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;

ReviewContro reviewcontro = Get.put(ReviewContro());

Widget reviewlistLoader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkColor
                  : Colors.white,
            ),
            child: ListView.builder(
                itemCount: reviewcontro.riviewlist.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Shimmer.fromColors(
                      baseColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.grey.shade300,
                      highlightColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white24
                              : Colors.grey.shade100,
                      child: Container(
                        height: Get.height * 0.19,
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(60),
                                    width: getProportionateScreenWidth(60),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          sizeBoxWidth(15),
                                          Container(
                                            height: 13,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 5),
                                              ),
                                            ),
                                          ),
                                          sizeBoxWidth(Get.width * 0.42),
                                          Container(
                                            height: 13,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      sizeBoxHeight(8),
                                      label(
                                        '',
                                        fontSize: 11,
                                        textColor: AppColors.brown,
                                        fontWeight: FontWeight.w600,
                                      ).paddingSymmetric(horizontal: 15),
                                    ],
                                  )
                                ],
                              ),
                              sizeBoxHeight(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    itemPadding:
                                        const EdgeInsets.only(left: 1.5),
                                    // initialRating: reviewcontro
                                    //             .riviewlist[index].reviewStar
                                    //             .toString() !=
                                    //         ''
                                    //     ? double.parse(reviewcontro
                                    //         .riviewlist[index].reviewStar
                                    //         .toString())
                                    //     : 0.0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 14.5,
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey.shade400,
                                    itemBuilder: (context, _) => Image.asset(
                                      'assets/images/Star.png',
                                      height: 16,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  const SizedBox(width: 4),
                                ],
                              ),
                              sizeBoxHeight(10),
                              label(
                                '',
                                fontSize: 9,
                                maxLines: 3,
                                textColor: AppColors.brown,
                                fontWeight: FontWeight.w400,
                              )
                            ],
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 20),
                    ),
                  );
                })),
      ],
    ),
  );
}
