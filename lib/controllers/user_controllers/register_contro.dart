// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/register_model.dart';
import 'package:nlytical_app/auth/otpscreen.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class RegisterContro extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  var isObscureForSignUp = true.obs;
  Rx<RegisterModel?> registerModel = RegisterModel().obs;

  Future<void> registerApi({
    String? Username,
    String? Firstname,
    String? Lastname,
    String? Newmobile,
    String? Countrycode,
    String? Email,
    String? Password,

    // required String device,
  }) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.userRegister);
      var request = http.MultipartRequest("POST", uri);

      request.fields['username'] = '$Username';
      request.fields['first_name'] = '$Firstname';
      request.fields['last_name'] = '$Lastname';
      request.fields['new_mobile'] = '$Newmobile';
      request.fields['country_code'] = '$Countrycode';
      request.fields['email'] = '$Email';
      request.fields['password'] = '$Password';
      request.fields['role'] = 'user';

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      registerModel.value = RegisterModel.fromJson(data);
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

      if (registerModel.value!.status == true) {
        isLoading.value = false;
        // ignore: unused_local_variable
        String userResponseStr = json.encode(data);

        snackBar(registerModel.value!.message!);

        Get.offAll(() => Otpscreen(
              email: Email, devicetoken: 'KKK',

              isfortap: 0,
              // devicetoken: device,
            ));
      } else {
        isLoading.value = false;
        snackBar(registerModel.value!.message!);
      }
    } catch (e) {
      isLoading.value = false;
      snackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
