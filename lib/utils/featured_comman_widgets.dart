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
    );
  }
}

class FeaturedScreen extends StatelessWidget {
  String sname;
  double ratingCount;
  String avrageReview;
  String date;
  String year;
  int isLike;
  Function() onTaplike;
  Function() onTapcall;
  Function() onTapwhatsup;
  FeaturedScreen(
      {super.key,
      required this.sname,
      required this.year,
      required this.ratingCount,
      required this.avrageReview,
      required this.isLike,
      required this.onTaplike,
      required this.onTapcall,
      required this.onTapwhatsup,
      required this.date});

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
            height: 28,
            width: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
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
        height: 120,
        // clipBehavior: Clip.antiAlias,
        // color: const Color.fromRGBO(82, 170, 94, 1.0),
        // shape: CircularNotchedRectangle(),

        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
              bottom: Radius.circular(10),
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(110),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),

          // ),
        ),
        child: SizedBox(
          // width: double.infinity,
          // height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 240,
                child: label(
                  sname,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18,
                  textColor: AppColors.brown,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        // initialRating: servicecontro.servicemodel.value!
                        //             .serviceDetail!.totalAvgReview!
                        //             .toString() !=
                        //         ''
                        //     ? double.parse(servicecontro
                        //         .servicemodel.value!.serviceDetail!.totalAvgReview!
                        //         .toString())
                        //     : 0.0,
                        initialRating: ratingCount,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 12.5,
                        ignoreGestures: true,
                        unratedColor: Colors.grey.shade400,
                        itemBuilder: (context, _) => Image.asset(
                          'assets/images/Star.png',
                          height: 16,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(width: 5),
                      label(
                        '($avrageReview Review)',
                        fontSize: 10,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      label(
                        'Open',
                        fontSize: 10,
                        textColor: const Color(0xff4CAF50),
                        fontWeight: FontWeight.w600,
                      ),
                      label(
                        date,
                        fontSize: 10,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ],
              ).paddingOnly(right: 14),
              sizeBoxHeight(5),
              label(
                year.toString(),
                fontSize: 10,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              sizeBoxHeight(8),
              Row(
                children: [
                  GestureDetector(
                    onTap: onTapcall,
                    child: Container(
                      height: 28,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0x0000001e).withOpacity(0.19),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/call.png',
                            height: 12,
                            color: AppColors.black,
                          ),
                          sizeBoxWidth(5),
                          label(
                            'Call',
                            fontSize: 10,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizeBoxWidth(10),
                  GestureDetector(
                    onTap: onTapwhatsup,
                    child: Container(
                      height: 28,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0x0000001e).withOpacity(0.19),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/whatsapp.png',
                            height: 12,
                          ),
                          sizeBoxWidth(5),
                          label(
                            'What’s app',
                            fontSize: 10,
                            textColor: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(left: 10, top: 12),
        ),
      ),
    );
  }
}
