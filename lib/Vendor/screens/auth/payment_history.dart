import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/payment_history_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/global.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  PaymentHistoryController controller = Get.find();
  // bool isExpanded = false;

  @override
  void initState() {
    controller.getPaymentHistory();
    super.initState();
  }

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
                  child: Obx(() {
                    return controller.isLoading.value
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.goalData.length,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return shimmerLoader(60, Get.width, 10)
                                  .paddingSymmetric(horizontal: 15);
                            })
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.goalData.length,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: themeContro.isLightMode.value
                                          ? Colors.white
                                          : AppColors.darkGray,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        controller.isExpandedList[index]
                                            ? const BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6,
                                                spreadRadius: 2,
                                                offset: Offset(0, 3),
                                              )
                                            : const BoxShadow(
                                                color: Colors.transparent,
                                                blurRadius: 0,
                                                spreadRadius: 0,
                                                offset: Offset(0, 0),
                                              ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: themeContro.isLightMode.value
                                                ? Colors.white
                                                : AppColors.darkGray,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6,
                                                spreadRadius: 2,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                controller
                                                        .isExpandedList[index] =
                                                    !controller
                                                        .isExpandedList[index];
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
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
                                                            '${controller.goalData[index].startDate} - ${controller.goalData[index].endDate}',
                                                            style: poppinsFont(
                                                                14,
                                                                themeContro
                                                                        .isLightMode
                                                                        .value
                                                                    ? AppColors
                                                                        .black
                                                                    : AppColors
                                                                        .white,
                                                                FontWeight
                                                                    .w600)),
                                                      ),
                                                      label(
                                                        '\$${controller.goalData[index].price}',
                                                        style: poppinsFont(
                                                            14,
                                                            themeContro
                                                                    .isLightMode
                                                                    .value
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .white,
                                                            FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      label(
                                                        "${controller.goalData[index].days.toString()} days",
                                                        style: TextStyle(
                                                            color: themeContro
                                                                    .isLightMode
                                                                    .value
                                                                ? AppColors
                                                                    .color808080
                                                                : AppColors
                                                                    .white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ).paddingOnly(left: 25),
                                                      Icon(
                                                        controller.isExpandedList[
                                                                index]
                                                            ? Icons
                                                                .keyboard_arrow_down
                                                            : Icons
                                                                .keyboard_arrow_up,
                                                        color: themeContro
                                                                .isLightMode
                                                                .value
                                                            ? AppColors
                                                                .colorC8C8C8
                                                            : AppColors.white,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (controller.isExpandedList[index])
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                label(
                                                  'Price Details',
                                                  style: TextStyle(
                                                      color: themeContro
                                                              .isLightMode.value
                                                          ? AppColors.black
                                                          : AppColors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 12),
                                                _buildDetailRow(
                                                    'Selected Ad Days',
                                                    "${controller.goalData[index].days.toString()} days"),
                                                _buildDetailRow('Price',
                                                    '\$${controller.goalData[index].price}'),
                                                _buildDetailRow(
                                                    'Tax/GST', '\$20'),
                                                _buildDetailRow(
                                                    'Platform Charges', '\$2'),
                                                Divider(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.black12
                                                        : AppColors.white,
                                                    thickness: 1),
                                                _buildDetailRow(
                                                  'Total Amount',
                                                  '\$${controller.goalData[index].price}',
                                                  isBold: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                  }),
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
