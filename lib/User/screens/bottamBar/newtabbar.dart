// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/chat_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/favourite_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/get_profile_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/review_contro.dart';
import 'package:nlytical_app/User/screens/categories/categories.dart';
import 'package:nlytical_app/User/screens/chat/user_message_screen.dart';
import 'package:nlytical_app/User/screens/controller/user_tab_controller.dart';
import 'package:nlytical_app/User/screens/explore/explore.dart';
import 'package:nlytical_app/User/screens/homeScreen/home.dart';
import 'package:nlytical_app/User/screens/settings/setting.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

// ignore: must_be_immutable
class TabbarScreen extends StatefulWidget {
  final String? userID;
  int currentIndex = 0;
  TabbarScreen({this.userID, required this.currentIndex});
  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen>
    with WidgetsBindingObserver {
  HomeContro homecontro = Get.put(HomeContro());
  GetprofileContro getprofilecontro = Get.put(GetprofileContro());
  CategoriesContro catecontro = Get.put(CategoriesContro());
  FavouriteContro favcontro = Get.put(FavouriteContro());
  ReviewContro reviewcontro = Get.put(ReviewContro());
  int page = 1;
  // MessageController messageController = Get.put(MessageController());
  ChatController messageController = Get.put(ChatController());

  UserTabController userTabController = Get.find();
  // ignore: unused_field
  List<dynamic> _handlePages = [
    Home(),
    Explore(
      lat: SharedPrefs.getString(SharedPreferencesKey.LATTITUDE),
      long: SharedPrefs.getString(SharedPreferencesKey.LONGITUDE),
    ),
    Categories(),
    UserMessageScreen(),
    Setting(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    userTabController.currentTabIndex.value = widget.currentIndex;
    homecontro.homeApi(
      latitudee: Latitude,
      longitudee: Longitude,
    );
    favcontro.favApi();
    catecontro.cateApi();
    messageController.chatApi(issearch: false);

    // reviewcontro.reviewApi(page: page.toString());

    // _checkLocationPermission();

    // _checkLocationPermission();
    // getUserDataFromPrefs();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      messageController.onlineuser(onlineStatus: "1");
      debugPrint("state: $state");
    } else if (state == AppLifecycleState.paused) {
      messageController.onlineuser(onlineStatus: "0");
      debugPrint("state: $state");
    } else if (state == AppLifecycleState.inactive) {
      messageController.onlineuser(onlineStatus: "0");
      debugPrint("state: $state");
    } else if (state == AppLifecycleState.detached) {
      messageController.onlineuser(onlineStatus: "1");
      debugPrint("state: $state");
    }
  }

  // Future<void> _checkLocationPermission() async {
  //   log("start");
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.deniedForever) {
  //     snackBar(
  //         "Nlytical app need location Permmision otherwise You are not able to see nearby stores, Please Allow location");
  //   } else if (permission == LocationPermission.denied) {
  //     LocationPermission newPermission = await Geolocator.requestPermission();
  //     if (newPermission == LocationPermission.denied) {
  //       snackBar("Please Allow location");
  //     } else if (newPermission == LocationPermission.whileInUse ||
  //         newPermission == LocationPermission.always) {
  //       await _getCurrentLocation();
  //     }
  //   } else {
  //     await _getCurrentLocation();
  //   }
  // }

  // Future<void> _getCurrentLocation() async {
  //   try {
  //     // Fetch the current position (latitude and longitude)
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     Latitude = position.latitude.toString();
  //     Longitude = position.longitude.toString();

  //     log("☺☺☺☺☺☺☺☺☺LAT :$Latitude");
  //     log("☺☺☺☺☺☺☺☺☺LONG : $Longitude");
  //     homecontro.homeApi(
  //       latitudee: Latitude,
  //       longitudee: Longitude,
  //     );
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     homecontro.homeApi(
  //       latitudee: '',
  //       longitudee: '',
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      // body: _handlePages[widget.currentIndex!],
      body: Obx(
        () => _handlePages[userTabController.currentTabIndex.value],
      ),
      // extendBody: true,
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
                color: themeContro.isLightMode.value
                    ? AppColors.white
                    : AppColors.darkMainBlack,
                // Background color of bottom navigation bar

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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15))
                // borderRadius: BorderRadius.vertical(
                //     top: Radius.circular(20)), // Rounded corners
                ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,

