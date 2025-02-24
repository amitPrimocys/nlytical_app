// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/models/user_models/login_model.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginContro extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  var isObscureForSignUp = true.obs;
  Rx<LoginModel?> loginModel = LoginModel().obs;

  Future<void> loginApi({
    String? Email,
    String? Password,

    // required String device,
  }) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.login);
      var request = http.MultipartRequest("POST", uri);

      request.fields['email'] = '$Email';
      request.fields['password'] = '$Password';
      request.fields['device_token'] = 'ABC';

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      loginModel.value = LoginModel.fromJson(data);
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

      if (loginModel.value!.status == true) {
        SharedPreferences preferencesToken =
            await SharedPreferences.getInstance();
        preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
            loginModel.value!.userId.toString());
        userID =
            preferencesToken.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

        isLoading.value = false;

        // ignore: unused_local_variable
        String userResponseStr = json.encode(data);

        snackBar(loginModel.value!.message!);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        //navigate to cart

        if (loginModel.value!.isStore == 0) {
          await preferences.setString(
            SharedPreferencesKey.LOGGED_IN_USERID,
            loginModel.value!.userId.toString(),
          );
          await preferences.setString(
            SharedPreferencesKey.LOGGED_IN_USERFNAME,
            loginModel.value!.firstName.toString(),
          );

          userID =
              preferences.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;
          Get.find<HomeContro>().checkLocationPermission();
          Get.offAll(() => TabbarScreen(currentIndex: 0));
        } else {
          await SharedPrefs.remove(SharedPreferencesKey.LOGGED_IN_USERID);
          await preferences.setString(
            SharedPreferencesKey.LOGGED_IN_VENDORID,
            loginModel.value!.userId.toString(),
          );
          SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USEREMAIL,
              loginModel.value!.email.toString());
          await preferences.setString(
            SharedPreferencesKey.STORE_ID,
            loginModel.value!.serviceId.toString(),
          );
          await preferences.setString(
            SharedPreferencesKey.SUBSCRIBE,
            loginModel.value!.subscribedUser.toString(),
          );
          Get.offAll(() => VendorNewTabar(currentIndex: 0));
        }
        // Get.to(TabbarScreen(
        //   currentIndex: 0,
        // ));
      } else {
        isLoading.value = false;
        snackBar(loginModel.value!.message!);
      }
    } catch (e) {
      isLoading.value = false;
      snackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
