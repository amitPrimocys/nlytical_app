// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/models/user_models/get_profile_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';

import 'package:nlytical_app/models/vendor_models/update_profile_model.dart';

import 'package:http/http.dart' as http;
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';

class ProfileCotroller extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  RxString contrycode = ''.obs;

  RxBool isGetData = false.obs;
  Rx<GetProfileModel> getDataModel = GetProfileModel().obs;

  getProfleApi() async {
    try {
      isGetData(true);

      var uri = Uri.parse(apiHelper.getProfile);
      var request = http.MultipartRequest("POST", uri);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);

      getDataModel.value = GetProfileModel.fromJson(data);

      print(request.fields);
      log("GET_PROFILE:$responseData");

      if (getDataModel.value.status == true) {
        fnameController.text =
            getDataModel.value.userDetails!.firstName.toString();
        lnameController.text =
            getDataModel.value.userDetails!.lastName.toString();
        emailController.text = getDataModel.value.userDetails!.email.toString();
        contrycode.value =
            getDataModel.value.userDetails!.countryCode.toString();

        phoneController.text =
            getMobile(getDataModel.value.userDetails!.mobile!.toString());

        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERFNAME,
            getDataModel.value.userDetails!.firstName.toString());
        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERLNAME,
            getDataModel.value.userDetails!.lastName.toString());

        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERIMAGE,
            getDataModel.value.userDetails!.image.toString());

        userIMAGE =
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERIMAGE);

        isGetData(false);
      } else {
        isGetData(false);
        snackBar(getDataModel.value.message!);
      }
    } catch (e) {
      isGetData(false);
      print(e.toString());
    }
  }

  RxBool isUpdate = false.obs;
  Rx<UpdateProfileModel> updateModel = UpdateProfileModel().obs;

  updateProfileApi(image,
      {required String fname,
      required String lname,
      required String email,
      required String countryCode,
      required String phone}) async {
    try {
      isUpdate(true);

      var uri = Uri.parse(apiHelper.updateUserprofile);
      var request = http.MultipartRequest("POST", uri);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);
      request.fields['first_name'] = fname;
      request.fields['last_name'] = lname;
      request.fields['email'] = email;
      request.fields['country_code'] = countryCode;
      // request.fields['mobile'] = phone;
      request.fields['mobile'] = "$countryCode$phone";
      request.fields['role'] = "vendor";

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      }

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);

      updateModel.value = UpdateProfileModel.fromJson(data);

      if (updateModel.value.status == true) {
        snackBar(updateModel.value.message!);
        getProfleApi();
        isUpdate(false);
      } else {
        isUpdate(false);
        snackBar(updateModel.value.message!);
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }
}
