// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/get_profile_model.dart';
import 'package:nlytical_app/models/user_models/update_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/Vendor/screens/auth/subcription.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';

final ApiHelper apiHelper = ApiHelper();

class GetprofileContro extends GetxController {
  RxBool isprofile = false.obs;
  Rx<GetProfileModel?> getprofilemodel = GetProfileModel().obs;
  RxString contrycode = ''.obs;
  TextEditingController FnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // TextEditingController countryCode = TextEditingController();

  //get contrycode => null;
  @override
  onInit() {
    getprofileApi();
    super.onInit();
  }

  getprofileApi() async {
    try {
      isprofile(true);
      var uri = Uri.parse(apiHelper.getprofile);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);
      request.fields['user_id'] = SharedPrefs.getString(
        SharedPreferencesKey.LOGGED_IN_USERID,
      );

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      getprofilemodel.value = GetProfileModel.fromJson(userData);

      FnameController.text =
          getprofilemodel.value!.userDetails!.firstName!.toString();
      LnameController.text =
          getprofilemodel.value!.userDetails!.lastName!.toString();
      emailcontroller.text =
          getprofilemodel.value!.userDetails!.email!.toString();
      contrycode.value =
          getprofilemodel.value!.userDetails!.countryCode!.toString();
      phoneController.text =
          getMobile(getprofilemodel.value!.userDetails!.mobile!.toString());

      print("CONTROLL${FnameController.text}");

      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (getprofilemodel.value!.status == true) {
        isprofile(false);
      } else {
        isprofile(false);
        print(getprofilemodel.value!.message);
      }
    } catch (e) {
      isprofile(false);
      print(e.toString());
    }
  }

  RxBool isupdate = false.obs;
  Rx<UpdateModel?> updatemodel = UpdateModel().obs;
  updateApi({
    String? file,
    String? countryCode,
    String? fname,
    String? lname,
    String? email,
    String? phone,
    required bool isUpdateProfile,
  }) async {
    print("kkk${file}");
    try {
      isupdate(true);
      var uri = Uri.parse(apiHelper.update);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      if (isUpdateProfile == false) {
        print('Go to Vendor');
        request.fields['user_id'] = userID;
        request.fields['role'] = 'vendor';
      } else {
        request.fields['user_id'] = userID;
        request.fields['first_name'] = FnameController.text;
        request.fields['last_name'] = LnameController.text;
        request.fields['email'] = emailcontroller.text;
        request.fields['country_code'] = countryCode!;
        // request.fields['mobile'] = phoneController.text;
        request.fields['mobile'] = "${contrycode.value}${phoneController.text}";
      }

      if (isUpdateProfile == true) {
        if (file != null) {
          request.files.add(await http.MultipartFile.fromPath('image', file));
        }
      }

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      updatemodel.value = UpdateModel.fromJson(userData);

      print(request.fields);
      print(responsData);
      print(request.files);
      print("status${response.statusCode}");

      if (updatemodel.value!.status == true) {
        // Navigator.pop(context);

        if (isUpdateProfile == true) {
          // user profile update
          Get.back();
          snackBar("Update successfully");

          getprofileApi();
        } else {
          // vendor navigate
          SharedPrefs.setString(SharedPreferencesKey.ROlE, 'Vendor');
          SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_VENDORID,
              updatemodel.value!.userdetails!.id!.toString());

          print('VENDOR ID: ${SharedPrefs.getString(
            SharedPreferencesKey.LOGGED_IN_VENDORID,
          )}');

          userID = '';
          await SharedPrefs.remove(SharedPreferencesKey.LOGGED_IN_USERID);
          Get.offAll(() => const SubscriptionSceen(),
              transition: Transition.rightToLeft);

          snackBar("Welcome to Vendor");
        }

        isupdate(false);
      } else {
        isupdate(false);
        print(updatemodel.value!.message);
      }
    } catch (e) {
      isupdate(false);
      print(e.toString());
    }
  }
}
