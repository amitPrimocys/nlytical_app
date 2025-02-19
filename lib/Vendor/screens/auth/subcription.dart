// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/get_profile_contro.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/controllers/vendor_controllers/login_controller.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class SubscriptionSceen extends StatefulWidget {
  const SubscriptionSceen({super.key});

  @override
  State<SubscriptionSceen> createState() => _SubscriptionSceenState();
}

class _SubscriptionSceenState extends State<SubscriptionSceen> {
  LoginContro1 loginContro = Get.put(LoginContro1());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SizedBox(
            height: Get.height,
            child: Stack(children: [
              Container(
                width: Get.width,
                height: getProportionateScreenHeight(150),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAsstes.line_design)),
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
                          "Subscription",
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
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              sizeBoxHeight(30),
                              Image.asset(
                                'assets/images/subscription.png',
                                height: 74,
                                width: 74,
                              ),
                              sizeBoxHeight(15),
                              Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'Buy ',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: AppColors.color0046AE,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Nlytical ',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: AppColors.color0046AE,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Premium',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: AppColors.color0046AE,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sizeBoxHeight(25),
                              Obx(
                                () => loginContro.isSubscriptionDetailLoading
                                            .value ==
                                        true
                                    ? Center(
                                        child: commonLoading(),
                                      )
                                    : loginContro
                                            .subscriptionDetailsData.isEmpty
                                        ? const SizedBox.shrink()
                                        : SizedBox(
                                            height: Get.height * 0.56,
                                            child: ListView.separated(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: loginContro
                                                  .subscriptionDetailsData
                                                  .length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Container(
                                                    height: Get.height * 0.54,
                                                    width: Get.width * 0.9,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                AppColors.blue1,
                                                            width: 3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/sub bg.png'),
                                                            fit: BoxFit.cover)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        label(
                                                            loginContro
                                                                .subscriptionDetailsData[
                                                                    index]
                                                                .planName!,
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            textColor:
                                                                AppColors.blue),
                                                        sizeBoxHeight(10),
                                                        SizedBox(
                                                          width: 250,
                                                          child: label(
                                                              loginContro
                                                                  .subscriptionDetailsData[
                                                                      index]
                                                                  .description
                                                                  .toString(),
                                                              fontSize: 14,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              textColor:
                                                                  AppColors
                                                                      .black),
                                                        ),
                                                        sizeBoxHeight(10),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: RichText(
                                                            text: TextSpan(
                                                              text: '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                color: AppColors
                                                                    .color0046AE,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                  text: loginContro
                                                                      .subscriptionDetailsData[
                                                                          index]
                                                                      .price!,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        36,
                                                                    color: AppColors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                const TextSpan(
                                                                  text:
                                                                      '/ PER MONTH',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 9,
                                                                    color: AppColors
                                                                        .color0046AE,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        sizeBoxHeight(10),
                                                        Divider(
                                                          height: 2,
                                                          color: Colors
                                                              .grey.shade400,
                                                        ),
                                                        sizeBoxHeight(20),
                                                        SizedBox(
                                                          height: 135,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: loginContro
                                                                      .subscriptionDetailsData[
                                                                          index]
                                                                      .planServices!
                                                                      .length,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index1) {
                                                                    return Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Image.asset(
                                                                              loginContro.subscriptionDetailsData[index].planServices![index1].status == 1 ? 'assets/images/right 1.png' : 'assets/images/right 2.png',
                                                                              height: getProportionateScreenHeight(20),
                                                                              width: getProportionateScreenWidth(20),
                                                                            ),
                                                                            sizeBoxWidth(10),
                                                                            SizedBox(
                                                                              width: 230,
                                                                              child: label(
                                                                                loginContro.subscriptionDetailsData[index].planServices![index1].planServices.toString().replaceAll("\n", ''),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                style: poppinsFont(
                                                                                  14,
                                                                                  AppColors.color000000,
                                                                                  FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }),
                                                        ),
                                                        sizeBoxHeight(20),
                                                        Obx(() => loginContro
                                                                    .isPaymentSuccessLoading
                                                                    .value ==
                                                                true
                                                            ? Center(
                                                                child:
                                                                    commonLoading(),
                                                              )
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  loginContro
                                                                      .selectedPlanIndex
                                                                      .value = index;
                                                                  rezorPay();
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width:
                                                                      Get.width,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                    child: label(
                                                                        'Choose Plan',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        textColor:
                                                                            AppColors.white),
                                                                  ),
                                                                ),
                                                              ))
                                                      ],
                                                    ).paddingAll(30),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return sizeBoxHeight(20);
                                              },
                                            ),
                                          ),
                              ),
                            ],
                          ).paddingSymmetric(
                            horizontal: 5,
                          ),
                        ),
                      ],
                    )),
              )
            ])));
  }

  GetprofileContro getprofilecontro = Get.put(GetprofileContro());

  void rezorPay() {
    print(
        "Priceee ${loginContro.subscriptionDetailsData[loginContro.selectedPlanIndex.value].price!.substring(1)}");
    loginContro.isPaymentSuccessLoading.value = true;
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_67sD9rAjWFVFZQ',
      'amount': int.parse(loginContro
              .subscriptionDetailsData[loginContro.selectedPlanIndex.value]
              .price!
              .replaceAll(RegExp(r'[^\d.]'), '')) *
          100,
      'name': loginContro
          .subscriptionDetailsData[loginContro.selectedPlanIndex.value]
          .planName!,
      'description': loginContro
          .subscriptionDetailsData[loginContro.selectedPlanIndex.value]
          .description!,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      },
      "currency": loginContro
          .subscriptionDetailsData[loginContro.selectedPlanIndex.value]
          .currencyValue!,
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    log(
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}",
      name: "Payment Failed",
    );
    loginContro.isPaymentSuccessLoading.value = false;
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    log(
      "Payment ID: ${response.paymentId}",
      name: "Payment Successful",
    );
    await getprofilecontro.updateApi(
      isUpdateProfile: false,
    );
    loginContro.paymentSuccess();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    log(
      "${response.walletName}",
      name: "External Wallet Selected",
    );
    loginContro.isPaymentSuccessLoading.value = false;
  }

  Widget appBarWidget() {
    return Container(
      height: getProportionateScreenHeight(100),
      width: Get.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
            color: Colors.grey.shade300)
      ], color: Colors.white),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              label(
                "subscription",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 15, right: 20, top: 25),
    );
  }
}
