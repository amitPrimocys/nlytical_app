// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/login.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/controllers/theme_contro.dart';
import 'package:nlytical_app/controllers/vendor_controllers/chat_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/lang_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/login_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/policy_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/profile_cotroller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/review_controller.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/my_review_screen.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/profile.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/web_view.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ThemeContro themeContro = Get.find();
  LoginContro1 loginContro = Get.find();
  ChatControllervendor messageController = Get.find();

  ProfileCotroller profileCotroller = Get.find();
  String? selectedGender;
  PolicyController policyController = Get.find();
  ReviewControvendor reviewcontro = Get.put(ReviewControvendor());
  final reviewController = TextEditingController();
  FocusNode reviewFocus = FocusNode();
  FocusNode reviewFocus1 = FocusNode();
  double rateValue = 0;

  @override
  void initState() {
    reviewFocus.requestFocus();
    reviewFocus1.requestFocus();
    policyController.policyApi();
    policyController.termsApi();
    profileCotroller.getProfleApi();

    super.initState();
  }

  @override
  void dispose() {
    reviewFocus.dispose();
    reviewFocus1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    void handleURLButtonPress(BuildContext context, String url, title) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PrivacyWebView(htmlContent: url, title: title)));
    }

    return Obx(() {
      return Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
        bottomNavigationBar: BottomAppBar(
          color: themeContro.isLightMode.value
              ? Colors.white
              : AppColors.darkMainBlack,
          elevation: 0,
          height: 70,
          child: button(),
        ),
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
                  alignment: Alignment.center, // Aligns content to the center
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      label(
                        "Settings",
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w500,
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
                                sizeBoxHeight(30),
                                profileWidget(),
                                sizeBoxHeight(20),
                                containerDesing(
                                  onTap: () {
                                    Get.to(() => const ProfilePage());
                                  },
                                  img: AppAsstes.profile2,
                                  title: "Profile",
                                  height: 16,
                                ),
                                sizeBoxHeight(15),
                                containerDesing(
                                  onTap: () {
                                    Get.to(() => const MyReviewScreen());
                                  },
                                  img: AppAsstes.Star_border,
                                  title: "Business Review",
                                  height: 18,
                                ),
                                sizeBoxHeight(15),
                                containerDesing(
                                  onTap: () {
                                    bottomSheetGobal(
                                        bottomsheetHeight: 450,
                                        title: "Nlytical Feedback",
                                        child: openBottomFreedBack());
                                  },
                                  img: AppAsstes.feed1,
                                  title: "App Feedback",
                                  height: 18,
                                ),
                                sizeBoxHeight(15),
                                containerDesing(
                                  onTap: () {
                                    handleURLButtonPress(
                                        context,
                                        policyController
                                            .policyModel.value.data![0].text
                                            .toString(),
                                        'Privacy & Policy');
                                  },
                                  img: AppAsstes.policy,
                                  title: "Privacy & Policy",
                                  height: 18,
                                ),
                                sizeBoxHeight(15),
                                containerDesing(
                                  onTap: () {
                                    handleURLButtonPress(
                                        context,
                                        policyController
                                            .termsModel.value.data![0].text
                                            .toString(),
                                        'Terms & Condition');
                                  },
                                  img: AppAsstes.termcon,
                                  title: "Terms & Condition",
                                  height: 18,
                                ),
                                sizeBoxHeight(15),
                                themeContro.lightDarkModeSwitch(),
                                sizeBoxHeight(15),
                                containerDesing(
                                  onTap: () {
                                    bottomSheetGobal(
                                        bottomsheetHeight: 260,
                                        title: "App Language",
                                        child: openBottomLang());
                                  },
                                  img: AppAsstes.languagesquare,
                                  title: "App Language",
                                  height: 16,
                                ),
                                sizeBoxHeight(15),
                                logoutWidget(),
                                sizeBoxHeight(195),
                                // deleteAccWidget(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }

  Widget button() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // _selectDelete();
          bottomSheetGobal(
              bottomsheetHeight: 250,
              title: "Logout",
              child: openBottomDailog(isDeleteParameter: false));
        },
        child: Container(
          height: 50,
          width: Get.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(color: AppColors.blue),
              color: AppColors.blue),
          child: Center(
            child: label(
              "Logout",
              textColor: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
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
        child: Text(
          "Settings",
          style: poppinsFont(20, AppColors.black, FontWeight.w500),
        ),
      ).paddingOnly(left: 20, right: 20, top: 25),
    );
  }

  Widget profileWidget() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                  colors: [AppColors.bluee3, AppColors.bluee2],
                  begin: Alignment.topCenter,
                  end: Alignment.centerRight)),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.grey),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(userIMAGE, fit: BoxFit.cover,
                    loadingBuilder: (BuildContext ctx, Widget child,
                        ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                        child:
                            CupertinoActivityIndicator(color: AppColors.blue));
                  }
                }, errorBuilder: (BuildContext? context, Object? exception,
                        StackTrace? stackTrace) {
                  return const Icon(Icons.person, size: 40);
                })),
          ).paddingAll(5),
        ),
        sizeBoxHeight(10),
        profileCotroller.getDataModel.value.userDetails!.firstName!.isNotEmpty
            // .getprofilemodel.value!.userDetails!.firstName!.isNotEmpty
            ? label(
                profileCotroller.getDataModel.value.userDetails!.firstName!
                    .toString(),
                fontSize: 12,
                textColor: themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
                fontWeight: FontWeight.w500,
              )
            : const SizedBox.shrink(),
        sizeBoxHeight(5),
        profileCotroller.getDataModel.value.userDetails!.email!.isNotEmpty
            ? label(
                profileCotroller.getDataModel.value.userDetails!.email
                    .toString(),
                fontSize: 12,
                textColor: themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
                fontWeight: FontWeight.w500,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget containerDesing(
      {required Function() onTap,
      required String img,
      required String title,
      required double height}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getProportionateScreenHeight(55),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: !themeContro.isLightMode.value
                ? AppColors.darkGray
                : Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 4),
                  blurRadius: 14.4,
                  spreadRadius: 0,
                  color: !themeContro.isLightMode.value
                      ? AppColors.darkShadowColor
                      : Colors.grey.shade300),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(img,
                    height: height,
                    color: !themeContro.isLightMode.value
                        ? AppColors.white
                        : AppColors.black),
                sizeBoxWidth(10),
                Text(
                  title,
                  style: poppinsFont(
                      12,
                      !themeContro.isLightMode.value
                          ? AppColors.white
                          : AppColors.black,
                      FontWeight.w500),
                )
              ],
            ),
            Image.asset(
              'assets/images/arrow-left (1).png',
              color: !themeContro.isLightMode.value
                  ? AppColors.white
                  : AppColors.black,
              height: 16,
              width: 16,
            ),
          ],
        ).paddingSymmetric(horizontal: 15),
      ).paddingSymmetric(horizontal: 10),
    );
  }

  Widget logoutWidget() {
    return GestureDetector(
      onTap: () async {
        bottomSheetGobal(
            bottomsheetHeight: 250,
            title: "Delete Account",
            child: openBottomDailog(isDeleteParameter: true));
      },
      child: Container(
        height: getProportionateScreenHeight(55),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkGray,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 4),
                  blurRadius: 14.4,
                  spreadRadius: 0,
                  color: themeContro.isLightMode.value
                      ? Colors.grey.shade300
                      : AppColors.darkShadowColor),
            ]),
        child: Row(
          children: [
            Image.asset(AppAsstes.logout, height: 18),
            sizeBoxWidth(10),
            Text(
              "Delete Account",
              style: poppinsFont(12, AppColors.colorDE0000, FontWeight.w500),
            )
          ],
        ).paddingSymmetric(horizontal: 10),
      ).paddingSymmetric(horizontal: 10),
    );
  }

  openBottomDailog({required bool isDeleteParameter}) {
    return Column(
      children: [
        sizeBoxHeight(20),
        Center(
          child: Text(
            isDeleteParameter
                ? "Are you sure you want to \nDelete Account ?"
                : "Are you sure you want to \nLogout Account?",
            textAlign: TextAlign.center,
            style: poppinsFont(
                16,
                themeContro.isLightMode.value
                    ? AppColors.greyColor
                    : AppColors.white,
                FontWeight.w500),
          ),
        ),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonBorder(
              title: "Cancle",
              onPressed: () => Get.back(),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: getProportionateScreenHeight(42),
              width: getProportionateScreenWidth(140),
              fontColor: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
            ),
            sizeBoxWidth(25),
            CustomButtom(
              title: isDeleteParameter ? "Delete" : "Logout",
              onPressed: () async {
                if (isDeleteParameter) {
                  messageController.onlineuservendor(onlineStatus: "0");
                  loginContro.deleteApi();
                } else {
                  messageController.onlineuservendor(onlineStatus: "0");
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  await SharedPrefs.clear();
                  userEmail = '';
                  userID = '';
                  userIMAGE = '';
                  await SharedPrefs.remove(
                      SharedPreferencesKey.LOGGED_IN_VENDORID);
                  Get.offAll(() => const Login());
                }
                Get.back();
              },
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: getProportionateScreenHeight(42),
              width: getProportionateScreenWidth(140),
            ),
          ],
        )
      ],
    );
  }

  openBottomLang() {
    LanguageController languageController = Get.find();
    return Column(
      children: [
        sizeBoxHeight(10),
        Obx(() => Row(
              children: [
                Transform.scale(
                  scale: 1.1,
                  child: Radio(
                    activeColor: AppColors.blue,
                    fillColor: WidgetStateColor.resolveWith(
                        (states) => AppColors.blue), // Set radio color to white
                    value: 'English',
                    groupValue: languageController.selectedLanguage.value,
                    onChanged: (value) {
                      languageController.updateLanguage(value!);
                    },
                  ),
                ),
                Text(
                  'English'.tr,
                  style: poppinsFont(
                    12,
                    themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    FontWeight.w600,
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 30)),
        Obx(() => Row(
              children: [
                Transform.scale(
                  scale: 1.1,
                  child: Radio(
                    activeColor: AppColors.blue,
                    fillColor: WidgetStateColor.resolveWith(
                        (states) => AppColors.blue), // Set radio color to white
                    value: 'Hindi',
                    groupValue: languageController.selectedLanguage.value,
                    onChanged: (value) {
                      languageController.updateLanguage(value!);
                    },
                  ),
                ),
                Text(
                  'Hindi'.tr,
                  style: poppinsFont(
                    12,
                    themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    FontWeight.w600,
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonBorder(
              title: "Cancle",
              onPressed: () => Get.back(),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: getProportionateScreenHeight(42),
              width: getProportionateScreenWidth(140),
              fontColor: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
            ),
            sizeBoxWidth(25),
            CustomButtom(
              title: "Apply",
              onPressed: () async {
                Get.back();
              },
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: getProportionateScreenHeight(42),
              width: getProportionateScreenWidth(140),
            ),
          ],
        )
      ],
    );
  }

  openBottomFreedBack() {
    return Column(
      children: [
        sizeBoxHeight(20),
        Center(
          child: Text(
            "How was Your Experience with this place?",
            textAlign: TextAlign.center,
            style: poppinsFont(
                15,
                themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
                FontWeight.w500),
          ),
        ),
        sizeBoxHeight(25),
        RatingBar.builder(
          initialRating: 0, // Start with 3 stars selected
          minRating: 1, // The minimum rating the user can give is 1 star
          direction: Axis.horizontal, // Stars are laid out horizontally
          allowHalfRating: false, // Full stars only, no half-star ratings
          unratedColor: const Color.fromARGB(
              255, 241, 210, 162), // Color for unselected stars
          itemCount: 5, // Total number of stars is 5
          itemSize: 25,
          itemPadding:
              const EdgeInsets.symmetric(horizontal: 4), // Space between stars
          itemBuilder: (context, _) => Image.asset(
            'assets/images/star1.png',
            color: const Color(0xffFFA41C),
          ),
          onRatingUpdate: (rating) {
            setState(() {
              rateValue = rating; // Update the rating value
            });
            print(
                'Select Review :- ${rateValue.toString().replaceAll(".0", "")}');
          },
        ),
        sizeBoxHeight(15),
        TextFormField(
          cursorColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : AppColors.blue,
          autofocus: false,
          controller: reviewController,
          style: TextStyle(
              fontSize: 14,
              color: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w400),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: false,
          keyboardType: TextInputType.text,
          maxLines: 5,
          decoration: InputDecoration(
            // filled: true,
            // fillColor: Theme.of(context).brightness == Brightness.dark
            //     ? AppColors.appColorBlack
            //     : AppColors.scaffoldColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(color: AppColors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Colors.grey.shade200)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Colors.grey.shade200)),
            hintText: "Write Your Review....",
            hintStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400),

            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Colors.grey.shade200)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Colors.grey.shade200)),
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
          ),
        ).paddingSymmetric(horizontal: 25),
        sizeBoxHeight(20),
        Obx(() {
          return reviewcontro.isfeedback.value
              ? Center(child: commonLoading())
              : CustomButtom(
                  title: "Send",
                  onPressed: () async {
                    if (rateValue == 0) {
                      snackBar("Please add rat");
                    } else if (reviewController.text.isEmpty) {
                      snackBar("Please write your review");
                    } else {
                      reviewcontro.feedbackApi(
                          rateValue.toString().replaceAll(".0", ""),
                          reviewController.text);
                      reviewController.clear();

                      reviewcontro.feedbackmodel.refresh();

                      setState(() {});
                      Get.back();
                    }
                  },
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenWidth(260),
                );
        })
      ],
    );
  }
}
