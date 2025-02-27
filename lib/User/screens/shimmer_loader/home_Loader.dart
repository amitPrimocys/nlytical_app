// ignore_for_file: prefer_const_constructors, unused_element, file_names

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;
List<String> imageUrls = [
  'assets/images/Mask group (2).png',
  'assets/images/Mask group (2).png',
  'assets/images/Mask group (2).png',
];

Widget homeLoader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Column(
      children: [
        sizeBoxHeight(5),
        _poster2(context, imageUrls),
        sizeBoxHeight(5),
        category(context),
        sizeBoxHeight(10),
        Shimmer.fromColors(
          baseColor: themeContro.isLightMode.value
              ? Colors.grey.shade300
              : Colors.white12,
          highlightColor: themeContro.isLightMode.value
              ? Colors.grey.shade100
              : Colors.white24,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  label(
                    'Nearby Stores',
                    fontSize: 14,
                    textColor: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
              sizeBoxHeight(18),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 5),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 80,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        sizeBoxHeight(22),
        store(context),
        sizeBoxHeight(10),
      ],
    ),
  );
}

Widget _app(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.grey,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label(
            'Hello',
            fontSize: 19,
            textColor: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/location1.png',
                height: 15,
                color: Colors.greenAccent,
              ),
              label(
                'United Kingdom',
                fontSize: 14,
                textColor: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
              ),
            ],
          )
        ],
      ),
      actions: [
        Container(
          height: getProportionateScreenHeight(40),
          width: getProportionateScreenWidth(40),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.grey.shade200),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppAsstes.search),
          ),
        ).paddingSymmetric(horizontal: 10)
      ],
    ),
  );
}

Widget _poster2(BuildContext context, List<String> imageUrls) {
  Widget carousel = Stack(
    children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: ImageSlideshow(
          initialPage: 0, // You can set this to any valid index
          autoPlayInterval: 3000,
          isLoop: true,
          indicatorColor: AppColors.white,
          indicatorBackgroundColor: Colors.grey.shade400,
          indicatorRadius: 3,
          children: imageUrls.map((img) {
            return shimmerLoader(180, Get.width, 15);
          }).toList(),
        ),
      ),
    ],
  );

  return Container(
    height: 200,
    width: Get.width,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: carousel.paddingSymmetric(horizontal: 4),
    ),
  );
}

Widget category(BuildContext context) {
  return Shimmer.fromColors(
    baseColor:
        themeContro.isLightMode.value ? Colors.grey.shade300 : Colors.white12,
    highlightColor:
        themeContro.isLightMode.value ? Colors.grey.shade100 : Colors.white24,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label(
              'Category',
              fontSize: 14,
              textColor: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        sizeBoxHeight(18),
        SizedBox(
          height: 240,
          child: GridView.builder(
            itemCount: 10,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1, // To ensure the grid is square
            ),
            itemBuilder: (context, index) {
              return categorylist();
            },
          ).paddingSymmetric(horizontal: 15),
        )
      ],
    ),
  );
}

Widget categorylist() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0), // Rounded corners
    child: Stack(
      children: [
        // Image.asset(
        //   '',
        //   fit: BoxFit.cover,
        //   width: double.infinity,
        //   height: double.infinity,
        // ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.grey,
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
              '',
              fontSize: 11,
              textColor: Colors.grey.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget store(BuildContext context) {
  return Shimmer.fromColors(
    baseColor:
        themeContro.isLightMode.value ? Colors.grey.shade300 : Colors.white12,
    highlightColor:
        themeContro.isLightMode.value ? Colors.grey.shade100 : Colors.white24,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label(
              'Find Your Perfect store',
              fontSize: 14,
              textColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            label(
              'See all',
              fontSize: 11,
              textColor: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        sizeBoxHeight(18),
        SizedBox(
          height: Get.height * 0.58,
          child: GridView.builder(
            itemCount: 4,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items in a row
              childAspectRatio: 0.8, // Adjust for image and text ratio
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return storelist();
            },
          ).paddingSymmetric(horizontal: 15),
        )
      ],
    ),
  );
}

Widget storelist() {
  return GestureDetector(
    child: Card(
      color: Colors.grey,
      shape: const RoundedRectangleBorder(
        // side: BorderSide(color: Colors.grey.shade100),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(9),
            bottomRight: Radius.circular(9)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    label(
                      '',
                      fontSize: 11,
                      textColor: AppColors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          itemPadding: const EdgeInsets.only(left: 1.5),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10.5,
                          ignoreGestures: true,
                          unratedColor: Colors.grey.shade400,
                          itemBuilder: (context, _) => Image.asset(
                            'assets/images/Star.png',
                            height: 6,
                            color: Colors.grey,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(width: 5),
                        label(
                          '(Review)',
                          fontSize: 8,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 40,
              right: 8,
              child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(AppAsstes.fill_heart),
                  ))),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              height: 13,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(color: Colors.grey, fontSize: 5),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
