// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/Vendor/screens/add_store.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:nlytical_app/auth/profile_details.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/login_contro.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/models/social_login_model.dart';
import 'package:nlytical_app/models/vendor_models/user_plan_model.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/common_widgets.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? email;
String? imageUrl;
String? userId;
String data = "";
Future<String> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  // final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final firebase_auth.User user = authResult.user!;

  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoURL != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoURL;
  userId = user.uid;

  print(name);
  print(email);
  print(imageUrl);

  // Only taking the first part of the name, i.e., First Name
  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final firebase_auth.User currentUser = authResult.user!;
  assert(user.uid == currentUser.uid);

  // ignore: unnecessary_null_comparison
  if (user.uid != null) {
    FirebaseMessaging.instance.getToken().then((token) {
      print("👌👌👌👌👌👌👌👌👌👌👌👌👌👌");
      // social login api
      // _userDataPost(context, token!);
      Get.find<LoginContro>()
          .socialLoginApi(type: "google", email: email.toString());
    });
  }
  // ignore: use_build_context_synchronously
  //_userDataPost(context, fcmtoken);
  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

final ApiHelper apiHelper = ApiHelper();
SocialLoginModel socialLoginModel = SocialLoginModel();
socialLoginApi(BuildContext context,
    {required String type, required String email}) async {
  var uri = Uri.parse(apiHelper.socialLogin);
  var request = http.MultipartRequest("POST", uri);

  request.fields['login_type'] = type;
  request.fields['email'] = email;
  // request.fields['device_token'] = 'ABC';

  print(request.fields);

  var response = await request.send();
  String responseData = await response.stream.transform(utf8.decoder).join();
  var data = json.decode(responseData);

  socialLoginModel = SocialLoginModel.fromJson(data);
  print(responseData);

  if (socialLoginModel.status == true) {
    if (socialLoginModel.user!.role == "user") {
      print("🙂🙂🙂Go to User flow🙂🙂🙂");
      SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_USERID,
          socialLoginModel.user!.id.toString());
      SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
      await SharedPrefs.setString(
        SharedPreferencesKey.LOGGED_IN_USERFNAME,
        "",
      );

      SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

      // Check if LOGGED_IN_USERFNAME is empty
      String userFName =
          SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERFNAME);
      if (userFName.isEmpty) {
        Get.offAll(() => ProfileDetails(
              email: email,
            ));
      } else {
        Get.offAll(() => TabbarScreen(currentIndex: 0));
      }
      Get.find<HomeContro>().checkLocationPermission();
      Get.find<HomeContro>().checkLocationPermission();
      // Get.offAll(() => TabbarScreen(currentIndex: 0));
    } else {
      print("🙂🙂🙂Go to Vendor flow🙂🙂🙂");
      await SharedPrefs.remove(SharedPreferencesKey.LOGGED_IN_USERID);
      SharedPrefs.setString(SharedPreferencesKey.LOGGED_IN_VENDORID,
          socialLoginModel.user!.id.toString());

      await profileCotroller.updateProfileApi1();

      if (profileCotroller.updateModel.value.userdetails!.subscribedUser != 0) {
        SharedPrefs.setString(
          SharedPreferencesKey.SUBSCRIBE,
          profileCotroller.updateModel.value.userdetails!.subscribedUser
              .toString(),
        );
        if (profileCotroller.updateModel.value.isStore != 0) {
          print("🙂🙂🙂Go to Vendor flow🙂🙂🙂");
          SharedPrefs.setString(
            SharedPreferencesKey.STORE_ID,
            profileCotroller.updateModel.value.serviceId.toString(),
          );
          Get.offAll(() => const VendorNewTabar(currentIndex: 0));
        } else {
          print("🙂🙂🙂Go to AddStore");
          Get.offAll(() => const AddStore());
        }
      } else {
        print("🙂🙂🙂Go to Subscription🙂🙂🙂");
        Get.offAll(() => Subscription());
      }
    }
  } else {
    print("rrrrrrrrrrr:${socialLoginModel.message!}");
    snackBar(socialLoginModel.message!);
  }
}
