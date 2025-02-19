// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/delete_model.dart';
import 'package:nlytical_app/auth/welcome.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ApiHelper apiHelper = ApiHelper();

class DeleteController extends GetxController {
  RxBool isdelete = false.obs;
  Rx<DeleteModel?> deletemodel = DeleteModel().obs;

  Future<void> deleteApi() async {
    isdelete.value = true;

    try {
      var uri = Uri.parse(apiHelper.delete);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] = userID;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      deletemodel.value = DeleteModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (deletemodel.value!.status == true) {
        isdelete.value = false;
        // SharedPrefs.clear();
        // SharedPreferences pref = await SharedPreferences.getInstance();
        // pref
        //     .remove(
        //   SharedPrefs.getString(
        //     SharedPreferencesKey.LOGGED_IN_USERID,
        //   ),
        // )
        //     .then((_) {
        //   Get.offAll(() => const Welcome());
        // });
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();
        await SharedPrefs.clear();
        print(
            "role logout user ::${SharedPrefs.getString(SharedPreferencesKey.ROlE)}");
        Get.offAll(() => const Welcome());

        snackBar("Delete Successfully");
      } else {
        isdelete.value = false;
        print(deletemodel.value!.message);
      }
    } catch (e) {
      isdelete.value = false;
    } finally {
      isdelete.value = false;
    }
  }
}
