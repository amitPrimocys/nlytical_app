// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({super.key});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  StoreController storeController = Get.find();
  final businessPhoneController = TextEditingController();
  final businessEmailController = TextEditingController();

  final phone = FocusNode();
  final phone1 = FocusNode();
  final email = FocusNode();
  final email1 = FocusNode();
  String phoneNumber = '';

  @override
  void initState() {
    contrycode =
        storeController.storeList[0].contactDetails!.serviceCountryCode ?? '';
    businessPhoneController.text = getMobile(
        storeController.storeList[0].contactDetails!.servicePhone ?? '');
    businessEmailController.text =
        storeController.storeList[0].contactDetails!.serviceEmail ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          clipBehavior: Clip.none,
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
                top: getProportionateScreenHeight(50),
                child: Row(
                  children: [
                    sizeBoxWidth(20),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/arrow-left1.png',
                          color: Colors.white,
                          height: 24,
                        )),
                    sizeBoxWidth(10),
                    Text("Contact Details",
                        style:
                            poppinsFont(20, AppColors.white, FontWeight.w500))
                  ],
                )),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizeBoxHeight(30),
                        Text(
                          "Contact Detail",
                          style: poppinsFont(
                              14,
                              themeContro.isLightMode.value
                                  ? AppColors.black
                                  : AppColors.white,
                              FontWeight.w600),
                        ),
                        sizeBoxHeight(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error_outline,
                                color: themeContro.isLightMode.value
                                    ? AppColors.blue
                                    : AppColors.white,
                                size: 15),
                            Flexible(
                              child: Text(
                                " Update your contact details to stay in touch your customers in real time",
                                style: poppinsFont(
                                    10,
                                    themeContro.isLightMode.value
                                        ? AppColors.blue
                                        : AppColors.white,
                                    FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                        sizeBoxHeight(30),
                        twoText(
                          fontWeight: FontWeight.w600,
                          text1: "Mobile Number",
                          text2: " *",
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        sizeBoxHeight(7),
                        IntlPhoneField(
                          initialValue: contrycode,
                          showCountryFlag: true,
                          showDropdownIcon: false,
                          dropdownTextStyle: TextStyle(
                              color: themeContro.isLightMode.value
                                  ? AppColors.black
                                  : AppColors.white),
                          onCountryChanged: (value) {
                            contrycode = '+${value.dialCode}';
                            log("Country Code: $contrycode");
                          },
                          onChanged: (number) {
                            phoneNumber =
                                number.number; // Extract only the phone number
                            log("Phone Number: $phoneNumber");
                          },
                          focusNode: phone1,
                          cursorColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : AppColors.bluee4,
                          autofocus: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(
                              fontSize: 14,
                              color: themeContro.isLightMode.value
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                          controller: businessPhoneController,
                          keyboardType: TextInputType.number,
                          flagsButtonPadding: const EdgeInsets.only(left: 5),
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: AppColors.bluee4)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColors.colorEFEFEF)),
                            disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: AppColors.colorEFEFEF)),
                            hintText: "Add Mobile Number".tr,
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                color: AppColors.colorB0B0B0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColors.colorEFEFEF)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColors.colorEFEFEF)),
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 10),
                          ),
                        ),
                        sizeBoxHeight(20),
                        globalTextField3(
                            isEmail: true,
                            // isOnlyRead: true,
                            lable: "Email",
                            lable2: " *",
                            controller: businessEmailController,
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(email);
                            },
                            focusNode: email1,
                            hintText: "Email",
                            context: context),
                      ],
                    ).paddingSymmetric(horizontal: 20),
                  ),
                )),
            Positioned(
              bottom: keyboardHeight > 0
                  ? keyboardHeight + -280 // Place above the keyboard
                  : 30, // Default position
              left: (Get.width - getProportionateScreenWidth(260)) / 2,
              child: Obx(() {
                return storeController.isUpdate.value
                    ? Center(child: commonLoading()).paddingSymmetric(
                        horizontal: getProportionateScreenWidth(100))
                    : customBtn(
                        onTap: () {
                          if (businessPhoneController.text.trim().isEmpty) {
                            snackBar("Please add your business phone number");
                          } else if (businessEmailController.text
                              .trim()
                              .isEmpty) {
                            snackBar("Please add your business email");
                          } else {
                            storeController.storeCotactUpdateApi(
                                countryCode: contrycode,
                                storePhone:
                                    contrycode + businessPhoneController.text,
                                storeEmail: businessEmailController.text);
                          }
                        },
                        title: "Save",
                        fontSize: 15,
                        weight: FontWeight.w400,
                        radius: BorderRadius.circular(10),
                        width: getProportionateScreenWidth(260),
                        height: getProportionateScreenHeight(55),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
