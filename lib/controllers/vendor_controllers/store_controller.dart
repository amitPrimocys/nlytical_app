// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/controllers/vendor_controllers/tabbar_controller.dart';
import 'package:nlytical_app/models/vendor_models/add_store_model.dart';
import 'package:nlytical_app/models/vendor_models/category_model.dart';
import 'package:nlytical_app/models/vendor_models/get_store_model.dart';
import 'package:nlytical_app/models/vendor_models/store_update_model.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

class StoreController extends GetxController {
  @override
  void onInit() {
    getCategory();

    if (SharedPrefs.getString(SharedPreferencesKey.STORE_ID).isNotEmpty ||
        SharedPrefs.getString(SharedPreferencesKey.STORE_ID) != "") {
      getStoreDetailApi();
      businessPercentageApi();
    }
    super.onInit();
  }

  ApiHelper apiHelper = ApiHelper();
  RxBool isCategoryLoading = false.obs;

  RxString caategoryName = ''.obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> filteredSubCategoryNames = <String>[].obs;

  List<String> categories = [];
  List<String> subCategories = [];

  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  RxList<String> openingAndClosingDays = <String>[].obs;
  RxList<String> openDaysList = <String>[].obs;

  Rx<CategoryModel> categoryData = CategoryModel().obs;

  var currentAddress = "Fetching location...";

  getCategory() async {
    try {
      isCategoryLoading.value = true;
      final responseJson = await apiHelper.getMethod(
        url: apiHelper.getCategory,
      );
      categoryData.value = CategoryModel.fromJson(responseJson);
      categories =
          categoryData.value.data!.map((e) => e.categoryName!).toList();
      debugPrint('categoryData ${categoryData.value.data!.length}');
      debugPrint('categories ${categories.length}');
      for (var i = 0; i < categoryData.value.data!.length; i++) {
        await getSubCategory(
          categoryId: categoryData.value.data![i].id.toString(),
          index: i,
        );
      }

      isCategoryLoading.value = false;
    } catch (e) {
      isCategoryLoading.value = false;
      debugPrint('get category failed: $e');
    }
  }

  getSubCategory({required String categoryId, required int index}) async {
    try {
      final responseJson = await apiHelper.multipartPostMethod(
        url: apiHelper.getSubcategory,
        formData: {
          "category_id": categoryId,
        },
        files: [],
        headers: {},
      );
      categoryData.value.data![index].subCategoryData =
          Data.fromJson(responseJson).subCategoryData;

      print(
          "sub cat length ${categoryData.value.data![index].subCategoryData!.length}");
    } catch (e) {
      isCategoryLoading.value = false;
      debugPrint('get sub category failed: $e');
    }
  }

  RxDouble searchLatitude = 0.0.obs;
  RxDouble searchLongitude = 0.0.obs;
  GoogleMapController? mapController;

