// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/customer_support.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/faq.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: getProportionateScreenHeight(150),
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(AppAsstes.line_design)),
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
                    sizeBoxWidth(115),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Support",
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
            Positioned.fill(
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
                      sizeBoxHeight(15),
                      containerDesing(
                        onTap: () {
                          Get.to(const Faq());
                        },
                        img: AppAsstes.faq,
                        title: "FAQ’s",
                        height: 18,
                      ),
                      sizeBoxHeight(10),
                      containerDesing(
                        onTap: () {
                          Get.to(const CustomerSupport());
                        },
                        img: AppAsstes.customersupport,
                        title: "Customer Support",
                        height: 18,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),

      // Column(
      //   children: [
      //     appBarWidget(),
      //     Expanded(
      //         child: Column(
      //       children: [
      //         sizeBoxHeight(15),
      //         containerDesing(
      //           onTap: () {
      //             Get.to(const Faq());
      //           },
      //           img: AppAsstes.faq,
      //           title: "FAQ’s",
      //           height: 18,
      //         ),
      //         sizeBoxHeight(10),
      //         containerDesing(
      //           onTap: () {
      //             Get.to(const CustomerSupport());
      //           },
      //           img: AppAsstes.customersupport,
      //           title: "Customer Support",
      //           height: 18,
      //         ),
      //       ],
      //     )
      //     ),
      //   ],
      // )
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
                "Support",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }

  Widget containerDesing(
      {required Function() onTap,
      required String img,
      required String title,
      required double height}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getProportionateScreenHeight(55),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkGray,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 4),
                  blurRadius: 14.4,
                  spreadRadius: 0,
                  color: themeContro.isLightMode.value
                      ? Colors.grey.shade300
                      : const Color(0xff0000000f)),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(img,
                    height: height,
                    color: themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white),
                sizeBoxWidth(10),
                Text(
                  title,
                  style: poppinsFont(
                      12,
                      themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white,
                      FontWeight.w500),
                )
              ],
            ),
            Image.asset(
              'assets/images/arrow-left (1).png',
              color: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
              height: 16,
              width: 16,
            ),
          ],
        ).paddingSymmetric(horizontal: 15),
      ).paddingSymmetric(horizontal: 15),
    );
  }
}
