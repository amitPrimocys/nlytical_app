// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/models/vendor_models/business_review_model.dart';
// import 'package:nlytical_vendor/models/business_review_model.dart';
// import 'package:nlytical_vendor/shared_preferences/prefrences_key.dart';
// import 'package:nlytical_vendor/shared_preferences/shared_prefkey.dart';
// import 'package:nlytical_vendor/utils/api_helper.dart';

final ApiHelper apiHelper = ApiHelper();

class BusinessReviewController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<BusinessReviewModel?> businessriviewmodel = BusinessReviewModel().obs;

  Future<void> businessReviewApi() async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.businessreviewlist);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['service_id'] =
          SharedPrefs.getString(SharedPreferencesKey.STORE_ID);

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      businessriviewmodel.value = BusinessReviewModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      // riviewlist.clear();

      if (businessriviewmodel.value!.status == true) {
        // riviewlist.addAll(riviewmodel.value!.reviewlist!);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        print(businessriviewmodel.value!.message);
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
