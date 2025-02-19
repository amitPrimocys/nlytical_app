// // ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/subcate_service_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/global.dart';

final ApiHelper apiHelper = ApiHelper();

class SubcateserviceContro extends GetxController {
  RxBool issubcat = false.obs;
  Rx<SubcatServiceModel?> subcateservicemodel = SubcatServiceModel().obs;
  RxList<FeaturedServices> subcatelist = <FeaturedServices>[].obs;
  RxList<AllServices> allcatelist = <AllServices>[].obs;

//   Future<void> subcateserviceApi({required String page,
//   required String? catId,
//   required String? subcatId,} ) async {
//     issubcat.value = true;

//     try {
//       var uri = Uri.parse(apiHelper.subcategoryservices);
//       var request = http.MultipartRequest('Post', uri);

//       Map<String, String> headers = {
//         "Accept": "application/json",
//         "Content-Type": "application/x-www-form-urlencoded",
//       };

//       request.headers.addAll(headers);

//       request.fields['category_id'] = '$catId';
//       request.fields['subcategory_id'] = '$subcatId';
//       request.fields['page_no'] = page.isEmpty ? '1' : page;

//       request.fields['user_id'] = userID;

//       var response = await request.send();
//       String responsData = await response.stream.transform(utf8.decoder).join();
//       var userData = json.decode(responsData);

//       subcateservicemodel.value = SubcatServiceModel.fromJson(userData);
//       print(request.fields);
//       print(responsData);
//       print("status${response.statusCode}");
//       subcatelist.clear();
//       allcatelist.clear();

//       if (subcateservicemodel.value!.status == true) {
//         subcatelist.addAll(
//           subcateservicemodel.value!.featuredServices!,
//         );

//         allcatelist.addAll(subcateservicemodel.value!.allServices!);
//         issubcat.value = false;
//       } else {
//         issubcat.value = false;
//         print(subcateservicemodel.value!.message);
//       }
//     } catch (e) {
//       issubcat.value = false;
//     } finally {
//       issubcat.value = false;
//     }
//   }
// }

  Future<SubcatServiceModel?> subcateserviceApi({
    required String page,
    required String? catId,
    required String? subcatId,
  }) async {
    issubcat.value = true;

    try {
      var uri = Uri.parse(apiHelper.subcategoryservices);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['category_id'] = '$catId';
      request.fields['subcategory_id'] = '$subcatId';
      request.fields['page_no'] = page.isEmpty ? '1' : page;
      request.fields['user_id'] = userID;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      subcateservicemodel.value = SubcatServiceModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      subcatelist.clear();

      if (subcateservicemodel.value!.status == true) {
        subcatelist.addAll(subcateservicemodel.value!.featuredServices!);
        if (page == "1") {
          allcatelist.value = subcateservicemodel.value!.allServices!;
        } else {
          allcatelist.addAll(subcateservicemodel.value!.allServices!);
          allcatelist.toSet().toList();
        }

        print("allcatelist ${allcatelist.length}");
        issubcat.value = false;
      } else {
        issubcat.value = false;
        print(subcateservicemodel.value!.message);
      }

      // Return the parsed response model
      return subcateservicemodel.value;
    } catch (e) {
      issubcat.value = false;
      return null;
    } finally {
      issubcat.value = false;
    }
  }
}
