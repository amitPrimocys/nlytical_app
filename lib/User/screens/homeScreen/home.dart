// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/User/screens/controller/user_tab_controller.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/get_profile_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/auth/login.dart';
import 'package:nlytical_app/User/screens/categories/subcategories.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/User/screens/homeScreen/find_store.dart';
import 'package:nlytical_app/User/screens/homeScreen/search.dart';
import 'package:nlytical_app/User/screens/settings/profile.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/home_Loader.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/comman_screen_new.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchcontroller = TextEditingController();
  FocusNode passFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  HomeContro homecontro = Get.put(HomeContro());
  LikeContro likecontro = Get.put(LikeContro());
  GetprofileContro getprofilecontro = Get.put(GetprofileContro());

  // ignore: unused_field
  Position? _currentPosition;

  @override
  void initState() {
    print("USERID 😍😍😍😍😍 :- $userID");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      apis();
    });
    super.initState();
  }

  apis() async {
    print(userID);
    await _getCurrentLocation();
    await homecontro.homeApi(
      latitudee: Latitude,
      longitudee: Longitude,
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, so request the user to enable them.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, so return an error.
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, so return an error.
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location of the device
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    if (!mounted) return; // Check if the widget is still mounted
    setState(() {
      _currentPosition = position;
    });

    // Get the address from the current latitude and longitude
    _getAddressFromLatLng(position);
  }

// Convert latitude and longitude to address using geocoding
  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      if (!mounted) return; // Check if the widget is still mounted
      setState(() {
        homecontro.currentAddress =
            "${place.subLocality}, ${place.locality}, ${place.country}";
        homecontro.homeApi(
          latitudee: position.latitude.toString(),
          longitudee: position.longitude.toString(),
        );
      });
    } catch (e) {
      if (!mounted) return; // Check if the widget is still mounted
      setState(() {
        homecontro.currentAddress = "Could not get address";
      });
    }
  }

  File? selectedImages;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? AppColors.white
          : AppColors.darkMainBlack,
      body: Column(
        children: [
          myLocationWidget(),
          sizeBoxHeight(45),
          Expanded(child: Obx(() {
            return (homecontro.ishome.value &&
                    homecontro.homemodel.value!.categories == null &&
                    homecontro.homemodel.value!.latestService == null)
                ? homeLoader(context)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        _poster2(context),
                        sizeBoxHeight(8),
                        category(),
                        sizeBoxHeight(8),
                        nearby(),
                        sizeBoxHeight(18),
                        store(),
                        sizeBoxHeight(15),
                      ],
                    ),
                  );
          }))
        ],
      ),
    );
  }

  Widget myLocationWidget() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: getProportionateScreenHeight(170),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAsstes.line_design), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: AppColors.blue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    sizeBoxHeight(60),
                    Obx(() {
                      return homecontro.ishome.value &&
                              // homecontro.homemodel.value == null &&
                              homecontro.homemodel.value!.firstName == null
                          ? Shimmer.fromColors(
                              baseColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white12
                                  : Colors.grey.shade300,
                              highlightColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white24
                                  : Colors.grey.shade100,
                              child: label(
                                'Hello,',
                                fontSize: 19,
                                textColor: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : userID.isEmpty
                              ? label(
                                  'Hello, Guest',
                                  fontSize: 19,
                                  textColor:
                                      const Color.fromRGBO(236, 236, 236, 1),
                                  fontWeight: FontWeight.w500,
                                )
                              : label(
                                  'Hello, ${homecontro.homemodel.value!.firstName!}',
                                  fontSize: 19,
                                  textColor:
                                      const Color.fromRGBO(236, 236, 236, 1),
                                  fontWeight: FontWeight.w500,
                                );
                      // : label(
                      //     'Hello,',
                      //     fontSize: 19,
                      //     fontWeight: FontWeight.w600,
                      //   );
                    }),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/location1.png',
                          height: 15,
                          color: const Color.fromRGBO(236, 236, 236, 1),
                        ),
                        label(
                          homecontro.currentAddress,
                          fontSize: 14,
                          textColor: const Color.fromRGBO(236, 236, 236, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    )
                  ])),
              userID.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Obx(() {
                        return getprofilecontro.isprofile.value
                            ? const Center(
                                child: SpinKitSpinningLines(
                                  size: 30,
                                  color: AppColors.blue,
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (getprofilecontro
                                          .getprofilemodel.value?.guestUser ==
                                      1) {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    await pref.clear();
                                    await SharedPrefs.clear();
                                    Get.offAll(const Login(),
                                        transition: Transition.rightToLeft);
                                  } else {
                                    Get.to(() => const Profile(),
                                        transition: Transition.rightToLeft);
                                  }
                                },
                                child: ClipOval(
                                  child: selectedImages == null
                                      ? (
                                              // getprofilecontro.getprofilemodel.value
                                              //           ?.userDetails?.image !=
                                              //       null
                                              //   ?
                                              Image.network(
                                          getprofilecontro.getprofilemodel
                                              .value!.userDetails!.image!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext ctx,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return const Center(
                                                child: SpinKitSpinningLines(
                                                  size: 30,
                                                  color: AppColors.blue,
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext? context,
                                              Object? exception,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/images/default_user.jpg',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                          // : const Center(
                                          //     child: SpinKitSpinningLines(
                                          //       size: 30,
                                          //       color: AppColors.blue,
                                          //     ),
                                          //   )
                                          )
                                      : Image.file(selectedImages!,
                                          fit: BoxFit.cover),
                                ),
                              );
                      }),
                    )
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
        Positioned(bottom: -23, left: 9, child: searchBar())
      ],
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: TextField(
        controller: searchcontroller,
        onTap: () {
          Get.to(() => const Search());
        },
        cursorColor: themeContro.isLightMode.value
            ? Colors.transparent
            : AppColors.white,
        readOnly: true,
        style: poppinsFont(
            13,
            themeContro.isLightMode.value ? Colors.black : AppColors.white,
            FontWeight.w500),
        decoration: InputDecoration(
            fillColor: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkGray,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray,
                    width: 1.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray,
                    width: 1.5)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.greyColor, width: 5)),
            hintText: "Search Services...",
            hintStyle: poppinsFont(13, Colors.grey.shade400, FontWeight.w500),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 15, top: 15),
              child: Image.asset(
                AppAsstes.search,
                color: Colors.grey.shade400,
                height: 10,
              ),
            )),
      ).paddingSymmetric(horizontal: 10),
    );
  }

  Widget searchProduct() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(const Search());
            },
            child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      AppAsstes.search,
                      scale: 4.0,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Search Services...',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    )
                  ],
                )

                //  TextFormField(
                //   // controller: searchTextContorller,
                //   onTap: () {
                //     Get.to(search());
                //   },
                //   readOnly: false,
                //   // onChanged: onSearchTextChanged,
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: appColorGreen),
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5),
                //       borderSide: const BorderSide(color: appColorGreen),
                //     ),
                //     contentPadding: EdgeInsets.only(left: 20),

                //     hintText: 'Search'.tr,
                //     hintStyle: const TextStyle(
                //       fontSize: 11,
                //       fontWeight: FontWeight.w400,
                //     ),
                //     border: InputBorder.none, // Remove border
                //     prefixIcon: Image.asset(
                //       'assets/images/SS.png',
                //       scale: 3.5,
                //     ),
                //     filled: true,
                //     fillColor: Theme.of(context).brightness == Brightness.dark
                //         ? Colors.black
                //         : Colors.white, // Add search icon
                //   ),
                // ),
                ),
          ),
        ],
      ),
    );
  }

  Widget category() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label(
              'Category',
              fontSize: 14,
              textColor: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            InkWell(
              onTap: () {
                Get.find<UserTabController>().currentTabIndex.value = 2;
              },
              child: label(
                'See all',
                fontSize: 12,
                textColor: AppColors.brown,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        sizeBoxHeight(18),
        homecontro.categories.isNotEmpty
            ? Container(
                height: Get.height * 0.30,
                decoration: BoxDecoration(
                    color: themeContro.isLightMode.value
                        ? Colors.white
                        : AppColors.darkMainBlack),
                child: GridView.builder(
                  itemCount: homecontro.categories.length.clamp(0, 6),
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1, // To ensure the grid is square
                  ),
                  itemBuilder: (context, index) {
                    return cateWidgets(
                      imagepath:
                          homecontro.categories[index].categoryImage.toString(),
                      cname: homecontro
                          .categories[index].categoryName!.capitalizeFirst
                          .toString(),
                      cateOnTap: () {
                        Get.to(
                            SubCategories(
                              cat: homecontro.categories[index].id.toString(),
                            ),
                            transition: Transition.rightToLeft);
                      },
                    );
                  },
                ).paddingSymmetric(horizontal: 15),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: SizedBox(
                    height: 100,
                    child: label("No Category Found",
                        fontSize: 16,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.brown
                            : AppColors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
      ],
    );
  }

  Widget nearby() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label(
              'Nearby Stores',
              fontSize: 14,
              textColor: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        const SizedBox(height: 15),
        homecontro.nearbylist.isNotEmpty
            ? SizedBox(
                height: 310,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: homecontro.nearbylist.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CommanScreenNew(
                        storeImages: homecontro
                            .nearbylist[index].serviceImages![0]
                            .toString(),
                        cname: homecontro.nearbylist[index].categoryName
                            .toString(),
                        sname:
                            homecontro.nearbylist[index].serviceName.toString(),
                        vname: homecontro.nearbylist[index].vendorFirstName
                            .toString(),
                        vendorImages:
                            homecontro.nearbylist[index].vendorImage.toString(),
                        year:
                            '${homecontro.nearbylist[index].totalYearsCount} Years in Business',
                        ratingCount: homecontro
                                .nearbylist[index].totalAvgReview!.isNotEmpty
                            ? double.parse(
                                homecontro.nearbylist[index].totalAvgReview!)
                            : 0,
                        avrageReview: homecontro
                            .nearbylist[index].totalReviewCount!
                            .toString(),
                        isfeatured: homecontro.nearbylist[index].isFeatured!,
                        isLike: userID.isEmpty
                            ? 0
                            : homecontro.nearbylist[index].isLike!,
                        onTaplike: () {
                          if (userID.isEmpty) {
                            snackBar('Please login to like this service');
                          } else {
                            likecontro.likeApi(
                                homecontro.nearbylist[index].id.toString());

                            // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                            setState(() {
                              homecontro.nearbylist[index].isLike =
                                  homecontro.nearbylist[index].isLike == 0
                                      ? 1
                                      : 0;

                              for (int i = 0;
                                  i < homecontro.allcatelist.length;
                                  i++) {
                                if (homecontro.allcatelist[i].id ==
                                    homecontro.nearbylist[index].id) {
                                  homecontro.allcatelist[i].isLike =
                                      homecontro.nearbylist[index].isLike;
                                }
                              }
                            });
                          }
                        },
                        onTapstore: () {
                          Get.to(
                              Details(
                                serviceid:
                                    homecontro.nearbylist[index].id.toString(),
                                latt:
                                    homecontro.nearbylist[index].lat.toString(),
                                longg:
                                    homecontro.nearbylist[index].lon.toString(),
                              ),
                              transition: Transition.rightToLeft);
                        },
                        location:
                            homecontro.nearbylist[index].address.toString(),
                        price:
                            'From ${homecontro.nearbylist[index].priceRange}',
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: SizedBox(
                    height: 100,
                    child: label("No Nearby Store Found",
                        fontSize: 16,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.brown
                            : AppColors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
      ],
    );
  }

  Widget store() {
    return Column(
      children: [
        sizeBoxHeight(3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label(
              'Find Your Perfect Store',
              fontSize: 14,
              textColor: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            homecontro.allcatelist.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      Get.to(const FindStore(),
                          transition: Transition.rightToLeft);
                    },
                    child: label(
                      'See all',
                      fontSize: 11,
                      textColor: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ).paddingSymmetric(horizontal: 20),
        sizeBoxHeight(22),
        homecontro.allcatelist.isNotEmpty
            ? GridView.builder(
                itemCount: homecontro.allcatelist.length.clamp(0, 4),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items in a row
                  childAspectRatio: 0.58, // Adjust for image and text ratio
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return CommanScreen(
                    storeImages: homecontro.allcatelist[index].serviceImages![0]
                        .toString(),
                    sname: homecontro
                        .allcatelist[index].serviceName!.capitalizeFirst
                        .toString(),
                    cname: homecontro
                        .allcatelist[index].categoryName!.capitalizeFirst
                        .toString(),
                    vname: homecontro.allcatelist[index].vendorFirstName
                        .toString(),
                    vendorImages:
                        homecontro.allcatelist[index].vendorImage.toString(),
                    isfeatured: homecontro.allcatelist[index].isFeatured!,
                    ratingCount:
                        homecontro.allcatelist[index].totalAvgReview!.isNotEmpty
                            ? double.parse(
                                homecontro.allcatelist[index].totalAvgReview!)
                            : 0,
                    avrageReview: homecontro
                        .allcatelist[index].totalReviewCount!
                        .toString(),
                    isLike: userID.isEmpty
                        ? 0
                        : homecontro.allcatelist[index].isLike!,
                    onTaplike: () {
                      if (userID.isEmpty) {
                        snackBar('Please login to like this service');
                      } else {
                        for (var i = 0; i < homecontro.nearbylist.length; i++) {
                          if (homecontro.allcatelist[index].id ==
                              homecontro.nearbylist[i].id) {
                            print("ID MATCHED");
                            if (homecontro.nearbylist[i].isLike == 0) {
                              homecontro.nearbylist[i].isLike = 1;
                            } else {
                              homecontro.nearbylist[i].isLike = 0;
                            }
                            homecontro.nearbylist.refresh();
                          }
                        }
                        likecontro.likeApi(
                            homecontro.allcatelist[index].id.toString());

                        // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                        setState(() {
                          homecontro.allcatelist[index].isLike =
                              homecontro.allcatelist[index].isLike == 0 ? 1 : 0;
                          for (int i = 0;
                              i < homecontro.allcatelist.length;
                              i++) {
                            if (homecontro.allcatelist[i].id ==
                                homecontro.nearbylist[index].id) {
                              homecontro.allcatelist[i].isLike =
                                  homecontro.nearbylist[index].isLike;
                            }
                          }
                        });
                      }
                    },
                    onTapstore: () {
                      Get.to(
                          Details(
                            serviceid:
                                homecontro.allcatelist[index].id.toString(),
                            latt: homecontro.allcatelist[index].lat.toString(),
                            longg: homecontro.allcatelist[index].lon.toString(),
                          ),
                          transition: Transition.rightToLeft);
                    },
                    location: homecontro.allcatelist[index].address.toString(),
                    price: 'From ${homecontro.allcatelist[index].priceRange}',
                  );

                  //  findstore(
                  //     imagepath: homecontro.allcatelist[index].serviceImages![0]
                  //         .toString(),
                  //     sname: homecontro
                  //         .allcatelist[index].serviceName!.capitalizeFirst
                  //         .toString(),
                  //     cname: homecontro
                  //         .allcatelist[index].categoryName!.capitalizeFirst
                  //         .toString(),
                  //     ratingCount: homecontro
                  //             .allcatelist[index].totalAvgReview!.isNotEmpty
                  //         ? double.parse(
                  //             homecontro.allcatelist[index].totalAvgReview!)
                  //         : 0,
                  //     avrageReview: homecontro
                  //         .allcatelist[index].totalReviewCount!
                  //         .toString(),
                  //     isLike: homecontro.homemodel.value!.guestUser == 1
                  //         ? 0
                  //         : homecontro.allcatelist[index].isLike!,
                  //     onTaplike: () {
                  //       if (homecontro.homemodel.value!.guestUser == 1) {
                  //         snackBar('Please login to like this service');
                  //       } else {
                  //         for (var i = 0;
                  //             i < homecontro.nearbylist.length;
                  //             i++) {
                  //           if (homecontro.allcatelist[index].id ==
                  //               homecontro.nearbylist[i].id) {
                  //             print("ID MATCHED");
                  //             if (homecontro.nearbylist[i].isLike == 0) {
                  //               homecontro.nearbylist[i].isLike = 1;
                  //             } else {
                  //               homecontro.nearbylist[i].isLike = 0;
                  //             }
                  //             homecontro.nearbylist.refresh();
                  //           }
                  //         }
                  //         likecontro.likeApi(
                  //             homecontro.allcatelist[index].id.toString());

                  //         // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                  //         setState(() {
                  //           homecontro.allcatelist[index].isLike =
                  //               homecontro.allcatelist[index].isLike == 0
                  //                   ? 1
                  //                   : 0;
                  //           for (int i = 0;
                  //               i < homecontro.allcatelist.length;
                  //               i++) {
                  //             if (homecontro.allcatelist[i].id ==
                  //                 homecontro.nearbylist[index].id) {
                  //               homecontro.allcatelist[i].isLike =
                  //                   homecontro.nearbylist[index].isLike;
                  //             }
                  //           }
                  //         });
                  //       }
                  //     },
                  //     storeOnTap: () {
                  //       Get.to(
                  //           Details(
                  //             serviceid:
                  //                 homecontro.allcatelist[index].id.toString(),
                  //             latt:
                  //                 homecontro.allcatelist[index].lat.toString(),
                  //             longg:
                  //                 homecontro.allcatelist[index].lon.toString(),
                  //           ),
                  //           transition: Transition.rightToLeft);
                  //     }
                  //     );
                },
              ).paddingSymmetric(horizontal: 15)
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: SizedBox(
                    height: 100,
                    child: label("No Perfect Store Found",
                        fontSize: 16,
                        textColor: AppColors.brown,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
      ],
    );
  }

  final List<String> images = [
    'assets/images/Frame 3398.png',
    'assets/images/Frame 3398.png',
    'assets/images/Frame 3398.png',
  ];

  Widget _poster2(BuildContext context) {
    Widget carousel = homecontro.homemodel.value!.slides == null ||
            homecontro.homemodel.value!.slides!.isEmpty
        ? postershimmer(context, imageUrls)
        : Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: ImageSlideshow(
                  initialPage: 0, // You can set this to any valid index
                  autoPlayInterval: 3000,
                  isLoop: true,
                  indicatorColor: AppColors.white,
                  indicatorBackgroundColor: Colors.grey.shade400,
                  indicatorRadius: 3,

                  children: homecontro.homemodel.value!.slides!.map((img) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.network(
                        img, // Use the image URL from your API
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ); // Handle image loading error
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );

    return Container(
      height: 200,
      width: Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: carousel.paddingSymmetric(horizontal: 10),
      ),
    );
  }

  Widget nearshimmer() {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white12
          : Colors.grey.shade300,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.grey.shade100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label(
                'Nearby Stores',
                fontSize: 14,
                textColor: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ],
          ).paddingSymmetric(horizontal: 20),
          sizeBoxHeight(12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              clipBehavior: Clip.none,
              itemCount: 10,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 5),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 80,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget postershimmer(BuildContext context, List<String> imageUrls) {
    Widget carousel = Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: ImageSlideshow(
            initialPage: 0, // You can set this to any valid index
            autoPlayInterval: 3000,
            isLoop: true,
            indicatorColor: AppColors.white,
            indicatorBackgroundColor: Colors.grey.shade400,
            indicatorRadius: 3,
            children: imageUrls.map((img) {
              return Shimmer.fromColors(
                baseColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white12
                    : Colors.grey.shade300,
                highlightColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white24
                    : Colors.grey.shade100,
                child: Container(
                  height: 180,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );

    return Container(
      height: 200,
      width: Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: carousel.paddingSymmetric(horizontal: 10),
      ),
    );
  }
}
