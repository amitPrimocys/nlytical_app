// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/guest_model.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';

final ApiHelper apiHelper = ApiHelper();

class GuestContro extends GetxController {
  RxBool isguest = false.obs;
  Rx<GuestModel?> guestmodel = GuestModel().obs;

  guestApi() async {
    isguest.value = true;

    try {
      var uri = Uri.parse(apiHelper.guest);
      var request = http.MultipartRequest("POST", uri);

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      print(request.fields);
      print(responseData);
      print("status${response.statusCode}");
      guestmodel.value = GuestModel.fromJson(data);

      if (guestmodel.value!.status == true && guestmodel.value!.user != null) {
        isguest.value = false;

        await SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERID,
            guestmodel.value!.user!.id.toString());

        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

        // Show snackbar message from the API response
        snackBar(guestmodel.value!.message!);

        // If the user ID is available, navigate to the TabbarScreen
        if (SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID)
            .isNotEmpty) {
          Get.to(TabbarScreen(
            currentIndex: 0,
          ));
        } else {
          // Show an error snackbar if userID is not available
          snackBar("User ID not found");
        }
      } else {
        // Show a snackbar if the status is false
        snackBar("Youre already as guest. Now you need to login");
      }
    } catch (e) {
      isguest.value = false;
      snackBar(e.toString());
      print("666${e.toString()}");
    } finally {
      isguest.value = false;
    }
  }
}
