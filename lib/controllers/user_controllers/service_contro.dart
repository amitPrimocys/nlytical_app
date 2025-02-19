// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/service_detail_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/global.dart';

final ApiHelper apiHelper = ApiHelper();

class ServiceContro extends GetxController {
  RxBool isservice = false.obs;
  Rx<ServiceDetailModel?> servicemodel = ServiceDetailModel().obs;

  Future<void> servicedetailApi({
    required String serviceID,
  }) async {
    isservice.value = true;

    try {
      var uri = Uri.parse(apiHelper.servicedetail);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] = userID;
      request.fields['service_id'] = serviceID;
      request.fields['lat'] = Latitude;
      request.fields['lon'] = Longitude;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      servicemodel.value = ServiceDetailModel.fromJson(userData);
      print("REQUEST ${request.fields}");
      print(responsData);
      print("status${response.statusCode}");

      if (servicemodel.value!.status == true) {
        isservice.value = false;
      } else {
        isservice.value = false;
        print(servicemodel.value!.message);
      }
    } catch (e) {
      isservice.value = false;
    } finally {
      isservice.value = false;
    }
  }
}
