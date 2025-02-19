// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class PrivacyWebView extends StatefulWidget {
  final String htmlContent; // Accept HTML content
  final String title;

  const PrivacyWebView(
      {super.key, required this.htmlContent, required this.title});

  @override
  State<PrivacyWebView> createState() => _PrivacyWebViewState();
}

class _PrivacyWebViewState extends State<PrivacyWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
        body: SizedBox(
          height: Get.height,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
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
                      sizeBoxWidth(60),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          widget.title,
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
                    child: Column(
                      children: [
                        sizeBoxHeight(10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Html(
                                  data: """
                                ${widget.htmlContent}
                                    """,
                                  onLinkTap: (url, attributes, element) {
                                    print("Opening $url...");
                                  },
                                  style: {
                                    "body": Style(
                                      color: themeContro.isLightMode.value
                                          ? Colors.black
                                          : Colors
                                              .white, // ✅ Text Color Based on Theme
                                    ),
                                    "div": Style(
                                      color: themeContro.isLightMode.value
                                          ? Colors.black
                                          : Colors.white, // ✅ Text Color
                                    ),
                                    "p": Style(
                                      color: themeContro.isLightMode.value
                                          ? Colors.black
                                          : Colors.white, // ✅ Paragraph Color
                                    ),
                                    "h1": Style(
                                      fontWeight: FontWeight.bold,
                                      color: themeContro.isLightMode.value
                                          ? Colors.black
                                          : Colors.white, // ✅ Header Color
                                    ),
                                    "sup": Style(
                                      fontSize: FontSize.small,
                                      color: themeContro.isLightMode.value
                                          ? Colors.black
                                          : Colors.white, // ✅ Superscript Color
                                    ),
                                  },
                                ),
                                sizeBoxHeight(20)
                              ],
                            ).paddingSymmetric(horizontal: 5),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
