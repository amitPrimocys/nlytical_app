// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/google_signin.dart';
import 'package:nlytical_app/controllers/user_controllers/login_contro.dart';
import 'package:nlytical_app/auth/forgotpass.dart';
import 'package:nlytical_app/auth/mobile.dart';
import 'package:nlytical_app/auth/register.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:permission_handler/permission_handler.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool isTermsPrivacy = false;

  LoginContro logincontro = Get.put(LoginContro());
  final GlobalKey<FormState> _keyform = GlobalKey();

  bool isselected = false;

  void fieldcheck() {
    setState(() {
      isselected =
          emailcontroller.text.isEmail && passcontroller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    requestPermission();
    emailcontroller.addListener(fieldcheck);
    passcontroller.addListener(fieldcheck);
    super.initState();
  }

  Future<void> requestPermission() async {
    await Permission.notification.request();
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.photos.request();
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
              child: Form(
                key: _keyform,
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
                    sizeBoxHeight(20),
                    globalTextField(
                        lable: "Email Address",
                        lable2: ' *',
                        controller: emailcontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(signUpPasswordFocusNode);
                        },
                        isEmail: true,
                        focusNode: signUpEmailIDFocusNode,
                        hintText: 'Email Address',
                        context: context,
                        imagePath: 'assets/images/sms.png',
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
                                'assets/images/sms.png',
                                color: Colors.grey.shade500,
                                height: 20,
                              ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(12),
                    globalTextField(
                      lable: "Password",
                      lable2: ' *',
                      controller: passcontroller,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      focusNode: passFocusNode,
                      hintText: 'Password',
                      context: context,
                      imagePath: 'assets/images/sms.png',
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
                              'assets/images/lock.png',
                              color: Colors.grey.shade500,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(20),
                    forgetPassField(),
                    sizeBoxHeight(25),
                    Obx(() {
                      return logincontro.isLoading.value
                          ? commonLoading()
                          : GestureDetector(
                              // logincontro.loginApi(
                              //     Email: emailcontroller.text,
                              //     Password: passcontroller.text);

                              onTap: () {
                                if (_keyform.currentState!.validate()) {
                                  logincontro.loginApi(
                                    Email: emailcontroller.text,
                                    Password: passcontroller.text,
                                  );
                                }
                              },

                              child: Container(
                                height: 50,
                                width: Get.width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: AppColors.blue

                                  gradient: isselected
                                      ? AppColors.logoColork
                                      : AppColors.logoColorWith60Opacityk,
                                ),
                                child: Center(
                                  child: label(
                                    "Sign In",
                                    textColor: AppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                    }),
                    sizeBoxHeight(25),
                    orTextField(),
                    sizeBoxHeight(25),
                    Obx(
                      () => logincontro.isSocial.value
                          ? googleLoading()
                          : GestureDetector(
                              onTap: () async {
                                print("Go to Google Login");
                                try {
                                  // Set the button state to loading
                                  setState(() {
                                    // Update state as needed
                                    logincontro.isSocial(true);
                                  });

                                  // Perform the asynchronous operation, e.g., sign in with Google
                                  await signInWithGoogle(context);

                                  // If successful, set the button state to success
                                  logincontro.isSocial(false);
                                } catch (error) {
                                  // If there's an error, set the button state to fail
                                  logincontro.isSocial(false);
                                } finally {
                                  // Regardless of success or failure, set the button state back to idle
                                  logincontro.isSocial(false);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: Get.width * 0.7,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: themeContro.isLightMode.value
                                            ? AppColors.blue
                                            : AppColors.white),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      height: 20,
                                    ),
                                    sizeBoxWidth(10),
                                    label(
                                      "Continue with Google",
                                      maxLines: 2,
                                      textColor: themeContro.isLightMode.value
                                          ? AppColors.brown
                                          : AppColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    sizeBoxHeight(25),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const Mobile(),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: Container(
                        height: 50,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: themeContro.isLightMode.value
                                    ? AppColors.blue
                                    : AppColors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/call1.png',
                              height: 20,
                              color: themeContro.isLightMode.value
                                  ? AppColors.blue
                                  : AppColors.white,
                            ),
                            sizeBoxWidth(10),
                            label(
                              "Continue with Number",
                              maxLines: 2,
                              textColor: themeContro.isLightMode.value
                                  ? AppColors.brown
                                  : AppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
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
                              () => const Register(),
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
              ),
            )),
      ),
    );
  }

  Widget forgetPassField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isTermsPrivacy = !isTermsPrivacy;
            });
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Row(
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
                width: 5,
              ),
              const Text("Remember me",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"))
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(
              const Forgotpass(),
              transition: Transition.rightToLeft,
            );
          },
          child: const Text("Forgot Password ?",
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.blue,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins")),
        )
      ],
    ).paddingSymmetric(horizontal: 25);
  }

  Widget orTextField() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: themeContro.isLightMode.value
                ? Colors.black12
                : AppColors.colorD0D0D0,
          ),
        ),
        Text("Or".tr,
            style: TextStyle(
              fontSize: 14,
              color: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            )).paddingSymmetric(horizontal: 14),
        Expanded(
          child: Divider(
            color: themeContro.isLightMode.value
                ? Colors.black12
                : AppColors.colorD0D0D0,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 25);
  }
}
