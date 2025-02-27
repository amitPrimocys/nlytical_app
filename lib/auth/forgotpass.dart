import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/forgot_contro.dart';
import 'package:nlytical_app/auth/register.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  TextEditingController emailcontroller = TextEditingController();
  ForgotContro forgotcontro = Get.put(ForgotContro());

  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();
  final GlobalKey<FormState> _keyform = GlobalKey();

  bool isselected = false;

  void fieldcheck() {
    setState(() {
      isselected = emailcontroller.text.isEmail;
    });
  }

  @override
  void initState() {
    emailcontroller.addListener(fieldcheck);
    super.initState();
  }

  //   String _fcmtoken = "";
  // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // Future<bool> getToken() async {
  //   if (Platform.isIOS) {
  //     await firebaseMessaging.getToken().then((token) {
  //       setState(() {
  //         _fcmtoken = token!;
  //       });
  //       log("DEVICE_TOKEN:$_fcmtoken");
  //     });
  //   } else if (Platform.isAndroid) {
  //     await firebaseMessaging.getToken().then((token) {
  //       setState(() {
  //         _fcmtoken = token!;
  //       });
  //       log("DEVICE_TOKEN:$_fcmtoken");
  //     });
  //   }

  //   return true;
  // }

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
                    sizeBoxHeight(15),
                    sizeBoxHeight(17),
                    globalTextField(
                        lable: "Email Address",
                        lable2: ' *',
                        controller: emailcontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(signUpPasswordFocusNode);
                        },
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
                    sizeBoxHeight(25),
                    Obx(() {
                      return forgotcontro.isLoading.value
                          ? commonLoading()
                          : GestureDetector(
                              onTap: () {
                                // forgotcontro.forgotApi(
                                //   email: emailcontroller.text,
                                //   // device: _fcmtoken
                                // );

                                if (_keyform.currentState!.validate()) {
                                  forgotcontro.forgotApi(
                                    email: emailcontroller.text,
                                  );
                                }
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
              ),
            )),
      ),
    );
  }
}
