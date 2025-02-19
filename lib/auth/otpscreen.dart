// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/forgot_otp_controller.dart';
import 'package:nlytical_app/controllers/user_controllers/mobile_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/otp_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/register_contro.dart';
import 'package:nlytical_app/auth/login.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:pinput/pinput.dart';

class Otpscreen extends StatefulWidget {
  String? email;
  String? passwrd;
  String? number;
  String? countryCode;
  String? usernme;
  String? fname;
  String? lname;
  String? devicetoken;
  int isfortap;
  Otpscreen(
      {super.key,
      this.email,
      this.number,
      this.countryCode,
      required String devicetoken,
      required this.isfortap});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpcontroller = TextEditingController();
  // EmailRegisterContro emailcontro = Get.put(EmailRegisterContro());
  RegisterContro registercontro = Get.put(RegisterContro());

  OtpController otpcontro = Get.put(OtpController());
  ForgotOtpController forgotOtpController = Get.put(ForgotOtpController());
  MobileContro mobilecontro = Get.put(MobileContro());

  late Timer _timer;
  int _currentSeconds = 60;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds == 0) {
        _timer.cancel();
        setState(() {
          _currentSeconds = 60;
        });
      } else {
        setState(() {
          _currentSeconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.blue,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.greyColor),
        border: Border.all(color: AppColors.colorD0D0D0),
        borderRadius: BorderRadius.circular(4),
      ),
    );
    final focusedPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.blue,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.appColor),
        border: Border.all(color: AppColors.colorD0D0D0),
        borderRadius: BorderRadius.circular(4),
      ),
    );
    final submittedPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.blue,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.appColor),
        border: Border.all(color: AppColors.blue),
        borderRadius: BorderRadius.circular(4),
      ),
    );
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
                  sizeBoxHeight(125),
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
                  sizeBoxHeight(18),
                  Center(
                    child: label(
                      "Verification Code",
                      textColor: themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  sizeBoxHeight(18),
                  Center(
                    child: label(
                      "We have sent the code verification",
                      textColor: AppColors.brown,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizeBoxHeight(1),
                  Center(
                    child: widget.isfortap == 1
                        ? label(
                            "to your Mobile Number",
                            textColor: AppColors.brown,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          )
                        : label(
                            "to your Email Address",
                            textColor: AppColors.brown,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                  sizeBoxHeight(18),
                  Center(
                    child: label(
                      widget.isfortap == 1
                          ? "${widget.number}"
                          : "${widget.email}",
                      textColor: themeContro.isLightMode.value
                          ? Colors.black
                          : AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  sizeBoxHeight(15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      length: 4,
                      showCursor: true,
                      controller: otpcontroller,
                      autofocus: true,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      onChanged: (value) {
                        debugPrint('val::::::$value');

                        setState(() {});
                      },
                    ),
                  ).paddingSymmetric(horizontal: 40),
                  sizeBoxHeight(25),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_currentSeconds == 60) {
                          setState(() {
                            _startTimer();
                          });
                          if (widget.isfortap == 1) {
                            // for mobile number
                            mobilecontro.registerNumberApi(
                              Newmobile: widget.number!,
                              Countrycode: '+$contrycode',
                            );
                          } else if (widget.isfortap == 2) {
                            forgotOtpController.forgotVerifyOtpApi(
                                email: widget.email!);
                          } else {
                            registercontro.registerApi(
                              Username: widget.usernme,
                              Firstname: widget.fname,
                              Lastname: widget.lname,
                              // Newmobile:
                              //     "$contrycode ${mobilecontroller.text}",
                              Newmobile: widget.number,
                              Countrycode: '+$contrycode',
                              Email: widget.email,
                              Password: widget.passwrd,

                              // device: _fcmtoken
                            );
                          }
                        }
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          fontSize: 14,
                          color: _currentSeconds == 60
                              ? AppColors.blue
                              : Colors.grey, // Change color based on condition
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  sizeBoxHeight(12),
                  Center(
                    child: label(
                      "Resend Code in 0:$_currentSeconds",
                      textColor: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizeBoxHeight(30),
                  Obx(() {
                    return otpcontro.isLoading.value
                        ? loader()
                        : GestureDetector(
                            onTap: () {
                              if (widget.isfortap == 1) {
                                print("Mobile OTP");
                                otpcontro.otpApi(
                                  mobile: widget.number!,
                                  otp: otpcontroller.text, email: '',
                                  // Device: fcmToken,
                                );
                              } else if (widget.isfortap == 2) {
                                print("EMAIL OTP");
                                forgotOtpController.forgotVerifyOtpApi(
                                  email: widget.email!,
                                  otp: otpcontroller.text,
                                );
                              } else if (widget.isfortap == 0) {
                                print("SignUp Otp");
                                otpcontro.otpApi(
                                  email: widget.email,
                                  otp: otpcontroller.text, mobile: '',
                                  // Device: fcmToken,
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              width: Get.width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: otpcontroller.length == 4
                                    ? AppColors.logoColork
                                    : AppColors.logoColorWith60Opacityk,
                              ),
                              child: Center(
                                child: label(
                                  "Submit",
                                  textColor: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                  }),
                  SizedBox(
                    height: Get.height * 0.18,
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
                            const Login(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: label(
                          "Sign In",
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
