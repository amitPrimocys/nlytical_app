// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/auth/google_signin.dart';
import 'package:nlytical_app/auth/welcome.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/models/vendor_models/delete_model.dart';
import 'package:nlytical_app/models/vendor_models/forgot_model.dart';
import 'package:nlytical_app/models/vendor_models/forgot_otp_model.dart';
import 'package:nlytical_app/models/vendor_models/login_model.dart';
import 'package:nlytical_app/models/vendor_models/otp_model.dart';
import 'package:nlytical_app/models/vendor_models/sign_up_model.dart';
import 'package:nlytical_app/models/vendor_models/subscription_plan_model.dart';
import 'package:nlytical_app/models/vendor_models/user_plan_model.dart';
import 'package:nlytical_app/Vendor/screens/add_store.dart';
import 'package:nlytical_app/Vendor/screens/auth/subcription.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginContro1 extends GetxController {
  final ApiHelper apiHelper = ApiHelper();
  RxBool isLoading = false.obs;
  var isObscureForSignUp = true.obs;
  Rx<LoginModel> loginModel = LoginModel().obs;
  StoreController storeController = Get.put(StoreController());

  @override
  void onInit() {
    subscriptionPlanDetails();
    super.onInit();
  }

  loginApi(
      {required String Email,
      required String Password,
      required String deviceToken}) async {
    try {
      isLoading.value = true;

      var uri = Uri.parse(apiHelper.login);
      var request = http.MultipartRequest("POST", uri);

      request.fields['email'] = Email;
      request.fields['password'] = Password;
      request.fields['device_token'] = deviceToken;

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      loginModel.value = LoginModel.fromJson(data);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      print(response.statusCode);

      print(request.fields);

      print(responseData);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      if (loginModel.value.status == true) {
        isLoading.value = false;

        SharedPreferences preferencesToken =
            await SharedPreferences.getInstance();
        preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
            loginModel.value.userId.toString());

        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

        SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USEREMAIL, loginModel.value.email!);

        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERNAME,
            loginModel.value.username!);

        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERFNAME,
            loginModel.value.firstName!);
        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERLNAME,
            loginModel.value.lastName!);

        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERMOBILE,
            loginModel.value.mobile!);

        SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERIMAGE, loginModel.value.image!);

        userIMAGE =
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERIMAGE);

        // Get.find<StoreController>().businessPercentageApi();
        storeController.businessPercentageApi();
        storeController.getStoreDetailApi();

        // ignore: unused_local_variable
        String userResponseStr = json.encode(data);

        snackBar(loginModel.value.message!);

        print(
            "SUBSCRIPTION_PLAN:${SharedPrefs.getString(SharedPreferencesKey.SUBSCRIBE)}");

        if (loginModel.value.subscribedUser == 0) {
          print("Navigate to subscription screen");
          SharedPrefs.setString(
              SharedPreferencesKey.STORE_ID, loginModel.value.serviceId!);
          Get.to(() => SubscriptionSceen());
        } else if (loginModel.value.serviceId == "") {
          print("Navigate to add store screen");
          Get.to(() => AddStore());
        } else {
          print("Navigate to home screen");
          SharedPrefs.setString(SharedPreferencesKey.SUBSCRIBE,
              loginModel.value.subscribedUser.toString());
          SharedPrefs.setString(
              SharedPreferencesKey.STORE_ID, loginModel.value.serviceId!);
          Get.find<StoreController>().getStoreDetailApi();
          Get.offAll(() => VendorNewTabar(currentIndex: 0));
        }

        // loginModel.value.subscribedUser == 0
        //     ? Get.to(() => SubscriptionSceen())
        //     : Get.offAll(() => VendorNewTabar(currentIndex: 0));

        if (loginModel.value.subscribedUser == 1) {
          SharedPrefs.setString(
            SharedPreferencesKey.SUBSCRIBE,
            "1",
          );
        }
      } else {
        isLoading.value = false;
        snackBar(loginModel.value.message!);
      }
    } catch (e) {
      isLoading.value = false;
      snackBar(e.toString());
      print(e.toString());
    }
  }

