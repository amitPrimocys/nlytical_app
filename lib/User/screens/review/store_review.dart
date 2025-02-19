// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/service_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class StoreReview extends StatefulWidget {
  const StoreReview({super.key});

  @override
  State<StoreReview> createState() => _StoreReviewState();
}

class _StoreReviewState extends State<StoreReview> {
  ServiceContro servicecontro = Get.put(ServiceContro());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.appbar,
        //   automaticallyImplyLeading: false,
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
        //       label(
        //         'Review',
        //         fontSize: 20,
        //         textColor: Colors.black,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ],
        //   ),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        label(
                          'Customer Reviews',
                          fontSize: 12,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ).paddingOnly(left: 14, right: 14, top: 14, bottom: 5),
                    sizeBoxHeight(10),
                    servicecontro.servicemodel.value!.serviceDetail!.reviews!
                            .isNotEmpty
                        ? ListView.builder(
                            itemCount: servicecontro.servicemodel.value!
                                .serviceDetail!.reviews!.length
                                .clamp(0, 3),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return review(
                                      fname:
                                          '${servicecontro.servicemodel.value!.serviceDetail!.reviews![index].firstName.toString() + " " + servicecontro.servicemodel.value!.serviceDetail!.reviews![index].lastName.toString()}',
                                      descname: servicecontro
                                          .servicemodel
                                          .value!
                                          .serviceDetail!
                                          .reviews![index]
                                          .reviewMessage
                                          .toString(),
                                      // content: 'super',
                                      imagepath: servicecontro
                                          .servicemodel
                                          .value!
                                          .serviceDetail!
                                          .reviews![index]
                                          .image
                                          .toString(),
                                      ratingCount: servicecontro
                                                  .servicemodel
                                                  .value!
                                                  .serviceDetail!
                                                  .reviews![index]
                                                  .reviewStar
                                                  .toString() !=
                                              ''
                                          ? double.parse(servicecontro
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .reviews![index]
                                              .reviewStar
                                              .toString())
                                          : 0.0)
                                  .paddingSymmetric(horizontal: 15, vertical: 15);
                            })
                        : Center(
                            child: Column(
                              children: [
                                sizeBoxHeight(130),
                                label(
                                  'Review not',
                                  fontSize: 16,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                label(
                                  'Found',
                                  fontSize: 16,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                sizeBoxHeight(130),
                              ],
                            ).paddingSymmetric(horizontal: 10),
                          ),
                  ],
                ).paddingSymmetric(horizontal: 10),
              ),
            ),
          ],
        ));
  }

  // Widget review() {
  //   return Stack(
  //     clipBehavior: Clip.none,
  //     children: [
  //       Container(
  //         width: Get.width,
  //         decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey.shade200),
  //             borderRadius: BorderRadius.circular(10)),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Serena Williams',
  //                   style: TextStyle(color: Colors.black, fontSize: 10),
  //                 ),
  //                 RatingBar.builder(
  //                   itemPadding: const EdgeInsets.only(left: 1.5),
  //                   // initialRating: reviewcontro
  //                   //             .riviewlist[index].reviewStar
  //                   //             .toString() !=
  //                   //         ''
  //                   //     ? double.parse(reviewcontro
  //                   //         .riviewlist[index].reviewStar
  //                   //         .toString())
  //                   // : 0.0,
  //                   minRating: 0,
  //                   direction: Axis.horizontal,
  //                   allowHalfRating: true,
  //                   itemCount: 5,
  //                   itemSize: 14.5,
  //                   ignoreGestures: true,
  //                   unratedColor: Colors.grey.shade400,
  //                   itemBuilder: (context, _) => Image.asset(
  //                     'assets/images/Star.png',
  //                     height: 16,
  //                   ),
  //                   onRatingUpdate: (rating) {},
  //                 ),
  //               ],
  //             ).paddingOnly(left: 85, right: 15, top: 7),
  //             sizeBoxHeight(15),
  //             label(
  //               'Superb',
  //               fontSize: 11,
  //               maxLines: 3,
  //               textColor: AppColors.black,
  //               fontWeight: FontWeight.w500,
  //             ).paddingOnly(left: 10),
  //             sizeBoxHeight(5),
  //             label(
  //               'fabric quality is super and color fading is super no damage, comfortable fit and Fabric is also too good and there is no. Damage in the product.',
  //               fontSize: 9,
  //               maxLines: 3,
  //               textColor: AppColors.brown,
  //               fontWeight: FontWeight.w400,
  //             ).paddingOnly(left: 10),
  //             sizeBoxHeight(10),
  //           ],
  //         ),
  //       ),
  //       Positioned(
  //           top: -25,
  //           left: 20,
  //           child: Container(
  //             decoration: const BoxDecoration(shape: BoxShape.circle),
  //             child: Container(
  //               height: 55,
  //               width: 55,
  //               decoration: const BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   image: DecorationImage(
  //                       image: NetworkImage(
  //                         "https://images.pexels.com/photos/26385142/pexels-photo-26385142/free-photo-of-hudsons-bay-department-store-in-victoria-in-canada.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
  //                       ),
  //                       fit: BoxFit.fill)),
  //             ),
  //           )),
  //     ],
  //   );
  // }

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
                'Review',
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }
}
