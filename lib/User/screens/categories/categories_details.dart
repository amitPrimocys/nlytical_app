// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_is_empty, unused_local_variable, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/subcate_service_contro.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/catedetail_loader.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/comman_screen_new.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Categoriesdetails extends StatefulWidget {
  String? cat;
  String? subcat;
  Categoriesdetails({super.key, this.cat, this.subcat});

  @override
  State<Categoriesdetails> createState() => _CategoriesdetailsState();
}

class _CategoriesdetailsState extends State<Categoriesdetails> {
  SubcateserviceContro subcateservicecontro = Get.put(SubcateserviceContro());
  LikeContro likecontro = Get.put(LikeContro());
  int page = 1;
  // List<AllServices> allcatelist = [];
  bool isLoadingMore = false;
  // ItemScrollController _scrollController = ItemScrollController();
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    // Load initial data
    fetchRestaurants();
    subcateservicecontro.subcateserviceApi(
      page: page.toString(),
      catId: widget.cat!,
      subcatId: widget.subcat,
    );
    super.initState();
  }

  void _scrollListener() {
    // Check if we have reached the bottom of the scroll
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      setState(() {
        isLoadingMore =
            true; // prevent multiple requests while loading more data
        page++;
      });
      fetchRestaurants();
      print("its scroll");
    }
  }

  Future<void> fetchRestaurants() async {
    try {
      // Call the API and handle the response
      // SubcatServiceModel? newRestaurants =
      await subcateservicecontro.subcateserviceApi(
        page: page.toString(),
        catId: widget.cat!,
        subcatId: widget.subcat,
      );
    } catch (error) {
      setState(() {
        isLoadingMore = false;
      });
      print("Error fetching data: $error");
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: getProportionateScreenHeight(60),
                left:
                    0, // Ensures alignment is calculated across the entire width
                right: 0,
                child: Container(
                  // Aligns content to the center
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                'assets/images/arrow-left1.png',
                                color: AppColors.white,
                                height: 24,
                              )),
                          sizeBoxWidth(15),
                          Obx(() {
                            return subcateservicecontro.issubcat.value &&
                                    subcateservicecontro.subcateservicemodel
                                            .value!.subcategoryName ==
                                        null
                                ? SizedBox(
                                    width: 255,
                                    child: label(
                                      "Sub Categories",
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : SizedBox(
                                    width: 255,
                                    child: label(
                                      subcateservicecontro.subcateservicemodel
                                          .value!.subcategoryName
                                          .toString(),
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
              Positioned(
                top: 100,
                child: Container(
                  width: Get.width,
                  height: getProportionateScreenHeight(800),
                  decoration: BoxDecoration(
                      color: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkMainBlack,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      sizeBoxHeight(10),
                      Expanded(
                        child: Obx(() {
                          return subcateservicecontro.issubcat.value &&
                                  subcateservicecontro.allcatelist.isEmpty
                              ? catedetail_Loader(context)
                              : SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      sizeBoxHeight(15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          label(
                                            'Featured Stores',
                                            fontSize: 14,
                                            textColor:
                                                themeContro.isLightMode.value
                                                    ? Colors.black
                                                    : AppColors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ).paddingSymmetric(horizontal: 20),
                                      sizeBoxHeight(15),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: storelist().paddingSymmetric(
                                              horizontal: 20)),
                                      sizeBoxHeight(18),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: label(
                                          'All Stores',
                                          fontSize: 14,
                                          textColor:
                                              themeContro.isLightMode.value
                                                  ? Colors.black
                                                  : AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ).paddingSymmetric(horizontal: 20),
                                      ),
                                      sizeBoxHeight(10),
                                      allstore()
                                    ],
                                  ),
                                );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget storelist() {
    return subcateservicecontro.subcatelist.isNotEmpty
        ? SizedBox(
            height: 320,
            child: ListView.builder(
              clipBehavior: Clip.none,
              padding: EdgeInsets.zero,
              itemCount: subcateservicecontro.subcatelist.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CommanScreenNew(
                  vname: subcateservicecontro.subcatelist[index].vendorFirstName
                      .toString(),
                  storeImages: subcateservicecontro
                      .subcatelist[index].serviceImages
                      .toString(),
                  sname: subcateservicecontro
                      .subcatelist[index].serviceName!.capitalizeFirst
                      .toString(),
                  cname: subcateservicecontro
                      .subcatelist[index].categoryName!.capitalizeFirst
                      .toString(),
                  vendorImages: subcateservicecontro
                      .subcatelist[index].vendorImage
                      .toString(),
                  isfeatured:
                      subcateservicecontro.subcatelist[index].isFeatured!,
                  year:
                      '${subcateservicecontro.subcatelist[index].totalYearsCount!.toString()} Years in Business',
                  ratingCount: subcateservicecontro
                          .subcatelist[index].totalAvgReview!.isNotEmpty
                      ? double.parse(subcateservicecontro
                          .subcatelist[index].totalAvgReview!)
                      : 0,
                  avrageReview: subcateservicecontro
                      .subcatelist[index].totalReviewCount!
                      .toString(),
                  isLike: SharedPrefs.getString(
                              SharedPreferencesKey.LOGGED_IN_USERID)
                          .isEmpty
                      ? 0
                      : subcateservicecontro.subcatelist[index].isLike!,
                  onTaplike: () {
                    if (SharedPrefs.getString(
                            SharedPreferencesKey.LOGGED_IN_USERID)
                        .isEmpty) {
                      snackBar('Please login to like this service');
                    } else {
                      likecontro.likeApi(subcateservicecontro
                          .subcatelist[index].id
                          .toString());

                      // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                      setState(() {
                        subcateservicecontro.subcatelist[index].isLike =
                            subcateservicecontro.subcatelist[index].isLike == 0
                                ? 1
                                : 0;
                        for (int i = 0;
                            i < subcateservicecontro.allcatelist.length;
                            i++) {
                          if (subcateservicecontro.allcatelist[i].id ==
                              subcateservicecontro.subcatelist[index].id) {
                            subcateservicecontro.allcatelist[i].isLike =
                                subcateservicecontro.subcatelist[index].isLike;
                          }
                        }
                      });
                    }
                  },
                  onTapstore: () async {
                    Get.to(
                        Details(
                          serviceid: subcateservicecontro.subcatelist[index].id
                              .toString(),
                          latt: subcateservicecontro.subcatelist[index].lat
                              .toString(),
                          longg: subcateservicecontro.subcatelist[index].lon
                              .toString(),
                        ),
                        transition: Transition.rightToLeft);
                  },
                  location: subcateservicecontro.subcatelist[index].address
                      .toString(),
                  price:
                      'From ${subcateservicecontro.subcatelist[index].priceRange}',
                );
              },
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: SizedBox(
                height: 100,
                child: label("No Featured Stores Found",
                    fontSize: 16,
                    textColor: AppColors.brown,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
  }

  whatsapp() async {
    var contact = subcateservicecontro.subcatelist[0].servicePhone!.toString();
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {}
  }

  Widget allstore() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the maxCrossAxisExtent based on the screen width
    double maxCrossAxisExtent =
        screenWidth / 2; // You can adjust this value as needed

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return subcateservicecontro.allcatelist.length > 0
        ? GridView.builder(
            itemCount: subcateservicecontro.allcatelist.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items in a row
              childAspectRatio: 0.58, // Adjust for image and text ratio
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              if (index == subcateservicecontro.allcatelist.length) {
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
                storeImages: subcateservicecontro
                    .allcatelist[index].serviceImages
                    .toString(),
                sname: subcateservicecontro.allcatelist[index].serviceName!,
                cname: subcateservicecontro.allcatelist[index].categoryName!,
                vname: subcateservicecontro.allcatelist[index].vendorFirstName
                    .toString(),
                vendorImages: subcateservicecontro
                    .allcatelist[index].vendorImage
                    .toString(),
                isfeatured: subcateservicecontro.allcatelist[index].isFeatured!,
                ratingCount: subcateservicecontro
                        .allcatelist[index].totalAvgReview!.isEmpty
                    ? 0.00
                    : double.parse(subcateservicecontro
                        .allcatelist[index].totalAvgReview!),
                avrageReview: subcateservicecontro
                    .allcatelist[index].totalReviewCount!
                    .toString(),
                isLike:
                    SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID)
                            .isEmpty
                        ? 0
                        : subcateservicecontro.allcatelist[index].isLike!,
                onTaplike: () {
                  if (SharedPrefs.getString(
                          SharedPreferencesKey.LOGGED_IN_USERID)
                      .isEmpty) {
                    snackBar('Please login to like this service');
                  } else {
                    for (var i = 0;
                        i < subcateservicecontro.subcatelist.length;
                        i++) {
                      if (subcateservicecontro.allcatelist[index].id ==
                          subcateservicecontro.subcatelist[i].id) {
                        print("ID MATCHED");
                        if (subcateservicecontro.subcatelist[i].isLike == 0) {
                          subcateservicecontro.subcatelist[i].isLike = 1;
                        } else {
                          subcateservicecontro.subcatelist[i].isLike = 0;
                        }
                        subcateservicecontro.subcatelist.refresh();
                      }
                    }

                    likecontro.likeApi(
                        subcateservicecontro.allcatelist[index].id.toString());

                    // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                    setState(() {
                      subcateservicecontro.allcatelist[index].isLike =
                          subcateservicecontro.allcatelist[index].isLike == 0
                              ? 1
                              : 0;
                    });
                  }
                },
                onTapstore: () {
                  Get.to(
                      Details(
                        serviceid: subcateservicecontro.allcatelist[index].id
                            .toString(),
                        latt: subcateservicecontro.allcatelist[index].lat
                            .toString(),
                        longg: subcateservicecontro.allcatelist[index].lon
                            .toString(),
                      ),
                      transition: Transition.rightToLeft);
                },
                location:
                    subcateservicecontro.allcatelist[index].address.toString(),
                price: 'From \$252-565',
              );
            },
          )
            .paddingSymmetric(horizontal: 15, vertical: 5)
            .paddingOnly(bottom: 65)
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizeBoxHeight(50),
                Image.asset(
                  'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
                  width: 100,
                  height: 100,
                ),
                label("No Store Found",
                    fontSize: 16,
                    textColor: AppColors.brown,
                    fontWeight: FontWeight.w500)
              ],
            ),
          );
  }
}
