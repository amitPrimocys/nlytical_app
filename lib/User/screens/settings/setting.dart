// ignore_for_file: prefer_const_constructors, unused_element, non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nlytical_app/utils/spinkit_loader.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/web_view.dart';
import 'package:nlytical_app/auth/google_signin.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/auth/welcome.dart';
import 'package:nlytical_app/controllers/user_controllers/appfeedback_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/chat_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/delete_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/feedback_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/get_profile_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/privacy_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/terms_contro.dart';
import 'package:nlytical_app/auth/login.dart';
import 'package:nlytical_app/User/screens/favourite/favourite.dart';
import 'package:nlytical_app/User/screens/review/my_review.dart';
import 'package:nlytical_app/User/screens/settings/profile.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/profile_loader.dart';
import 'package:nlytical_app/controllers/vendor_controllers/lang_controller.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/slider_custom.dart';
import 'package:nlytical_app/Vendor/screens/auth/subcription.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  GetprofileContro getprofilecontro = Get.find();
  DeleteController deletecontro = Get.put(DeleteController());
  PrivacyPolicyContro privacycontro = Get.put(PrivacyPolicyContro());
  ChatController messageController = Get.find();
  TermsContro termscontro = Get.put(TermsContro());
  bool themeSwitch_noti = false;

  FeedbackContro feedbackContro = Get.put(FeedbackContro());
  TextEditingController msgController = TextEditingController();
  String userID = '';
  @override
  void initState() {
    userID = SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
    getprofilecontro.getprofileApi();
    privacycontro.privacypolicyApi();
    termscontro.termsandcondiApi();
    super.initState();
  }

  File? file;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Obx(() {
        return Scaffold(
            extendBody: true,
            backgroundColor: themeContro.isLightMode.value
                ? AppColors.white
                : AppColors.darkMainBlack,
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
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
                      alignment:
                          Alignment.center, // Aligns content to the center
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          label(
                            "Setting",
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
                              ? AppColors.white
                              : AppColors.darkMainBlack,
                          borderRadius: BorderRadius.only(
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
                                sizeBoxHeight(10),
                                userID.isEmpty
                                    ? Column(
                                        children: [
                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // openBottomForImagePick(context);
                                              },
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            100),
                                                    width:
                                                        getProportionateScreenWidth(
                                                            100),
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                AppColors.blue1,
                                                            boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 10,
                                                            spreadRadius: 0,
                                                            color:
                                                                AppColors.blue1,
                                                          )
                                                        ]),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.white,
                                                        border: Border.all(
                                                          width: 2.5,
                                                          color: AppColors.blue,
                                                        ),
                                                      ),
                                                      child: ClipOval(
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        child: Image.asset(
                                                          AppAsstes
                                                              .default_user,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ).paddingAll(3),
                                                    ).paddingAll(3),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          sizeBoxHeight(10),
                                          label(
                                            'Guest',
                                            fontSize: 12,
                                            textColor: AppColors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          sizeBoxHeight(5),
                                        ],
                                      )
                                    : profileImage(context),
                                sizeBoxHeight(20),
                                profiledetail(),
                                sizeBoxHeight(165),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      });
    });
  }

  Widget profileImage(BuildContext context) {
    return Obx(() {
      return getprofilecontro.isprofile.value
          ? ProfileLoader(context)
          : Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: getProportionateScreenHeight(100),
                        width: getProportionateScreenWidth(100),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.blue1,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: AppColors.blue1,
                              )
                            ]),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeContro.isLightMode.value
                                ? AppColors.white
                                : AppColors.darkGray,
                            border: Border.all(
                              width: 2.5,
                              color: AppColors.blue,
                            ),
                          ),
                          child: ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              getprofilecontro
                                  .getprofilemodel.value!.userDetails!.image
                                  .toString(),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                return Center(
                                    child: SpinKitSpinningLines(
                                        size: 30, color: AppColors.blue));
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppAsstes.default_user,
                                  fit: BoxFit.cover,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ).paddingAll(3),
                        ).paddingAll(3),
                      ),
                    ],
                  ),
                ),
                sizeBoxHeight(10),
                getprofilecontro.getprofilemodel.value!.userDetails!.firstName!
                        .isNotEmpty
                    ? label(
                        getprofilecontro
                            .getprofilemodel.value!.userDetails!.firstName
                            .toString(),
                        fontSize: 12,
                        textColor: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w600,
                      )
                    : SizedBox.shrink(),
                sizeBoxHeight(5),
                getprofilecontro
                        .getprofilemodel.value!.userDetails!.email!.isNotEmpty
                    ? label(
                        getprofilecontro
                            .getprofilemodel.value!.userDetails!.email
                            .toString(),
                        fontSize: 12,
                        textColor: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w500,
                      )
                    : SizedBox.shrink(),
              ],
            );
    });
  }

  Widget profiledetail() {
    void handleURLButtonPress(BuildContext context, String url, title) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PrivacyWebView(htmlContent: url, title: title)));
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (userID.isEmpty) {
              snackBar('Please login to access to add store');
            } else {
              // getprofilecontro.updateApi(
              //   isUpdateProfile: false,
              // );

              Get.to(
                () => SubscriptionSceen(),
                transition: Transition.rightToLeft,
              );
            }
          },
          child: Container(
            height: 45,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.color585859.withOpacity(0.10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/shop-add.png',
                      height: 16,
                      width: 16,
                      color: themeContro.isLightMode.value
                          ? Colors.black
                          : AppColors.white,
                    ),
                    sizeBoxWidth(7),
                    label(
                      'Add Store',
                      fontSize: 12,
                      textColor: themeContro.isLightMode.value
                          ? Colors.black
                          : AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/arrow-left (1).png',
                  color: themeContro.isLightMode.value
                      ? Colors.black
                      : AppColors.white,
                  height: 16,
                  width: 16,
                ),
              ],
            ).paddingSymmetric(horizontal: 15),
          ),
        ),
        sizeBoxHeight(15),
        setting(
          imagepath: 'assets/images/profile.png',
          name: 'Profile',
          buttonOnTap: () {
            if (userID.isEmpty) {
              snackBar('Please login to access to profile');
            } else {
              Get.to(() => Profile(), transition: Transition.rightToLeft);
            }
          },
        ),
        sizeBoxHeight(15),
        setting(
          imagepath: AppAsstes.heart,
          name: 'Favorites',
          buttonOnTap: () {
            if (userID.isEmpty) {
              snackBar('Please login to access to favourite');
            } else {
              Get.to(
                  () => Favourite(
                        tap: true,
                      ),
                  transition: Transition.rightToLeft);
            }
          },
        ),
        sizeBoxHeight(15),
        setting(
          imagepath: 'assets/images/Star_border.png',
          name: 'My Review',
          buttonOnTap: () {
            if (userID.isEmpty) {
              snackBar('Please login to access Review');
            } else {
              Get.to(Review(), transition: Transition.rightToLeft);
            }
          },
        ),
        sizeBoxHeight(15),
        setting(
          imagepath: AppAsstes.lock2,
          name: 'Privacy & Policy',
          buttonOnTap: () {
            handleURLButtonPress(
                context,
                privacycontro.privacymodel.value!.data![0].text!,
                'Privacy & Policy');
            //  Get.to(PrivacyPolicy(), transition: Transition.rightToLeft);
          },
        ),
        sizeBoxHeight(15),
        setting(
          imagepath: 'assets/images/terms & con.png',
          name: 'Terms & Condition',
          buttonOnTap: () {
            handleURLButtonPress(
                context, termscontro.termsdata[0].text!, 'Terms and Condition');
          },
        ),
        sizeBoxHeight(15),
        themeContro.lightDarkModeSwitch(isVendor: false),
        sizeBoxHeight(15),
        setting(
          imagepath: 'assets/images/language-square.png',
          name: 'App Language',
          buttonOnTap: () {
            bottomSheetGobal(
                bottomsheetHeight: 260,
                title: "App Language",
                child: _selectlanguage());
          },
        ),
        sizeBoxHeight(15),
        setting(
          imagepath: 'assets/images/share.png',
          name: 'Share App',
          buttonOnTap: () {
            Share.share('Check out this amazing app: [Your App Link Here]');
          },
        ),
        sizeBoxHeight(15),
        setting(
          imagepath: 'assets/images/feedback.png',
          name: 'App Feedback',
          buttonOnTap: () {
            bottomSheetGobal(
                bottomsheetHeight: Get.height * 0.7,
                title: "Nlytical App Feedback",
                child: appFeedback());
          },
        ),
        sizeBoxHeight(15),
        InkWell(
          onTap: () {},
          child: Container(
            height: 45,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Colors.white),
                color: themeContro.isLightMode.value
                    ? Colors.white
                    : AppColors.darkGray,
                boxShadow: [
                  BoxShadow(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkShadowColor,
                    blurRadius: 14.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 4.0), // shadow direction: bottom right
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/app_versio.png',
                      height: 16,
                      width: 16,
                      color: themeContro.isLightMode.value
                          ? Colors.black
                          : AppColors.white,
                    ),
                    sizeBoxWidth(6),
                    label(
                      'App Version',
                      fontSize: 12,
                      textColor: themeContro.isLightMode.value
                          ? Colors.black
                          : AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                label(
                  '120.253',
                  fontSize: 12,
                  textColor: themeContro.isLightMode.value
                      ? Colors.grey
                      : AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ).paddingSymmetric(horizontal: 15),
          ),
        ),
        sizeBoxHeight(15),
        userID.isEmpty
            ? SizedBox.shrink()
            : InkWell(
                onTap: () {
                  bottomSheetGobal(
                      bottomsheetHeight: 250,
                      title: "Delete Account",
                      child: openBottomDailog(isDeleteParameter: true));
                },
                child: Container(
                  height: 45,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: Colors.white),
                      color: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkGray,
                      boxShadow: [
                        BoxShadow(
                          color: themeContro.isLightMode.value
                              ? Colors.grey.shade300
                              : AppColors.darkShadowColor,
                          blurRadius: 14.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 4.0), // shadow direction: bottom right
                        )
                      ]),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logout.png',
                        height: 16,
                        width: 16,
                      ),
                      sizeBoxWidth(6),
                      label(
                        'Delete Account',
                        fontSize: 12,
                        textColor: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 15),
                ),
              ),
        sizeBoxHeight(20),
      ],
    ).paddingSymmetric(horizontal: 20);
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
                  messageController.onlineuser(onlineStatus: "0");
                  deletecontro.deleteApi();
                } else {
                  messageController.onlineuser(onlineStatus: "0");
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  await SharedPrefs.clear();
                  userEmail = '';
                  userID = '';
                  userIMAGE = '';
                  await SharedPrefs.remove(
                      SharedPreferencesKey.LOGGED_IN_VENDORID);
                  signOutGoogle();
                  Get.offAll(() => const Welcome());
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

  Widget button() {
    return userID.isEmpty
        ? Center(
            child: GestureDetector(
              onTap: () async {
                messageController.onlineuser(onlineStatus: "0");
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.clear();
                await SharedPrefs.clear();
                Get.offAll(const Login(), transition: Transition.rightToLeft);
              },
              child: Container(
                height: 50,
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.blue),
                child: Center(
                  child: label(
                    "Login",
                    textColor: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: GestureDetector(
              onTap: () {
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

  _selectlanguage() {
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

  appFeedback() {
    final AppfeedbackContro appfeedbackContro = Get.put(AppfeedbackContro());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label(
              'Feel Free to share your feedback with Us',
              fontSize: 14,
              textColor: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w500,
            ),
            sizeBoxHeight(15),
            Container(
              height: 125,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      appfeedbackContro.emojis.length,
                      (index) {
                        return Opacity(
                          opacity:
                              appfeedbackContro.sliderValue.value.round() ==
                                      index + 1
                                  ? 1.0
                                  : 0.3, // Adjust opacity based on sliderValue
                          child: Column(
                            children: [
                              Text(
                                appfeedbackContro.emojis[index],
                                style: const TextStyle(fontSize: 25),
                              ),
                              if (appfeedbackContro.sliderValue.value.round() ==
                                  index + 1)
                                label(
                                  appfeedbackContro.emojiLabels[index],
                                  fontSize: 10,
                                  textColor: themeContro.isLightMode.value
                                      ? AppColors.black
                                      : AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ), // Show label for the selected emoji
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SliderTheme(
                      data: SliderThemeData(
                        trackShape: GradientRectSliderTrackShape(
                            gradient: AppColors.logoColorWith60Opacity1,
                            darkenInactive: true),
                        thumbShape: CustomThumbShape(),
                      ),
                      child: Slider(
                        // thumbColor: Colors.white,
                        min: 1.0,
                        divisions: appfeedbackContro.emojis.length - 1,
                        max: appfeedbackContro.emojis.length.toDouble(),
                        value: appfeedbackContro.sliderValue.value.clamp(
                            1.0, appfeedbackContro.emojis.length.toDouble()),
                        onChanged: (value) {
                          appfeedbackContro.sliderValue.value = value;
                          print(
                              'Select Review :- ${appfeedbackContro.sliderValue.toString().replaceAll(".0", "")}');
                        },
                      )),
                ],
              ),
            ),
            sizeBoxHeight(10),
            TextFormField(
              cursorColor: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              autofocus: false,
              controller: msgController,
              style: TextStyle(
                  fontSize: 14,
                  color: themeContro.isLightMode.value
                      ? Colors.black
                      : AppColors.white,
                  fontWeight: FontWeight.w400),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              readOnly: false,
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
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
                errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 10),
              ),
            ),
            sizeBoxHeight(15),
            Obx(() {
              return feedbackContro.isfeedback.value
                  ? commonLoading()
                  : GestureDetector(
                      onTap: () {
                        feedbackContro.feedbackApi(
                            appfeedbackContro.sliderValue
                                .toString()
                                .replaceAll(".0", ""),
                            msgController.text);
                        msgController.clear();

                        feedbackContro.feedbackmodel.refresh();

                        setState(() {});
                        Get.back();
                      },
                      child: Center(
                        child: Container(
                          height: getProportionateScreenHeight(50),
                          width: getProportionateScreenWidth(250),
                          decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: label(
                              'Send',
                              fontSize: 14,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
            }),
          ],
        ),
      );
    });
  }
}
