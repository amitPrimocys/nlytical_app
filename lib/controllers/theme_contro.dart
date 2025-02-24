import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/theame_switch.dart';
import 'package:nlytical_app/utils/colors.dart';

class ThemeContro extends GetxController {
  RxBool isLightTheme = false.obs; // Default to light theme

  final RxBool _isLightMode = true.obs;

  // Getter for the current theme mode
  RxBool get isLightMode => _isLightMode;

  // Function to toggle the theme mode
  Future<void> toggleThemeMode(bool value) async {
    _isLightMode.value = value; // ✅ Set value properly
    debugPrint("IS LIGHT MODE $_isLightMode");

    await SharedPrefs.setBool(
        SharedPreferencesKey.isLightMode, _isLightMode.value);

    // Retrieve the stored value, using `?? false` to prevent null issues
    var isLight = SharedPrefs.getBool(SharedPreferencesKey.isLightMode);
    debugPrint("IS LIGHT MODE AFTER $isLight ");
  }

  updateLightModeValue(bool value) {
    _isLightMode.value = value;
  }

  Widget lightDarkModeSwitch({required bool isVendor}) {
    return Container(
      height: 45,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.white),
          color: !isLightMode.value ? AppColors.darkGray : Colors.white,
          boxShadow: [
            BoxShadow(
              color: !isLightMode.value
                  ? AppColors.darkShadowColor
                  : Colors.grey.shade300,
              blurRadius: 14.0,
              spreadRadius: 0.0,
              offset: const Offset(2.0, 4.0), // shadow direction: bottom right
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(AppAsstes.moon,
                  height: 18,
                  color:
                      !isLightMode.value ? AppColors.white : AppColors.black),
              sizeBoxWidth(10),
              label(
                !isLightMode.value ? "Dark Mode" : "Light Mode",
                fontSize: 12,
                textColor:
                    !isLightMode.value ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
          Obx(
            () => CustomSwitch(
              value: _isLightMode.value, // ✅ Use _isLightMode.value directly
              onChanged: (bool value) {
                toggleThemeMode(value);
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 15),
    ).paddingSymmetric(horizontal: isVendor ? 10 : 0);
  }
}
