// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:nlytical_app/Vendor/share-prefrences/prefrencesKey.dart';
// import 'package:nlytical_app/Vendor/utils/api_helper.dart';
// import 'package:nlytical_app/models/vendor_models/sign_up_model.dart';
// import 'package:nlytical_app/Vendor/screens/auth/otp_screen.dart';
// import 'package:nlytical_app/Vendor/utils/global.dart';
// // import 'package:nlytical_vendor/models/sign_up_model.dart';
// // import 'package:nlytical_vendor/screens/auth/otp_screen.dart';
// // import 'package:nlytical_vendor/shared_preferences/prefrences_key.dart';
// // import 'package:nlytical_vendor/utils/api_helper.dart';
// // import 'package:nlytical_vendor/utils/global.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MobileContro extends GetxController {
//   final ApiHelper apiHelper = ApiHelper();
//   RxBool isLoading = false.obs;
//   Rx<RegisterModel?> registerModel = RegisterModel().obs;

//   Future<void> registerNumberApi({
//     required String Newmobile,
//     required String Countrycode,
//   }) async {
//     try {
//       isLoading.value = true;

//       // API URL
//       var url = Uri.parse(apiHelper.userRegister);

//       // Request body
//       Map<String, String> body = {
//         'country_code': Countrycode,
//         'mobile': Newmobile,
//         'role': 'user',
//       };

//       // Sending a POST request
//       var response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(body),
//       );

//       // Parsing response
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         registerModel.value = RegisterModel.fromJson(data);

//         if (registerModel.value?.status == true) {
//           // Save user ID in shared preferences
//           SharedPreferences preferencesToken =
//               await SharedPreferences.getInstance();
//           preferencesToken.setString(
//             SharedPreferencesKey.LOGGED_IN_USERID,
//             registerModel.value!.userId.toString(),
//           );
//           userID = preferencesToken
//               .getString(SharedPreferencesKey.LOGGED_IN_USERID)!;

//           print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");
//           // ignore: avoid_print
//           print(response.statusCode);
//           // ignore: avoid_print
//           print(response.body);
//           // ignore: avoid_print

//           // ignore: avoid_print
//           print("☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻☺☻");
//           // Navigate to OTP screen
//           Get.offAll(
//             () => Otpscreen(
//               countryCode: '+$Countrycode',
//               mobile: Newmobile,
//               // devicetoken: 'KKK',
//               isfortap: 1,
//             ),
//             transition: Transition.rightToLeft,
//           );
//           snackBar(registerModel.value!.message!);
//         } else {
//           // Handle API error
//           snackBar(registerModel.value?.message ?? 'Something went wrong');
//         }
//       } else {
//         snackBar('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle unexpected errors
//       snackBar('Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
