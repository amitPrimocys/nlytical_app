import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/controllers/vendor_controllers/support_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  SupportController supportcontro = Get.put(SupportController());

  final fnameController = TextEditingController();
  final msgController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();
  FocusNode fnameFocus = FocusNode();
  FocusNode fnameFocus1 = FocusNode();
  FocusNode numberFocus = FocusNode();
  FocusNode numberFocus1 = FocusNode();
  FocusNode msgFocus = FocusNode();
  FocusNode msgFocus1 = FocusNode();

  @override
  void initState() {
    fnameController.text =
        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERFNAME);

    emailController.text =
        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USEREMAIL);

    phoneController.text =
        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERMOBILE);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                    sizeBoxWidth(70),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Customer Support",
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
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sizeBoxHeight(30),
                            globalTextField2(
                              lable: "Name",
                              controller: fnameController,
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(fnameFocus);
                              },
                              focusNode: fnameFocus1,
                              hintText: "Name",
                              context: context,
                            ).paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(20),
                            globalTextField2(
                              lable: "Email",
                              controller: emailController,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(signUpPasswordFocusNode);
                              },
                              focusNode: signUpEmailIDFocusNode,
                              hintText: 'Email',
                              context: context,
                            ).paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(20),
                            globalTextField2(
                              lable: "Phone",
                              controller: phoneController,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(numberFocus);
                              },
                              focusNode: numberFocus1,
                              isNumber: true,
                              hintText: "Phone",
                              context: context,
                            ).paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(20),
                            globalTextField2(
                              lable: "Message",
                              controller: msgController,
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(msgFocus);
                              },
                              focusNode: msgFocus1,
                              maxLines: 5,
                              hintText: "Write Message",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              context: context,
                            ).paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(20),
                            label('GDPR Agreement',
                                    textColor: themeContro.isLightMode.value
                                        ? AppColors.black
                                        : AppColors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)
                                .paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(20),
                            customtext(),
                            sizeBoxHeight(20),
                            Center(
                              child: Obx(() {
                                return supportcontro.isLoading1.value
                                    ? Center(child: commonLoading())
                                    : GestureDetector(
                                        onTap: () {
                                          if (isTermsPrivacy == false) {
                                            snackBar(
                                                "Please accept the terms before proceeding.");
                                          } else if (fnameController
                                              .text.isEmpty) {
                                            snackBar("Please enter your name");
                                          } else if (emailController
                                              .text.isEmpty) {
                                            snackBar("Please enter your email");
                                          } else if (phoneController
                                              .text.isEmpty) {
                                            snackBar(
                                                "Please enter your mobile number");
                                          } else if (msgController
                                              .text.isEmpty) {
                                            snackBar(
                                                "Please enter your message");
                                          } else {
                                            supportcontro.customersupportApi(
                                              message: msgController.text,
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 260,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  AppColors.blue // Active color
                                              // Disabled color
                                              ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                AppAsstes.message3,
                                                scale: 4,
                                              ),
                                              sizeBoxWidth(7),
                                              label(
                                                'Send Message',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                textColor: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  bool isTermsPrivacy = false;

  Widget customtext() {
    return InkWell(
      onTap: () {
        setState(() {
          isTermsPrivacy = !isTermsPrivacy;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: isTermsPrivacy ? AppColors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(3),
              border: isTermsPrivacy
                  ? null
                  : Border.all(color: AppColors.greyColor),
            ),
            child: isTermsPrivacy
                ? const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  )
                : Container(),
          ),
          const SizedBox(
            width: 7,
          ),
          Flexible(
            child: Text(
                "I Agree that this app will store my submitted information so that they can respond to my request.",
                style: TextStyle(
                    fontSize: 12,
                    color: themeContro.isLightMode.value
                        ? Colors.black
                        : AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins")),
          )
        ],
      ),
    ).paddingSymmetric(horizontal: 20);
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
                "Customer Support",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }
}
