// ignore_for_file: constant_identifier_names
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';

class SharedPreferencesKey {
  static const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";
  static const String LOGGED_IN_USERRDATA = "LOGGED_IN_USERRDATA";
  static const String LOGGED_IN_USEREMAIL = "LOGGED_IN_USEREMAIL";
  static const String LOGGED_IN_USERNAME = "LOGGED_IN_USERNAME";
  static const String LOGGED_IN_USERID = "LOGGED_IN_USERID";
  static const String LOGGED_IN_VENDORID = "LOGGED_IN_VENDORID";
  static const String LOGGED_IN_USERTOKEN = "LOGGED_IN_USERTOKEN";
  static const String ROlE = "ROlE";
  static const String LATTITUDE = "LATTITUDE";
  static const String LONGITUDE = "LONGITUDE";
  static const String STATUS = "STATUS";
  static const String SUBSCRIBE = "SUBSCRIBE";
  // static const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";
  // static const String LOGGED_IN_USERRDATA = "LOGGED_IN_USERRDATA";
  // static const String LOGGED_IN_USEREMAIL = "LOGGED_IN_USEREMAIL";
  // static const String LOGGED_IN_USERNAME = "LOGGED_IN_USERNAME";
  // static const String LOGGED_IN_USERID = "LOGGED_IN_USERID";
  // static const String LOGGED_IN_USERTOKEN = "LOGGED_IN_USERTOKEN";
  static const String LOGGED_IN_USERFNAME = "LOGGED_IN_USERFNAME";
  static const String LOGGED_IN_USERLNAME = "LOGGED_IN_USERLNAME";
  static const String LOGGED_IN_USERMOBILE = "LOGGED_IN_USERMOBILE";
  static const String LOGGED_IN_USERIMAGE = "LOGGED_IN_USERIMAGE";
  static const String LOGGED_IN_USERSTOREID = "LOGGED_IN_USERIMAGE";
  static const String STORE_ID = "STORE_ID";
  // static const String ROlE = "ROlE";
  // static const String LATTITUDE = "LATTITUDE";
  // static const String LONGITUDE = "LONGITUDE";
  // static const String STATUS = "STATUS";
  // static const String SUBSCRIBE = "SUBSCRIBE";
  static const String PERCENTAGE = 'PERCENTAGE';
  static const String ISGUEST = 'ISGUEST';
  static const isLightMode = 'isLightMode';
}

class SharedPrefHelper {
  /// Getter for `isGuest`
  static int get isGuest =>
      SharedPrefs.getString(SharedPreferencesKey.ISGUEST) == "1" ? 1 : 0;

  /// Method to set `isGuest` value
  static Future<void> setGuestStatus(int status) async {
    await SharedPrefs.setString(
        SharedPreferencesKey.ISGUEST, status.toString());
  }
}

class Role {
  static const String user = "user";
  static const String vendor = "vendor";

  static String role =
      SharedPrefs.getString(SharedPreferencesKey.ROlE) == Role.user
          ? user
          : vendor;
}
