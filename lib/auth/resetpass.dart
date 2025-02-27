// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/password_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/reset_contro.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Resetpass extends StatefulWidget {
  String? email;
  Resetpass({
    super.key,
    this.email,
  });

  @override
  State<Resetpass> createState() => _ResetpassState();
}

class _ResetpassState extends State<Resetpass> {
  TextEditingController conformcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  FocusNode passFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode conformpassFocusNode = FocusNode();
  FocusNode conformpasswordFocusNode = FocusNode();

  ResetContro resetcontro = Get.put(ResetContro());
  PassCheckController passCheckCtrl = Get.put(PassCheckController());
  final GlobalKey<FormState> _keyform = GlobalKey();

  bool isselected = false;

  // void fieldcheck() {
  //   setState(() {
  //     isselected = passcontroller.text.isNotEmpty &&
  //         passcontroller.text.contains(RegExp(
  //             r'[A-Za-z0-9@#$%^&+=]')) && // Example: check for specific characters
  //         passcontroller.text.length >= 8 && // Minimum length requirement
  //         conformcontroller.text.isNotEmpty;
  //   });
  // }

  void fieldcheck() {
    setState(() {
      isselected = passcontroller.text.isNotEmpty &&
          passcontroller.text.contains(
              RegExp(r'[A-Za-z0-9@#$%^&+=]')) && // Specific characters
          passcontroller.text.length >= 8 && // Minimum length
          conformcontroller.text.isNotEmpty && // Confirm password not empty
          passcontroller.text ==
              conformcontroller.text; // Confirm matches new password
    });
  }

  @override
  void initState() {
    conformcontroller.addListener(fieldcheck);
    passcontroller.addListener(fieldcheck);

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
            body: Form(
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
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Row(
                  //     children: [
                  //       label(
                  //         'New Password',
                  //         fontSize: 10,
                  //         textColor: AppColors.black,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //       sizeBoxWidth(3),
                  //       label(' *',
                  //           textColor: Colors.redAccent,
                  //           fontSize: 11,
                  //           fontWeight: FontWeight.w600)
                  //     ],
                  //   ),
                  // ).paddingSymmetric(horizontal: 20),
                  // sizeBoxHeight(4),
                  // confirm().paddingSymmetric(horizontal: 20),
                  // globalTextField(
                  //     lable: "New Password",
                  //     lable2: " *",
                  //     controller: passcontroller,
                  //     onEditingComplete: () {
                  //       FocusScope.of(context).requestFocus(passwordFocusNode);
                  //     },
                  //     focusNode: passFocusNode,
                  //     hintText: 'Enter New Password',
                  //     context: context,
                  //     imagePath: 'assets/images/sms.png',
                  //     suffixIcon: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //         height: 26,
                  //         width: 26,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Colors.grey.shade200),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Image.asset(
                  //             'assets/images/lock.png',
                  //             color: Colors.grey.shade500,
                  //             height: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     )).paddingSymmetric(horizontal: 20),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        label(
                          'New Password',
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
                  passwordField().paddingSymmetric(horizontal: 10),
                  sizeBoxHeight(15),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        label(
                          'Confirm Password',
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
                  confirm().paddingSymmetric(horizontal: 20),
                  // globalTextField(
                  //   lable: "Confirm Password",
                  //   lable2: " *",
                  //   controller: conformcontroller,
                  //   onEditingComplete: () {
                  //     FocusScope.of(context)
                  //         .requestFocus(conformpasswordFocusNode);
                  //   },
                  //   focusNode: conformpassFocusNode,
                  //   hintText: 'Confirm Password',
                  //   context: context,
                  //   imagePath: 'assets/images/sms.png',
                  //   suffixIcon: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       height: 26,
                  //       width: 26,
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle, color: Colors.grey.shade200),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Image.asset(
                  //           'assets/images/lock.png',
                  //           color: Colors.grey.shade500,
                  //           height: 20,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'please re-enter new password';
                  //     }
                  //     print(passcontroller.text);
                  //     print(conformcontroller.text);
                  //     if (passcontroller.text != conformcontroller.text) {
                  //       return 'password does not match';
                  //     }
                  //     return null;
                  //   },
                  // ).paddingSymmetric(horizontal: 20),
                  sizeBoxHeight(25),
                  Obx(() {
                    return resetcontro.isLoading.value
                        ? commonLoading()
                        : GestureDetector(
                            onTap: () {
                              // Get.to(resetcontro.resetApi(
                              //     Email: widget.email,
                              //     Password: passcontroller.text,
                              //     ConfirmPassword: conformcontroller.text));

                              if (_keyform.currentState!.validate()) {
                                resetcontro.resetApi(
                                    Email: widget.email,
                                    Password: passcontroller.text,
                                    ConfirmPassword: conformcontroller.text);
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
                                  "Sign In",
                                  textColor: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                  }),
                ],
              ),
            )),
      ),
    );
  }

