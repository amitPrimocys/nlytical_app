// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/models/vendor_models/add_campaign_model.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/vendor_models/get_campaign_model.dart';

final ApiHelper apiHelper = ApiHelper();

class CampaignController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<AddCamoaignModel?> addcampmodel = AddCamoaignModel().obs;

  Future<void> AddCampaignApi(
      {String? campaignName,
      String? addres,
      String? lat,
      String? lon,
      String? areadistance}) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.addcampaign);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['vendor_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);
      request.fields['service_id'] =
          SharedPrefs.getString(SharedPreferencesKey.STORE_ID);
      request.fields['campaign_name'] = campaignName!;
      request.fields['address'] = addres!;
      request.fields['lat'] = lat!;
      request.fields['lon'] = lon!;
      request.fields['area_distance'] = areadistance!;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      addcampmodel.value = AddCamoaignModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (addcampmodel.value!.status == true) {
        isLoading.value = false;

        Get.back();
        Get.back();
        snackBar("Campaign added successfully!");
        GetCampaignApi();
      } else {
        isLoading.value = false;
        print(addcampmodel.value!.message);
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool getLoading = false.obs;
  Rx<GetCampaignModel?> getcampaignmodel = GetCampaignModel().obs;
  RxList<CampaignData> camplist = <CampaignData>[].obs;

  RxList<bool> istapList = <bool>[].obs;
  RxnInt selectedIndex = RxnInt(null);

  void toggleTap(int index) {
    istapList[index] = !istapList[index];
  }

  GetCampaignApi() async {
    try {
      getLoading.value = true;
      var uri = Uri.parse(apiHelper.getcampaign);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['vendor_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      getcampaignmodel.value = GetCampaignModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      camplist.clear();

      if (getcampaignmodel.value!.status == true) {
        camplist.addAll(getcampaignmodel.value!.campaignData!);
        getLoading.value = false;
        // istapList.assignAll(List.generate(camplist.length, (index) => false));
      } else {
        camplist.clear();
        getLoading.value = false;
        print(getcampaignmodel.value!.message);
      }
    } catch (e) {
      getLoading.value = false;
      print(e.toString);
    } finally {
      getLoading.value = false;
    }
  }
}
