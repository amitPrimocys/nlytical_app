// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/add_review_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/edit_review_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/review_contro.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/my_review_loader.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Review extends StatefulWidget {
  const Review({
    super.key,
  });

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  ReviewContro reviewcontro = Get.put(ReviewContro());
  int page = 1;
  bool isLoadingMore = false;
  // ItemScrollController _scrollController1 = ItemScrollController();
  final scrollController = ScrollController();

  AddreviewContro addreviewcontro = Get.put(AddreviewContro());
  EditReviewContro editreview = Get.put(EditReviewContro());

  final msgController = TextEditingController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    reviewcontro.reviewApi(page: page.toString());

    // Load initial data
    fetchRestaurants();

    super.initState();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true; // Start showing the loader
        page++; // Increment the page number
      });
      fetchRestaurants(); // Fetch next page data
    }
  }

  Future<void> fetchRestaurants() async {
    try {
      print('Fetching page: $page'); // Log the page number
      await reviewcontro.reviewApi(page: page.toString());

      setState(() {
        isLoadingMore = false;
      });
    } catch (error) {
      setState(() {
        isLoadingMore = false;
      });
      print("Error fetching data: $error");
    }
  }

  @override
  dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
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
                      sizeBoxWidth(100),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "My Review",
                          textAlign: TextAlign.center,
                          fontSize: 20,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      sizeBoxHeight(10),
                      Expanded(
                        child: Obx(() {
                          return reviewcontro.isfav.value &&
                                  reviewcontro.riviewlist.isEmpty
                              ? reviewlistLoader(context)
                              : SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      sizeBoxHeight(15),
                                      reeviewlist()
                                    ],
                                  ),
                                );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

        //  Column(
        //   children: [
        //     appBarWidget(),
        //     Expanded(
        //       child: Obx(() {
        //         return reviewcontro.isfav.value && reviewcontro.riviewlist.isEmpty
        //             ? reviewlistLoader(context)
        //             //  Center(
        //             //     child: CircularProgressIndicator(
        //             //     color: AppColors.blue,
        //             //   ))
        //             : SingleChildScrollView(
        //                 controller: scrollController,
        //                 child: Column(
        //                   children: [sizeBoxHeight(15), reeviewlist()],
        //                 ),
        //               );
        //       }),
        //     ),
        //   ],
        // ),
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
                'My Review',
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }

  Widget reeviewlist() {
    return reviewcontro.riviewlist.isNotEmpty
        ? ListView.builder(
            itemCount: reviewcontro.riviewlist.length + 1,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index == reviewcontro.riviewlist.length) {
                return isLoadingMore // Check if more data is being loaded
                    ? Center(
                        child: Column(
                          children: [
                            sizeBoxHeight(10),
                            CircularProgressIndicator(
                              color: AppColors.blue,
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(); // If no more data, show nothing
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  // height: Get.height * 0.19,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkGray,
                      border: Border.all(
                          color: themeContro.isLightMode.value
                              ? Colors.grey.shade200
                              : Colors.transparent),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 14,
                            spreadRadius: 0,
                            offset: Offset(2, 4))
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.9,
                          child: label(
                            reviewcontro.riviewlist[index].serviceName
                                .toString(),
                            fontSize: 14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textColor: themeContro.isLightMode.value
                                ? AppColors.brown
                                : AppColors.white,
                            fontWeight: FontWeight.w600,
                          ).paddingOnly(
                            left: 3,
                          ),
                        ),
                        sizeBoxHeight(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar.builder(
                              itemPadding: const EdgeInsets.only(left: 1.5),
                              initialRating: reviewcontro
                                          .riviewlist[index].reviewStar
                                          .toString() !=
                                      ''
                                  ? double.parse(reviewcontro
                                      .riviewlist[index].reviewStar
                                      .toString())
                                  : 0.0,
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
                            SizedBox(width: 4),
                            Text(
                              formatDateTime(DateTime.parse(
                                  reviewcontro.riviewlist[index].createdAt!)),
                              style: TextStyle(
                                fontSize: 10,
                                color: themeContro.isLightMode.value
                                    ? AppColors.black
                                    : AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        sizeBoxHeight(10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            reviewcontro.riviewlist[index].reviewMessage
                                .toString(),
                            style: poppinsFont(
                                11,
                                themeContro.isLightMode.value
                                    ? AppColors.brown
                                    : AppColors.colorFFFFFF,
                                FontWeight.w400),
                          ),
                        ),
                        sizeBoxHeight(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(reviewcontro.riviewlist[index].id);
                                editreview.reviewdelete(
                                  reviewid: reviewcontro.riviewlist[index].id
                                      .toString(),
                                );
                                reviewcontro.riviewlist.removeAt(index);
                              },
                              child: Container(
                                height: 32,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.blue),
                                child: Center(
                                  child: Text(
                                    'Delete',
                                    style: poppinsFont(
                                        11, AppColors.white, FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            sizeBoxWidth(10),
                            GestureDetector(
                              onTap: () {
                                editreview.reviewEditApi(
                                  isupdate: true,
                                  serviceId: reviewcontro
                                      .riviewlist[index].serviceId
                                      .toString(),
                                  reviewid: reviewcontro.riviewlist[index].id
                                      .toString(),
                                );
                                print('Tapped');
                                _confirmReview(index);
                              },
                              child: Container(
                                height: 32,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: themeContro.isLightMode.value
                                            ? AppColors.blue
                                            : AppColors.colorFFFFFF)),
                                child: Center(
                                  child: Text(
                                    'Edit',
                                    style: poppinsFont(
                                        11,
                                        themeContro.isLightMode.value
                                            ? AppColors.blue
                                            : AppColors.colorFFFFFF,
                                        FontWeight.w400),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        sizeBoxHeight(10),
                      ],
                    ),
                  ),
                ).paddingSymmetric(horizontal: 20),
              );
            })
        : reviewempty();
  }

  Widget reviewempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(200),
          SizedBox(
            height: 160,
            child: Image.asset(
              'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
              width: 200,
              height: 180,
            ),
          ),
          label(
            "Review not Found",
            fontSize: 18,
            textColor: themeContro.isLightMode.value
                ? AppColors.black
                : AppColors.white,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  _confirmReview(index) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              insetPadding: EdgeInsets.only(),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: StatefulBuilder(builder: (context, kk) {
                return SingleChildScrollView(
                  child: Obx(() {
                    return Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: getProportionateScreenHeight(380),
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: themeContro.isLightMode.value
                                      ? Colors.white
                                      : AppColors.darkGray),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sizeBoxHeight(30),
                                  label(
                                    'Feel Free to share your review and ratings',
                                    fontSize: 14,
                                    textColor: themeContro.isLightMode.value
                                        ? Colors.black
                                        : AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ).paddingSymmetric(horizontal: 25),
                                  sizeBoxHeight(12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: editreview.rateValue
                                            .value, // Start with 3 stars selected
                                        minRating:
                                            1, // The minimum rating the user can give is 1 star
                                        direction: Axis
                                            .horizontal, // Stars are laid out horizontally
                                        allowHalfRating:
                                            false, // Full stars only, no half-star ratings
                                        unratedColor: Colors.grey
                                            .shade400, // Color for unselected stars
                                        itemCount:
                                            5, // Total number of stars is 5
                                        itemSize: 25,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                4), // Space between stars
                                        itemBuilder: (context, _) =>
                                            Image.asset(
                                          'assets/images/star1.png',
                                          color: Color(0xffFFA41C),
                                        ),
                                        onRatingUpdate: (rating) {
                                          editreview.rateValue.value =
                                              rating; // Update the rating value

                                          print(
                                              'Select Review :- ${editreview.rateValue.value.toString().replaceAll(".0", "")}');
                                        },
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 25),
                                  sizeBoxHeight(22),
                                  TextFormField(
                                    cursorColor: themeContro.isLightMode.value
                                        ? Colors.black
                                        : AppColors.white,
                                    autofocus: false,
                                    controller: editreview.msgController,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: themeContro.isLightMode.value
                                            ? Colors.black
                                            : AppColors.white,
                                        fontWeight: FontWeight.w400),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    readOnly: false,
                                    keyboardType: TextInputType.text,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: const BorderSide(
                                              color: AppColors.blue)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      hintText: "Write Your Review....",
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      errorStyle: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 10),
                                    ),
                                  ).paddingSymmetric(horizontal: 25),
                                  sizeBoxHeight(20),
                                  Obx(() {
                                    return editreview.isedit.value
                                        ? commonLoading()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          50),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          140),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: themeContro
                                                                  .isLightMode
                                                                  .value
                                                              ? AppColors.blue
                                                              : AppColors
                                                                  .colorFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: label(
                                                      'Cancel',
                                                      fontSize: 14,
                                                      textColor: themeContro
                                                              .isLightMode.value
                                                          ? Colors.black
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              sizeBoxWidth(10),
                                              GestureDetector(
                                                onTap: () async {
                                                  // reviewcontro.riviewlist
                                                  //     .firstWhere(
                                                  //   (element) {
                                                  //     print(
                                                  //         "Element ID: ${element.id}, Review ID: ${reviewcontro.riviewlist[0].id}"); // Print both IDs
                                                  //     if (element.id
                                                  //             .toString() ==
                                                  //         reviewcontro
                                                  //             .riviewmodel
                                                  //             .value!
                                                  //             .reviewlist![0]
                                                  //             .id
                                                  //             .toString()) {
                                                  //       // When IDs match, make the API call
                                                  //       Reviewlist(
                                                  //         reviewMessage:
                                                  //             msgController
                                                  //                 .text,
                                                  //       );
                                                  //       return true; // Match found
                                                  //     }
                                                  //     return false; // No match
                                                  //   },
                                                  //   orElse: () {
                                                  //     print(
                                                  //         "No match found for Review ID: ${reviewcontro.riviewlist[0].id}");
                                                  //     return Reviewlist(
                                                  //       reviewMessage:
                                                  //           msgController.text,
                                                  //       // reviewStar: rateValue.value.toString(),
                                                  //     );
                                                  //   },
                                                  // );
                                                  editreview.reviewEditApi(
                                                      isupdate: false,
                                                      review_messsage:
                                                          editreview
                                                              .msgController
                                                              .text,
                                                      serviceId: reviewcontro
                                                          .riviewlist[index]
                                                          .serviceId
                                                          .toString(),
                                                      reviewid: reviewcontro
                                                          .riviewlist[index].id
                                                          .toString(),
                                                      reviewstar: editreview
                                                          .rateValue
                                                          .toString());
                                                  reviewcontro.riviewlist[index]
                                                          .reviewMessage =
                                                      editreview
                                                          .msgController.text;
                                                  reviewcontro.riviewlist[index]
                                                          .reviewStar =
                                                      editreview.rateValue
                                                          .toString();
                                                  reviewcontro.riviewlist
                                                      .refresh();
                                                  reviewcontro.riviewmodel
                                                      .refresh();

                                                  setState(() {});

                                                  //     widget.serviceid!,
                                                  //     rateValue
                                                  //         .toString()
                                                  //         .replaceAll(".0", ""),
                                                  //     msgController.text);
                                                  // msgController.clear();
                                                  // addreviewcontro.addreviewmodel
                                                  //     .refresh();
                                                  // setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          50),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          140),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: label(
                                                      'Edit',
                                                      fontSize: 14,
                                                      textColor: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                  })
                                ],
                              ),
                            ),
                            Positioned(
                                top: -40,
                                child: Container(
                                  height: 58,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: themeContro.isLightMode.value
                                          ? Colors.white
                                          : AppColors.darkgray1,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.12),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(0.0,
                                              2.0), // shadow direction: bottom right
                                        )
                                      ],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(22),
                                          topLeft: Radius.circular(22),
                                          bottomRight: Radius.circular(22),
                                          topRight: Radius.circular(22))),
                                  child: Center(
                                    child: label(
                                      'Review & Rating',
                                      fontSize: 18,
                                      textAlign: TextAlign.center,
                                      textColor: themeContro.isLightMode.value
                                          ? Colors.black
                                          : AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    );
                  }),
                );
              }),
            ),
          );
        });
  }
}
