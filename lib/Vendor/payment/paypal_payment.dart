// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nlytical_app/controllers/vendor_controllers/payment_controller.dart';
import 'package:nlytical_app/Vendor/payment/paypal_service.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart' as webView;

class PaypalPayment extends StatefulWidget {
  final String publickKey;
  final String secretKey;
  final String totalPrice;

  final Function onFinish;

  const PaypalPayment({
    super.key,
    required this.publickKey,
    required this.secretKey,
    required this.onFinish,
    this.totalPrice = '',
  });

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  // PaypalServices services =
  //     PaypalServices(clientId: widget.publickKey, secret: widget.secretKey);
  late webView.WebViewController controller;

  // CartController cartController = Get.put(CartController());
  PaymentController paymentController = Get.put(PaymentController());

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    PaypalServices services =
        PaypalServices(clientId: widget.publickKey, secret: widget.secretKey);
    super.initState();
    // getCheckout();
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];

            debugPrint("Check out url is $checkoutUrl");
            debugPrint("Execute out url is $executeUrl");

            controller = webView.WebViewController()
              ..setJavaScriptMode(webView.JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                webView.NavigationDelegate(
                  onProgress: (int progress) {
                    //  CupertinoActionSheet();
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (webView.WebResourceError error) {},
                  onNavigationRequest: (webView.NavigationRequest request) {
                    if (request.url.contains(returnURL)) {
                      final uri = Uri.parse(request.url);
                      final payerID = uri.queryParameters['PayerID'];
                      if (payerID != null) {
                        services
                            .executePayment(executeUrl, payerID, accessToken)
                            .then((id) {
                          widget.onFinish(id);
                          Navigator.of(context).pop();
                        });
                      } else {
                        Navigator.of(context).pop();
                      }
                      Navigator.of(context).pop();
                    }
                    if (request.url.contains(cancelURL)) {
                      Navigator.of(context).pop();
                    }
                    return webView.NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse(checkoutUrl!));
          });
        }
      } catch (e) {
        debugPrint('exception: $e');
        debugPrint("checkoutUrl$checkoutUrl");
      }
    });
  }

  // item name, price and quantity
  Map<String, dynamic> getOrderParams() {
    // checkout invoice details
    // String totalAmt = model!.totalAmount!.toString();
    // String subTotalAmount = model!.totalAmount!.toString();
    // String shippingCost = '0';
    // int shippingDiscountCost = 0;
    // String userFirstName = model!.address!.firstName!;
    // String userLastName = model!.address!.lastName!;
    // String addressCity = model!.address!.city!;
    // String addressStreet = model!.address!.locality!;
    // String addressZipCode = model!.address!.pincode!;
    // String addressState = model!.address!.state!;
    // String addressPhoneNumber = model!.address!.mobile!;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": widget.totalPrice,
            "currency": "USD",
            "details": {
              "subtotal": widget.totalPrice,
              "shipping": '0',
              "shipping_discount": '0',
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          // "item_list": {
          //   if (isEnableShipping && isEnableAddress)
          //     "shipping_address": {
          //       "recipient_name": "$userFirstName $userLastName",
          //       "line1": addressStreet,
          //       "line2": "",
          //       "city": addressCity,
          //       // "country_code": addressCountry,
          //       "postal_code": addressZipCode,
          //       "phone": addressPhoneNumber,
          //       "state": addressState
          //     },
          // }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          // leading: GestureDetector(
          //   child: const Icon(Icons.arrow_back_ios, color: Colors.black),
          //   onTap: () => Navigator.pop(context),
          // ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 28,
            ),
          ),
          title: const Text('Paypal').paddingOnly(right: 5),
        ),
        body: Column(
          children: [
            Expanded(
              child: webView.WebViewWidget(controller: controller),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
  }
}
