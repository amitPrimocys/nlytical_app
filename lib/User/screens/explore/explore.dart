// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, must_be_immutable, unnecessary_brace_in_string_interps, unused_local_variable, unused_import, invalid_use_of_protected_member, avoid_print

import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/filter_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/nearby_contro.dart';
import 'package:nlytical_app/User/screens/explore/filter.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/favourite_loader.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/nearby_loader.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Explore extends StatefulWidget {
  String lat;
  String long;
  Explore({super.key, required this.lat, required this.long});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  NearbyContro nearcontro = Get.put(NearbyContro());
  LikeContro likecontro = Get.put(LikeContro());
  FilterContro filtercontro = Get.put(FilterContro());

  // int page = 1;
  bool isLoadingMore = false;
  // ItemScrollController _scrollController1 = ItemScrollController();
  final scrollController = ScrollController();

  @override
  void initState() {
    filtercontro.scrollControllerlocation = ScrollController();
    addMarker();
    // addMarker1();
    nearcontro.nearbyApi(
        latitudee: Latitude,
        longitudee: Longitude,
        page: nearcontro.currentpage.toString());
    scrollController.addListener(_scrollListener);

    // Load initial data
    fetchRestaurants();

    // _checkLocationPermission();
    debugPrint("lat****** ${Latitude}");
    debugPrint("lng***** ${Longitude}");

    // apis();

    if (mounted) {
      setState(() {});
    }

    super.initState();
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoadingMore && // Ensure loader isn't already active
          nearcontro.currentpage.value <
              nearcontro.nearbymodel.value!.totalPage!) {
        setState(() {
          isLoadingMore = true; // Start showing the loader
        });

        try {
          await fetchRestaurants(); // Fetch data for the next page
          nearcontro.currentpage.value = nearcontro.currentpage.value + 1;
        } catch (e) {
          print("Error fetching restaurants: $e");
        } finally {
          setState(() {
            isLoadingMore = false; // Stop showing the loader
          });
        }
      } else {
        print("Limit reached or already loading");
      }
    }
  }

  // void _scrollListener() async {
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     if (!isLoadingMore && // Ensure loader isn't already active
  //         nearcontro.nearbymodel.value !=
  //             null && // Check if nearbymodel is not null
  //         nearcontro.nearbymodel.value!.totalPage !=
  //             null && // Check if totalPage is not null
  //         nearcontro.currentpage.value <=
  //             nearcontro.nearbymodel.value!.totalPage!) {
  //       setState(() {
  //         isLoadingMore = true; // Start showing the loader
  //       });

  //       try {
  //         await fetchRestaurants(); // Fetch data for the next page
  //         nearcontro.currentpage.value = nearcontro.currentpage.value + 1;
  //       } catch (e) {
  //         print("Error fetching restaurants: $e");
  //       } finally {
  //         setState(() {
  //           isLoadingMore = false; // Stop showing the loader
  //         });
  //       }
  //     } else {
  //       print("Limit reached or already loading");
  //     }
  //   }
  // }

  Future<void> fetchRestaurants() async {
    try {
      print('Fetching page: ${nearcontro.currentpage}'); // Log the page number
      await nearcontro.nearbyApi(
          latitudee: Latitude,
          longitudee: Longitude,
          page: nearcontro.currentpage.toString());
      // filtercontro.filterApi(
      //   widget.catid.toString(),
      //   ratingValue.toString(),
      //   selectedService,
      //   page: page.toString(), catId:  widget.catid.toString(),
      // );

      // Once data is fetched, stop showing the loading spinner
      setState(() {
        isLoadingMore = false;
      });
    } catch (error) {
      setState(() {
        isLoadingMore = false;
      });
      print("Error fetching data: $error");
    }
  }

  @override
  dispose() {
    scrollController.dispose();
    filtercontro.isnavfilter.value = false;
    super.dispose();
  }

  apis() async {
    await addMarker();
    // await addMarker1();
    await nearcontro.nearbyApi(
        latitudee: Latitude,
        longitudee: Longitude,
        page: nearcontro.currentpage.toString());
  }

  // Future<void> _checkLocationPermission() async {
  //   log("start");
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.deniedForever) {
  //     showCustomToast(
  //         "Bigservice app need location Permmision otherwise You are not able to see nearby stores, Please Allow location");
  //   } else if (permission == LocationPermission.denied) {
  //     LocationPermission newPermission = await Geolocator.requestPermission();
  //     if (newPermission == LocationPermission.denied) {
  //       showCustomToast("Please Allow location");
  //     } else if (newPermission == LocationPermission.whileInUse ||
  //         newPermission == LocationPermission.always) {
  //       debugPrint("Allowed location");
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

  //     setState(() {
  //       Latitude = position.latitude.toString();
  //       Longitude = position.longitude.toString();
  //       widget.lat;
  //       widget.long;
  //     });

  //     log("☺☺☺☺☺☺☺☺☺LAT :$Latitude");
  //     log("☺☺☺☺☺☺☺☺☺LONG : $Longitude");
  //     // nearcontro.nearbyApi(
  //     //     position.latitude.toString(), position.longitude.toString());
  //     await nearcontro.nearbyApi(
  //         latitudee: Latitude, longitudee: Longitude, page: page.toString());
  //     // ignore: empty_catches
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    debugPrint("lat ${Latitude}");
    debugPrint("lng ${Longitude}");
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? AppColors.white
            : AppColors.darkMainBlack,
        body: SizedBox(
          height: Get.height,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Container(
                width: Get.width,
                height: getProportionateScreenHeight(150),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAsstes.line_design)),
                    color: AppColors.blue),
              ),
              Positioned(
                top: getProportionateScreenHeight(50),
                left:
                    100, // Ensures alignment is calculated across the entire width
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizeBoxWidth(20),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Explore",
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sizeBoxWidth(110),
                    nearcontro.isnear.value || nearcontro.nearbylist.isEmpty
                        ? SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              // openBottomForfilter(context);
                              Get.to(() => Filter(
                                    catid: nearcontro.nearbymodel.value!
                                        .nearbyService![0].categoryId
                                        .toString(),
                                  ));
                            },
                            child: Image.asset(
                              'assets/images/menu1.png',
                              color: AppColors.white,
                              height: 24,
                            )),
                  ],
                ),
              ),
              Positioned.fill(
                top: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Get.width,
                      height: getProportionateScreenHeight(800),
                      decoration: BoxDecoration(
                          color: themeContro.isLightMode.value
                              ? AppColors.white
                              : AppColors.darkMainBlack,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Color.fromRGBO(0, 0, 0, 0.12),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.black54,
                          //         blurRadius: 10,
                          //         spreadRadius: 0,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Expanded(
                            child: SizedBox(
                              height: Get.height,
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Obx(() {
                                    return
                                        // !nearcontro.isnear.value
                                        //  &&
                                        (nearcontro.nearbylist.isEmpty &&
                                                nearcontro.isnear.value)
                                            ? nearbyListLoader(context)
                                            //  Center(
                                            //     child: CircularProgressIndicator(
                                            //     color: AppColors.blue,
                                            //   ))
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    sizeBoxHeight(40),
                                                    filtercontro
                                                            .isnavfilter.value
                                                        ? Column(
                                                            children: [
                                                              filter_clear(),
                                                              filterlisting(),
                                                            ],
                                                          ) // Show the listing if isnavfilter is true
                                                        : listing(),
                                                  ],
                                                ),
                                              );
                                  }),
                                  Obx(() {
                                    return nearcontro.isnear.value
                                        ? Center(
                                            child: CupertinoActivityIndicator(
                                            color: AppColors.blue,
                                          ))
                                        : filtercontro.isnavfilter.value
                                            ? location_() // Show the listing if isnavfilter is true
                                            : location();
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: -20,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Column(
                            children: [
                              profiletab(),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profiletab() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: themeContro.isLightMode.value
                    ? AppColors.white
                    : AppColors.darkGray,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade100
                        : AppColors.darkShadowColor,
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                    offset: const Offset(
                        1.0, 1.0), // shadow direction: bottom right
                  )
                ]),
            child: TabBar(
              // controller: _tabController,

              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 1.0, color: Colors.transparent),
                  insets: EdgeInsets.symmetric(horizontal: 2.0)),
              dividerColor: Colors.transparent,
              labelColor: AppColors.blue,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
              indicatorColor: AppColors.blue,
              indicatorSize: TabBarIndicatorSize.label,

              tabs: const [
                Tab(child: Text('   Listing   ')),
                Tab(child: Text('    Location    ')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------filter list ------------------------------------------------------------

  Widget filterlisting() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the maxCrossAxisExtent based on the screen width
    double maxCrossAxisExtent =
        screenWidth / 2; // You can adjust this value as needed

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return filtercontro.filtermodel.value!.serviceFilter!.isNotEmpty
        ? GridView.builder(
            itemCount: filtercontro.filtermodel.value!.serviceFilter!.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            controller: scrollController,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items in a row
              childAspectRatio: 0.58, // Adjust for image and text ratio
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return CommanScreen(
                storeImages: filtercontro
                    .filtermodel.value!.serviceFilter![index].serviceImages![0]
                    .toString(),
                sname: filtercontro.filtermodel.value!.serviceFilter![index]
                    .serviceName!.capitalizeFirst
                    .toString(),
                cname: filtercontro.filtermodel.value!.serviceFilter![index]
                    .categoryName!.capitalizeFirst
                    .toString(),
                vname: filtercontro
                    .filtermodel.value!.serviceFilter![index].vendorFirstName
                    .toString(),
                vendorImages: filtercontro
                    .filtermodel.value!.serviceFilter![index].vendorImage
                    .toString(),
                isfeatured: filtercontro
                    .filtermodel.value!.serviceFilter![index].isFeatured!,
                ratingCount: filtercontro.filtermodel.value!
                        .serviceFilter![index].averageReviewStar!.isEmpty
                    ? 0.00
                    : double.parse(filtercontro.filtermodel.value!
                        .serviceFilter![index].averageReviewStar!),
                avrageReview: filtercontro
                    .filtermodel.value!.serviceFilter![index].totalReviewCount!
                    .toString(),
                isLike: userID.isEmpty
                    ? 0
                    : filtercontro
                        .filtermodel.value!.serviceFilter![index].isLike!,
                onTaplike: () {
                  if (userID.isEmpty) {
                    snackBar('Please login to like this service');
                  } else {
                    likecontro.likeApi(filtercontro
                        .filtermodel.value!.serviceFilter![index].id
                        .toString());

                    // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                    setState(() {
                      filtercontro.filtermodel.value!.serviceFilter![index]
                          .isLike = filtercontro.filtermodel.value!
                                  .serviceFilter![index].isLike ==
                              0
                          ? 1
                          : 0;
                    });
                  }
                },
                onTapstore: () {
                  Get.to(
                      Details(
                        serviceid: filtercontro
                            .filtermodel.value!.serviceFilter![index].id
                            .toString(),
                        latt: filtercontro
                            .filtermodel.value!.serviceFilter![index].lat
                            .toString(),
                        longg: filtercontro
                            .filtermodel.value!.serviceFilter![index].lon
                            .toString(),
                      ),
                      transition: Transition.rightToLeft);
                },
                location: filtercontro
                    .filtermodel.value!.serviceFilter![index].address
                    .toString(),
                price: 'From \$252-565',
              );
            },
          ).paddingSymmetric(horizontal: 15, vertical: 5)
        : explore_empty();
  }

  Widget filter_clear() {
    return Column(
      children: [
        sizeBoxHeight(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 270,
              height: 30,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: filtercontro.selectedCategories.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  border: Border.all(color: AppColors.blue)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    sizeBoxWidth(10),
                                    SizedBox(
                                      child: label(
                                        filtercontro.selectedCategories.value
                                                .isNotEmpty
                                            ? filtercontro.selectedCategories[
                                                index] // Convert list to a string
                                            : 'No Category Selected',
                                        fontSize: 10,
                                        maxLines: 2,
                                        textColor: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    sizeBoxWidth(10),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    sizeBoxWidth(15),
                    filtercontro.selectedRating.value > 0
                        ? Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                border: Border.all(color: AppColors.blue)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  sizeBoxWidth(10),
                                  label(
                                    // (filtercontro.selectedRating.value != null &&
                                    //         filtercontro.selectedRating.value > 0)
                                    //     ? '${filtercontro.selectedRating.value} Star'
                                    //     : 'No Rating Selected',

                                    filtercontro.selectedRating.value > 0
                                        ? '${filtercontro.selectedRating.value} Star'
                                        : 'No Rating Selected',
                                    fontSize: 10,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  sizeBoxWidth(5),
                                  Icon(
                                    Icons.close,
                                    size: 12,
                                  ),
                                  sizeBoxWidth(10),
                                ],
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                filtercontro.isnavfilter.value = false;
                nearcontro.nearbyApi(
                    latitudee: Latitude,
                    longitudee: Longitude,
                    page: nearcontro.currentpage.toString());
              },
              child: label(
                'Clear All',
                fontSize: 10,
                textColor: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
        sizeBoxHeight(20),
      ],
    );
  }

  // -----------------------------------------------------------location list -----------------------------------------------------------

  Widget location_filter() {
    return filtercontro.isfilter.value
        ? Center(
            child: CupertinoActivityIndicator(
            color: AppColors.blue,
          ))
        : SizedBox(
            height: getProportionateScreenHeight(180),
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: ui.Radius.circular(15),
                      topRight: ui.Radius.circular(15))),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount:
                      filtercontro.filtermodel.value!.serviceFilter!.length,
                  controller: filtercontro.scrollControllerlocation,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          sizeBoxHeight(25),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                  Details(
                                    serviceid: filtercontro.filtermodel.value!
                                        .serviceFilter![index].id
                                        .toString(),
                                    latt: filtercontro.filtermodel.value!
                                        .serviceFilter![index].lat
                                        .toString(),
                                    longg: filtercontro.filtermodel.value!
                                        .serviceFilter![index].lon
                                        .toString(),
                                  ),
                                  transition: Transition.rightToLeft);
                            },
                            child: Container(
                              height: getProportionateScreenHeight(120),
                              width: Get.width * 0.90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300)),
                              child: Row(
                                children: [
                                  Container(
                                    height: getProportionateScreenHeight(120),
                                    width: getProportionateScreenWidth(130),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(9),
                                            bottomLeft: Radius.circular(9)),
                                        border: Border.all(color: Colors.white),
                                        image: DecorationImage(
                                            image: NetworkImage(filtercontro
                                                .filtermodel
                                                .value!
                                                .serviceFilter![index]
                                                .serviceImages![0]
                                                .toString()),
                                            fit: BoxFit.fill)),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sizeBoxHeight(3),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          sizeBoxWidth(10),
                                          Container(
                                            height: 15,
                                            decoration: BoxDecoration(
                                              color: AppColors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: Center(
                                              child: label(
                                                filtercontro
                                                    .filtermodel
                                                    .value!
                                                    .serviceFilter![index]
                                                    .categoryName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                ),
                                              ).paddingOnly(left: 4, right: 4),
                                            ),
                                          ),
                                          // Container(
                                          //   height: 13,
                                          //   width: 45,
                                          //   decoration: BoxDecoration(
                                          //     color: AppColors.blue,
                                          //     borderRadius:
                                          //         BorderRadius.circular(3),
                                          //   ),
                                          //   child: Center(
                                          //     child: Text(
                                          //       filtercontro
                                          //           .filtermodel
                                          //           .value!
                                          //           .serviceFilter![index]
                                          //           .categoryName
                                          //           .toString(),
                                          //       style: TextStyle(
                                          //           color: Colors.white,
                                          //           fontSize: 5),
                                          //     ),
                                          //   ),
                                          // ),
                                          sizeBoxWidth(130),
                                          GestureDetector(
                                            onTap: () {
                                              // Call the API to like/unlike the service
                                              if (userID.isEmpty) {
                                                snackBar(
                                                    'Please login to like this service');
                                              } else {
                                                likecontro.likeApi(filtercontro
                                                    .filtermodel
                                                    .value!
                                                    .serviceFilter![index]
                                                    .id
                                                    .toString());

                                                // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                                                setState(() {
                                                  filtercontro
                                                      .filtermodel
                                                      .value!
                                                      .serviceFilter![index]
                                                      .isLike = filtercontro
                                                              .filtermodel
                                                              .value!
                                                              .serviceFilter![
                                                                  index]
                                                              .isLike ==
                                                          0
                                                      ? 1
                                                      : 0;
                                                });
                                              }
                                            },
                                            child: Container(
                                                height: 26,
                                                width: 26,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.blue1),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: filtercontro
                                                              .filtermodel
                                                              .value!
                                                              .serviceFilter![
                                                                  index]
                                                              .isLike ==
                                                          0
                                                      ? Image.asset(AppAsstes
                                                          .heart) // Unlike
                                                      : Image.asset(
                                                          AppAsstes.fill_heart),
                                                )),
                                          )
                                        ],
                                      ),
                                      label(
                                        filtercontro.filtermodel.value!
                                            .serviceFilter![index].serviceName
                                            .toString(),
                                        fontSize: 11,
                                        textColor: AppColors.brown,
                                        fontWeight: FontWeight.w600,
                                      ).paddingOnly(left: 10),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          sizeBoxWidth(10),
                                          Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.blue1),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Image.asset(
                                                  'assets/images/location1.png',
                                                  color: Colors.black,
                                                ),
                                              )),
                                          sizeBoxWidth(10),
                                          SizedBox(
                                            width: 155,
                                            child: label(
                                              filtercontro.filtermodel.value!
                                                  .serviceFilter![index].address
                                                  .toString(),
                                              maxLines: 1,
                                              fontSize: 10,
                                              textColor: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      sizeBoxHeight(6),
                                      Row(
                                        children: [
                                          sizeBoxWidth(10),
                                          RatingBar.builder(
                                            itemPadding: const EdgeInsets.only(
                                                left: 1.5),
                                            initialRating: filtercontro
                                                        .filtermodel
                                                        .value!
                                                        .serviceFilter![index]
                                                        .averageReviewStar !=
                                                    ''
                                                ? double.parse(filtercontro
                                                    .filtermodel
                                                    .value!
                                                    .serviceFilter![index]
                                                    .averageReviewStar!)
                                                : 0.0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 10.5,
                                            ignoreGestures: true,
                                            unratedColor: Colors.grey.shade400,
                                            itemBuilder: (context, _) =>
                                                Image.asset(
                                              'assets/images/Star.png',
                                              height: 8,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                          SizedBox(width: 5),
                                          label(
                                            // ignore: unnecessary_string_escapes
                                            '(${filtercontro.filtermodel.value!.serviceFilter![index].totalReviewCount} \Review)',
                                            fontSize: 10,
                                            textColor: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 20),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
  }

  // ignore: prefer_final_fields
  // ScrollController _scrollControllerlocation = ScrollController();

  List<Marker> markerList = <Marker>[];

  addMarker() async {
    if (nearcontro.nearbymodel.value?.nearbyService == null) {
      return; // Exit early if there's no data
    }

    for (int i = 0;
        i < nearcontro.nearbymodel.value!.nearbyService!.length;
        i++) {
      final service = nearcontro.nearbymodel.value!.nearbyService![i];

      // Check for null lat or lon before parsing
      if (service.lat == null || service.lon == null) {
        continue; // Skip this entry if lat or lon is null
      }

      markerList.add(
        Marker(
          markerId: MarkerId('MarkerId$i'),
          position: LatLng(
            double.parse(service.lat!),
            double.parse(service.lon!),
          ),
          icon: await getCustomIcon(),
          onTap: () {
            if (i >= 0 &&
                i < nearcontro.nearbymodel.value!.nearbyService!.length) {
              _scrollToIndex(i);
            }
          },
        ),
      );
    }

    if (mounted) {
      setState(() {});
    }
  }

  // List<Marker> filtermarkerList.value = <Marker>[];

  void _scrollToIndex(int index) {
    filtercontro.scrollControllerlocation.animateTo(
      index * 370.0, // Adjust 150.0 based on your item height
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<BitmapDescriptor> getCustomIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(2, 2), // Specify the size (height and width) here
      ),
      "assets/images/locationpick.png",
    );
  }

  Future<Uint8List> getBytesFromAsset(
      String path, int width, int height) async {
    final byteData = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    final frame = await codec.getNextFrame();
    return (await frame.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Widget location() {
    return FutureBuilder<Uint8List>(
      future: getBytesFromAsset(
        'assets/images/locationpick.png',
        10,
        10,
      ),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: GoogleMap(
                    onCameraMoveStarted: () {
                      // if (mounted) {
                      //   setState(() {});
                      // }
                    },

                    zoomGesturesEnabled: true, // Enable Zoom in/out on the map
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        double.parse(Latitude),
                        double.parse(Longitude),
                      ),
                      zoom: 15,
                    ),

                    rotateGesturesEnabled: true,

                    markers: Set<Marker>.of(markerList),
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Nearby_location_listing()),
            ],
          );
        } else {
          return const Center(
              child: CupertinoActivityIndicator(
            color: AppColors.blue,
          ));
        }
      },
    );
  }

  Widget location_() {
    return FutureBuilder<Uint8List>(
      future: getBytesFromAsset(
        'assets/images/locationpick.png',
        10,
        10,
      ),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: Get.height,
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Column(
                      children: [
                        // filter_clear(),
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     itemCount: filtercontro.filtermarkerList.length,
                        //     itemBuilder: (context, index) {
                        //       return Text(filtercontro
                        //           .filtermarkerList[index].position
                        //           .toString());
                        //     }),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            child: GoogleMap(
                              onCameraMoveStarted: () {
                                // if (mounted) {
                                //   setState(() {});
                                // }
                              },

                              zoomGesturesEnabled:
                                  true, // Enable Zoom in/out on the map
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  double.parse(Latitude),
                                  double.parse(Longitude),
                                ),
                                zoom: 15,
                              ),

                              rotateGesturesEnabled: true,

                              markers: Set<Marker>.of(
                                  filtercontro.filtermarkerList.value),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Obx(() {
                          return filtercontro.isfilter.value
                              ? SizedBox.shrink()
                              : filtercontro.filtermodel.value!.serviceFilter!
                                      .isNotEmpty
                                  ? location_filter()
                                  : Container(
                                      height: getProportionateScreenHeight(150),
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: ui.Radius.circular(15),
                                              topRight: ui.Radius.circular(15)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 14.0,
                                              spreadRadius: 0.0,
                                              offset: const Offset(2.0,
                                                  4.0), // shadow direction: bottom right
                                            )
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          label(
                                            'No Store available in your Location',
                                            fontSize: 13,
                                            textColor: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    );
                        }))
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
              child: CupertinoActivityIndicator(
            color: AppColors.blue,
          ));
        }
      },
    );
  }

  Widget listing() {
    return nearcontro.nearbylist.isNotEmpty
        ? GridView.builder(
            itemCount: nearcontro.nearbylist.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items in a row
              childAspectRatio: 0.58, // Adjust for image and text ratio
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              if (index == nearcontro.nearbylist.length) {
                return isLoadingMore // Check if more data is being loaded
                    ? Center(
                        child: Column(
                          children: [
                            sizeBoxHeight(10),
                            CircularProgressIndicator(
                              color: AppColors.blue,
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(); // If no more data, show nothing
              }
              return CommanScreen(
                storeImages:
                    nearcontro.nearbylist[index].serviceImages![0].toString(),
                sname: nearcontro.nearbylist[index].serviceName!.capitalizeFirst
                    .toString(),
                cname: nearcontro
                    .nearbylist[index].categoryName!.capitalizeFirst
                    .toString(),
                vname: nearcontro.nearbylist[index].vendorFirstName.toString(),
                vendorImages:
                    nearcontro.nearbylist[index].vendorImage.toString(),
                isfeatured: nearcontro.nearbylist[index].isFeatured!,
                ratingCount: nearcontro
                        .nearbylist[index].totalAvgReview!.isNotEmpty
                    ? double.parse(nearcontro.nearbylist[index].totalAvgReview!)
                    : 0,
                avrageReview:
                    nearcontro.nearbylist[index].totalReviewCount!.toString(),
                isLike:
                    userID.isEmpty ? 0 : nearcontro.nearbylist[index].isLike!,
                onTaplike: () {
                  if (userID.isEmpty) {
                    snackBar('Please login to like this service');
                  } else {
                    likecontro
                        .likeApi(nearcontro.nearbylist[index].id.toString());

                    // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                    setState(() {
                      nearcontro.nearbylist[index].isLike =
                          nearcontro.nearbylist[index].isLike == 0 ? 1 : 0;
                    });
                  }
                },
                onTapstore: () {
                  Get.to(
                      Details(
                        serviceid: nearcontro.nearbylist[index].id.toString(),
                        latt: nearcontro.nearbylist[index].lat.toString(),
                        longg: nearcontro.nearbylist[index].lon.toString(),
                      ),
                      transition: Transition.rightToLeft);
                },
                location: nearcontro.nearbylist[index].address.toString(),
                price: 'From \$252-565',
              );
            },
          ).paddingSymmetric(horizontal: 15, vertical: 5)
        : explore_empty();
  }

  Widget Nearby_location_listing() {
    return nearcontro.nearbylist.isNotEmpty
        ? SizedBox(
            height: getProportionateScreenHeight(180),
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: ui.Radius.circular(15),
                      topRight: ui.Radius.circular(15))),
              child: ListView.builder(
                  controller: filtercontro.scrollControllerlocation,
                  shrinkWrap: true,
                  itemCount: nearcontro.nearbylist.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        sizeBoxHeight(25),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                                Details(
                                  serviceid: nearcontro.nearbylist[index].id
                                      .toString(),
                                  latt: nearcontro.nearbylist[index].lat
                                      .toString(),
                                  longg: nearcontro.nearbylist[index].lon
                                      .toString(),
                                ),
                                transition: Transition.rightToLeft);
                          },
                          child: Container(
                            height: getProportionateScreenHeight(120),
                            width: Get.width * 0.90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(120),
                                  width: getProportionateScreenWidth(130),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9),
                                          bottomLeft: Radius.circular(9)),
                                      border: Border.all(color: Colors.white),
                                      image: DecorationImage(
                                          image: NetworkImage(nearcontro
                                              .nearbylist[index]
                                              .serviceImages![0]
                                              .toString()),
                                          fit: BoxFit.fill)),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sizeBoxHeight(3),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        sizeBoxWidth(10),
                                        Container(
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: AppColors.blue,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Center(
                                            child: SizedBox(
                                              width: 55,
                                              child: label(
                                                nearcontro.nearbylist[index]
                                                    .categoryName
                                                    .toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 8,
                                                ),
                                              ).paddingOnly(left: 4, right: 4),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   height: 13,
                                        //   width: 45,
                                        //   decoration: BoxDecoration(
                                        //     color: AppColors.blue,
                                        //     borderRadius:
                                        //         BorderRadius.circular(3),
                                        //   ),
                                        //   child: Center(
                                        //     child: Text(
                                        //       nearcontro.nearbylist[index]
                                        //           .categoryName
                                        //           .toString(),
                                        //       style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontSize: 5),
                                        //     ),
                                        //   ),
                                        // ),
                                        sizeBoxWidth(130),
                                        GestureDetector(
                                          onTap: () {
                                            if (userID.isEmpty) {
                                              snackBar(
                                                  'Please login to like this service');
                                            } else {
                                              likecontro.likeApi(nearcontro
                                                  .nearbylist[index].id
                                                  .toString());

                                              setState(() {
                                                nearcontro.nearbylist[index]
                                                    .isLike = nearcontro
                                                            .nearbylist[index]
                                                            .isLike ==
                                                        0
                                                    ? 1
                                                    : 0;
                                              });
                                            }
                                          },
                                          child: Container(
                                              height: 26,
                                              width: 26,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.blue1),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: nearcontro
                                                            .nearbylist[index]
                                                            .isLike ==
                                                        0
                                                    ? Image.asset(
                                                        AppAsstes.heart)
                                                    : Image.asset(
                                                        AppAsstes.fill_heart),
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.5,
                                      child: label(
                                        nearcontro.nearbylist[index].serviceName
                                            .toString(),
                                        fontSize: 11,
                                        maxLines: 1,
                                        textColor: AppColors.brown,
                                        fontWeight: FontWeight.w600,
                                      ).paddingOnly(left: 10),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        sizeBoxWidth(10),
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.blue1),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Image.asset(
                                              'assets/images/location1.png',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        sizeBoxWidth(10),
                                        SizedBox(
                                          width: 155,
                                          child: label(
                                            nearcontro.nearbylist[index].address
                                                .toString(),
                                            maxLines: 1,
                                            fontSize: 10,
                                            textColor: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizeBoxHeight(6),
                                    Row(
                                      children: [
                                        sizeBoxWidth(10),
                                        RatingBar.builder(
                                          itemPadding:
                                              const EdgeInsets.only(left: 1.5),
                                          initialRating: nearcontro
                                                      .nearbylist[index]
                                                      .totalAvgReview !=
                                                  ''
                                              ? double.parse(nearcontro
                                                  .nearbylist[index]
                                                  .totalAvgReview!)
                                              : 0.0,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 10.5,
                                          ignoreGestures: true,
                                          unratedColor: Colors.grey.shade400,
                                          itemBuilder: (context, _) =>
                                              Image.asset(
                                            'assets/images/Star.png',
                                            height: 8,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        SizedBox(width: 5),
                                        label(
                                          '(${nearcontro.nearbylist[index].totalReviewCount} Review)',
                                          fontSize: 10,
                                          textColor: AppColors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(
                      horizontal: 20,
                    );
                  }),
            ),
          )
        : Container(
            height: getProportionateScreenHeight(180),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: ui.Radius.circular(15),
                  topRight: ui.Radius.circular(15)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                sizeBoxHeight(35),
                Image.asset(
                  'assets/images/Illustration.png',
                  height: 65,
                  width: 65,
                ),
                sizeBoxHeight(1),
                label('No Store available in \nyour Location',
                    fontSize: 8,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center),
              ],
            ),
          );
  }

  Widget explore_empty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(150),
          SizedBox(
            height: 150,
            child: Image.asset(
              'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
              width: 200,
              height: 180,
            ),
          ),
          label(
            "Explore List Not Available",
            fontSize: 18,
            textColor: themeContro.isLightMode.value
                ? AppColors.black
                : AppColors.white,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  void openBottomForfilter(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            alignment: Alignment.bottomCenter,
            insetPadding: const EdgeInsets.only(),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            content: nearcontro.nearbymodel.value?.nearbyService != null &&
                    nearcontro.nearbymodel.value!.nearbyService!.isNotEmpty
                ? Filter(
                    catid: nearcontro
                        .nearbymodel.value!.nearbyService![0].categoryId
                        .toString(),
                  )
                : const SizedBox(), // Show empty widget if no data is available
          ),
        );
      },
    ).then(
      (value) {
        setState(() {});
      },
    );
  }
}
