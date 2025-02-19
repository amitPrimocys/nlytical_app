import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nlytical_app/models/user_models/update_model.dart';
import 'package:nlytical_app/auth/profile_details.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';

class ProfileDetailContro extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  Rx<UpdateModel?> updatemodel = UpdateModel().obs;

  Future<void> newupdateApi({
    required String uname,
    required String fname,
    required String laname,
    required String email,
    String? file,
  }) async {
    try {
      print(file);
      isLoading.value = true;

      var url = Uri.parse(apiHelper.update);

      var request = http.MultipartRequest('POST', url);

      request.fields.addAll({
        'username': uname,
        'first_name': fname,
        'last_name': laname,
        'email': email,
        'user_id': userID,
      });

      if (file != null && file.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', file));
      }

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      print(request.files);
      if (updatemodel.value!.status == true) {
        var data = json.decode(responseBody);
        updatemodel.value = UpdateModel.fromJson(data);

        if (updatemodel.value?.status == true) {
          print("API Success Response:");
          print(responseBody);

          preferences!.setString(
            SharedPreferencesKey.LOGGED_IN_USERFNAME,
            updatemodel.value!.userdetails!.firstName.toString(),
          );

          preferences!.setString(
            SharedPreferencesKey.LOGGED_IN_USEREMAIL,
            updatemodel.value!.userdetails!.email.toString(),
          );

          String userFName = preferences
                  ?.getString(SharedPreferencesKey.LOGGED_IN_USERFNAME) ??
              '';
          String userMAIL = preferences
                  ?.getString(SharedPreferencesKey.LOGGED_IN_USEREMAIL) ??
              '';
          if (userFName.isEmpty && userMAIL.isEmpty) {
            Get.offAll(() => ProfileDetails(
                  number: updatemodel.value!.userdetails!.mobile.toString(),
                ));
          } else {
            Get.offAll(() => TabbarScreen(currentIndex: 0));
          }
        } else {
          snackBar(updatemodel.value?.message ?? 'Something went wrong');
        }
      } else {
        snackBar('Error: ${response.statusCode}');
      }
    } catch (e) {
      snackBar('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
