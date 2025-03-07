// // ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:nlytical_app/models/user_models/nearby_model.dart';
// import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
// import 'package:nlytical_app/User/utils/api_helper.dart';
// import 'package:nlytical_app/utils/global.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final ApiHelper apiHelper = ApiHelper();

// class NearbyContro extends GetxController {
//   RxBool isnear = false.obs;
//   Rx<NearbyModel?> nearbymodel = NearbyModel().obs;
//   RxList<NearbyService> nearbylist = <NearbyService>[].obs;

//   Future<NearbyModel?> nearbyApi(
//       {required String page,
//       required String? latitudee,
//       required String? longitudee}) async {
//     try {
//       print(' page: $page');
//       isnear.value = true;
//       var uri = Uri.parse(apiHelper.nearby);
//       var request = http.MultipartRequest('Post', uri);

//       Map<String, String> headers = {
//         "Accept": "application/json",
//         "Content-Type": "application/x-www-form-urlencoded",
//       };

//       request.headers.addAll(headers);

//       request.fields['lat'] = '$latitudee';
//       request.fields['lon'] = "$longitudee";
//       request.fields['user_id'] = userID;
//       request.fields['page_no'] = page.isEmpty ? '1' : page;

//       var response = await request.send();
//       String responsData = await response.stream.transform(utf8.decoder).join();
//       var userData = json.decode(responsData);

//       nearbymodel.value = NearbyModel.fromJson(userData);
//       print(request.fields);
//       print(responsData);
//       print("status${response.statusCode}");
//       // nearbylist.clear();

//       if (nearbymodel.value!.status == true) {
//         // nearbylist.addAll(
//         //   nearbymodel.value!.nearbyService!,
//         // );
//         if (page == "1") {
//           // For the first page, clear the existing list
//           nearbylist.value = nearbymodel.value!.nearbyService!;
//         } else {
//           // For the subsequent pages, add the new items to the existing list
//           nearbylist.addAll(nearbymodel.value!.nearbyService!);
//           nearbylist.toSet().toList();
//         }

//         print("allcatelist ${nearbylist.length}");

//         isnear.value = false;

//         SharedPreferences preferencesToken =
//             await SharedPreferences.getInstance();
//         preferencesToken.setString(SharedPreferencesKey.LATTITUDE,
//             nearbymodel.value!.nearbyService![0].lat.toString());
//         Latitude = preferencesToken.getString(SharedPreferencesKey.LATTITUDE)!;

//         preferencesToken.setString(SharedPreferencesKey.LONGITUDE,
//             nearbymodel.value!.nearbyService![0].lon.toString());
//         Longitude = preferencesToken.getString(SharedPreferencesKey.LONGITUDE)!;
//       } else {
//         isnear.value = false;
//         print(nearbymodel.value!.message);
//       }
//       return nearbymodel.value;
//     } catch (e) {
//       isnear.value = false;
//       return null;
//     } finally {
//       isnear.value = false;
//     }
//   }
// }

// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/nearby_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';

final ApiHelper apiHelper = ApiHelper();

class NearbyContro extends GetxController {
  RxBool isnear = false.obs;
  Rx<NearbyModel?> nearbymodel = NearbyModel().obs;
  RxList<NearbyService> nearbylist = <NearbyService>[].obs;
  RxInt currentpage = 1.obs;

  Future<NearbyModel?> nearbyApi(
      {required String page,
      required String? latitudee,
      required String? longitudee}) async {
    try {
      print(' page: $page');
      isnear.value = true;
      var uri = Uri.parse(apiHelper.nearby);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['lat'] = '$latitudee';
      request.fields['lon'] = "$longitudee";
      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      request.fields['page_no'] = page.isEmpty ? '1' : page;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      nearbymodel.value = NearbyModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      // nearbylist.clear();

      if (nearbymodel.value!.status == true) {
        // nearbylist.addAll(
        //   nearbymodel.value!.nearbyService!,
        // );
        if (page == "1") {
          // For the first page, clear the existing list
          nearbylist.value = nearbymodel.value!.nearbyService!;
        } else {
          // For the subsequent pages, add the new items to the existing list
          nearbylist.addAll(nearbymodel.value!.nearbyService!);
          nearbylist.toSet().toList();
        }

        print("allcatelist ${nearbylist.length}");
        log("allcatelist ${jsonEncode(nearbylist)}");

        isnear.value = false;

        // SharedPreferences preferencesToken =
        //     await SharedPreferences.getInstance();
        // preferencesToken.setString(SharedPreferencesKey.LATTITUDE,
        //     nearbymodel.value!.nearbyService![0].lat.toString());
        // Latitude = preferencesToken.getString(SharedPreferencesKey.LATTITUDE)!;

        // preferencesToken.setString(SharedPreferencesKey.LONGITUDE,
        //     nearbymodel.value!.nearbyService![0].lon.toString());
        // Longitude = preferencesToken.getString(SharedPreferencesKey.LONGITUDE)!;
      } else {
        isnear.value = false;
        print(nearbymodel.value!.message);
      }
      return nearbymodel.value;
    } catch (e) {
      isnear.value = false;
      return null;
    }
  }
}
