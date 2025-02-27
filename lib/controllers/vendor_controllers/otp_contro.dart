// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/models/vendor_models/otp_model.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class OtpController extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  Rx<OtpModel> otpmodel = OtpModel().obs;

  Future<void> otpApi(
      {String? mobile,
      String? email,
      required String otp,
      required String Device}) async {
    isLoading.value = true;

    try {
      // API URL
      var url = Uri.parse(apiHelper.otp);

      // Constructing request body
      Map<String, String> body = {
        'otp': otp,
        'device_token': Device,
      };

      if (email != null && email.isNotEmpty) {
        body['email'] = email;
      } else if (mobile != null && mobile.isNotEmpty) {
        body['mobile'] = mobile;
      }

      // Sending POST request
      var response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print("Status code $url  :${response.statusCode}");

      print("Status body $url  :${response.body}");

      // Handling response
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        otpmodel.value = OtpModel.fromJson(data);

        if (otpmodel.value.status == true) {
          // Save user ID in shared preferences
          SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERID,
            otpmodel.value.userId.toString(),
          );
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

          snackBar("Login Successfully".tr);

          // Navigate to TabbarScreen
          Get.offAll(() => const VendorNewTabar(currentIndex: 0));
        } else {
          snackBar(otpmodel.value.message ?? "Invalid response");
        }
      } else {
        snackBar('Error: ${response.statusCode}');
      }
    } catch (e) {
      snackBar('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