//================================================================= SIGNUP ===============================================================================

  Rx<RegisterModel> registerModel = RegisterModel().obs;
  registerApi({
    String? Username,
    String? Firstname,
    String? Lastname,
    String? Newmobile,
    String? Countrycode,
    String? Email,
    String? Password,
  }) async {
    try {
      isLoading(true);

      var uri = Uri.parse(apiHelper.userRegister);
      var request = http.MultipartRequest("POST", uri);

      request.fields['username'] = '$Username';
      request.fields['first_name'] = '$Firstname';
      request.fields['last_name'] = '$Lastname';
      request.fields['country_code'] = '$Countrycode';
      request.fields['new_mobile'] = '$Newmobile';
      request.fields['email'] = '$Email';
      request.fields['password'] = '$Password';
      request.fields['role'] = 'vendor';

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      registerModel.value = RegisterModel.fromJson(data);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      print(response.statusCode);

      print(request.fields);

      print(responseData);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      if (registerModel.value.status == true) {
        SharedPreferences preferencesToken =
            await SharedPreferences.getInstance();
        preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
            registerModel.value.userId.toString());

        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

        SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERNAME, Username!);

        SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERFNAME, Firstname!);
        SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERLNAME, Lastname!);

        SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERMOBILE, Newmobile!);

        SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USEREMAIL, Email!);

        SharedPrefs.setString(
            SharedPreferencesKey.LOGGED_IN_USERIMAGE, AppAsstes.default_user);

        userIMAGE =
            SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERIMAGE);

        Get.find<StoreController>().businessPercentageApi();

        // ignore: unused_local_variable
        String userResponseStr = json.encode(data);

        // Get.to(() => Otpscreen(
        //       email: Email,
        //       userName: Username,
        //       fname: Firstname,
        //       lname: Lastname,
        //       pwd: Password,
        //       isfortap: 0,
        //       countryCode: Countrycode,
        //       mobile: Newmobile,
        //     ));

        snackBar(registerModel.value.message!);
        isLoading(false);
      } else {
        isLoading(false);
        snackBar(registerModel.value.message!);
      }
    } catch (e) {
      isLoading(false);

      print(e.toString());
      snackBar(e.toString());
    }
  }

//================================================= mobile regiter =======================================================================
  // registerApi1({
  //   String? Newmobile,
  //   String? Countrycode,

  //   // required String device,
  // }) async {
  //   try {
  //     isLoading.value = true;

  //     var uri = Uri.parse(apiHelper.userRegister);
  //     var request = http.MultipartRequest("POST", uri);

  //     request.fields['country_code'] = '$Countrycode';
  //     request.fields['mobile'] = '$Newmobile';
  //     request.fields['role'] = 'vendor';

  //     var response = await request.send();
  //     String responseData =
  //         await response.stream.transform(utf8.decoder).join();
  //     var data = json.decode(responseData);
  //     registerModel.value = RegisterModel.fromJson(data);

  //     print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

  //     print(response.statusCode);

  //     print(request.fields);

  //     print(responseData);

  //     print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

  //     if (registerModel.value.status == true) {
  //       isLoading.value = false;

  //       SharedPreferences preferencesToken =
  //           await SharedPreferences.getInstance();
  //       preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
  //           registerModel.value.userId.toString());
  //       userID =
  //           preferencesToken.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

  //       // ignore: unused_local_variable
  //       String userResponseStr = json.encode(data);

  //       snackBar(registerModel.value.message!);

  //       //navigate to home
  //       Get.to(
  //         Otpscreen(
  //           isfortap: 1,
  //           countryCode: '+$contrycode',
  //           mobile: "$Newmobile",
  //         ),
  //         transition: Transition.rightToLeft,
  //       );
  //     } else {
  //       isLoading.value = false;
  //       snackBar(registerModel.value.message!);
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     snackBar(e.toString());
  //   }
  // }

  // registerApi1({
  //   required String Newmobile,
  //   required String Countrycode,
  // }) async {
  //   try {
  //     isLoading.value = true;

  //     // API URL
  //     var url = Uri.parse(apiHelper.userRegister);

  //     // Request body
  //     Map<String, String> body = {
  //       'country_code': Countrycode,
  //       'mobile': Newmobile,
  //       'role': 'vendor',
  //     };

  //     // Sending a POST request
  //     var response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(body),
  //     );

  //     // Parsing response
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       registerModel.value = RegisterModel.fromJson(data);

  //       if (registerModel.value.status == true) {
  //         // Save user ID in shared preferences
  //         SharedPreferences preferencesToken =
  //             await SharedPreferences.getInstance();
  //         preferencesToken.setString(
  //           SharedPreferencesKey.LOGGED_IN_USERID,
  //           registerModel.value.userId.toString(),
  //         );
  //         userID = preferencesToken
  //             .getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

  //         print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");
  //         // ignore: avoid_print
  //         print(response.statusCode);
  //         // ignore: avoid_print
  //         print(response.body);
  //         // ignore: avoid_print

  //         // ignore: avoid_print
  //         print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");
  //         // Navigate to OTP screen
  //         Get.offAll(
  //           () => Otpscreen(
  //             // countryCode: '+$Countrycode',
  //             // number: Newmobile,
  //             // devicetoken: 'KKK',
  //             // isfortap: 1,
  //             isfortap: 1,
  //             countryCode: '+$contrycode',
  //             mobile: Newmobile,
  //           ),
  //           transition: Transition.rightToLeft,
  //         );
  //         snackBar(registerModel.value.message!);
  //       } else {
  //         // Handle API error
  //         snackBar(registerModel.value.message ?? 'Something went wrong');
  //       }
  //     } else {
  //       snackBar('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle unexpected errors
  //     snackBar('Error: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

