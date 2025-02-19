// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/filter_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';

final ApiHelper apiHelper = ApiHelper();

class FilterContro extends GetxController {
  RxBool isfilter = false.obs;
  RxBool isnavfilter = false.obs;
  Rx<FilterModel?> filtermodel = FilterModel().obs;
  // RxList<ServiceFilter> filterlist = <ServiceFilter>[].obs;
  var selectedCategories = <String>[].obs; // Store selected category
  var selectedRating = 0.obs; // Store selected rating

  RxList<Marker> filtermarkerList = <Marker>[].obs;

  addMarker1() async {
    for (int i = 0; i < filtermodel.value!.serviceFilter!.length; i++) {
      print('FILTERLIST${filtermodel.value!.serviceFilter![i].lat.toString()}');
      filtermarkerList.add(
        Marker(
          markerId: MarkerId('MarkerId$i'),
          position: LatLng(
            double.parse(filtermodel.value!.serviceFilter![i].lat.toString()),
            double.parse(filtermodel.value!.serviceFilter![i].lon.toString()),
          ),
          icon: await getCustomIcon(),
          onTap: () {
            // Check if the index is valid
            if (i >= 0 && i < filtermodel.value!.serviceFilter!.length) {
              _scrollToIndex(i);
            }
          },
        ),
      );
      filtermarkerList.refresh();
      print("FILTERMARKER${filtermarkerList}");
    }
  }

  Future<BitmapDescriptor> getCustomIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(10, 10), // Specify the size (height and width) here
      ),
      "assets/images/locationpick.png",
    );
  }

  void _scrollToIndex(int index) {
    scrollControllerlocation.animateTo(
      index * 362.0, // Adjust 150.0 based on your item height
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  ScrollController scrollControllerlocation = ScrollController();

  Future<void> filterApi(
      {required String page,
      required catId,
      required rivstar,
      required selectedService}) async {
    try {
      isfilter.value = true;
      var uri = Uri.parse(apiHelper.filter);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] = userID;
      request.fields['category_id'] = '$catId';
      request.fields['review_star'] = '$rivstar';
      request.fields['page_no'] = page.isEmpty ? '1' : page;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      filtermodel.value = FilterModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      // filterlist.clear();

      if (filtermodel.value!.status == true) {
        // filterlist.addAll(filtermodel.value!.serviceFilter!);
        // if (page == "1") {
        //   filtermodel.value!.serviceFilter = filtermodel.value!.serviceFilter!;
        // } else {
        //   filtermodel.value!.serviceFilter!
        //       .addAll(filtermodel.value!.serviceFilter!);
        //   filtermodel.value!.serviceFilter!.toSet().toList();
        // }

        // print("allcatelist ${filterlist.length}");
        isfilter.value = false;

        snackBar(filtermodel.value!.message!);
        Get.back();
      } else {
        isfilter.value = false;
        print(filtermodel.value!.message);
      }
    } catch (e) {
      isfilter.value = false;
    } finally {
      isfilter.value = false;
    }
  }
}
