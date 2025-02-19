// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/favourite_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/global.dart';

final ApiHelper apiHelper = ApiHelper();

class FavouriteContro extends GetxController {
  RxBool isfav = false.obs;
  Rx<FavouriteModel> favemodel = FavouriteModel().obs;
  RxList<ServiceLikedList> favlist = <ServiceLikedList>[].obs;

  Future<void> favApi() async {
    isfav.value = true;

    try {
      var uri = Uri.parse(apiHelper.likedservices);
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

      favemodel.value = FavouriteModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      favlist.clear();

      if (favemodel.value.status == true) {
        favlist.addAll(favemodel.value.serviceLikedList!);
        isfav.value = false;
      } else {
        isfav.value = false;
        print(favemodel.value.message);
      }
    } catch (e) {
      isfav.value = false;
    } finally {
      isfav.value = false;
    }
  }
}
