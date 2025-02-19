import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/size_config.dart';

snackBar(String message, {String title = "", BuildContext? context}) {
  return Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    titleText: const SizedBox(height: 0),
    padding: EdgeInsets.symmetric(
      horizontal: getProportionateScreenWidth(20),
      vertical: getProportionateScreenHeight(15),
    ),
    // icon: Icon(Icons.error),
    messageText: Text(message,
        style: const TextStyle(fontSize: 16, color: Colors.white)),
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(getProportionateScreenHeight(20)),
    borderRadius: 7,
    backgroundColor: AppColors.blue,
    duration: const Duration(seconds: 2),
  );
}
