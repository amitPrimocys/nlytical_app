// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nlytical_app/models/user_models/update_model.dart';
import 'package:nlytical_app/auth/profile_details.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class ProfileDetailContro extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  Rx<UpdateModel?> updatemodel = UpdateModel().obs;

  Future<void> newupdateApi({
    required String uname,
    required String fname,
    required String laname,
    required String email,
    String? file,
  }) async {
    try {
      isLoading.value = true;

      var url = Uri.parse(apiHelper.update);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        'username': uname,
        'first_name': fname,
        'last_name': laname,
        'email': email,
        'user_id': SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID),
      });

      if (file != null && file.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', file));
      }

      print("fields:${request.fields}");
      print("files:${request.files}");
      var response = await request.send();

      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      updatemodel.value = UpdateModel.fromJson(userData);
      print("responsData:$responsData");

      if (updatemodel.value?.status == true) {
        isLoading.value = false;

        SharedPrefs.setString(
          SharedPreferencesKey.LOGGED_IN_USERFNAME,
          updatemodel.value!.userdetails!.firstName.toString(),
        );

        SharedPrefs.setString(
          SharedPreferencesKey.LOGGED_IN_USEREMAIL,
          updatemodel.value!.userdetails!.email.toString(),
        );

        String userFName =
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERFNAME);
        String userMAIL =
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USEREMAIL);
        if (userFName.isEmpty && userMAIL.isEmpty) {
          Get.offAll(() => ProfileDetails(
                number: updatemodel.value!.userdetails!.mobile.toString(),
              ));
        } else {
          Get.offAll(() => TabbarScreen(currentIndex: 0));
        }
      } else {
        isLoading.value = false;
        snackBar(updatemodel.value?.message ?? 'Something went wrong');
      }
    } catch (e) {
      isLoading.value = false;
      snackBar('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
