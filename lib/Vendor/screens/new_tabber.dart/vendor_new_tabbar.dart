// ignore_for_file: avoid_print, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/theme_contro.dart';
import 'package:nlytical_app/controllers/vendor_controllers/chat_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/lang_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/login_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/policy_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/profile_cotroller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/service_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/tabbar_controller.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/home_screen.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/message_screen.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/notification.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/settings_screen.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class VendorNewTabar extends StatefulWidget {
  final int currentIndex;
  const VendorNewTabar({super.key, required this.currentIndex});

  @override
  State<VendorNewTabar> createState() => _VendorNewTabarState();
}

class _VendorNewTabarState extends State<VendorNewTabar>
    with WidgetsBindingObserver {
  VendorTabbarController vendorTabbarController =
      Get.put(VendorTabbarController());
  ThemeContro themeContro = Get.find();
  StoreController storeController = Get.put(StoreController());
  LanguageController languageController = Get.put(LanguageController());
  LoginContro1 loginContro = Get.put(LoginContro1());
  ChatControllervendor messageController = Get.put(ChatControllervendor());

  ServiceController serviceController = Get.put(ServiceController());
  ProfileCotroller profileCotroller = Get.put(ProfileCotroller());
  PolicyController policyCotroller = Get.put(PolicyController());

  final List<dynamic> handlePages = [
    const HomeScreen(),
    const MessageScreen(),
    const NotificationList(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    vendorTabbarController.currentTabIndex.value = widget.currentIndex;
    print("TAB_INDEX:${vendorTabbarController.currentTabIndex.value}");
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      messageController.onlineuservendor(onlineStatus: "1");
      print("state: $state");
    } else if (state == AppLifecycleState.paused) {
      messageController.onlineuservendor(onlineStatus: "0");
      print("state: $state");
    } else if (state == AppLifecycleState.inactive) {
      messageController.onlineuservendor(onlineStatus: "0");
      print("state: $state");
    } else if (state == AppLifecycleState.detached) {
      messageController.onlineuservendor(onlineStatus: "1");
      print("state: $state");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: Obx(
        () => handlePages[vendorTabbarController.currentTabIndex.value],
      ),
      extendBody: true,
      bottomNavigationBar: Obx(() => Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: themeContro.isLightMode.value
                  ? Colors.white
                  : AppColors.darkMainBlack,
              boxShadow: !themeContro.isLightMode.value
                  ? [
                      const BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0,
                        blurRadius: 15,
                        offset: Offset(5, 5),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: themeContro.isLightMode.value
                  ? Colors.white10
                  : AppColors.darkMainBlack,
              selectedItemColor: themeContro.isLightMode.value
                  ? Colors.white
                  : AppColors.darkMainBlack,
              unselectedItemColor: themeContro.isLightMode.value
                  ? Colors.white
                  : AppColors.black,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              currentIndex: vendorTabbarController.currentTabIndex.value,
              selectedLabelStyle: poppinsFont(
                  8,
                  themeContro.isLightMode.value
                      ? AppColors.black
                      : Colors.white,
                  FontWeight.w600),
              onTap: (index) {
                vendorTabbarController.currentTabIndex.value = index;
              },
              items: [
                _buildNavItem(
                  index: 0,
                  label: 'Home',
                  selectedIcon: 'assets/images/Vector (1).png',
                  unselectedIcon: 'assets/images/home-2.png',
                ),
                _buildNavItem(
                  index: 1,
                  label: 'Message',
                  selectedIcon: AppAsstes.message1,
                  unselectedIcon: AppAsstes.message,
                ),
                _buildNavItem(
                  index: 2,
                  label: 'Notification',
                  selectedIcon: AppAsstes.notifyfill,
                  unselectedIcon: AppAsstes.notify,
                ),
                _buildNavItem(
                  index: 3,
                  label: 'Setting',
                  selectedIcon: AppAsstes.setting_fill,
                  unselectedIcon: AppAsstes.setting_unfill,
                ),
              ],
            ),
          )),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required int index,
    required String label,
    required String selectedIcon,
    required String unselectedIcon,
  }) {
    final bool isSelected =
        vendorTabbarController.currentTabIndex.value == index;
    return BottomNavigationBarItem(
      icon: isSelected
          ? ClipPath(
              clipper: BottomNavBarClipper(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 70, 174, 0),
                      Color.fromRGBO(0, 70, 174, 0.25)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      selectedIcon,
                      height: 25,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Image.asset(
                  unselectedIcon,
                  height: 25,
                  color: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
                ),
                const Text(
                  "",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
      label: isSelected ? '' : label,
    );
  }
}

// Custom Clipper for BottomNavigationBar Shape
class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Start at the left edge
    path.moveTo(0, 0);

    // Draw to the left side of the dip
    path.lineTo(size.width, 0);

    // Draw a downward curve for the dip
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.8, // Control point
      size.width * 0.8, 0.8, // End of the dip
    );

    // Continue to the right edge
    path.lineTo(size.width, 0);

    // Close the path with the bottom line
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(size.width * 0.3, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