  getLonLat(String input) async {
    String kPlaceApiKey = "AIzaSyAo178gm6y82PrD-BBC5s4UST_leL_I1Ns";
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
    String kPlaceApiKey = "AIzaSyAo178gm6y82PrD-BBC5s4UST_leL_I1Ns";
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

//=========================================================== ADD STORE API ==============================================================================
  RxBool addStoreLoad = false.obs;
  Rx<AddStoreModel> addStoreMoodel = AddStoreModel().obs;

  addSotreApi({
    required String storeName,
    required String storeDescription,
    required String address,
    required String lat,
    required String lon,
    required String categoryId,
    required String subCategoryId,
    required String featured,
    required String employeeStrength,
    required String publishedMonth,
    required String publishedYear,
    String? countryCode,
    String? storePhone,
    String? storeEmail,
    String? storeSite,
    String? whatsapplink,
    String? facebooklink,
    String? instagramlink,
    String? twitterlink,
    String openDays = "",
    String closeDays = "",
    required String openTime,
    required String closeTime,
    List<String>? storeImages,
    List<String>? coverImages,
    String storeVideoThumbnail = "",
    String storeVideo = "",
  }) async {
    try {
      addStoreLoad(true);

      http.MultipartFile? thumbnailFile;
      http.MultipartFile? videoFile;

      if (storeVideo.isNotEmpty) {
        thumbnailFile = await http.MultipartFile.fromPath(
          'video_thumbnail',
          storeVideoThumbnail,
        );
        videoFile = await http.MultipartFile.fromPath(
          'video',
          storeVideo,
        );
      }

      List<http.MultipartFile> filesList = [];

      // Adding Store Images
      if (storeImages != null && storeImages.isNotEmpty) {
        for (String image in storeImages) {
          filesList.add(
            await http.MultipartFile.fromPath('service_images[]', image),
          );
        }
      }

      // Adding Cover Images
      if (coverImages != null && coverImages.isNotEmpty) {
        for (String image in coverImages) {
          filesList.add(
            await http.MultipartFile.fromPath('cover_image', image),
          );
        }
      }

      // Adding Video & Thumbnail
      if (thumbnailFile != null) filesList.add(thumbnailFile);
      if (videoFile != null) filesList.add(videoFile);

      final responseJson = await apiHelper.multipartPostMethod(
        url: apiHelper.addStoreUrl,
        formData: {
          "vendor_id":
              SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
          "service_name": storeName,
          "service_description": storeDescription,
          "address": address,
          "lat": lat,
          "lon": lon,
          "category_id": categoryId,
          "subcategory_id": subCategoryId,
          "is_featured": featured,
          "employee_strength": employeeStrength,
          "published_month": publishedMonth,
          "published_year": publishedYear,
          "service_country_code": countryCode ?? "",
          "service_phone": storePhone ?? "",
          "service_email": storeEmail ?? "",
          "service_website": storeSite ?? "",
          "instagram_link": instagramlink ?? "",
          "facebook_link": facebooklink ?? "",
          "whatsapp_link": whatsapplink ?? "",
          "twitter_link": twitterlink ?? "",
          "open_days": openDays,
          "closed_days": closeDays,
          "open_time": openTime,
          "close_time": closeTime,
        },
        files: filesList, // Using the prepared files list
        headers: {},
      );

      addStoreMoodel.value = AddStoreModel.fromJson(responseJson);

      if (addStoreMoodel.value.status == true) {
        SharedPrefs.setString(SharedPreferencesKey.STORE_ID,
            addStoreMoodel.value.serviceId.toString());

        getStoreDetailApi();
        businessPercentageApi();
        caategoryName.value = "";
        subCategoryNames.clear();
        openingAndClosingDays.clear();

        snackBar("Store added successfully");
        Get.put(VendorTabbarController());
        Get.find<VendorTabbarController>().currentTabIndex.value = 0;
        Get.to(
          const VendorNewTabar(currentIndex: 0),
          transition: Transition.rightToLeft,
        );
        addStoreLoad(false);
      } else {
        addStoreLoad(false);
        snackBar(responseJson["message"]);
      }
    } catch (e) {
      addStoreLoad(false);
      debugPrint('add store failed: $e');
    }
  }

  //================================================== STORE DETAIL API ===================================================================
  RxBool isLoading = false.obs;
  Rx<GetStoreDetailModel> storeDetailModel = GetStoreDetailModel().obs;
  RxList<ServiceDetails> storeList = <ServiceDetails>[].obs;

  getStoreDetailApi() async {
    try {
      isLoading(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.vendorhome, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
      }, files: [], headers: {});
      storeDetailModel.value = GetStoreDetailModel.fromJson(response);
      storeList.clear();

      if (storeDetailModel.value.status == true) {
        storeList.addAll(storeDetailModel.value.serviceDetails!);
        print(storeList);
        isLoading(false);
      } else {
        isLoading(false);
        print("STORE_DETAIL_RESPONSE:${storeDetailModel.value.message}");
      }
    } catch (e) {
      isLoading(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  //=============================================== UPDAE STORE ======================================================================================
  RxBool isUpdate = false.obs;
  Rx<UpdateStoreModel> updateModel = UpdateStoreModel().obs;

  // business name update
  storeNameUpdateApi(
      {required String storeName, required String storeDesc}) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "service_name": storeName,
        "service_description": storeDesc,
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Detail updated...!");
        storeList[0].businessDetails!.serviceName = storeName.toString();
        storeList[0].businessDetails!.serviceDescription = storeDesc.toString();
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store contact update api
  storeCotactUpdateApi(
      {required String countryCode,
      required String storePhone,
      required String storeEmail}) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "service_country_code": countryCode,
        "service_phone": storePhone,
        "service_email": storeEmail,
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Contact Detail updated...!");
        storeList[0].contactDetails!.serviceCountryCode =
            countryCode.toString();
        storeList[0].contactDetails!.servicePhone = storePhone.toString();
        storeList[0].contactDetails!.serviceEmail = storeEmail.toString();
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store address update
  storeAddressUpdateApi(
      {required String address,
      required String lat,
      required String long}) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "address": address,
        "lat": lat,
        "lon": long
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Address updated...!");
        storeList[0].contactDetails!.address = address.toString();
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store timing api
  storeTimingsUpdateApi(
      {required String openDays,
      required String closedDays,
      required String openTime,
      required String closeTime}) async {
    print('OPENDAYS: $openDays');
    print('CLOSEDAYS: $closedDays');
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "open_days": openDays,
        "closed_days": closedDays,
        "open_time": openTime,
        "close_time": closeTime
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        openingAndClosingDays.clear();
        Get.back();

        snackBar("Your Business Timings updated...!");
        getStoreDetailApi();
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store month and years update
  storeMonthYearsUpdateApi(
      {required String month, required String years}) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "published_month": month,
        "published_year": years,
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Detail updated...!");
        storeList[0].businessTime!.publishedMonth = month.toString();
        storeList[0].businessTime!.publishedYear = years.toString();
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

// store category and sub category
  storeCategoryUpdateApi(
      {required String categoryId, required String subCategoryId}) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "category_id": categoryId,
        "subcategory_id": subCategoryId,
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Detail updated...!");
        // getStoreDetailApi();
        storeList[0].businessDetails!.categoryId = int.tryParse(categoryId);
        storeList[0].businessDetails!.subcategoryId = subCategoryId.toString();
        print("SUB:${storeList[0].businessDetails!.subcategoryId}");
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store emplyee
  storeEmployeeUpdateApi({required String storeEmplyee}) async {
    try {
      isUpdate(true);
      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "employee_strength": storeEmplyee,
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Detail updated...!");
        storeList[0].businessTime!.employeeStrength = storeEmplyee.toString();
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store website update
  storeWebSiteUpdateApi({required String storeWebSite}) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "service_website": storeWebSite
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Detail updated...!");
        storeList[0].contactDetails!.serviceWebsite = storeWebSite;
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store
  storeSocialUpdateApi(
      {String? whp, String? fc, String? insta, String? twitter}) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "whatsapp_link": whp!,
        "facebook_link": fc!,
        "instagram_link": insta!,
        "twitter_link": twitter!,
      }, files: [], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        isUpdate(false);
        Get.back();
        snackBar("Your Business Detail updated...!");
        storeList[0].contactDetails!.whatsappLink = whp.toString();
        storeList[0].contactDetails!.facebookLink = fc.toString();
        storeList[0].contactDetails!.instagramLink = insta.toString();
        storeList[0].contactDetails!.twitterLink = twitter.toString();
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store videos
  storeVideoUpdateApi({
    String storeVideoThumbnail = "",
    String storeVideo = "",
  }) async {
    try {
      isUpdate(true);

      http.MultipartFile? thumbnailFile;
      http.MultipartFile? videoFile;
      if (storeVideo.isNotEmpty) {
        thumbnailFile = await http.MultipartFile.fromPath(
          'video_thumbnail',
          storeVideoThumbnail,
        );
        videoFile = await http.MultipartFile.fromPath(
          'video',
          storeVideo,
        );
      }

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
      }, files: [
        if (thumbnailFile != null) thumbnailFile,
        if (videoFile != null) videoFile,
      ], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        getStoreDetailApi();
        isUpdate(false);
        Get.back();
        snackBar("Your business video uploaded...!");
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  // store images update
  storeIMAGEUpdateApi({
    List<String>? storeImages,
  }) async {
    try {
      isUpdate(true);

      final response = await apiHelper
          .multipartPostMethod(url: apiHelper.updateStore, formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
      }, files: [
        if (storeImages!.length == 1)
          await http.MultipartFile.fromPath(
            'service_images[]',
            storeImages[0],
          )
        // Otherwise, iterate through the list of images.
        else
          for (String image in storeImages)
            await http.MultipartFile.fromPath(
              'service_images[]',
              image,
            ),
      ], headers: {});
      updateModel.value = UpdateStoreModel.fromJson(response);

      if (updateModel.value.status == true) {
        getStoreDetailApi();
        isUpdate(false);
        Get.back();
        snackBar("Your Business Detail updated...!");
        storeDetailModel.refresh();
        storeList.refresh();
        businessPercentageApi();
      } else {
        isUpdate(false);
        print(updateModel.value.message.toString());
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  RxBool isRemoveImg = false.obs;

  removeServiceImgApi({required String serviceIMGID}) async {
    isRemoveImg(true);
    final responseJson = await apiHelper.multipartPostMethod(
      url: apiHelper.imgRemove,
      formData: {
        "vendor_id":
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
        "service_image_id": serviceIMGID
      },
      files: [],
      headers: {},
    );

    if (responseJson['status'] == true) {
      isRemoveImg(false);
    } else {
      isRemoveImg(false);
      print(responseJson['message']);
    }
  }

  RxBool isPercent = false.obs;
  businessPercentageApi() async {
    try {
      isPercent(true);

      final response = await apiHelper.multipartPostMethod(
        url: apiHelper.totalpercentage,
        headers: {},
        formData: {
          'vendor_id':
              SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
        },
        files: [],
      );

      if (response['status'] == true) {
        SharedPrefs.setString(
            SharedPreferencesKey.PERCENTAGE, response['percentage'].toString());
        isPercent(false);
      } else {
        SharedPrefs.setString(SharedPreferencesKey.PERCENTAGE, 0.toString());
        isPercent(false);
        print(response['status']);
      }
    } catch (e) {
      isPercent(false);
      print("TOTAL_PERCENTAG_ERROR:${e.toString()}");
    }
  }
}