//========================================================= OTP GET =============================================================================
  Rx<OtpModel> otpmodel = OtpModel().obs;

  // otpApi(
  //     {String? mobile,
  //     String? email,
  //     required String otp,
  //     required String Device}) async {
  //   try {
  //     isLoading.value = true;

  //     var uri = Uri.parse(apiHelper.otp);
  //     var request = http.MultipartRequest("POST", uri);
  //     Map<String, String> headers = {
  //       "Accept": "application/json",
  //       "Content-Type": "application/x-www-form-urlencoded",
  //     };

  //     request.headers.addAll(headers);
  //     email != "" || email!.isNotEmpty
  //         ? request.fields['email'] = email!
  //         : request.fields['mobile'] = mobile!;
  //     request.fields['otp'] = otp;
  //     request.fields['device_token'] = Device;

  //     var response = await request.send();
  //     String responseData =
  //         await response.stream.transform(utf8.decoder).join();
  //     var data = json.decode(responseData);
  //     otpmodel.value = OtpModel.fromJson(data);

  //     print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

  //     print(response.statusCode);

  //     print(request.fields);

  //     print(responseData);

  //     print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

  //     if (otpmodel.value.status == true) {
  //       isLoading.value = false;

  //       SharedPreferences preferencesToken =
  //           await SharedPreferences.getInstance();
  //       preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
  //           otpmodel.value.userId.toString());
  //       userID =
  //           preferencesToken.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

  //       snackBar("Login Successfully".tr);

  //       //navigate to cart
  //       Get.to(SubscriptionSceen());
  //     } else {
  //       snackBar(otpmodel.value.message!);
  //       isLoading.value = false;
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     snackBar(e.toString());
  //   }
  // }

  Future<void> otpApi(
      {String? mobile,
      String? email,
      required String otp,
      required String Device}) async {
    isLoading.value = true;

    try {
      // API URL
      var url = Uri.parse(apiHelper.otp);

      // Constructing request body
      Map<String, String> body = {
        'otp': otp,
        'device_token': Device,
      };

      if (email != null && email.isNotEmpty) {
        body['email'] = email;
      } else if (mobile != null && mobile.isNotEmpty) {
        body['mobile'] = mobile;
      }

      // Sending POST request
      var response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print("Status code $url  :${response.statusCode}");

      print("Status body $url  :${response.body}");

      // Handling response
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        otpmodel.value = OtpModel.fromJson(data);

        if (otpmodel.value.status == true) {
          // Save user ID in shared preferences
          SharedPreferences preferencesToken =
              await SharedPreferences.getInstance();
          preferencesToken.setString(
            SharedPreferencesKey.LOGGED_IN_USERID,
            otpmodel.value.userId.toString(),
          );
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

          snackBar("Login Successfully".tr);

          // Navigate to TabbarScreen
          Get.offAll(() => VendorNewTabar(currentIndex: 0));
        } else {
          snackBar(otpmodel.value.message ?? "Invalid response");
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

//=============================================== Forgot password ========================================================================================

  Rx<ForgotModel> forgotModel = ForgotModel().obs;

  forgotApi({
    required String email,
  }) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.forgot);
      var request = http.MultipartRequest("POST", uri);

      request.fields['email'] = email;

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      forgotModel.value = ForgotModel.fromJson(data);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      print(response.statusCode);

      print(request.fields);

      print(responseData);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      if (forgotModel.value.status == true) {
        isLoading.value = false;

        // SharedPreferences preferencesToken =
        //     await SharedPreferences.getInstance();
        // preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
        //     registerModel.value!.userId.toString());
        // userID =
        //     preferencesToken.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

        // ignore: unused_local_variable
        String userResponseStr = json.encode(data);

        snackBar(forgotModel.value.message!);

        // //navigate to cart
        // Get.to(() => Otpscreen(
        //       email: email, isfortap: 2,
        //       // devicetoken: device,
        //     ));

        // Get.to(TabbarScreen(
        //   currentIndex: 0,
        // ));
      } else {
        isLoading.value = false;
        snackBar(forgotModel.value.message!);
      }
    } catch (e) {
      isLoading.value = false;
      snackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

//=============================================== Forgot password otp ====================================================================================
  Rx<ForgotVerifyModel> forgotOTPmodel = ForgotVerifyModel().obs;

  forgotVerifyOtpApi({required String email, required String otp}) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.forgotVerify);
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['email'] = email;
      request.fields['otp'] = otp;

      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var data = json.decode(responseData);
      forgotOTPmodel.value = ForgotVerifyModel.fromJson(data);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      print(response.statusCode);

      print(request.fields);

      print(responseData);

      print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");

      if (forgotOTPmodel.value.status == true) {
        isLoading.value = false;

        // SharedPreferences preferencesToken =
        //     await SharedPreferences.getInstance();
        // preferencesToken.setString(SharedPreferencesKey.LOGGED_IN_USERID,
        //     otpmodel.value!.userId.toString());
        // userID =
        //     preferencesToken.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

        // snackBar("Login Successfully".tr);

        //navigate to cart
        // Get.to(Resetpass(
        //   email: email,
        // ));
      } else {
        snackBar(forgotOTPmodel.value.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      snackBar(e.toString());
    }
  }

//============================================= SUBSCRIPTION PLAN =======================================================
  final RxString selectedPayment = "Credit or Debit Card".obs;

  RxList<Map<String, String>> paymentOptions = [
    {
      "title": "Credit or Debit Card",
      "value": "credit_debit",
      "image": "assets/images/cr&deb.png",
    },
    {
      "title": "PayPal",
      "value": "paypal",
      "image": "assets/images/paypal_image.png",
    },
    {
      "title": "Gpay",
      "value": "gpay",
      "image": "assets/images/gpay.png",
    },
    {
      "title": "Razorpay",
      "value": "razorpay",
      "image": "assets/images/razorpay.png",
    },
  ].obs;

  RxBool isSubscriptionDetailLoading = false.obs;
  RxBool isPaymentSuccessLoading = false.obs;

  // Rx<UserPlanModel> userPlanData = UserPlanModel().obs;

  RxList<SubscriptionDetail> subscriptionDetailsData =
      <SubscriptionDetail>[].obs;

  RxInt selectedPlanIndex = 0.obs;

  subscriptionPlanDetails() async {
    try {
      isSubscriptionDetailLoading.value = true;
      final responseJson = await apiHelper.postMethod(
        url: apiHelper.subscriptionPlan,
        requestBody: {},
      );

      if (responseJson["status"] == true) {
        subscriptionDetailsData.value =
            SubscriptionDetailModel.fromJson(responseJson).subscriptionDetail!;
      }
      isSubscriptionDetailLoading.value = false;
    } catch (e) {
      isSubscriptionDetailLoading.value = false;
      debugPrint('subscription plan details failed: $e');
    }
  }

  Rx<UserPlanModel> userPlanData = UserPlanModel().obs;
  paymentSuccess({required String paymentType}) async {
    print('VENDOR ID: ${SharedPrefs.getString(
      SharedPreferencesKey.LOGGED_IN_VENDORID,
    )}');

    try {
      isPaymentSuccessLoading.value = true;
      final responseJson = await apiHelper.multipartPostMethod(
        url: apiHelper.paymentSuccess,
        headers: {},
        formData: {
          "user_id": SharedPrefs.getString(
            SharedPreferencesKey.LOGGED_IN_VENDORID,
          ),
          "plan_name":
              subscriptionDetailsData[selectedPlanIndex.value].planName!,
          "price": subscriptionDetailsData[selectedPlanIndex.value]
              .price!
              .replaceAll(RegExp(r'[^\d.]'), ''),
          "payment_mode": paymentType,
        },
        files: [],
      );

      if (responseJson["status"] == true) {
        userPlanData.value = UserPlanModel.fromJson(responseJson);
        SharedPrefs.setString(
          SharedPreferencesKey.SUBSCRIBE,
          "1",
        );

        Get.offAll(() => AddStore());
        // Get.to(AddStore());
      }
      isPaymentSuccessLoading.value = false;
    } catch (e) {
      isPaymentSuccessLoading.value = false;
      debugPrint('user plan details failed: $e');
    }
  }

//==================================================== LOGIN CONTROLLER ======================================================================
  RxBool isdelete = false.obs;
  Rx<DeleteModel> deletemodel = DeleteModel().obs;

  deleteApi() async {
    try {
      isdelete.value = true;
      var uri = Uri.parse(apiHelper.delete);
      var request = http.MultipartRequest('Post', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      deletemodel.value = DeleteModel.fromJson(userData);
      print("DELETE_ACC:${request.fields}");
      print("DELETE_ACC:$responsData");
      print("status${response.statusCode}");

      if (deletemodel.value.status == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();
        await SharedPrefs.clear();
        userEmail = '';
        userIMAGE = '';
        signOutGoogle();
        Get.offAll(() => const Welcome());

        snackBar("Delete Successfully");
        isdelete.value = false;
      } else {
        isdelete.value = false;
        print(deletemodel.value.message);
      }
    } catch (e) {
      isdelete.value = false;
      print(e.toString());
    }
  }
}
