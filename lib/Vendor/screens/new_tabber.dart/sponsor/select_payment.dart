// ignore_for_file: unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/controllers/vendor_controllers/payment_controller.dart';
import 'package:nlytical_app/Vendor/payment/payment_google_pay.dart';
import 'package:nlytical_app/Vendor/payment/paypal_payment.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:pay/pay.dart';

class SelectPayment extends StatefulWidget {
  final String? price;
  final String? goalID;
  const SelectPayment({super.key, this.goalID, this.price});

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  PaymentController paymentcontro = Get.find();

  Pay payClient = Pay({
    PayProvider.google_pay:
        PaymentConfiguration.fromJsonString(defaultGooglePay),
    PayProvider.apple_pay: PaymentConfiguration.fromJsonString(defaultApplePay),
  });

  @override
  void initState() {
    super.initState();
    print("123");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      payClient.userCanPay(PayProvider.google_pay).then((value) {
        debugPrint("USER CAN GOOGLE PAY : $value");

        return value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? AppColors.white
          : AppColors.darkMainBlack,
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
                    sizeBoxWidth(30),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Select Preferred Payment",
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
                      sizeBoxHeight(20),
                      // stripe payment button
                      containerDesign(
                          onTap: () {
                            paymentcontro.makeStripePayment(
                              goalId: widget.goalID.toString(),
                              price: widget.price!.toString(),
                            );
                          },
                          img: 'assets/images/cr&deb.png',
                          title: 'Credit or Debit Card'),
                      sizeBoxHeight(10),
                      // paypal payment button
                      containerDesign(
                          onTap: () async {
                            print("PRICE ::: ${widget.price}");
                            String symbol = widget.price!
                                .replaceAll(RegExp(r'[\d\s.,]'), '')
                                .trim();

                            // Find the matching currency code
                            String currencyCode = "USD"; // Default currency
                            for (var entry in countryCurrency.values) {
                              if (entry["symbol"] == symbol) {
                                currencyCode = entry["code"]!;
                                break;
                              }
                            }

                            double amount = double.parse(
                              widget.price!.replaceAll(RegExp(r'[^\d.]'), ''),
                            );

                            amount = await paymentcontro.convertUSDtoOTHER(
                                amount, currencyCode);

                            print("Final Amount in USD: $amount");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaypalPayment(
                                          totalPrice: amount.toString(),
                                          onFinish: (number) async {
                                            debugPrint('order id: ' + number);
                                            await paymentcontro.paymentApi(
                                                goalId:
                                                    widget.goalID.toString(),
                                                price: widget.price!
                                                    .replaceAll("\$", "")
                                                    .toString(),
                                                paymentType: "paypal");
                                          },
                                          publickKey:
                                              'AVzMVWctLyouPgmfv9Nh6E5KakydG4JHiFGm-fgg6HRqFYUW-gHVKS1ebRfPgDOr2uYABGGcnU_3RaSL',
                                          secretKey:
                                              'EGWCyNAp9oTXjlmckT8DO9lepyKFrWQy2KvPPmrUsard4K98fuArUYbFQl7CaHdhk4Ehdg_hPkToods4',
                                        )));
                          },
                          img: 'assets/images/paypal_image.png',
                          title: 'PayPal'),
                      sizeBoxHeight(10),
                      // gpay payment button
                      containerDesign(
                          onTap: () async {
                            String symbol = widget.price!
                                .replaceAll(RegExp(r'[\d\s.,]'), '')
                                .trim();

                            // Find the matching currency code
                            String currencyCode = "USD"; // Default currency
                            for (var entry in countryCurrency.values) {
                              if (entry["symbol"] == symbol) {
                                currencyCode = entry["code"]!;
                                break;
                              }
                            }

                            double amount = double.parse(
                              widget.price!.replaceAll(RegExp(r'[^\d.]'), ''),
                            );

                            amount = await paymentcontro.convertUSDtoOTHER(
                                amount, currencyCode);

                            print("Final Amount in USD: $amount");
                            print("object");
                            if (Platform.isIOS) {
                              final result =
                                  await payClient.showPaymentSelector(
                                PayProvider.apple_pay,
                                [
                                  PaymentItem(
                                      amount: amount.toStringAsFixed(2),
                                      status: PaymentItemStatus.final_price,
                                      label: "Nlytical app")
                                ],
                              ).then((value) async {
                                setState(() async {
                                  await paymentcontro.paymentApi(
                                      goalId: widget.goalID.toString(),
                                      price: widget.price.toString(),
                                      paymentType: "gpay");
                                  if (paymentcontro
                                          .paymentmodel.value!.status ==
                                      true) {
                                    selectblock();
                                  }
                                });
                              });
                            } else {
                              final result =
                                  await payClient.showPaymentSelector(
                                PayProvider.google_pay,
                                [
                                  PaymentItem(
                                      amount: amount.toStringAsFixed(2),
                                      status: PaymentItemStatus.final_price,
                                      label: "Nlytical app")
                                ],
                              ).then((value) async {
                                // _successPayment();
                                setState(() async {
                                  await paymentcontro.paymentApi(
                                      goalId: widget.goalID.toString(),
                                      price: widget.price.toString(),
                                      paymentType: "googlepay");
                                  if (paymentcontro
                                          .paymentmodel.value!.status ==
                                      true) {
                                    selectblock();
                                  }
                                  // Get.back();
                                });
                              });
                            }
                          },
                          img: 'assets/images/gpay.png',
                          title: 'Gpay'),
                      sizeBoxHeight(10),
                      containerDesign(
                          onTap: () {
                            paymentcontro.rezorPay(
                                goalId: widget.goalID.toString(),
                                price: widget.price.toString());
                          },
                          img: 'assets/images/razorpay.png',
                          title: 'Razorpay')
                    ],
                  ).paddingSymmetric(horizontal: 10),
                ))
          ],
        ),
      ),
    );
  }

  selectblock() {
    final ap = Get.bottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        barrierColor: const Color.fromRGBO(0, 0, 0, 0.57),
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.8,
            sigmaY: 3.8,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: getProportionateScreenHeight(300),
            width: Get.width,
            child: Column(
              children: [
                Container(
                  height: getProportionateScreenHeight(70),
                  width: Get.width,
                  decoration: BoxDecoration(
                    // color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            0.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Payment success",
                        style:
                            poppinsFont(16, AppColors.black, FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                sizeBoxHeight(50),
                Image.asset("assets/images/sucess.png", height: 80),
                sizeBoxHeight(5),
                Text(
                  "Payment successful!",
                  textAlign: TextAlign.center,
                  style: poppinsFont(14, AppColors.black, FontWeight.w600),
                ),
                Text(
                  "Thank you for your transaction.",
                  textAlign: TextAlign.center,
                  style: poppinsFont(11.5, AppColors.black, FontWeight.w400),
                )
              ],
            ),
          ),
        ));
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        Get.back();
        Get.offAll(() => const VendorNewTabar(currentIndex: 0));
      });
    });
    return ap;
  }

  containerDesign({
    required Function() onTap,
    required String img,
    required String title,
  }) {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              themeContro.isLightMode.value ? Colors.white : AppColors.darkGray,
          boxShadow: [
            BoxShadow(
              color: themeContro.isLightMode.value
                  ? Colors.grey.shade200
                  : AppColors.darkShadowColor,
              blurRadius: 14.0,
              spreadRadius: 0.0,
              offset: const Offset(2.0, 4.0), // shadow direction: bottom right
            )
          ]),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                sizeBoxWidth(10),
                Image.asset(img, height: 20),
                sizeBoxWidth(10),
                label(title,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white)
              ],
            ),
            Image.asset(
              'assets/images/arrow-left (1).png',
              color: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
              height: 16,
              width: 16,
            ),
          ],
        ).paddingOnly(right: 10),
      ),
    ).paddingSymmetric(horizontal: 10);
  }
}
