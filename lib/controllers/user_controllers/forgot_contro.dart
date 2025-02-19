// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/forgot_model.dart';
import 'package:nlytical_app/auth/otpscreen.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class ForgotContro extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  var isObscureForSignUp = true.obs;
  Rx<ForgotModel?> forgotModel = ForgotModel().obs;

  Future<void> forgotApi({
    String? email,
    // required String device,
  }) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.forgot);
      var request = http.MultipartRequest("POST", uri);

      request.fields['email'] = '$email';

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      forgotModel.value = ForgotModel.fromJson(data);
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

      if (forgotModel.value!.status == true) {
        isLoading.value = false;

        // SharedPreferences preferencesToken =
        //     await SharedPreferences.getInstance();
        // preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
        //     registerModel.value!.userId.toString());
        // userID =
        //     preferencesToken.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

        // ignore: unused_local_variable
        String userResponseStr = json.encode(data);

        snackBar(forgotModel.value!.message!);

        //navigate to cart
        Get.to(() => Otpscreen(
              email: email, devicetoken: 'ABC', isfortap: 2,
              // devicetoken: device,
            ));

        // Get.to(TabbarScreen(
        //   currentIndex: 0,
        // ));
      } else {
        isLoading.value = false;
        snackBar(forgotModel.value!.message!);
      }
    } catch (e) {
      isLoading.value = false;
      snackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
