// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/models/vendor_models/add_service_model.dart';
import 'package:nlytical_app/models/vendor_models/delete_service_model.dart';
import 'package:nlytical_app/models/vendor_models/service_detail_model.dart';
import 'package:nlytical_app/models/vendor_models/service_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/utils/common_widgets.dart';

class ServiceController extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  RxBool isloading = false.obs;
  Rx<AddServiceModel> addServiceModel = AddServiceModel().obs;

  addServiceApi({
    required String name,
    required String desc,
    required String price,
    List<String>? storeImages,
    List<String>? storeAttachment,
  }) async {
    try {
      isloading(true);

      final response = await apiHelper.multipartPostMethod(
        url: apiHelper.addServiceUrl,
        headers: {},
        formData: {
          "vendor_id":
              SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID),
          "service_id": SharedPrefs.getString(SharedPreferencesKey.STORE_ID),
          "store_name": name,
          "store_description": desc,
          "price": price,
        },
        files: [
          if (storeImages!.length == 1)
            await http.MultipartFile.fromPath(
              'store_images[]',
              storeImages[0],
            )
          // Otherwise, iterate through the list of images.
          else
            for (String image in storeImages)
              await http.MultipartFile.fromPath(
                'store_images[]',
                image,
              ),
          // service attachment
          if (storeAttachment!.length == 1)
            await http.MultipartFile.fromPath(
              'store_attachments[]',
              storeAttachment[0],
            )
          // Otherwise, iterate through the list of images.
          else
            for (String image in storeAttachment)
              await http.MultipartFile.fromPath(
                'store_attachments[]',
                image,
              ),
        ],
      );

      addServiceModel.value = AddServiceModel.fromJson(response);

      if (addServiceModel.value.status == true) {
        isloading(false);
        Get.back();

        // Get.offAll(const VendorNewTabar(
        //   currentIndex: 0,
        // ));

        snackBar("Service added successfully...!");
        serviceListApi();
      } else {
        isloading(false);
        snackBar(addServiceModel.value.message!);
      }
    } catch (e) {
      isloading(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  RxBool isGetData = false.obs;
  Rx<ServiceListModel> serviceListModel = ServiceListModel().obs;
  RxList<StoreList> serviceList = <StoreList>[].obs;
  RxInt serviceIndex = (-1).obs;

  serviceListApi() async {
    try {
      isGetData(true);

      final response = await apiHelper.multipartPostMethod(
        url: apiHelper.storelist,
        headers: {},
        formData: {
          'service_id': SharedPrefs.getString(SharedPreferencesKey.STORE_ID)
        },
        files: [],
      );

      serviceListModel.value = ServiceListModel.fromJson(response);
      serviceList.clear();
      if (serviceListModel.value.status == true) {
        serviceList.addAll(serviceListModel.value.storeList!);
        log(serviceList.toString());
        isGetData(false);
      } else {
        isGetData(false);
        serviceList.clear();
        print(serviceListModel.value.message);
        snackBar(serviceListModel.value.message!);
      }
    } catch (e) {
      isGetData(false);
      serviceList.clear();
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  RxBool isdelete = false.obs;
  Rx<DeleteServiceModel?> deletemodel = DeleteServiceModel().obs;
  deleteserviceApi({String? storeid}) async {
    isdelete.value = true;

    try {
      var uri = Uri.parse(apiHelper.deleteService);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['store_id'] = storeid!;

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      deletemodel.value = DeleteServiceModel.fromJson(userData);
      print(request.fields);
      print(responsData);

      if (deletemodel.value!.status == true) {
        isdelete.value = false;
      } else {
        isdelete.value = false;

        snackBar(deletemodel.value!.message!);
        print(deletemodel.value!.message);
      }
    } catch (e) {
      isdelete.value = false;
      print(e.toString());
    }
  }

  RxBool isUpdate = false.obs;
  updateServiceApi({
    required String serviceID,
    required String name,
    required String desc,
    required String price,
    List<String>? storeImages,
    List<String>? storeAttachment,
  }) async {
    try {
      isUpdate(true);

      final response = await apiHelper.multipartPostMethod(
        url: apiHelper.updateService,
        headers: {},
        formData: {
          "store_id": serviceID,
          "store_name": name,
          "store_description": desc,
          "price": price,
        },
        files: [
          if (storeImages!.length == 1)
            await http.MultipartFile.fromPath(
              'store_images[]',
              storeImages[0],
            )
          // Otherwise, iterate through the list of images.
          else
            for (String image in storeImages)
              await http.MultipartFile.fromPath(
                'store_images[]',
                image,
              ),
          // service attachment
          if (storeAttachment!.length == 1)
            await http.MultipartFile.fromPath(
              'store_attachments[]',
              storeAttachment[0],
            )
          // Otherwise, iterate through the list of images.
          else
            for (String image in storeAttachment)
              await http.MultipartFile.fromPath(
                'store_attachments[]',
                image,
              ),
        ],
      );

      if (response['status'] == true) {
        isUpdate(false);
        Get.back();
        snackBar("Service updated successfully...!");
        serviceListApi();
        serviceListModel.refresh();
        serviceList.refresh();
      } else {
        isUpdate(false);
        snackBar(response['message']);
      }
    } catch (e) {
      isUpdate(false);
      print(e.toString());
      snackBar("Something went wrong, try again");
    }
  }

  RxBool isRemoveImg = false.obs;

  removeServiceImgApi(
      {required String serviceID, required String serviceIMGID}) async {
    isRemoveImg(true);
    final responseJson = await apiHelper.multipartPostMethod(
      url: apiHelper.imgRemoveService,
      formData: {"store_id": serviceID, "store_image_id": serviceIMGID},
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

  RxBool isRemoveAttach = false.obs;

  removeServiceAttachApi(
      {required String serviceID, required String serviceIMGID}) async {
    isRemoveAttach(true);
    final responseJson = await apiHelper.multipartPostMethod(
      url: apiHelper.attachRemoveService,
      formData: {"store_id": serviceID, "store_attach_id": serviceIMGID},
      files: [],
      headers: {},
    );

    if (responseJson['status'] == true) {
      isRemoveAttach(false);
    } else {
      isRemoveAttach(false);
      print(responseJson['message']);
    }
  }

  //========================================== service detail
  RxBool isservice = false.obs;
  Rx<ServiceDetailModel?> servicemodel = ServiceDetailModel().obs;

  Future<void> servicedetailApi() async {
    isservice.value = true;

    try {
      var uri = Uri.parse(apiHelper.getServicedetail);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);
      request.fields['service_id'] =
          SharedPrefs.getString(SharedPreferencesKey.STORE_ID);
      request.fields['lat'] =
          SharedPrefs.getString(SharedPreferencesKey.LATTITUDE);
      request.fields['lon'] =
          SharedPrefs.getString(SharedPreferencesKey.LONGITUDE);

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      servicemodel.value = ServiceDetailModel.fromJson(userData);
      print("REQUEST ${request.fields}");
      print(responsData);
      print("status${response.statusCode}");

      if (servicemodel.value!.status == true) {
        isservice.value = false;
      } else {
        isservice.value = false;
        print(servicemodel.value!.message);
      }
    } catch (e) {
      isservice.value = false;
      print(e.toString());
      snackBar("Something went wrong, try again...!");
    }
  }
}
