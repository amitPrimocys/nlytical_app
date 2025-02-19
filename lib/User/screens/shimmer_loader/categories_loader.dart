// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nlytical_app/Vendor/utils/colors.dart';
// import 'package:nlytical_app/User/utils/comman_widgets.dart';
// import 'package:nlytical_app/utils/size_config.dart';
// import 'package:shimmer/shimmer.dart';

// double? h, w;

// Widget CategoriesLoader(BuildContext context) {
//   h = MediaQuery.sizeOf(context).height;
//   w = MediaQuery.sizeOf(context).width;
//   return SingleChildScrollView(
//     child: SizedBox(
//       width: Get.width,
//       child: GridView.builder(
//         itemCount: 20,
//         // physics: const AlwaysScrollableScrollPhysics(),
//         // padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 0.0,
//           mainAxisSpacing: 10.0,
//           childAspectRatio: 1, // To ensure the grid is square
//         ),
//         itemBuilder: (context, index) {
//           return Shimmer.fromColors(
//             baseColor: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white12
//                 : Colors.grey.shade200,
//             highlightColor: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white24
//                 : Colors.grey.shade100,
//             child: Container(
//               height: 80,
//               width: 150,
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(10)),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
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
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
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
