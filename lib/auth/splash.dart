// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_new, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/welcome.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/controllers/theme_contro.dart';
import 'package:nlytical_app/Vendor/screens/add_store.dart';
import 'package:nlytical_app/Vendor/screens/auth/subcription.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/vendor_new_tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeContro themeContro = Get.find();

class SplashScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const SplashScreen(this.prefs);
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  var _isLightMode;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => _handleCurrentScreen(widget.prefs)),
    // );
    Get.offAll(_handleCurrentScreen(widget.prefs));
  }

  @override
  void initState() {
    super.initState();
    assignValueForMode();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController!, curve: Curves.easeOut);

    // ignore: unnecessary_this
    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();

    // getCurrentLocation().then((_) async {
    //   setState(() {});
    // });
  }

  assignValueForMode() async {
    _isLightMode = SharedPrefs.getBool(SharedPreferencesKey.isLightMode);

    log("IS LIGHT MODE IS - $_isLightMode");

    if (_isLightMode == null || _isLightMode == false) {
      themeContro.updateLightModeValue(false);
      // appearanceCtrl.toggleThemeMode();

      SharedPrefs.setBool(SharedPreferencesKey.isLightMode, false);
    } else {
      themeContro.updateLightModeValue(true);
      SharedPrefs.setBool(SharedPreferencesKey.isLightMode, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAsstes.splashbg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppAsstes.logo,
            height: 55,
            width: 180,
            fit: BoxFit.contain,
            // width: SizeConfig.blockSizeHorizontal * 50,
          ).paddingSymmetric(horizontal: 100, vertical: 100),
        ],
      ),
    );
  }

  Widget _handleCurrentScreen(SharedPreferences prefs) {
    // Fetching user and vendor IDs from SharedPreferences
    String? userid = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);
    String? vendorid = prefs.getString(SharedPreferencesKey.LOGGED_IN_VENDORID);

    // Debug prints for verification
    print("USERID 😍 :- $userid");
    print("VENDORID 😍 :- $vendorid");
    print("STORE_ID 😍 :- ${prefs.getString(SharedPreferencesKey.STORE_ID)}");

    // Logic to decide the screen to navigate to
    if (userid == null && vendorid == null) {
      // Navigate to SplashScreen if both IDs are null
      return Welcome();
    } else if (userid != null) {
      userID = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERID)!;
      print("ROLE: ${prefs.getString(SharedPreferencesKey.ROlE)}");
      Get.find<HomeContro>().checkLocationPermission();
      return TabbarScreen(currentIndex: 0);
    } else if (vendorid != null) {
      String? storeId = prefs.getString(SharedPreferencesKey.STORE_ID);
      if (prefs.getString(SharedPreferencesKey.SUBSCRIBE)?.isEmpty ?? true) {
        print("Navigate to subscription screen");
        return const SubscriptionSceen();
      } else if (storeId == null || storeId.isEmpty || storeId == '0') {
        print("Navigate to add store screen");
        return const AddStore();
      } else {
        print("Navigate to home screen");
        return const VendorNewTabar(currentIndex: 0);
      }
    } else {
      // Fallback case (should never happen with correct data)
      return Welcome();
    }
  }
}
