// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/forgot_verify_model.dart';
import 'package:nlytical_app/auth/resetpass.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class ForgotOtpController extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  Rx<ForgotVerifyModel?> otpmodel = ForgotVerifyModel().obs;

  Future<void> forgotVerifyOtpApi(
      {String? email, String? otp, String? Device}) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.forgotVerify);
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['email'] = '$email';
      request.fields['otp'] = '$otp';
      // request.fields['device_token'] = '$Device';
      //  request.fields['device_token'] = 'KKK';

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      otpmodel.value = ForgotVerifyModel.fromJson(data);
      // ignore: avoid_print
      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");
      // ignore: avoid_print
      print(response.statusCode);
      // ignore: avoid_print
      print(request.fields);
      // ignore: avoid_print
      print(responseData);
      // ignore: avoid_print
      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      if (otpmodel.value!.status == true) {
        isLoading.value = false;

        // SharedPreferences preferencesToken =
        //     await SharedPreferences.getInstance();
        // preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
        //     otpmodel.value!.userId.toString());
        // userID =
        //     preferencesToken.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

        // snackBar("Login Successfully".tr);

        //navigate to cart
        Get.to(Resetpass(
          email: email,
        ));
      } else {
        snackBar(otpmodel.value!.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      snackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
