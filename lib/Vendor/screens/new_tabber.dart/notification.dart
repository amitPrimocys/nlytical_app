import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.white
          : AppColors.darkMainBlack,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          clipBehavior: Clip.none,
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
                alignment: Alignment.center, // Aligns content to the center
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    label(
                      "Notification",
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
            Positioned(
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizeBoxHeight(15),
                        Text("Today",
                            style: poppinsFont(
                                14,
                                themeContro.isLightMode.value
                                    ? AppColors.black
                                    : AppColors.white,
                                FontWeight.w600)),
                        sizeBoxHeight(5),
                        ListView.builder(
                            itemCount: 25,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: AppColors.blue1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        AppAsstes.notify,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                  sizeBoxWidth(15),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const DynamicTextWidget(
                                            text:
                                                'Install Nlytical App New Version',
                                          ),
                                          Text("11:05 pm",
                                              style: poppinsFont(
                                                  7,
                                                  Colors.grey.shade500,
                                                  FontWeight.w400)),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text("App New Version",
                                          style: poppinsFont(
                                              10,
                                              Colors.grey.shade500,
                                              FontWeight.w400)),
                                    ],
                                  ))
                                ],
                              ).paddingSymmetric(vertical: 10);
                            }),
                      ],
                    ).paddingSymmetric(horizontal: 20, vertical: 10),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
