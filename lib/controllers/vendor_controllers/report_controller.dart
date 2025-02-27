// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nlytical_app/models/user_models/report_get_model.dart';
import 'package:nlytical_app/models/user_models/report_text_mpdel.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

final ApiHelper apiHelper = ApiHelper();

class VendorReportContro extends GetxController {
  RxBool isreport = false.obs;
  Rx<ReportGetModel?> reportmodel = ReportGetModel().obs;
  RxList<Data> reportlist = <Data>[].obs;

  Future<void> reportgetApi() async {
    isreport.value = true;

    try {
      var uri = Uri.parse(apiHelper.report);
      var request = http.MultipartRequest('GET', uri);

      // request.headers.addAll(headers);
      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      reportmodel.value = ReportGetModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      reportlist.clear();

      if (reportmodel.value!.status == true) {
        reportlist.addAll(reportmodel.value!.data!);
        isreport.value = false;
      } else {
        isreport.value = false;
        print(reportmodel.value!.message);
      }
    } catch (e) {
      isreport.value = false;
    }
  }

  RxBool isLoading = false.obs;
  Rx<ReportTextModel?> reportTextmodel = ReportTextModel().obs;

  Future<void> ReportUserApi(
      {String? reportoppsiteId, String? reportText}) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.reportuser);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['reportByUserId'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);
      request.fields['reportedUserId'] = reportoppsiteId!;
      request.fields['report_text'] = reportText!;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      reportTextmodel.value = ReportTextModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (reportTextmodel.value!.status == true) {
        isLoading.value = false;

        snackBar("User has already been reported");
      } else {
        isLoading.value = false;
        print(reportTextmodel.value!.message);
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
