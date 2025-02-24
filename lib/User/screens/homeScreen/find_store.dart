// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class FindStore extends StatefulWidget {
  const FindStore({super.key});

  @override
  State<FindStore> createState() => _FindStoreState();
}

class _FindStoreState extends State<FindStore> {
  HomeContro homecontro = Get.put(HomeContro());
  LikeContro likecontro = Get.put(LikeContro());

  @override
  void initState() {
    homecontro.homeApi(
      latitudee: Latitude,
      longitudee: Longitude,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
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
                      sizeBoxWidth(40),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "Find Your Perfect Store",
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
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            store(),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

        // Column(
        //   children: [
        //     appBarWidget(),
        //     Expanded(
        //         child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           store(),
        //         ],
        //       ),
        //     )
        //     ),
        //   ],
        // ),
        );
  }

  Widget store() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the maxCrossAxisExtent based on the screen width
    double maxCrossAxisExtent =
        screenWidth / 2; // You can adjust this value as needed

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return homecontro.allcatelist.isNotEmpty
        ? GridView.builder(
            itemCount: homecontro.allcatelist.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items in a row
              childAspectRatio: 0.58, // Adjust for image and text ratio
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return CommanScreen(
                storeImages:
                    homecontro.allcatelist[index].serviceImages![0].toString(),
                sname: homecontro
                    .allcatelist[index].serviceName!.capitalizeFirst
                    .toString(),
                cname: homecontro
                    .allcatelist[index].categoryName!.capitalizeFirst
                    .toString(),
                vname: homecontro.allcatelist[index].vendorFirstName.toString(),
                vendorImages:
                    homecontro.allcatelist[index].vendorImage.toString(),
                isfeatured: homecontro.allcatelist[index].isFeatured!,
                ratingCount:
                    homecontro.allcatelist[index].totalAvgReview!.isNotEmpty
                        ? double.parse(
                            homecontro.allcatelist[index].totalAvgReview!)
                        : 0,
                avrageReview:
                    homecontro.allcatelist[index].totalReviewCount!.toString(),
                isLike:
                    userID.isEmpty ? 0 : homecontro.allcatelist[index].isLike!,
                onTaplike: () {
                  if (userID.isEmpty) {
                    snackBar('Please login to like this service');
                  } else {
                    for (var i = 0; i < homecontro.nearbylist.length; i++) {
                      if (homecontro.allcatelist[index].id ==
                          homecontro.nearbylist[i].id) {
                        print("ID MATCHED");
                        if (homecontro.nearbylist[i].isLike == 0) {
                          homecontro.nearbylist[i].isLike = 1;
                        } else {
                          homecontro.nearbylist[i].isLike = 0;
                        }
                        homecontro.nearbylist.refresh();
                      }
                    }
                    likecontro
                        .likeApi(homecontro.allcatelist[index].id.toString());

                    // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                    setState(() {
                      homecontro.allcatelist[index].isLike =
                          homecontro.allcatelist[index].isLike == 0 ? 1 : 0;
                      for (int i = 0; i < homecontro.allcatelist.length; i++) {
                        if (homecontro.allcatelist[i].id ==
                            homecontro.nearbylist[index].id) {
                          homecontro.allcatelist[i].isLike =
                              homecontro.nearbylist[index].isLike;
                        }
                      }
                    });
                  }
                },
                onTapstore: () {
                  Get.to(
                      Details(
                        serviceid: homecontro.allcatelist[index].id.toString(),
                        latt: homecontro.allcatelist[index].lat.toString(),
                        longg: homecontro.allcatelist[index].lon.toString(),
                      ),
                      transition: Transition.rightToLeft);
                },
                location: homecontro.allcatelist[index].address.toString(),
                price: 'From \$252-565',
              );

              // findstore(
              //     imagepath: homecontro.allcatelist[index].serviceImages![0]
              //         .toString(),
              //     sname: homecontro.allcatelist[index].serviceName!,
              //     cname: homecontro.allcatelist[index].categoryName!,
              //     ratingCount:
              //         homecontro.allcatelist[index].totalAvgReview!.isEmpty
              //             ? 0.00
              //             : double.parse(
              //                 homecontro.allcatelist[index].totalAvgReview!),
              //     avrageReview: homecontro.allcatelist[index].totalReviewCount!
              //         .toString(),
              //     isLike: homecontro.homemodel.value!.guestUser == 1
              //         ? 0
              //         : homecontro.allcatelist[index].isLike!,
              //     onTaplike: () {
              //       if (homecontro.homemodel.value!.guestUser == 1) {
              //         snackBar('Please login to like this service');
              //       } else {
              //         likecontro
              //             .likeApi(homecontro.allcatelist[index].id.toString());

              //         // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
              //         setState(() {
              //           homecontro.allcatelist[index].isLike =
              //               homecontro.allcatelist[index].isLike == 0 ? 1 : 0;
              //         });
              //       }
              //     },
              //     storeOnTap: () {
              //       Get.to(
              //           Details(
              //             serviceid:
              //                 homecontro.allcatelist[index].id.toString(),
              //             latt: homecontro.allcatelist[index].lat.toString(),
              //             longg: homecontro.allcatelist[index].lon.toString(),
              //           ),
              //           transition: Transition.rightToLeft);
              //     });
            },
          ).paddingSymmetric(horizontal: 15, vertical: 15)
        : Center(
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
                  "No Perfect Store Found",
                  fontSize: 18,
                  textColor: AppColors.brown,
                  fontWeight: FontWeight.w500,
                )
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
                'Find Your Perfect Store',
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }
}
