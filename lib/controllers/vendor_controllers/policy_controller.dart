import 'dart:convert';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/models/vendor_models/policy_model.dart';
import 'package:nlytical_app/models/vendor_models/terms_model.dart';
// import 'package:nlytical_vendor/models/policy_model.dart';
// import 'package:nlytical_vendor/models/terms_model.dart';
// import 'package:nlytical_vendor/utils/api_helper.dart';
import 'package:http/http.dart' as http;

class PolicyController extends GetxController {
  ApiHelper apiHelper = ApiHelper();
  Rx<PolicyModel> policyModel = PolicyModel().obs;

  policyApi() async {
    var uri = Uri.parse(apiHelper.getPrivacypolicy);
    var request = http.MultipartRequest("GET", uri);

    var response = await request.send();
    String responseData = await response.stream.transform(utf8.decoder).join();
    var data = json.decode(responseData);

    policyModel.value = PolicyModel.fromJson(data);
  }

  Rx<TermsModel> termsModel = TermsModel().obs;
  termsApi() async {
    var uri = Uri.parse(apiHelper.getTermsconditions);
    var request = http.MultipartRequest("GET", uri);

    var response = await request.send();
    String responseData = await response.stream.transform(utf8.decoder).join();
    var data = json.decode(responseData);

    termsModel.value = TermsModel.fromJson(data);
  }
}
