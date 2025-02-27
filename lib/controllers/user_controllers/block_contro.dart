// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nlytical_app/models/user_models/block_model.dart';
import 'package:nlytical_app/models/user_models/unblock_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

final ApiHelper apiHelper = ApiHelper();

class BlockContro extends GetxController {
  RxBool isblock = false.obs;
  Rx<BlockModel?> blockmodel = BlockModel().obs;

  Future<void> BlockApi({String? oppsiteId}) async {
    isblock.value = true;

    try {
      var uri = Uri.parse(apiHelper.block);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['blockedByUserId'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      request.fields['blockedUserId'] = oppsiteId!;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      blockmodel.value = BlockModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (blockmodel.value!.status == true) {
        isblock.value = false;

        snackBar("Block Successfully");
      } else {
        isblock.value = false;
        print(blockmodel.value!.message);
      }
    } catch (e) {
      isblock.value = false;
    } finally {
      isblock.value = false;
    }
  }

  RxBool isunblock = false.obs;
  Rx<UnBlockModel?> unblockmodel = UnBlockModel().obs;

  Future<void> UnBlockApi({String? oppsiteId}) async {
    isunblock.value = true;

    try {
      var uri = Uri.parse(apiHelper.unblock);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['blockedByUserId'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      request.fields['blockedUserId'] = oppsiteId!;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      unblockmodel.value = UnBlockModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (unblockmodel.value!.status == true) {
        isunblock.value = false;

        snackBar("UnBlock Successfully");
      } else {
        isunblock.value = false;
        print(unblockmodel.value!.message);
      }
    } catch (e) {
      isunblock.value = false;
    } finally {
      isunblock.value = false;
    }
  }
}
