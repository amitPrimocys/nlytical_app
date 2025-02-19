// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Container(
      //         height: 40,
      //         width: 100,
      //         decoration: BoxDecoration(color: Colors.white)),
      //     SizedBox(
      //       height: 200,
      //       child: ListView.separated(
      //         shrinkWrap: true,
      //         scrollDirection: Axis.horizontal,
      //         itemCount: 12,
      //         separatorBuilder: (BuildContext context, int index) {
      //           return SizedBox(width: 12);
      //         },
      //         itemBuilder: (BuildContext context, int index) {
      //           return Stack(
      //             children: [
      //               ClipRRect(
      //                 borderRadius: BorderRadius.circular(10),
      //                 child: Container(
      //                   height: 200,
      //                   width: Get.width * 0.82,
      //                   // width: 400,
      //                   decoration: const BoxDecoration(
      //                     color: Colors.black12,
      //                     image: DecorationImage(
      //                         image: NetworkImage(
      //                             'https://images.pexels.com/photos/28993966/pexels-photo-28993966/free-photo-of-stylish-woman-in-black-dress-against-concrete-wall.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load'),
      //                         fit: BoxFit.cover),
      //                   ),
      //                   //Add the child widget....
      //                 ),
      //               ),

      //               const Positioned.fill(bottom: 0, child: FloatingScreen(sname: '',))
      //               // FloatingActionButton(
      //               //   backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
      //               //   tooltip: 'Increment',
      //               //   onPressed: () {},
      //               //   child: const Icon(Icons.add, size: 28),
      //               // ),
      //               // FloatingScreen()
      //             ],
      //           );
      //         },
      //       ),
      //     )
      //   ],
      // )
    );
  }
}

class NearbyScreen extends StatelessWidget {
  String sname;
  double ratingCount;
  String avrageReview;
  int isLike;
  Function() onTaplike;
  Function() onTapstore;
  NearbyScreen({
    super.key,
    required this.sname,
    required this.ratingCount,
    required this.avrageReview,
    required this.isLike,
    required this.onTaplike,
    required this.onTapstore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.5)
            .copyWith(top: 20, bottom: 4),
        child: GestureDetector(
          onTap: onTaplike,
          child: Container(
            height: 24,
            width: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: isLike == 0
                    ? Image.asset(AppAsstes.heart) // Unlike
                    : Image.asset(AppAsstes.fill_heart),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Colors.white,
        notchMargin: 0,
        clipBehavior: Clip.none,
        elevation: 0,
        height: 60,
        // clipBehavior: Clip.antiAlias,
        // color: const Color.fromRGBO(82, 170, 94, 1.0),
        // shape: CircularNotchedRectangle(),

        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
              bottom: Radius.circular(20),
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(110),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          // RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.elliptical(30, 90),
          //     bottomLeft: Radius.elliptical(40, 30),
          //     bottomRight: Radius.elliptical(10, 20),
          //     topRight: Radius.elliptical(-10, 10),
          //   ),

          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // sizeBoxHeight(15),
            SizedBox(
              width: 250,
              child: label(
                sname,
                maxLines: 1,
                fontSize: 11,
                textColor: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            sizeBoxHeight(5),
            Row(
              children: [
                RatingBar.builder(
                  itemPadding: const EdgeInsets.only(left: 1.5),
                  // initialRating: allServices.totalAvgReview != ''
                  //     ? double.parse(allServices.totalAvgReview!)
                  //     : 0.0,

                  initialRating: ratingCount,
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
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(width: 5),
                label(
                  // ignore: unnecessary_brace_in_string_interps
                  '(${avrageReview} Review)',
                  fontSize: 8,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ).paddingOnly(left: 15, top: 12),
      ),
    );
  }
}
