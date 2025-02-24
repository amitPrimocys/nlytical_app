// ignore_for_file: unnecessary_brace_in_string_interps, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/find_gridview.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/nearby_comman_widgets.dart';
import 'package:nlytical_app/utils/size_config.dart';

Widget twoText({
  required String text1,
  String text2 = "",
  Color colorText2 = Colors.red,
  Color colorText1 = AppColors.black,
  double size = 10,
  FontWeight? fontWeight,
  TextStyle? style1,
  TextStyle? style2,
  void Function()? onTap2,
  MainAxisAlignment? mainAxisAlignment,
  MainAxisSize? mainAxisSize,
}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
    mainAxisSize: mainAxisSize ?? MainAxisSize.max,
    children: [
      label(
        "${text1.tr} ",
        style: style1 ??
            poppinsFont(size, colorText1, fontWeight ?? FontWeight.normal),
      ),
      GestureDetector(
        onTap: onTap2,
        child: label(
          text2.tr,
          style: style2 ??
              poppinsFont(size, colorText2, fontWeight ?? FontWeight.normal),
        ),
      ),
    ],
  );
}

Widget findstore({
  required String imagepath,
  required String sname,
  required String cname,
  required double ratingCount,
  required String avrageReview,
  required int isLike,
  required Function() onTaplike,
  required Function() storeOnTap,
}) {
  return GestureDetector(
    onTap: storeOnTap,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // height: 200,
          width: Get.width * 0.8,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 0,
                color: Colors.grey.shade300,
                offset: const Offset(0.0, 3.0),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            ),
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
                imagepath,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 12,
          child: Container(
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: AppColors.blue,
            ),
            child: Center(
              child: SizedBox(
                // width: 40,
                child: label(
                  cname,
                  // maxLines: 1,
                  fontSize: 8,
                  // overflow: TextOverflow.ellipsis,
                  textColor: Colors.white,
                  fontWeight: FontWeight.w600,
                ).paddingSymmetric(horizontal: 5),
              ),
            ),
          ),
        ),
        Positioned.fill(
            top: 20,
            bottom: -1,
            child: FloatingScreen1(
              sname: sname,
              ratingCount: ratingCount,
              avrageReview: avrageReview,
              isLike: isLike,
              onTaplike: onTaplike,
              storeOnTap: storeOnTap,
            )),
      ],
    ),
  );
}

Widget nearbystore({
  required String imagepath,
  required String sname,
  required String cname,
  required double ratingCount,
  required String avrageReview,
  required int isLike,
  required Function() onTaplike,
  required Function() storeOnTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: storeOnTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            // height: 200,
            width: Get.width * 0.82,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  color: Colors.grey.shade300,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  imagepath,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 14,
            child: Container(
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColors.blue,
              ),
              child: Center(
                child: SizedBox(
                  // width: 40,
                  child: label(
                    cname,
                    // maxLines: 1,
                    fontSize: 8,
                    // overflow: TextOverflow.ellipsis,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ).paddingSymmetric(horizontal: 5),
                ),
              ),
            ),
          ),
          Positioned.fill(
              top: 20,
              bottom: -1,
              child: NearbyScreen(
                sname: sname,
                ratingCount: ratingCount,
                avrageReview: avrageReview,
                isLike: isLike,
                onTaplike: onTaplike,
                onTapstore: storeOnTap,
              )),
        ],
      ),
    ),
  );
}

cateWidgets({
  required String imagepath,
  required String cname,
  required Function() cateOnTap,
}) {
  return GestureDetector(
    // onTap: () {
    //   // Get.to(
    //   //     SubCategories(
    //   //       cat: categories.id.toString(),
    //   //     ),
    //   //     transition: Transition.rightToLeft);
    // },
    onTap: cateOnTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0), // Rounded corners
      child: Stack(
        children: [
          Image.network(
            imagepath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: label(
              cname,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontSize: 10,
              textColor: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ).paddingAll(8),
        ],
      ),
    ),
  );
}

allservice({
  required String imagepath,
  required String cname,
  required Function() cateOnTap,
}) {
  return GestureDetector(
    // onTap: () {
    //   // Get.to(
    //   //     SubCategories(
    //   //       cat: categories.id.toString(),
    //   //     ),
    //   //     transition: Transition.rightToLeft);
    // },
    onTap: cateOnTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0), // Rounded corners
      child: Stack(
        children: [
          Image.network(
            imagepath,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black12,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: label(
                cname,
                fontSize: 11,
                textColor: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget review({
  required String imagepath,
  required String fname,
  required double ratingCount,
  // required String content,
  required String descname,
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: Get.width,
        decoration: BoxDecoration(
            border: Border.all(
                color: themeContro.isLightMode.value
                    ? Colors.grey.shade200
                    : AppColors.darkMainBlack),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    fname,
                    style: poppinsFont(
                        10,
                        themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white,
                        FontWeight.w600),
                  ),
                ),
                RatingBar.builder(
                  itemPadding: const EdgeInsets.only(left: 1.5),
                  // initialRating: reviewcontro
                  //             .riviewlist[index].reviewStar
                  //             .toString() !=
                  //         ''
                  //     ? double.parse(reviewcontro
                  //         .riviewlist[index].reviewStar
                  //         .toString())
                  // : 0.0,
                  initialRating: ratingCount,
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
              ],
            ).paddingOnly(left: 70, right: 15, top: 5),
            sizeBoxHeight(15),
            // label(
            //   content,
            //   fontSize: 11,
            //   maxLines: 3,
            //   textColor: AppColors.black,
            //   fontWeight: FontWeight.w500,
            // ).paddingOnly(left: 10),
            // sizeBoxHeight(5),
            Text(
              descname,
              style: poppinsFont(
                  11,
                  themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
                  FontWeight.w400),
            ).paddingOnly(left: 15, right: 15),
            sizeBoxHeight(20),
          ],
        ),
      ),
      Positioned(
          top: -20,
          left: 15,
          child: Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                imagepath,
                fit: BoxFit.cover,
              ),
            ),
          )),
    ],
  );
}

Widget setting({
  required String imagepath,
  required String name,
  required Function() buttonOnTap,
}) {
  return GestureDetector(
    onTap: buttonOnTap,
    child: Container(
      height: 45,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.white),
          color: themeContro.isLightMode.value
              ? Colors.white
              : name == "Profile"
                  ? AppColors.blue
                  : AppColors.darkGray,
          boxShadow: [
            BoxShadow(
              color: themeContro.isLightMode.value
                  ? Colors.grey.shade300
                  : AppColors.darkShadowColor,
              blurRadius: 14.0,
              spreadRadius: 0.0,
              offset: const Offset(2.0, 4.0), // shadow direction: bottom right
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                imagepath,
                height: 16,
                width: 16,
                color: themeContro.isLightMode.value
                    ? Colors.black
                    : AppColors.white,
              ),
              sizeBoxWidth(6),
              label(
                name,
                fontSize: 12,
                textColor: themeContro.isLightMode.value
                    ? Colors.black
                    : AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Image.asset(
            'assets/images/arrow-left (1).png',
            color:
                themeContro.isLightMode.value ? Colors.black : AppColors.white,
            height: 16,
            width: 16,
          ),
        ],
      ).paddingSymmetric(horizontal: 15),
    ),
  );
}
