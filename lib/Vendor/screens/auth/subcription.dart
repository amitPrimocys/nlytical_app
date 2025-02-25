// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/Vendor/payment/payment_google_pay.dart';
import 'package:nlytical_app/Vendor/payment/paypal_payment.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/get_profile_contro.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/controllers/vendor_controllers/login_controller.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:pay/pay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:http/http.dart' as http;

class SubscriptionSceen extends StatefulWidget {
  const SubscriptionSceen({super.key});

  @override
  State<SubscriptionSceen> createState() => _SubscriptionSceenState();
}

class _SubscriptionSceenState extends State<SubscriptionSceen> {
  LoginContro1 loginContro = Get.put(LoginContro1());
  GetprofileContro getprofilecontro = Get.put(GetprofileContro());

  Pay payClient = Pay({
    PayProvider.google_pay:
        PaymentConfiguration.fromJsonString(defaultGooglePay),
    PayProvider.apple_pay: PaymentConfiguration.fromJsonString(defaultApplePay),
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      payClient.userCanPay(PayProvider.google_pay).then((value) {
        debugPrint("USER CAN GOOGLE PAY : $value");

        return value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? AppColors.white
            : AppColors.darkMainBlack,
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
                    decoration: BoxDecoration(
                        color: themeContro.isLightMode.value
                            ? AppColors.white
                            : AppColors.darkMainBlack,
                        borderRadius: const BorderRadius.only(
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
                                                        color: themeContro
                                                                .isLightMode
                                                                .value
                                                            ? Colors.white
                                                            : AppColors
                                                                .darkGray,
                                                        border: Border.all(
                                                            color: themeContro
                                                                    .isLightMode
                                                                    .value
                                                                ? AppColors
                                                                    .blue1
                                                                : AppColors
                                                                    .darkgray2,
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
                                                              textColor: themeContro
                                                                      .isLightMode
                                                                      .value
                                                                  ? AppColors
                                                                      .black
                                                                  : AppColors
                                                                      .colorFFFFFF),
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
                                                                      TextStyle(
                                                                    fontSize:
                                                                        36,
                                                                    color: themeContro
                                                                            .isLightMode
                                                                            .value
                                                                        ? AppColors
                                                                            .black
                                                                        : AppColors
                                                                            .colorFFFFFF,
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
                                                                              color: loginContro.subscriptionDetailsData[index].planServices![index1].status == 1 ? AppColors.blue : AppColors.white,
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
                                                                                  themeContro.isLightMode.value ? AppColors.black : AppColors.colorFFFFFF,
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
                                                                  // rezorPay();
                                                                  paymentDialog();
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

  paymentDialog() {
    return Get.dialog(
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.57),
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.8,
            sigmaY: 3.8,
          ),
          child: Obx(() => Container(
                height: Get.height * 0.40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: themeContro.isLightMode.value
                      ? Colors.white
                      : AppColors.darkGray,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: loginContro.paymentOptions.map((option) {
                        return RadioListTile<String>(
                          dense: true,
                          activeColor: AppColors.blue,
                          value: option["value"]!,
                          groupValue: loginContro.selectedPayment.value,
                          onChanged: (String? value) {
                            loginContro.selectedPayment.value = value!;
                          },
                          title: Row(
                            children: [
                              Image.asset(
                                option["image"]!,
                                width: 25, // Adjust size as needed
                                height: 25,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                option["title"]!,
                                style: poppinsFont(
                                    12,
                                    themeContro.isLightMode.value
                                        ? AppColors.black
                                        : AppColors.white,
                                    FontWeight.w600),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    sizeBoxHeight(10),
                    CustomButtom(
                            title: "Apply",
                            onPressed: () async {
                              print(loginContro.selectedPayment.value);
                              //======================================================= stripe payment call
                              if (loginContro.selectedPayment.value ==
                                  "credit_debit") {
                                makeStripePayment();
                                //===================================================== Paypal payment call
                              } else if (loginContro.selectedPayment.value ==
                                  "paypal") {
                                String symbol = loginContro
                                    .subscriptionDetailsData[
                                        loginContro.selectedPlanIndex.value]
                                    .price!
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
                                  loginContro
                                      .subscriptionDetailsData[
                                          loginContro.selectedPlanIndex.value]
                                      .price!
                                      .replaceAll(RegExp(r'[^\d.]'), ''),
                                );

                                amount = await convertUSDtoOTHER(
                                    amount, currencyCode);

                                print("Final Amount in USD: $amount");

                                print("currencyCode:$currencyCode");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaypalPayment(
                                              totalPrice:
                                                  amount.toStringAsFixed(2),
                                              // loginContro
                                              //     .subscriptionDetailsData[
                                              //         loginContro
                                              //             .selectedPlanIndex
                                              //             .value]
                                              //     .price!
                                              //     .replaceAll(
                                              //         RegExp(r'[^\d.]'), ''),
                                              onFinish: (number) async {
                                                debugPrint('order id: $number');
                                                await getprofilecontro
                                                    .updateApi(
                                                  isUpdateProfile: false,
                                                );
                                                loginContro.paymentSuccess(
                                                    paymentType: "paypal");
                                                Get.back();
                                              },
                                              publickKey:
                                                  'AVzMVWctLyouPgmfv9Nh6E5KakydG4JHiFGm-fgg6HRqFYUW-gHVKS1ebRfPgDOr2uYABGGcnU_3RaSL',
                                              secretKey:
                                                  'EGWCyNAp9oTXjlmckT8DO9lepyKFrWQy2KvPPmrUsard4K98fuArUYbFQl7CaHdhk4Ehdg_hPkToods4',
                                            )));
                                //====================================================== Gpay payment call
                              } else if (loginContro.selectedPayment.value ==
                                  "gpay") {
                                String symbol = loginContro
                                    .subscriptionDetailsData[
                                        loginContro.selectedPlanIndex.value]
                                    .price!
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
                                  loginContro
                                      .subscriptionDetailsData[
                                          loginContro.selectedPlanIndex.value]
                                      .price!
                                      .replaceAll(RegExp(r'[^\d.]'), ''),
                                );

                                amount = await convertUSDtoOTHER(
                                    amount, currencyCode);

                                print("Final Amount in USD: $amount");
                                if (Platform.isIOS) {
                                  final result =
                                      await payClient.showPaymentSelector(
                                    PayProvider.apple_pay,
                                    [
                                      PaymentItem(
                                          amount: amount.toStringAsFixed(2),
                                          // loginContro
                                          //     .subscriptionDetailsData[
                                          //         loginContro
                                          //             .selectedPlanIndex.value]
                                          //     .price!
                                          //     .replaceAll(
                                          //         RegExp(r'[^\d.]'), ''),
                                          status: PaymentItemStatus.final_price,
                                          label: "Nlytical app")
                                    ],
                                  ).then((value) async {
                                    setState(() async {
                                      await getprofilecontro.updateApi(
                                        isUpdateProfile: false,
                                      );
                                      loginContro.paymentSuccess(
                                          paymentType: "gpay");
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
                                      await getprofilecontro.updateApi(
                                        isUpdateProfile: false,
                                      );
                                      loginContro.paymentSuccess(
                                          paymentType: "gpay");
                                      // Get.back();
                                    });
                                  });
                                }
                                //================================================= Razorpay payment call
                              } else if (loginContro.selectedPayment.value ==
                                  "razorpay") {
                                rezorPay();
                                Navigator.pop(context);
                              } else {
                                snackBar("Please select method");
                              }
                            },
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 40,
                            width: Get.width)
                        .paddingSymmetric(horizontal: 30)
                  ],
                ),
              )),
        ),
      ),
    );
  }

//=================================================================== RAZRPAY ====================================
//=================================================================== RAZRPAY ====================================

  void rezorPay() {
    print(
        "Priceee ${loginContro.subscriptionDetailsData[loginContro.selectedPlanIndex.value].price!.substring(1)}");
    loginContro.isPaymentSuccessLoading.value = true;

    String symbol = loginContro
        .subscriptionDetailsData[loginContro.selectedPlanIndex.value].price!
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
    print("currencyCode:$currencyCode");

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
      "currency": currencyCode,
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
    loginContro.paymentSuccess(paymentType: "razorpay");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    log(
      "${response.walletName}",
      name: "External Wallet Selected",
    );
    loginContro.isPaymentSuccessLoading.value = false;
  }

//========================================================================== STRIPE ======================
//========================================================================== STRIPE ======================
  bool payLoading = false;
  Map<String, dynamic>? customer;
  Map<String, dynamic>? paymentIntent;
  final String key =
      "sk_test_51OP303SJayPbST1lMDr6nn6WieehdLmIpiG2pgVil38DVNPjDqKcFG87d1GMOk10WWtoqZIxvSx2WLAP7G1GMkWu00SJWzq7cn";

  Future<void> makeStripePayment() async {
    payLoading = true; // Start showing loader

    String symbol = loginContro
        .subscriptionDetailsData[loginContro.selectedPlanIndex.value].price!
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
    print("currencyCode:$currencyCode");

    var totalAmount = int.parse(loginContro
            .subscriptionDetailsData[loginContro.selectedPlanIndex.value].price!
            .replaceAll(RegExp(r'[^\d.]'), '')) *
        100;

    var finalAmount = totalAmount.toStringAsFixed(0);

    try {
      // Call createCustomer API
      customer = await createCustomer();

      // Check if the customer creation was successful
      if (customer != null && customer!.containsKey('id')) {
        // Get the customer ID
        String customerId = customer!['id'];

        paymentIntent =
            await createPaymentIntent(finalAmount, currencyCode, customerId);

        var gpay = PaymentSheetGooglePay(
          merchantCountryCode: 'US',
          currencyCode: currencyCode,
          testEnv: true,
        );

        // var applePay = PaymentSheetApplePay(
        //   merchantCountryCode: "US".tr,
        //   cartItems: [],
        // );

        // STEP 2: Initialize Payment Sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            merchantDisplayName: 'Merchant Name',
            style: ThemeMode.light,
            googlePay: gpay,
            allowsDelayedPaymentMethods: true,
            // applePay: applePay
            // //googlePay: gpay,
            //applePay: applePay
          ),
        );

        // STEP 3: Display Payment sheet
        displayPaymentSheet();

        payLoading = false; // Stop showing loader
      } else {
        print('Customer creation failed.');
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        print("Payment Successfully");
        await getprofilecontro.updateApi(
          isUpdateProfile: false,
        );
        loginContro.paymentSuccess(paymentType: "stripe");
        // paymentApi(goalId: goalId, price: price, paymentType: "stripe");
      });
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency, String customerId) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'customer': customerId,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51OP303SJayPbST1lMDr6nn6WieehdLmIpiG2pgVil38DVNPjDqKcFG87d1GMOk10WWtoqZIxvSx2WLAP7G1GMkWu00SJWzq7cn',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  createCustomer() async {
    try {
      Map<String, dynamic> body = {
        'email': "demo2@gmail.com",
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/customers'),
        headers: {
          'Authorization':
              'Bearer sk_test_51OP303SJayPbST1lMDr6nn6WieehdLmIpiG2pgVil38DVNPjDqKcFG87d1GMOk10WWtoqZIxvSx2WLAP7G1GMkWu00SJWzq7cn',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: json.encode(body),
      );
      return json.decode(response.body);
    } catch (err) {
      print(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<double> convertUSDtoOTHER(double amount, String currencyCode) async {
    try {
      // Fetch live exchange rate (Replace with your API Key)
      final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/$currencyCode'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double exchangeRate = data["rates"]["USD"]; // Get CNY to USD rate
        return amount * exchangeRate;
      } else {
        throw Exception("Failed to load exchange rate");
      }
    } catch (e) {
      print("Exchange Rate Error: $e");
      return amount * 0.138; // Default fallback conversion rate
    }
  }
}
