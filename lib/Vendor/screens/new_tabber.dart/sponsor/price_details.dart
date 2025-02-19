// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/sponsor/select_payment.dart';

class PriceDetails extends StatefulWidget {
  String? totaldays;
  String? startdate;
  String? enddate;
  String? price;
  String? goalId;
  PriceDetails(
      {super.key,
      this.totaldays,
      this.startdate,
      this.enddate,
      this.price,
      this.goalId});

  @override
  State<PriceDetails> createState() => _PriceDetailsState();
}

class _PriceDetailsState extends State<PriceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? AppColors.white
          : AppColors.darkMainBlack,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 70,
        child: button(),
      ).paddingOnly(bottom: 30),
      body: SizedBox(
        height: Get.height,
        child: Stack(
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
                // Aligns content to the center
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/arrow-left1.png',
                          color: AppColors.white,
                          height: 24,
                        )),
                    sizeBoxWidth(95),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Price Details",
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
            Positioned.fill(
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
                  child: Column(
                    children: [
                      sizeBoxHeight(30),
                      Container(
                        height: 70,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: themeContro.isLightMode.value
                                ? AppColors.blue1
                                : AppColors.darkGray,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            sizeBoxHeight(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                label(
                                  'Total Days',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  textColor: themeContro.isLightMode.value
                                      ? AppColors.black
                                      : Colors.grey,
                                ),
                                label("${widget.totaldays!} days",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColors.blue)
                              ],
                            ).paddingSymmetric(
                              horizontal: 10,
                            ),
                            sizeBoxHeight(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                label(
                                  'Start Date / End Date',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  textColor: themeContro.isLightMode.value
                                      ? AppColors.black
                                      : Colors.grey,
                                ),
                                label(
                                    '${widget.startdate!} to ${widget.enddate!}',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    textColor:
                                        const Color.fromRGBO(142, 142, 142, 1))
                              ],
                            ).paddingSymmetric(
                              horizontal: 10,
                            ),
                            sizeBoxHeight(5),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 20),
                      sizeBoxHeight(20),
                      Container(
                        height: 170,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: themeContro.isLightMode.value
                              ? Colors.white
                              : AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 13,
                              spreadRadius: 0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            sizeBoxHeight(10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: label(
                                'Price Details',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: themeContro.isLightMode.value
                                      ? AppColors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow('Selected Ad Days',
                                "${widget.totaldays!} days"),
                            _buildDetailRow('Price', widget.price!),
                            _buildDetailRow('Tax/GST', '\$20'),
                            _buildDetailRow('Platform Charges', '\$2'),
                            Divider(
                                color: themeContro.isLightMode.value
                                    ? Colors.black12
                                    : AppColors.grey1,
                                thickness: 1),
                            _buildDetailRow(
                              'Total Amount',
                              widget.price!,
                              isBold: true,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 15, vertical: 3),
                      ).paddingSymmetric(horizontal: 20),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      onTap: () {
        print("PRICE ::: ${widget.price}");
        Get.to(SelectPayment(
          price: widget.price,
          goalID: widget.goalId,
        ));
      },
      child: Container(
        height: 30,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColors.blue, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: label('Make Payment',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              textColor: Colors.white),
        ),
      ).paddingSymmetric(
        horizontal: 20,
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          label(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
              color: themeContro.isLightMode.value
                  ? AppColors.black
                  : Colors.white,
            ),
          ),
          label(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
              color: themeContro.isLightMode.value
                  ? AppColors.black
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
