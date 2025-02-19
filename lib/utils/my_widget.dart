// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
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
  String price;
  String desc;

  FeaturedScreen({
    super.key,
    required this.sname,
    required this.price,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.5)
            .copyWith(top: 20, bottom: 4),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color:
            themeContro.isLightMode.value ? Colors.white : AppColors.darkGray,
        notchMargin: 0,
        clipBehavior: Clip.none,
        elevation: 0,
        height: getProportionateScreenHeight(150),
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
              bottom: Radius.circular(16),
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
                  textColor: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              sizeBoxHeight(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: poppinsFont(
                          10,
                          themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          FontWeight.w400),
                    ),
                  )
                ],
              ),
              sizeBoxHeight(8),
              Container(
                height: 35,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.blue)),
                child: Center(
                  child: Text(
                    "\$$price",
                    style: poppinsFont(12, AppColors.blue, FontWeight.w600),
                  ),
                ),
              ),
            ],
          ).paddingOnly(left: 14, top: 14, right: 14, bottom: 5),
        ),
      ),
    );
  }
}
