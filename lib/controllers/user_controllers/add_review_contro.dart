// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/controllers/user_controllers/service_contro.dart';
import 'package:nlytical_app/models/user_models/add_review_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

final ApiHelper apiHelper = ApiHelper();

class AddreviewContro extends GetxController {
  RxBool isaddreview = false.obs;
  ServiceContro servicecontro = Get.put(ServiceContro());
  Rx<AddReviewModel?> addreviewmodel = AddReviewModel().obs;

  addreviewApi(String serviceId, String rewstar, String rewmsg) async {
    isaddreview.value = true;

    try {
      var uri = Uri.parse(apiHelper.addreview);
      var request = http.MultipartRequest("POST", uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      request.fields['service_id'] = serviceId;
      request.fields['review_star'] = rewstar;
      request.fields['review_message'] = rewmsg;

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      print(request.fields);
      print(responseData);
      print("status${response.statusCode}");
      addreviewmodel.value = AddReviewModel.fromJson(data);

      if (addreviewmodel.value!.status == true) {
        isaddreview.value = false;

        snackBar("Add Review successfully");
        addreviewmodel.refresh();

        await servicecontro.servicedetailApi(
          serviceID: serviceId,
        );
        Get.back();

        //navigate to cart
      } else {
        snackBar(addreviewmodel.value!.message!);
        isaddreview.value = false;
      }
    } catch (e) {
      isaddreview.value = false;
      snackBar(e.toString());
    } finally {
      isaddreview.value = false;
    }
  }
}
