// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/password_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/register_contro.dart';
import 'package:nlytical_app/auth/login.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();

  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();
  FocusNode userpassFocusNode = FocusNode();
  FocusNode userFocusNode = FocusNode();
  FocusNode firstnamepassFocusNode = FocusNode();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnamepassFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  PassCheckController passCheckCtrl = Get.put(PassCheckController());

  RegisterContro registercontro = Get.put(RegisterContro());

  final GlobalKey<FormState> _keyform = GlobalKey();
  String? phone;

  bool isselected = false;

  void fieldcheck() {
    setState(() {
      isselected = emailcontroller.text.isEmail &&
          passcontroller.text.isNotEmpty &&
          passcontroller.text.contains(RegExp(
              r'[A-Za-z0-9@#$%^&+=]')) && // Example: check for specific characters
          passcontroller.text.length >= 8 && // Minimum length requirement
          mobilecontroller.text.isNotEmpty &&
          lnamecontroller.text.isNotEmpty &&
          fnamecontroller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    emailcontroller.addListener(fieldcheck);
    passcontroller.addListener(fieldcheck);
    mobilecontroller.addListener(fieldcheck);
    lnamecontroller.addListener(fieldcheck);
    fnamecontroller.addListener(fieldcheck);
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
                        lable: "User Name",
                        controller: usercontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(userpassFocusNode);
                        },
                        focusNode: userFocusNode,
                        hintText: 'User Name',
                        context: context,
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
                                'assets/images/profile1.png',
                                color: Colors.grey.shade500,
                                height: 20,
                              ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
                    globalTextField(
                        lable: 'First Name',
                        lable2: " *",
                        controller: fnamecontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(firstnamepassFocusNode);
                        },
                        focusNode: firstnameFocusNode,
                        hintText: 'First Name',
                        context: context,
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
                                'assets/images/profile1.png',
                                color: Colors.grey.shade500,
                                height: 20,
                              ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
                    globalTextField(
                        lable: "Last Name",
                        lable2: " *",
                        controller: lnamecontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(lastnamepassFocusNode);
                        },
                        focusNode: lastnameFocusNode,
                        hintText: 'Last Name',
                        context: context,
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
                                'assets/images/profile1.png',
                                color: Colors.grey.shade500,
                                height: 20,
                              ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
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
                      dropdownTextStyle: poppinsFont(
                          14,
                          themeContro.isLightMode.value
                              ? Colors.black
                              : AppColors.white,
                          FontWeight.w400),
                      showCountryFlag: true,
                      showDropdownIcon: false,
                      initialValue: contrycode,
                      onCountryChanged: (value) {
                        contrycode = value.dialCode;
                        print('+$contrycode');
                      },
                      onChanged: (number) {
                        print(number);
                        phone = number.completeNumber;
                      },
                      cursorColor: themeContro.isLightMode.value
                          ? Colors.blue
                          : AppColors.white,
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
                        fillColor: themeContro.isLightMode.value
                            ? Colors.transparent
                            : AppColors.darkGray,
                        filled: true,
                        counterText: '',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: AppColors.blue)),
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
                          color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
                      validator: (value) {
                        if (phone == null ||
                            phone!.isEmpty ||
                            mobilecontroller.text.isEmpty) {
                          return 'Please Enter Your Valid Number';
                        }
                      },
                    ).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
                    globalTextField(
                        lable: "Email Address",
                        lable2: " *",
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
                    sizeBoxHeight(10),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          label(
                            'Password',
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
                    sizeBoxHeight(10),
                    sizeBoxHeight(25),
                    Obx(() {
                      return registercontro.isLoading.value
                          ? commonLoading()
                          : GestureDetector(
                              onTap: () {
                                if (_keyform.currentState!.validate()) {
                                  registercontro.registerApi(
                                    Username: usercontroller.text,
                                    Firstname: fnamecontroller.text,
                                    Lastname: lnamecontroller.text,
                                    Newmobile:
                                        "$contrycode${mobilecontroller.text}",
                                    Countrycode: contrycode,
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
                                  gradient: isselected
                                      ? AppColors.logoColork
                                      : AppColors.logoColorWith60Opacityk,
                                ),
                                child: Center(
                                  child: label(
                                    "Next",
                                    textColor: AppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                    }),
                    SizedBox(
                      height: Get.height * 0.05,
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
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ),
            )),
      ),
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

                hintText: "Password",
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
                            : AppColors.darkgray3)),
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
              // validator: (value) {
              //   if (!passCheckCtrl.moreThan8Char.value ||
              //       !passCheckCtrl.oneNumberChar.value ||
              //       !passCheckCtrl.oneUpperCaseChar.value ||
              //       !passCheckCtrl.oneLowerCaseChar.value ||
              //       !passCheckCtrl.oneSpecialCaseChar.value) {
              //     return 'Please Enter Your Password';
              //   }

              //   return null;
              // },
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






//  twoText(
//           text1: "Select Number of Employees",
//           text2: " *",
//           fontWeight: FontWeight.w600,
//           mainAxisAlignment: MainAxisAlignment.start,
//         ),