              elevation: 0, // Makes all items visible
              backgroundColor: themeContro.isLightMode.value
                  ? Colors.white10
                  : AppColors.darkMainBlack,
              selectedItemColor: themeContro.isLightMode.value
                  ? Colors.white
                  : AppColors.darkMainBlack,
              unselectedItemColor: themeContro.isLightMode.value
                  ? Colors.white
                  : AppColors.black,
              showSelectedLabels: true, // Show labels on selection
              showUnselectedLabels: false, // Hide labels for unselected items
              currentIndex: userTabController.currentTabIndex.value,
              selectedLabelStyle: poppinsFont(
                  8,
                  themeContro.isLightMode.value
                      ? AppColors.black
                      : Colors.white,
                  FontWeight.w500),
              onTap: (index) {
                userTabController.currentTabIndex.value = index;
              },
              items: [
                userTabController.currentTabIndex.value == 0
                    ? BottomNavigationBarItem(
                        icon: clippath(
                            label: "Home", selectedIcon: AppAsstes.home_fill),
                        label: '',
                      )
                    : BottomNavigationBarItem(
                        icon: unselected(
                            label: '', selectedIcon: AppAsstes.home_unfill),
                        label: '',
                      ),
                userTabController.currentTabIndex.value == 1
                    ? BottomNavigationBarItem(
                        icon: clippath(
                            label: "Explore",
                            selectedIcon: AppAsstes.explore_fill1),
                        label: '',
                      )
                    : BottomNavigationBarItem(
                        icon: unselected(
                            selectedIcon: AppAsstes.explore_unfill, label: ""),
                        label: '',
                      ),
                userTabController.currentTabIndex.value == 2
                    ? BottomNavigationBarItem(
                        icon: clippath(
                            label: "Categories",
                            selectedIcon: AppAsstes.cate_fill),
                        label: '',
                      )
                    : BottomNavigationBarItem(
                        icon: unselected(
                            selectedIcon: AppAsstes.cate_unfill, label: ""),
                        label: 'Categories',
                      ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      userTabController.currentTabIndex.value == 3
                          ? clippath(
                              label: "Message",
                              selectedIcon: AppAsstes.message1)
                          : unselected(
                              selectedIcon: AppAsstes.message, label: ""),
                      Positioned(
                        right: -5,
                        top: -8,
                        child: Obx(() {
                          return messageController.totalUnreadMessages.value ==
                                  0
                              ? const SizedBox.shrink()
                              : Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors
                                        .blue, // Adjust the color as needed
                                  ),
                                  child: Center(
                                    child: Text(
                                      messageController
                                                  .totalUnreadMessages.value >
                                              9
                                          ? "9+"
                                          : "${messageController.totalUnreadMessages.value}",
                                      style: poppinsFont(
                                          8, AppColors.white, FontWeight.w600),
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ],
                  ),
                  label: '',
                ),
                userTabController.currentTabIndex.value == 4
                    ? BottomNavigationBarItem(
                        icon: clippath(
                            label: "Setting",
                            selectedIcon: AppAsstes.setting_fill),
                        label: '',
                      )
                    : BottomNavigationBarItem(
                        icon: unselected(
                            selectedIcon: AppAsstes.setting_unfill, label: ""),
                        label: 'Setting',
                      ),
              ],
            ),
          )),
    );
  }

  clippath({
    required String selectedIcon,
    required String label,
  }) {
    return ClipPath(
      clipper: BottomNavBarClipper(),
      child: Container(
        height: 53,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color.fromRGBO(0, 70, 174, 0),
              Color.fromRGBO(0, 70, 174, 0.25)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              selectedIcon,
              height: 25,
            ),
            SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
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
    );
  }

  unselected({
    required String selectedIcon,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          selectedIcon,
          height: 25,
          color:
              themeContro.isLightMode.value ? AppColors.black : AppColors.white,
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color:
                themeContro.isLightMode.value ? Colors.black : AppColors.white,
          ),
        ),
      ],
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
