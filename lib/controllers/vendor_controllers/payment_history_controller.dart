import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/models/vendor_models/payment_history_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class PaymentHistoryController extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  Rx<PaymentHistoryModel> model = PaymentHistoryModel().obs;
  RxList<GoalData> goalData = <GoalData>[].obs;
  RxList<bool> isExpandedList = <bool>[].obs;

  getPaymentHistory() async {
    try {
      isLoading.value = true;
      final responseJson = await apiHelper.multipartPostMethod(
        url: apiHelper.getGoalspayment,
        headers: {},
        formData: {
          "vendor_id":
              SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID)
        },
        files: [],
      );
      model.value = PaymentHistoryModel.fromJson(responseJson);
      goalData.clear();
      isExpandedList.clear();
      if (model.value.status == true) {
        goalData.addAll(model.value.goalData!);
        isExpandedList.addAll(List.generate(goalData.length, (index) => false));
        log(jsonEncode(goalData));
      } else {
        snackBar(model.value.message!);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      goalData.clear();
      isExpandedList.clear();
      snackBar("Something went wrong, try again");
      debugPrint('get category failed: $e');
    }
  }
}
