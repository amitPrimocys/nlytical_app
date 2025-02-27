import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiHelper {
  // static const String baseUrl = 'https://bigservice.theprimoapp.com/api';
  // static const String baseUrl = 'http://62.72.58.23/api';
  static const String baseUrl = 'http://192.168.0.69:8001/api';

// -------------User

  String guest = "$baseUrl/guest-user";
  String userRegister = "$baseUrl/newuser-registeraccount";
  String otp = "$baseUrl/verify-user";
  String login = "$baseUrl/user-login";
  String socialLogin = "$baseUrl/social-login";
  String forgot = "$baseUrl/forgot-password";
  String forgotVerify = "$baseUrl/passwordotp-verify";
  String reset = "$baseUrl/reset-password";
  String filter = "$baseUrl/fetch-filterservices";
  String update = "$baseUrl/update-userprofile";
  String categories = "$baseUrl/get-category";
  String subcategories = "$baseUrl/get-subcategory";
  String likedservices = "$baseUrl/get-likedservices";
  String subcategoryservices = "$baseUrl/get-subcategoryservices";
  String home = "$baseUrl/home";
  String servicedetail = "$baseUrl/get-servicedetail";
  String reviewlist = "$baseUrl/user-reviewlist";
  String revieweditlist = "$baseUrl/edit-userreview";
  String deletereview = "$baseUrl/delete-userreview";
  String addreview = "$baseUrl/add-review";
  String addfeedback = "$baseUrl/app-feedback";
  String like = "$baseUrl/service-like";
  String search = "$baseUrl/search-service";
  String terms = "$baseUrl/get-termsconditions";
  String privacy = "$baseUrl/get-privacypolicy";
  String delete = "$baseUrl/delete-useraccount";
  String block = "$baseUrl/block-user";
  String unblock = "$baseUrl/unblock-user";
  String report = "$baseUrl/report-text";
  String reportuser = "$baseUrl/report-user";
  String getprofile = "$baseUrl/get-userprofile";
  String nearby = "$baseUrl/nearby-services";
  String vendorinfo = "$baseUrl/vendor-info";
  // String updateUserProfile = "$baseUrl/update-userprofile";
  // String subscriptionPlan = "$baseUrl/subscription-plan";
  // String paymentSuccess = "$baseUrl/payment-success";
  // String addStore = "$baseUrl/add-service";
  // String vendorHome = "$baseUrl/vendor-home";
  // String businessReview = "$baseUrl/business-review";
  String chatList = "$baseUrl/chat-list";
  String addChat = "$baseUrl/add-chat";
  String innerChat = "$baseUrl/inner-chat";

// ------------Vendor

  // String login = "$baseUrl/user-login";
  // String userRegister = "$baseUrl/newuser-registeraccount";
  // String otp = "$baseUrl/verify-user";
  // String forgotVerify = "$baseUrl/passwordotp-verify";
  // String forgot = "$baseUrl/forgot-password";
  String subscriptionPlan = "$baseUrl/subscription-plan";
  String paymentSuccess = "$baseUrl/payment-success";
  // String delete = "$baseUrl/delete-useraccount";
  String getProfile = "$baseUrl/get-userprofile";
  String updateUserprofile = "$baseUrl/update-userprofile";
  String getPrivacypolicy = "$baseUrl/get-privacypolicy";
  String getTermsconditions = "$baseUrl/get-termsconditions";
  String getCategory = "$baseUrl/get-category";
  String getSubcategory = "$baseUrl/get-subcategory";
  String addStoreUrl = "$baseUrl/add-service";
  String addServiceUrl = "$baseUrl/add-store";
  String vendorhome = "$baseUrl/vendor-home";
  String updateStore = "$baseUrl/update-service";
  String imgRemove = "$baseUrl/remove-serviceimages";
  String storelist = "$baseUrl/store-list";
  String updateService = "$baseUrl/update-store";
  String deleteService = "$baseUrl/delete-store";
  String imgRemoveService = "$baseUrl/remove-storeimages";
  String attachRemoveService = "$baseUrl/remove-storeattachments";
  String getServicedetail = "$baseUrl/get-servicedetail";
  String totalpercentage = "$baseUrl/total-percentage";
  // String reviewlist = "$baseUrl/user-reviewlist";
  String businessreviewlist = "$baseUrl/business-review";
  String supportfaqs = "$baseUrl/get-faq";
  String customersupport = "$baseUrl/add-customersupport";
  // String addfeedback = "$baseUrl/app-feedback";
  // String chatList = "$baseUrl/chat-list";
  String innerchat = "$baseUrl/inner-chat";
  String useronline = "$baseUrl/user-online";
  // String addChat = "$baseUrl/add-chat";
  String addcampaign = "$baseUrl/add-campaign";
  String getcampaign = "$baseUrl/get-campaign";
  String getbudgett = "$baseUrl/get-budgetcount";
  String addgoal = "$baseUrl/add-goals";
  String addpayment = "$baseUrl/goalpayment-success";

  /// METHODS GET AND POST
  Future<Map<String, dynamic>> getMethod(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? queryParameters}) async {
    try {
      final uri = queryParameters != null
          ? Uri.parse(url).replace(queryParameters: queryParameters)
          : Uri.parse(url);
      final response = await http.get(
        uri,
        headers: headers ??
            <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded",
            },
      );
      log("GET URL: $uri");
      // log("$headers");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log('jsonResponse--->$jsonData');
        return jsonData;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> postMethod(
      {required String url,
      Map<String, String>? headers,
      required Map<String, dynamic> requestBody}) async {
    try {
      final body = jsonEncode(requestBody);

      final response = await http.post(
        Uri.parse(url),
        headers: headers ??
            {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded",
            },
        body: body,
      );

      log('POST URL: $url');
      log('Body: $body');

      log("Status of $url is ${response.statusCode}");

      if (response.statusCode == 200) {
        log('Response body ---> ${response.body}');

        final jsonResponse = jsonDecode(response.body);
        log('jsonResponse--->$jsonResponse');
        return jsonResponse;
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        log('jsonResponse--->$jsonResponse');
        return jsonResponse;
      } else if (response.statusCode == 404) {
        final jsonResponse = jsonDecode(response.body);
        log('jsonResponse--->$jsonResponse');
        return jsonResponse;
      } else if (response.statusCode == 422) {
        final jsonResponse = jsonDecode(response.body);
        log('jsonResponse--->$jsonResponse');
        return jsonResponse;
      } else {
        throw Exception('Failed to perform the POST request');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> multipartPostMethod({
    required String url,
    required Map<String, String> headers,
    required Map<String, String> formData,
    required List<http.MultipartFile> files,
  }) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add headers if provided

      request.headers.addAll(headers);

      // Add form data fields
      formData.forEach((key, value) {
        if (value.isNotEmpty) {
          request.fields[key] = value;
        }
      });

      // Add files to the request
      for (var file in files) {
        request.files.add(file);
      }

      // Send the request
      var response = await request.send();

      // Await the complete response body
      var responseBody = await http.Response.fromStream(response);

      log('POST URL: $url');
      log('Form Data: for $url ${jsonEncode(formData)}');
      log('files: $files}');
      log('Response Status Code: ${response.statusCode}');

      // Check the response status code and decode the body
      if (response.statusCode == 200) {
        log('Response body ---> ${responseBody.body}');

        final jsonResponse = jsonDecode(responseBody.body);
        log('jsonResponse ---> $jsonResponse');
        return jsonResponse;
      } else {
        final jsonResponse = jsonDecode(responseBody.body);
        log('Error Response ---> $jsonResponse');
        throw Exception('Failed to perform the multipart POST request');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Error: $e');
    }
  }

  // String emailregister = "$baseUrl/newuser-registeraccount";
}
