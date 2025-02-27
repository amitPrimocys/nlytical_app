import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;

Widget profiledetailsLoader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
            decoration: const BoxDecoration(),
            child: Shimmer.fromColors(
              baseColor: themeContro.isLightMode.value
                  ? Colors.grey.shade300
                  : Colors.white12,
              highlightColor: themeContro.isLightMode.value
                  ? Colors.grey.shade100
                  : Colors.white24,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizeBoxHeight(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // openBottomForImagePick(context);
                            },
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(100),
                                  width: getProportionateScreenWidth(100),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blue1,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          color: AppColors.blue1,
                                        )
                                      ]),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                      border: Border.all(
                                        width: 2.5,
                                      ),
                                    ),
                                    child: ClipOval(
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.network(
                                        '',
                                        fit: BoxFit.cover,
                                      ),
                                    ).paddingAll(3),
                                  ).paddingAll(3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizeBoxHeight(5),
                    sizeBoxHeight(8),
                    GestureDetector(
                      child: Center(
                        child: label(
                          "Select Your Profile",
                          maxLines: 2,
                          textColor: AppColors.greyColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    sizeBoxHeight(28),
                    label(
                      'First Name',
                      fontSize: 11,
                      textColor: AppColors.brown,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      height: 45,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                    ),
                    sizeBoxHeight(17),
                    label(
                      'Last Name',
                      fontSize: 11,
                      textColor: AppColors.brown,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      height: 45,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                    ),
                    sizeBoxHeight(17),
                    label(
                      'Email Address',
                      fontSize: 11,
                      textColor: AppColors.brown,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      height: 45,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                    ),
                    sizeBoxHeight(15),
                    label(
                      'Mobile Number',
                      fontSize: 11,
                      textColor: AppColors.brown,
                      fontWeight: FontWeight.w500,
                    ),
                    sizeBoxHeight(4),
                    Container(
                      height: 45,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                    ),
                    sizeBoxHeight(17),
                    sizeBoxHeight(25),
                    // globButton(
                    //   name: "Save",
                    //   gradient: AppColors.logoColork,
                    //   onTap: () {},
                    // ).paddingSymmetric(horizontal: 20),
                    Center(
                      child: Container(
                        height: 50,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.white),
                        child: Center(
                          child: label(
                            "Submit",
                            textColor: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    sizeBoxHeight(50),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            )),
      ],
    ),
  );
}
