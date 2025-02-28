// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/home_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
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
      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

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

  //========================= location fetch method =========================================
  Future<void> checkLocationPermission() async {
    log("start");
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      snackBar(
          "Nlytical app need location Permmision otherwise You are not able to see nearby stores, Please Allow location");
    } else if (permission == LocationPermission.denied) {
      LocationPermission newPermission = await Geolocator.requestPermission();
      if (newPermission == LocationPermission.denied) {
        snackBar("Please Allow location");
      } else if (newPermission == LocationPermission.whileInUse ||
          newPermission == LocationPermission.always) {
        await _getCurrentLocation();
      }
    } else {
      await _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Fetch the current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      Latitude = position.latitude.toString();
      Longitude = position.longitude.toString();

      log("☺☺☺☺☺☺☺☺☺LAT :$Latitude");
      log("☺☺☺☺☺☺☺☺☺LONG : $Longitude");
      SharedPrefs.setString(
          SharedPreferencesKey.LATTITUDE, position.latitude.toString());
      SharedPrefs.setString(
          SharedPreferencesKey.LONGITUDE, position.longitude.toString());
      homeApi(
        latitudee: Latitude,
        longitudee: Longitude,
      );
    } catch (e) {
      debugPrint(e.toString());
      homeApi(
        latitudee: '',
        longitudee: '',
      );
    }
  }
}
