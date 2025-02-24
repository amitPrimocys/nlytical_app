import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/User/screens/controller/user_tab_controller.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/controllers/vendor_controllers/lang_controller.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/custome_data_empty.dart';
import 'package:nlytical_app/controllers/theme_contro.dart';
import 'package:nlytical_app/controllers/vendor_controllers/payment_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_themes/dynamic_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs.init();
  Get.put(PaymentController());

  await SharedPrefs.init();
  // Get.put(AuthController());
  Get.put(ThemeContro());
  Get.put(LanguageController());
  Get.put(UserTabController());
  Get.put(HomeContro());

  await SharedPreferences.getInstance().then((prefs) {
    final themeCollection = ThemeCollection(themes: {});
    runApp(DynamicTheme(
      themeCollection: themeCollection,
      builder: (context, theme) {
        // belowe brightness methos show mobile device wise dark or light mode
        final Brightness brightness =
            PlatformDispatcher.instance.platformBrightness;
        final bool isDarkMode = brightness == Brightness.dark;

        print("System Theme Mode: ${isDarkMode ? "Dark" : "Light"}");
        return GetMaterialApp(
          themeMode: ThemeMode.system,
          builder: (BuildContext context, Widget? widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return CustomError(errorDetails: errorDetails);
            };
            return widget!;
          },
          color: Colors.white,
          locale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(prefs),
        );
      },
    ));
  });
}

// version : 3.24.5
