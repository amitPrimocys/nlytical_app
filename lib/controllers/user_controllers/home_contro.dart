// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/home_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/global.dart';

final ApiHelper apiHelper = ApiHelper();

class HomeContro extends GetxController {
  RxBool ishome = false.obs;
  Rx<HomeModel?> homemodel = HomeModel().obs;
  RxList<Categories> categories = <Categories>[].obs;
  RxList<LatestService> allcatelist = <LatestService>[].obs;
  RxList<NearbyStores> nearbylist = <NearbyStores>[].obs;
  var currentAddress = "Fetching location...";

  Future<void> homeApi(
      {required String? latitudee, required String? longitudee}) async {
    ishome.value = true;

    try {
      var uri = Uri.parse(apiHelper.home);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['lat'] = Latitude;
      request.fields['lon'] = Longitude;
      request.fields['user_id'] = userID;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      homemodel.value = HomeModel.fromJson(userData);
      print("REQUEST ${request.fields}");
      print("REQUEST ${responsData}");

      print("status${response.statusCode}");
      categories.clear();
      allcatelist.clear();
      nearbylist.clear();

      if (homemodel.value!.status == true) {
        categories.addAll(
          homemodel.value!.categories!,
        );

        allcatelist.addAll(homemodel.value!.latestService!);
        nearbylist.addAll(homemodel.value!.nearbyStores!);
        ishome.value = false;
      } else {
        ishome.value = false;
        print(homemodel.value!.message);
      }
    } catch (e) {
      ishome.value = false;
    }
  }
}
