// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
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
  String businessMonth;
  String businessYear;
  Function() onTapEdit;
  FeaturedScreen({
    super.key,
    required this.sname,
    required this.ratingCount,
    required this.avrageReview,
    required this.businessMonth,
    required this.businessYear,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    String publishedYearString = businessYear;
    String publishedMonthString = businessMonth;

    // Parse the year
    int publishedYear = int.tryParse(publishedYearString) ?? 0;

    // Convert the month name to a DateTime-compatible integer (1-12)
    int publishedMonth = getMonthNumber(publishedMonthString);

    // Create a DateTime object for the published year and month
    DateTime publishedDate = DateTime(publishedYear, publishedMonth);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference
    int totalMonths = (currentDate.year - publishedDate.year) * 12 +
        (currentDate.month - publishedDate.month);
    int years = totalMonths ~/ 12;
    int months = totalMonths % 12;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.5)
            .copyWith(top: 20, bottom: 4),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Colors.white,
        notchMargin: 0,
        clipBehavior: Clip.none,
        elevation: 0,
        height: getProportionateScreenHeight(120),
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
                bottomRight: Radius.circular(50)),
          ),

          // ),
        ),
        child: SizedBox(
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
                  fontSize: 15,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              sizeBoxHeight(10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
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
              ]),
              sizeBoxHeight(10),
              years != 0
                  ? Text(
                      "$years Years in Business",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: poppinsFont(10, AppColors.black, FontWeight.w400),
                    )
                  : Text(
                      "$months months in Business",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: poppinsFont(10, AppColors.black, FontWeight.w400),
                    ),
            ],
          ).paddingOnly(left: 14, top: 14, right: 14, bottom: 5),
        ),
      ),
    );
  }
}
