// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nlytical_app/models/user_models/vendor_info_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';

ApiHelper apiHelper = ApiHelper();

class VendorInfoContro extends GetxController {
  RxBool isfav = false.obs;
  Rx<VendorInfoModel> vendorlistmodel = VendorInfoModel().obs;
  RxList<ServiceDetails> vendorlist = <ServiceDetails>[].obs;

  Future<void> vendorApi({
    String? toUSerID,
  }) async {
    isfav.value = true;

    try {
      var uri = Uri.parse(apiHelper.vendorinfo);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      request.fields['vendor_id'] = toUSerID!;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      vendorlistmodel.value = VendorInfoModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      vendorlist.clear();

      if (vendorlistmodel.value.status == true) {
        vendorlist.addAll(vendorlistmodel.value.serviceDetails!);
        isfav.value = false;
      } else {
        isfav.value = false;
        print(vendorlistmodel.value.message);
      }
    } catch (e) {
      isfav.value = false;
    } finally {
      isfav.value = false;
    }
  }
}
