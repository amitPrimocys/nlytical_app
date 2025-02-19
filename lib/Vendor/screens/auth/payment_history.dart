import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/global.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    sizeBoxWidth(80),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Payment History",
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Uncomment and use if required
                    // sizeBoxWidth(240),
                    // Image.asset(
                    //   AppAsstes.search,
                    //   scale: 3.5,
                    //   color: Colors.white,
                    // ),
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
                      Container(
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: themeContro.isLightMode.value
                              ? Colors.white
                              : AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/cal.png',
                                          height: 15,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: label(
                                            '10/12/2024 - 10/01/2025',
                                            style: TextStyle(
                                                color: themeContro
                                                        .isLightMode.value
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        label(
                                          '\$135',
                                          style: TextStyle(
                                              color:
                                                  themeContro.isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        label(
                                          '30 days',
                                          style: TextStyle(
                                              color:
                                                  themeContro.isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ).paddingOnly(left: 25),
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: themeContro.isLightMode.value
                                              ? AppColors.black
                                              : AppColors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            if (isExpanded)
                              const Divider(
                                  color: Colors.black12, thickness: 1),
                            if (isExpanded)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    label(
                                      'Price Details',
                                      style: TextStyle(
                                          color: themeContro.isLightMode.value
                                              ? AppColors.black
                                              : AppColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 12),
                                    _buildDetailRow(
                                        'Selected Ad Days', '10 days'),
                                    _buildDetailRow('Price', '\$150'),
                                    _buildDetailRow('Tax/GST', '\$20'),
                                    _buildDetailRow('Platform Charges', '\$2'),
                                    Divider(
                                        color: themeContro.isLightMode.value
                                            ? Colors.black12
                                            : AppColors.white,
                                        thickness: 1),
                                    _buildDetailRow(
                                      'Total Amount',
                                      '\$172.00',
                                      isBold: true,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
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
                color: themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
                fontSize: 12,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w400),
          ),
          label(
            value,
            style: TextStyle(
                color: themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
                fontSize: 12,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
