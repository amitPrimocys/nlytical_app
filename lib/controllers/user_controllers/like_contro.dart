// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/Like_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

final ApiHelper apiHelper = ApiHelper();

class LikeContro extends GetxController {
  RxBool islike = false.obs;
  Rx<LikeModel?> likemodel = LikeModel().obs;

  likeApi(String serviceId) async {
    islike.value = true;

    try {
      var uri = Uri.parse(apiHelper.like);
      var request = http.MultipartRequest("POST", uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      request.fields['service_id'] = serviceId;

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      print(request.fields);
      print(responseData);
      print("status${response.statusCode}");
      likemodel.value = LikeModel.fromJson(data);

      if (likemodel.value!.status == true) {
        islike.value = false;

        snackBar(likemodel.value!.message!);
      } else {
        snackBar(likemodel.value!.message!);
        islike.value = false;
      }
    } catch (e) {
      islike.value = false;
      snackBar(e.toString());
    } finally {
      islike.value = false;
    }
  }
}
