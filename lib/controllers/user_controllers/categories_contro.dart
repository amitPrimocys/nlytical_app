// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/cate_model.dart';
import 'package:nlytical_app/models/user_models/subcate_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';

final ApiHelper apiHelper = ApiHelper();

class CategoriesContro extends GetxController {
  RxBool iscat = false.obs;
  Rx<CategoriesModel?> catemodel = CategoriesModel().obs;
  RxList<Data> catelist = <Data>[].obs;

  Future<void> cateApi() async {
    iscat.value = true;

    try {
      var uri = Uri.parse(apiHelper.categories);
      var request = http.MultipartRequest('GET', uri);

      // request.headers.addAll(headers);
      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      catemodel.value = CategoriesModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      catelist.clear();

      if (catemodel.value!.status == true) {
        catelist.addAll(catemodel.value!.data!);
        iscat.value = false;
      } else {
        iscat.value = false;
        print(catemodel.value!.message);
      }
    } catch (e) {
      iscat.value = false;
    }
  }

  RxBool issubcat = false.obs;
  Rx<SubCategoriesModel?> subcatemodel = SubCategoriesModel().obs;
  RxList<SubCategoryData> subcatelist = <SubCategoryData>[].obs;

  Future<void> subcateApi({required String catId}) async {
    issubcat.value = true;

    try {
      var uri = Uri.parse(apiHelper.subcategories);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['category_id'] = catId;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      subcatemodel.value = SubCategoriesModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      subcatelist.clear();

      if (subcatemodel.value!.status == true) {
        subcatelist.addAll(subcatemodel.value!.subCategoryData!);
        issubcat.value = false;
      } else {
        issubcat.value = false;
        print(subcatemodel.value!.message);
      }
    } catch (e) {
      issubcat.value = false;
    }
  }
}
