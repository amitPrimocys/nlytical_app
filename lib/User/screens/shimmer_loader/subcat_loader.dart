// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;

CategoriesContro subcatecontro = Get.put(CategoriesContro());

Widget SubcatLoader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Column(
      children: [
        sizeBoxHeight(18),
        Container(
            decoration: BoxDecoration(
              color: !themeContro.isLightMode.value
                  ? AppColors.darkColor
                  : Colors.white,
            ),
            child: ListView.builder(
                itemCount: subcatecontro.subcatelist.length,
                padding: const EdgeInsets.symmetric(vertical: 5),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: !themeContro.isLightMode.value
                        ? Colors.white12
                        : Colors.grey.shade300,
                    highlightColor: !themeContro.isLightMode.value
                        ? Colors.white24
                        : Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 45,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            label(
                              '',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            Image.asset(
                              'assets/images/arrow-left (1).png',
                              color: AppColors.black,
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 15),
                      ).paddingSymmetric(horizontal: 15),
                    ),
                  );
                })),
      ],
    ),
  );
}
