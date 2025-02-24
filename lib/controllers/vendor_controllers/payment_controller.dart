// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/models/vendor_models/getpaymentmodel.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

ApiHelper apiHelper = ApiHelper();

class PaymentController extends GetxController {
  RxBool isloading = false.obs;
  Rx<GetPaymentModel?> paymentmodel = GetPaymentModel().obs;

  paymentApi(
      {required String goalId,
      required String price,
      required String paymentType}) async {
    try {
      isloading.value = true;
      var uri = Uri.parse(apiHelper.addpayment);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['vendor_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);
      request.fields['goal_id'] = goalId;
      request.fields['payment_mode'] = paymentType;
      request.fields['price'] = price;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      paymentmodel.value = GetPaymentModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (paymentmodel.value!.status == true) {
        isloading.value = false;

        snackBar("Payment successful");

        if (paymentType == "paypal" &&
            paymentType == "stripe" &&
            paymentType == "razorpay") {
          Get.offAll(() => const VendorNewTabar(currentIndex: 0));
        }
      } else {
        isloading.value = false;
        print(paymentmodel.value!.message);
      }
    } catch (e) {
      isloading.value = false;
    } finally {
      isloading.value = false;
    }
  }

  //================================================================
  RxBool payLoading = false.obs;
  Map<String, dynamic>? customer;
  Map<String, dynamic>? paymentIntent;
  final String key =
      "sk_test_51OP303SJayPbST1lMDr6nn6WieehdLmIpiG2pgVil38DVNPjDqKcFG87d1GMOk10WWtoqZIxvSx2WLAP7G1GMkWu00SJWzq7cn";

  Future<void> makeStripePayment(
      {required String goalId, required String price}) async {
    payLoading(true); // Start showing loader

    var totalAmount =
        double.parse(price.replaceAll(RegExp(r'[^\d.]'), '')) * 100;

    var finalAmount = totalAmount.toStringAsFixed(0);

    try {
      // Call createCustomer API
      customer = await createCustomer();

      // Check if the customer creation was successful
      if (customer != null && customer!.containsKey('id')) {
        // Get the customer ID
        String customerId = customer!['id'];

        paymentIntent =
            await createPaymentIntent(finalAmount, "usd", customerId);

        var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: 'US',
          currencyCode: 'USD',
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
        displayPaymentSheet(goalId: goalId, price: price);

        payLoading(false); // Stop showing loader
      } else {
        print('Customer creation failed.');
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> displayPaymentSheet(
      {required String goalId, required String price}) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully");
        // checkoutApi("", "Stripe");
        paymentApi(goalId: goalId, price: price, paymentType: "stripe");
      });
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency, String customerId) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency.toUpperCase(),
        'customer': customerId,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51OP303SJayPbST1lMDr6nn6WieehdLmIpiG2pgVil38DVNPjDqKcFG87d1GMOk10WWtoqZIxvSx2WLAP7G1GMkWu00SJWzq7cn',
          //sk_test_mCGuHRWMGuDBHHma9OLR1cX800m49bxZKG',
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

//============================================= RAZORPAY ==========================================
  RxString selectedGoalId = "".obs;
  RxString selectedPrice = "".obs;
  RxBool isRazorPayLoading = false.obs;
  void rezorPay({required String goalId, required String price}) {
    print("Priceee $price");
    isRazorPayLoading(true);
    selectedGoalId.value = goalId;
    selectedPrice.value = price;

    String symbol = price.replaceAll(RegExp(r'[\d\s.,]'), '').trim();

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
      'amount': int.parse(price.replaceAll(RegExp(r'[^\d.]'), '')) * 100,
      'name': "Nlytical app",
      'description': "",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      },
      "currency": currencyCode,
      // "currency": "USD",
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
    isRazorPayLoading(false);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    log(
      "Payment ID: ${response.paymentId}",
      name: "Payment Successful",
    );
    paymentApi(
        goalId: selectedGoalId.value,
        price: selectedPrice.value,
        paymentType: "razorpay");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    log(
      "${response.walletName}",
      name: "External Wallet Selected",
    );
    isRazorPayLoading(false);
  }
}
