// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/user_models/filter_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';

final ApiHelper apiHelper = ApiHelper();

class FilterContro extends GetxController {
  RxBool isfilter = false.obs;
  RxBool isnavfilter = false.obs;
  Rx<FilterModel?> filtermodel = FilterModel().obs;
  // RxList<ServiceFilter> filterlist = <ServiceFilter>[].obs;
  RxList<String> selectedCategories = <String>[].obs; // Store selected category
  RxList<String> selectedSubCate = <String>[].obs; // Store selected category
  var selectedRating = 0.obs; // Store selected rating
  var selectedPrice = 0.obs;
  RxList<String> selectedType = <String>[].obs;
  RxString location = ''.obs;

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

  RxBool isvisible1 = true.obs;
  RxBool isvisible2 = false.obs;
  RxBool isvisible3 = false.obs;
  RxInt? selectedIndexType;
  RxInt? selectedIndexRating;

  filterApi({
    required String page,
    String? catId,
    String? catName,
    String? subCatId,
    String? subCatName,
    String? price,
    String? type,
    int? rivstar,
    required selectedService,
  }) async {
    try {
      isfilter.value = true;
      var uri = Uri.parse(apiHelper.filter);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      if (catId != null) {
        request.fields['category_id'] = catId;
      }
      request.fields['subcategory_id'] = '$subCatId';
      request.fields['price'] = '$price';
      request.fields['type'] = '$type';
      if (rivstar != null) {
        request.fields['review_star'] = '$rivstar';
      }
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
        isnavfilter.value = true;
        if (price != null) {
          selectedPrice.value = int.parse(price);
        } else {
          selectedPrice.value = 0;
        }
        if (rivstar != null) {
          selectedRating.value = rivstar;
        } else {
          selectedRating.value = 0;
        }
        print("IDC:${catId}");
        if (catId != null) {
          selectedCategories.value = [catName.toString()];
          print("selectedCategories:${jsonEncode(selectedCategories)}");
        } else {
          selectedCategories.clear();
          print("selectedCategories:${jsonEncode(selectedCategories)}");
        }
        print("IDS:${subCatId}");
        if (subCatId != null) {
          selectedSubCate.value = [subCatName.toString()];
          print("selectedSubCate:${selectedSubCate}");
        } else {
          selectedSubCate.clear();
          print("selectedSubCate:${selectedSubCate}");
        }
        if (type != null) {
          selectedType.value = [type.toString()];
          print("selectedType:${selectedType}");
        } else {
          selectedType.clear();
        }
        filtermarkerList.clear();
        addMarker1();

        Get.back();
        snackBar(filtermodel.value!.message!);
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

  RxDouble searchLatitude = 0.0.obs;
  RxDouble searchLongitude = 0.0.obs;
  GoogleMapController? mapController;

  getLonLat(String input) async {
    String kPlaceApiKey = googleMapKey;
    String baseURL =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$input&key=$kPlaceApiKey';

    var response = await http.get(Uri.parse(baseURL));
    var data = response.body.toString();
    print(data);
    print(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final location = data['results'][0]['geometry']['location'];

      searchLatitude.value = location['lat'];
      searchLongitude.value = location['lng'];

      mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(
          searchLatitude.value,
          searchLongitude.value,
        )),
      );
      print('Latitude: $searchLatitude');
      print('Longitude: $searchLongitude');
      print('ADDRESSS: ${mapController.toString()}');
    } else {
      print('Error getting location data: ${response.statusCode}');
    }
  }

  List<dynamic> mapresult = [];

  getsuggestion(String input) async {
    String kPlaceApiKey = googleMapKey;
    String baseURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = '$baseURL?input=$input&key=$kPlaceApiKey';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    print(response.body.toString());
    if (response.statusCode == 200) {
      mapresult = jsonDecode(response.body)['predictions'];
    } else {
      snackBar("Problem while getting Location");
    }
  }

  RxDouble circleRadius = 100.0.obs; // Start from $100
  final RxDouble minPrice = 100.0.obs;
  final RxDouble maxPrice = 10000.0.obs;
}
