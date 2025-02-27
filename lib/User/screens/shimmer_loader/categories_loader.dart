import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

CategoriesContro catecontro = Get.put(CategoriesContro());

Widget cat(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.zero,
      itemCount: catecontro.catelist.length, // Number of items in the grid
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: themeContro.isLightMode.value
              ? Colors.grey.shade300
              : AppColors.darkGray,
          highlightColor: themeContro.isLightMode.value
              ? Colors.grey.shade100
              : AppColors.darkgray1,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        );
      },
    ),
  );
}
