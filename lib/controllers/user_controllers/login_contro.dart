// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/Vendor/screens/add_store.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/controllers/vendor_controllers/profile_cotroller.dart';
import 'package:nlytical_app/models/social_login_model.dart';
import 'package:nlytical_app/models/user_models/login_model.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/models/vendor_models/user_plan_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';

ProfileCotroller profileCotroller = Get.find();

class LoginContro extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isSocial = false.obs;
  RxBool isLoading = false.obs;
  var isObscureForSignUp = true.obs;
  Rx<LoginModel?> loginModel = LoginModel().obs;

  loginApi({
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
      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");
      print(response.statusCode);
      print(request.fields);
      print(responseData);
      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      if (loginModel.value!.status == true) {
        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERID,
            loginModel.value!.userId.toString());

        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

        isLoading.value = false;

        // ignore: unused_local_variable
        String userResponseStr = json.encode(data);

        snackBar(loginModel.value!.message!);
        //navigate to cart

        if (loginModel.value!.isStore == 0) {
          await SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERID,
            loginModel.value!.userId.toString(),
          );
          await SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERFNAME,
            loginModel.value!.firstName.toString(),
          );

          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
          Get.find<HomeContro>().checkLocationPermission();
          Get.offAll(() => TabbarScreen(currentIndex: 0));
        } else {
          await SharedPrefs.remove(SharedPreferencesKey.LOGGED_IN_USERID);
          await SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_VENDORID,
            loginModel.value!.userId.toString(),
          );
          SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USEREMAIL,
              loginModel.value!.email.toString());
          await SharedPrefs.setString(
            SharedPreferencesKey.STORE_ID,
            loginModel.value!.serviceId.toString(),
          );
          await SharedPrefs.setString(
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

  RxBool isSocialLogin = false.obs;
  Rx<SocialLoginModel> socialLoginModel = SocialLoginModel().obs;
  socialLoginApi({required String type, required String email}) async {
    try {
      isSocialLogin(true);

      var uri = Uri.parse(apiHelper.socialLogin);
      var request = http.MultipartRequest("POST", uri);

      request.fields['login_type'] = type;
      request.fields['email'] = email;
      // request.fields['device_token'] = 'ABC';

      print(request.fields);

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);

      socialLoginModel.value = SocialLoginModel.fromJson(data);
      print(responseData);

      if (socialLoginModel.value.status == true) {
        if (socialLoginModel.value.user!.role == "user") {
          print("🙂🙂🙂Go to User flow🙂🙂🙂");
          SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERID,
              socialLoginModel.value.user!.id.toString());
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
          Get.find<HomeContro>().checkLocationPermission();
          Get.find<HomeContro>().checkLocationPermission();
          Get.offAll(() => TabbarScreen(currentIndex: 0));
        } else {
          print("🙂🙂🙂Go to Vendor flow🙂🙂🙂");
          await SharedPrefs.remove(SharedPreferencesKey.LOGGED_IN_USERID);
          SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_VENDORID,
              socialLoginModel.value.user!.id.toString());

          await profileCotroller.updateProfileApi1();

          if (profileCotroller.updateModel.value.userdetails!.subscribedUser !=
              0) {
            SharedPrefs.setString(
              SharedPreferencesKey.SUBSCRIBE,
              profileCotroller.updateModel.value.userdetails!.subscribedUser
                  .toString(),
            );
            if (profileCotroller.updateModel.value.isStore != 0) {
              print("🙂🙂🙂Go to Vendor flow🙂🙂🙂");
              SharedPrefs.setString(
                SharedPreferencesKey.STORE_ID,
                profileCotroller.updateModel.value.serviceId.toString(),
              );
              Get.offAll(() => VendorNewTabar(currentIndex: 0));
            } else {
              print("🙂🙂🙂Go to AddStore");
              Get.offAll(() => AddStore());
            }
          } else {
            print("🙂🙂🙂Go to Subscription🙂🙂🙂");
            Get.offAll(() => Subscription());
          }
        }
        isSocialLogin(false);
      } else {
        isSocialLogin(false);
        print("rrrrrrrrrrr:${socialLoginModel.value.message!}");
        snackBar(socialLoginModel.value.message!);
      }
    } catch (e) {
      isSocialLogin(false);
      print("eeeeeeee:${e.toString()}");
      snackBar("Something went wrong, try again");
    }
  }
}
