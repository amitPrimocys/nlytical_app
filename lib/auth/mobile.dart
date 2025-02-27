// ignore_for_file: unnecessary_string_interpolations, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/mobile_contro.dart';
import 'package:nlytical_app/auth/register.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  TextEditingController mobilecontroller = TextEditingController();
  MobileContro mobilecontro = Get.put(MobileContro());
  int maxLength = 10;

  bool isselected = false;

  void fieldcheck() {
    setState(() {
      isselected = mobilecontroller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    mobilecontroller.addListener(fieldcheck);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
            color: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkMainBlack,
            image: const DecorationImage(
              image: AssetImage(AppAsstes.appbackground),
              fit: BoxFit.fitWidth,
            )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  sizeBoxHeight(105),
                  Image.asset(
                    AppAsstes.logo,
                    height: 55,
                    width: 180,
                    fit: BoxFit.contain,
                    // width: SizeConfig.blockSizeHorizontal * 50,
                  ).paddingSymmetric(
                    horizontal: 100,
                  ),
                  sizeBoxHeight(15),
                  Center(
                    child: label(
                      "Discover more about our app by registering",
                      maxLines: 2,
                      textColor: const Color.fromRGBO(113, 113, 113, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizeBoxHeight(1),
                  Center(
                    child: label(
                      "or logging in",
                      maxLines: 2,
                      textColor: const Color.fromRGBO(113, 113, 113, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizeBoxHeight(15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        label(
                          'Mobile Number',
                          fontSize: 10,
                          textColor: themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        sizeBoxWidth(3),
                        label(' *',
                            textColor: Colors.redAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 20),
                  sizeBoxHeight(4),
                  IntlPhoneField(
                    showCountryFlag: true,
                    showDropdownIcon: false,
                    initialCountryCode: "IN",
                    onCountryChanged: (value) {
                      contrycode = value.dialCode;
                      print('+$contrycode');
                    },
                    onChanged: (number) {
                      print(number);
                    },
                    dropdownTextStyle: TextStyle(
                        fontSize: 14,
                        color: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                    cursorColor: themeContro.isLightMode.value
                        ? AppColors.blue
                        : Colors.white,
                    autofocus: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                        fontSize: 14,
                        color: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                    controller: mobilecontroller,
                    keyboardType: TextInputType.number,
                    flagsButtonPadding: const EdgeInsets.only(left: 5),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: themeContro.isLightMode.value
                          ? Colors.transparent
                          : AppColors.darkGray,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: AppColors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: themeContro.isLightMode.value
                                  ? AppColors.colorEFEFEF
                                  : AppColors.grey1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.redAccent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.redAccent)),
                      hintText: "Enter Your Mobile Number".tr,
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.colorB0B0B0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.sufcolor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/call.png',
                              color: Colors.grey.shade500,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 11),
                    ),
                  ).paddingSymmetric(horizontal: 20),
                  sizeBoxHeight(25),
                  Obx(() {
                    return mobilecontro.isLoading.value
                        ? Center(child: commonLoading())
                        : GestureDetector(
                            onTap: () {
                              if (mobilecontroller.text.isEmpty) {
                                snackBar("Please enter your mobile number");
                              } else {
                                mobilecontro.registerNumberApi(
                                  Newmobile:
                                      "$contrycode${mobilecontroller.text}",
                                  Countrycode: '$contrycode',
                                );
                              }
                              // if (_keyform.currentState!.validate()) {
                              //   mobilecontro.registerNumberApi(
                              //     Newmobile:
                              //         "$contrycode${mobilecontroller.text}",
                              //     Countrycode: '$contrycode',
                              //   );
                              // }
                              // maxLength == mobilecontroller.text.length
                              //     ? mobilecontro.registerNumberApi(
                              //         Newmobile:
                              //             "$contrycode${mobilecontroller.text}",
                              //         Countrycode: '$contrycode',
                              //       )
                              //     : null;
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: isselected
                                    ? AppColors.logoColork
                                    : AppColors.logoColorWith60Opacityk,
                              ),
                              child: Center(
                                child: label(
                                  "Get OTP",
                                  textColor: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                  }),
                  SizedBox(
                    height: Get.height * 0.46,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      label(
                        "Don’t have an account? ",
                        textColor: AppColors.brown,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            const Register(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: label(
                          "Sign Up",
                          textColor: AppColors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
