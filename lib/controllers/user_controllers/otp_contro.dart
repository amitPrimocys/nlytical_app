// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/otp_model.dart';
import 'package:nlytical_app/auth/profile_details.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  Rx<OtpModel?> otpmodel = OtpModel().obs;

  Future<void> otpApi({
    required String? email,
    required String? mobile,
    required String? otp,
    String deviceToken = 'KKK',
  }) async {
    isLoading.value = true;

    try {
      // API URL
      var url = Uri.parse(apiHelper.otp);

      // Constructing request body
      Map<String, String> body = {
        'otp': otp ?? '',
        'device_token': deviceToken,
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

        if (otpmodel.value?.status == true) {
          SharedPreferences preferences = await SharedPreferences.getInstance();

          if (otpmodel.value!.role!.toLowerCase() == "user") {
            await preferences.setString(
              SharedPreferencesKey.LOGGED_IN_USERID,
              otpmodel.value!.userId.toString(),
            );
            await preferences.setString(
              SharedPreferencesKey.LOGGED_IN_USERFNAME,
              otpmodel.value!.firstName.toString(),
            );

            userID =
                preferences.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

            // Check if LOGGED_IN_USERFNAME is empty
            String userFName = preferences
                    .getString(SharedPreferencesKey.LOGGED_IN_USERFNAME) ??
                '';
            if (userFName.isEmpty) {
              Get.offAll(() => ProfileDetails(
                    number: otpmodel.value!.mobile,
                  ));
            } else {
              Get.offAll(() => TabbarScreen(currentIndex: 0));
            }
          } else {
            await SharedPrefs.remove(SharedPreferencesKey.LOGGED_IN_USERID);
            await preferences.setString(
              SharedPreferencesKey.LOGGED_IN_VENDORID,
              otpmodel.value!.userId.toString(),
            );
            await preferences.setString(
              SharedPreferencesKey.STORE_ID,
              otpmodel.value!.serviceId.toString(),
            );
            await preferences.setString(
              SharedPreferencesKey.SUBSCRIBE,
              otpmodel.value!.userSubscription.toString(),
            );
            Get.offAll(() => VendorNewTabar(currentIndex: 0));
          }

          // preferences.setString(
          //   SharedPreferencesKey.ROlE,
          //   otpmodel.value!.role.toString(),
          // );

          //  userID =
          //     preferences.getString(SharedPreferencesKey.LOGGED_IN_USERID) ??
          //         '';
          // String role = preferences.getString(SharedPreferencesKey.ROlE) ?? '';

          snackBar("Login Successfully".tr);

          // Navigate to TabbarScreen
        } else {
          snackBar(otpmodel.value?.message ?? "Invalid response");
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