  Widget confirm() {
    return TextFormField(
      cursorColor:
          themeContro.isLightMode.value ? AppColors.blue : Colors.white,
      autofocus: false,
      style: poppinsFont(
          14,
          themeContro.isLightMode.value ? Colors.black : AppColors.white,
          FontWeight.w400),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: conformcontroller,
      readOnly: false,
      keyboardType: TextInputType.text,
      // Toggle obscure text
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                    : AppColors.darkBorder)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.redAccent)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.redAccent)),
        hintText: "Confirm Password",
        hintStyle: poppinsFont(14, AppColors.colorB0B0B0, FontWeight.w400),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 26,
            width: 26,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.sufcolor),
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
        errorStyle: poppinsFont(12, Colors.redAccent, FontWeight.normal),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Re-Enter New Password';
        }
        // ignore: avoid_print
        print(passcontroller.text);
        // ignore: avoid_print
        print(conformcontroller.text);
        if (passcontroller.text != conformcontroller.text) {
          return 'Password Does Not Match';
        }
        return null;
      },
    );
  }

  Widget passwordField() {
    return Theme(
      data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: AppColors.blue,
              cursorColor: AppColors.blue,
              selectionColor: AppColors.blue.withOpacity(0.5))),
      child: Obx(() {
        return Column(
          children: [
            TextFormField(
              controller: passcontroller,
              focusNode: passFocusNode,
              cursorColor: AppColors.blue,

              onEditingComplete: () {
                // FocusScope.of(context).nextFocus();
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: poppinsFont(
                  14,
                  themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
                  FontWeight.normal),
              // focusNode: focusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              onSaved: (newValue) {
                FocusScope.of(context).nextFocus();
              },

              onChanged: (value) {
                if (value.length < 8) {
                  passCheckCtrl.moreThan8Char(false);
                  // return "Minimum 8 characters required";
                } else {
                  passCheckCtrl.moreThan8Char(true);
                }

                // Check if password contains a special character
                if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                  passCheckCtrl.oneSpecialCaseChar(false);
                  // return "Password must contain at least one special character";
                } else {
                  passCheckCtrl.oneSpecialCaseChar(true);
                }

                // Check if password contains at least one number
                if (!value.contains(RegExp(r'[0-9]'))) {
                  passCheckCtrl.oneNumberChar(false);
                  // return "Password must contain at least one number";
                } else {
                  passCheckCtrl.oneNumberChar(true);
                }

                // Check if password contains at least one lowercase letter
                if (!value.contains(RegExp(r'[a-z]'))) {
                  passCheckCtrl.oneLowerCaseChar(false);
                  // return "Password must contain at least one lowercase letter";
                } else {
                  passCheckCtrl.oneLowerCaseChar(true);
                }

                // Check if password contains at least one uppercase letter
                if (!value.contains(RegExp(r'[A-Z]'))) {
                  passCheckCtrl.oneUpperCaseChar(false);
                  // return "Password must contain at least one uppercase letter";
                } else {
                  passCheckCtrl.oneUpperCaseChar(true);
                }

                if (value.isEmpty) {
                  passCheckCtrl.moreThan8Char(false);
                  passCheckCtrl.oneNumberChar(false);
                  passCheckCtrl.oneUpperCaseChar(false);
                  passCheckCtrl.oneLowerCaseChar(false);
                  passCheckCtrl.oneSpecialCaseChar(false);
                }
              },
              readOnly: false,

              // textAlignVertical: TextAlignVertical.top,
              // expands: true,
              // expands: true,
              // obscureText: userAuthController.isObscureForSignUp.value,
              decoration: InputDecoration(
                // prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 40),
                // prefixIcon: Text('+91 '),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.sufcolor),
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
                floatingLabelBehavior: FloatingLabelBehavior.always,

                hintText: "New Password",
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),

                hintStyle:
                    poppinsFont(14, AppColors.colorB0B0B0, FontWeight.w400),
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
                            : AppColors.darkBorder)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),

                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.redAccent)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.redAccent)),
                errorStyle:
                    poppinsFont(12, Colors.redAccent, FontWeight.normal),
                labelStyle: poppinsFont(12, AppColors.black, FontWeight.w400),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return 'Password must contain at least one uppercase letter';
                }
                if (!RegExp(r'[a-z]').hasMatch(value)) {
                  return 'Password must contain at least one lowercase letter';
                }
                if (!RegExp(r'\d').hasMatch(value)) {
                  return 'Password must contain at least one number';
                }
                if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Password must contain at least one special character';
                }
                return null;
              },
            ).paddingSymmetric(horizontal: 6).paddingSymmetric(
                vertical: (passCheckCtrl.moreThan8Char.value &&
                        passCheckCtrl.oneNumberChar.value &&
                        passCheckCtrl.oneUpperCaseChar.value &&
                        passCheckCtrl.oneLowerCaseChar.value &&
                        passCheckCtrl.oneSpecialCaseChar.value)
                    ? 0
                    : 0),
            (passCheckCtrl.moreThan8Char.value &&
                    passCheckCtrl.oneNumberChar.value &&
                    passCheckCtrl.oneUpperCaseChar.value &&
                    passCheckCtrl.oneLowerCaseChar.value &&
                    passCheckCtrl.oneSpecialCaseChar.value)
                ? const SizedBox.shrink()
                : Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          passCheckCtrl.moreThan8Char.value
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.red,
                                ),
                          Text("8 or more character ",
                              style: poppinsFont(
                                  12,
                                  passCheckCtrl.moreThan8Char.value
                                      ? Colors.green
                                      : Colors.red,
                                  FontWeight.w400)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          passCheckCtrl.oneNumberChar.value
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.red,
                                ),
                          Text("1 number ",
                              style: poppinsFont(
                                  12,
                                  passCheckCtrl.oneNumberChar.value
                                      ? Colors.green
                                      : Colors.red,
                                  FontWeight.w400)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          passCheckCtrl.oneUpperCaseChar.value
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.red,
                                ),
                          Text("1 Uppercase ",
                              style: poppinsFont(
                                  12,
                                  passCheckCtrl.oneUpperCaseChar.value
                                      ? Colors.green
                                      : Colors.red,
                                  FontWeight.w400)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          passCheckCtrl.oneLowerCaseChar.value
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.red,
                                ),
                          Text("1 LowerCase ",
                              style: poppinsFont(
                                  12,
                                  passCheckCtrl.oneLowerCaseChar.value
                                      ? Colors.green
                                      : Colors.red,
                                  FontWeight.w400)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          passCheckCtrl.oneSpecialCaseChar.value
                              ? const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.red,
                                ),
                          Text("1 special character ",
                              style: poppinsFont(
                                  12,
                                  passCheckCtrl.oneSpecialCaseChar.value
                                      ? Colors.green
                                      : Colors.red,
                                  FontWeight.w400)),
                        ],
                      )
                    ],
                  ),
            (passCheckCtrl.moreThan8Char.value &&
                    passCheckCtrl.oneNumberChar.value &&
                    passCheckCtrl.oneUpperCaseChar.value &&
                    passCheckCtrl.oneLowerCaseChar.value &&
                    passCheckCtrl.oneSpecialCaseChar.value)
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 0,
                  ),
          ],
        ).paddingSymmetric(horizontal: 6);
      }),
    );
  }
}
