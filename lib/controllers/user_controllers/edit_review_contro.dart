// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/review_contro.dart';
import 'package:nlytical_app/models/user_models/delete_model.dart';
import 'package:nlytical_app/models/user_models/review_edit_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/utils/common_widgets.dart';

final ApiHelper apiHelper = ApiHelper();

class EditReviewContro extends GetxController {
  RxBool isedit = false.obs;
  Rx<ReviewEditModel?> revieweditmodel = ReviewEditModel().obs;
  final msgController = TextEditingController();
  RxDouble rateValue = 0.0.obs;
  ReviewContro reviewcontro = Get.put(ReviewContro());
  RxInt page = 1.obs;

  Future<void> reviewEditApi(
      {String? reviewid,
      String? reviewstar,
      String? review_messsage,
      required bool isupdate,
      String? serviceId}) async {
    isedit.value = true;

    try {
      var uri = Uri.parse(apiHelper.revieweditlist);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      if (isupdate == true) {
        request.fields['user_id'] =
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
        request.fields['id'] = reviewid!;
        request.fields['service_id'] = serviceId!;
      } else {
        request.fields['user_id'] =
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
        request.fields['id'] = reviewid!;
        request.fields['service_id'] = serviceId!;
        request.fields['review_star'] = reviewstar!;
        request.fields['review_message'] = review_messsage!;
      }

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      revieweditmodel.value = ReviewEditModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (revieweditmodel.value!.status == true) {
        if (isupdate == true) {
          msgController.text =
              revieweditmodel.value!.reviewdata!.reviewMessage.toString();
          rateValue.value = double.parse(
              revieweditmodel.value!.reviewdata!.reviewStar.toString());

          print(rateValue);
        } else {}
        isedit.value = false;
      }
    } catch (e) {
      isedit.value = false;
      print(e.toString());
    } finally {
      isedit.value = false;
    }
  }

  RxBool isdelete = false.obs;
  Rx<DeleteModel?> deletemodel = DeleteModel().obs;
  Future<void> reviewdelete({
    String? reviewid,
  }) async {
    isdelete.value = true;

    try {
      var uri = Uri.parse(apiHelper.deletereview);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      request.fields['id'] = reviewid!;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      deletemodel.value = DeleteModel.fromJson(userData);
      print(request.fields);
      print(responsData);

      if (deletemodel.value!.status == true) {
        isdelete.value = false;
      } else {
        isdelete.value = false;
        snackBar("Delete Review successfully");

        print(deletemodel.value!.message);
      }
    } catch (e) {
      isdelete.value = false;
      print(e.toString());
    } finally {
      isdelete.value = false;
    }
  }
}
