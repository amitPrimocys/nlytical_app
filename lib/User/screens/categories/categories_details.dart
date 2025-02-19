// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_is_empty, unused_local_variable, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/subcate_service_contro.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/catedetail_loader.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/comman_screen_new.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';
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

      // // Check if the response is not null and update the state
      // if (newRestaurants != null) {
      //   setState(() {
      //     allcatelist.addAll(newRestaurants.allServices ?? []);
      //     isLoadingMore = false;
      //   });
      // } else {
      //   setState(() {
      //     isLoadingMore = false;
      //   });
      //   print("Error: Received null response");
      // }
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
        backgroundColor: AppColors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.appbar,
        //   automaticallyImplyLeading: false,
        //   title: Row(
        //     children: [
        //       GestureDetector(
        //           onTap: () {
        //             Navigator.pop(context);
        //           },
        //           child: Image.asset(
        //             'assets/images/arrow-left1.png',
        //             height: 24,
        //           )),
        //       sizeBoxWidth(10),
        //       Obx(() {
        //         return subcateservicecontro.issubcat.value
        //             ? Shimmer.fromColors(
        //                 baseColor: Theme.of(context).brightness == Brightness.dark
        //                     ? Colors.white12
        //                     : Colors.grey.shade300,
        //                 highlightColor:
        //                     Theme.of(context).brightness == Brightness.dark
        //                         ? Colors.white24
        //                         : Colors.grey.shade100,
        //                 child: label(
        //                   '',
        //                   fontSize: 19,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               )
        //             : label(
        //                 subcateservicecontro
        //                     .subcateservicemodel.value!.subcategoryName
        //                     .toString(),
        //                 fontSize: 20,
        //                 textColor: Colors.black,
        //                 fontWeight: FontWeight.w500,
        //               );
        //       }),
        //     ],
        //   ),
        // ),
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
                                ? Shimmer.fromColors(
                                    baseColor: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white12
                                        : Colors.grey.shade300,
                                    highlightColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white24
                                            : Colors.grey.shade100,
                                    child: label(
                                      '',
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
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
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/menu1.png',
                            color: AppColors.white,
                            height: 24,
                          )),
                      // Uncomment and use if required
                      // sizeBoxWidth(240),
                      // Image.asset(
                      //   AppAsstes.search,
                      //   scale: 3.5,
                      //   color: Colors.white,
                      // ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
              Positioned(
                top: 100,
                child: Container(
                  width: Get.width,
                  height: getProportionateScreenHeight(800),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      sizeBoxHeight(10),
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
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     Get.to(Featured(
                                          //       cat: subcateservicecontro.subcateservicemodel
                                          //           .value!.featuredServices![0].categoryId
                                          //           .toString(),
                                          //       subcat: subcateservicecontro.subcateservicemodel
                                          //           .value!.featuredServices![0].id
                                          //           .toString(),
                                          //     ));
                                          //   },
                                          //   child: label(
                                          //     'See all',
                                          //     fontSize: 11,
                                          //     textColor: Colors.grey,
                                          //     fontWeight: FontWeight.w400,
                                          //   ),
                                          // ),
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
                                          textColor: Colors.black,
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

  Widget appBarWidget() {
    return Container(
      height: getProportionateScreenHeight(100),
      width: Get.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
            color: Colors.grey.shade300)
      ], color: Colors.white),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              Obx(() {
                return subcateservicecontro.issubcat.value &&
                        subcateservicecontro
                                .subcateservicemodel.value!.subcategoryName ==
                            null
                    ? Shimmer.fromColors(
                        baseColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white12
                                : Colors.grey.shade300,
                        highlightColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white24
                                : Colors.grey.shade100,
                        child: label(
                          '',
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : SizedBox(
                        width: 100,
                        child: label(
                          subcateservicecontro
                              .subcateservicemodel.value!.subcategoryName
                              .toString(),
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      );
              }),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
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
                  isLike: userID.isEmpty
                      ? 0
                      : subcateservicecontro.subcatelist[index].isLike!,
                  onTaplike: () {
                    if (userID.isEmpty) {
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

                // GestureDetector(
                //   onTap: () {
                //     Get.to(
                //         Details(
                //           serviceid: subcateservicecontro.subcatelist[index].id
                //               .toString(),
                //           latt: subcateservicecontro.subcatelist[index].lat
                //               .toString(),
                //           longg: subcateservicecontro.subcatelist[index].lon
                //               .toString(),
                //         ),
                //         transition: Transition.rightToLeft);
                //   },
                //   child: Stack(
                //     clipBehavior: Clip.none,
                //     children: [
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Container(
                //             // height: 200,
                //             width: Get.width * 0.82,
                //             decoration: BoxDecoration(
                //               boxShadow: [
                //                 BoxShadow(
                //                   blurRadius: 5,
                //                   spreadRadius: 0,
                //                   color: Colors.grey.shade300,
                //                   offset: const Offset(0.0, 3.0),
                //                 ),
                //               ],
                //               borderRadius: const BorderRadius.only(
                //                 topLeft: Radius.circular(10),
                //                 topRight: Radius.circular(10),
                //                 bottomLeft: Radius.circular(10),
                //                 bottomRight: Radius.circular(10),
                //               ),
                //               image: DecorationImage(
                //                 image: NetworkImage(
                //                   subcateservicecontro
                //                       .subcatelist[index].serviceImages
                //                       .toString(),
                //                 ),
                //                 fit: BoxFit.fill,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Positioned.fill(
                //           top: 20,
                //           bottom: -1,
                //           child: FeaturedScreen(
                //             sname: subcateservicecontro
                //                 .subcatelist[index].serviceName
                //                 .toString(),
                //             ratingCount: subcateservicecontro.subcatelist[index]
                //                     .totalAvgReview!.isNotEmpty
                //                 ? double.parse(subcateservicecontro
                //                     .subcatelist[index].totalAvgReview!)
                //                 : 0,
                //             avrageReview: subcateservicecontro
                //                 .subcatelist[index].totalReviewCount!
                //                 .toString(),
                //             date:
                //                 ' Until ${subcateservicecontro.subcatelist[index].closeTime.toString()}',
                //             year:
                //                 '${subcateservicecontro.subcatelist[index].totalYearsCount!.toString()} Years in Business',
                //             isLike: subcateservicecontro
                //                         .subcateservicemodel.value!.guestUser ==
                //                     1
                //                 ? 0
                //                 : subcateservicecontro
                //                     .subcatelist[index].isLike!,
                //             onTaplike: () {
                //               if (subcateservicecontro
                //                       .subcateservicemodel.value!.guestUser ==
                //                   1) {
                //                 snackBar('Please login to like this service');
                //               } else {
                //                 likecontro.likeApi(subcateservicecontro
                //                     .subcatelist[index].id
                //                     .toString());

                //                 // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                //                 setState(() {
                //                   subcateservicecontro.subcatelist[index]
                //                       .isLike = subcateservicecontro
                //                               .subcatelist[index].isLike ==
                //                           0
                //                       ? 1
                //                       : 0;
                //                   for (int i = 0;
                //                       i <
                //                           subcateservicecontro
                //                               .allcatelist.length;
                //                       i++) {
                //                     if (subcateservicecontro
                //                             .allcatelist[i].id ==
                //                         subcateservicecontro
                //                             .subcatelist[index].id) {
                //                       subcateservicecontro
                //                               .allcatelist[i].isLike =
                //                           subcateservicecontro
                //                               .subcatelist[index].isLike;
                //                     }
                //                   }
                //                 });
                //               }
                //             },
                //             onTapcall: () async {
                //               if (subcateservicecontro
                //                       .subcateservicemodel.value!.guestUser ==
                //                   1) {
                //                 snackBar(
                //                     "Login must need for see mobile number ");
                //               } else {
                //                 String phoneNum = Uri.encodeComponent(
                //                     subcateservicecontro
                //                         .subcatelist[index].servicePhone!
                //                         .toString());
                //                 Uri tel = Uri.parse("tel:$phoneNum");
                //                 if (await launchUrl(tel)) {
                //                   //phone dail app is opened
                //                 } else {
                //                   //phone dail app is not opened
                //                   snackBar('Phone dail not opened');
                //                 }
                //               }
                //             },
                //             onTapwhatsup: () {
                //               // whatsapp();
                //               if (subcateservicecontro
                //                       .subcateservicemodel.value!.guestUser ==
                //                   1) {
                //                 snackBar(
                //                     "Login must need for see what's app number ");
                //               } else {
                //                 whatsapp();
                //               }
                //             },
                //           )),
                //       Positioned(
                //         top: 14,
                //         child: Container(
                //           height: 18,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(3),
                //             color: AppColors.blue,
                //           ),
                //           child: Center(
                //             child: label(
                //               subcateservicecontro
                //                   .subcatelist[index].categoryName
                //                   .toString(),
                //               fontSize: 8,
                //               textColor: Colors.white,
                //               fontWeight: FontWeight.w600,
                //             ).paddingSymmetric(horizontal: 8),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // );
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
            // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //   maxCrossAxisExtent: maxCrossAxisExtent,
            //   childAspectRatio: (itemWidth / itemHeight * 1.6),
            //   mainAxisSpacing: 14,
            //   crossAxisSpacing: 14,
            // ),
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
                isLike: userID.isEmpty
                    ? 0
                    : subcateservicecontro.allcatelist[index].isLike!,
                onTaplike: () {
                  if (userID.isEmpty) {
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
                      // for (int i = 0;
                      //     i < subcateservicecontro.allcatelist.length;
                      //     i++) {
                      //   if (subcateservicecontro.allcatelist[i].id ==
                      //       subcateservicecontro.subcatelist[index].id) {
                      //     subcateservicecontro.allcatelist[i].isLike =
                      //         subcateservicecontro.subcatelist[index].isLike;
                      //   }
                      // }
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

              // findstore(
              //     imagepath: subcateservicecontro
              //         .allcatelist[index].serviceImages
              //         .toString(),
              //     sname: subcateservicecontro.allcatelist[index].serviceName!,
              //     cname: subcateservicecontro.allcatelist[index].categoryName!,
              //     ratingCount: subcateservicecontro
              //             .allcatelist[index].totalAvgReview!.isEmpty
              //         ? 0.00
              //         : double.parse(subcateservicecontro
              //             .allcatelist[index].totalAvgReview!),
              //     avrageReview: subcateservicecontro
              //         .allcatelist[index].totalReviewCount!
              //         .toString(),
              //     isLike: subcateservicecontro
              //                 .subcateservicemodel.value!.guestUser ==
              //             1
              //         ? 0
              //         : subcateservicecontro.allcatelist[index].isLike!,
              //     onTaplike: () {
              //       if (subcateservicecontro
              //               .subcateservicemodel.value!.guestUser ==
              //           1) {
              //         snackBar('Please login to like this service');
              //       } else {
              //         for (var i = 0;
              //             i < subcateservicecontro.subcatelist.length;
              //             i++) {
              //           if (subcateservicecontro.allcatelist[index].id ==
              //               subcateservicecontro.subcatelist[i].id) {
              //             print("ID MATCHED");
              //             if (subcateservicecontro.subcatelist[i].isLike == 0) {
              //               subcateservicecontro.subcatelist[i].isLike = 1;
              //             } else {
              //               subcateservicecontro.subcatelist[i].isLike = 0;
              //             }
              //             subcateservicecontro.subcatelist.refresh();
              //           }
              //         }

              //         likecontro.likeApi(subcateservicecontro
              //             .allcatelist[index].id
              //             .toString());

              //         // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
              //         setState(() {
              //           subcateservicecontro.allcatelist[index].isLike =
              //               subcateservicecontro.allcatelist[index].isLike == 0
              //                   ? 1
              //                   : 0;
              //           // for (int i = 0;
              //           //     i < subcateservicecontro.allcatelist.length;
              //           //     i++) {
              //           //   if (subcateservicecontro.allcatelist[i].id ==
              //           //       subcateservicecontro.subcatelist[index].id) {
              //           //     subcateservicecontro.allcatelist[i].isLike =
              //           //         subcateservicecontro.subcatelist[index].isLike;
              //           //   }
              //           // }
              //         });
              //       }
              //     },
              //     storeOnTap: () {
              //       Get.to(
              //           Details(
              //             serviceid: subcateservicecontro.allcatelist[index].id
              //                 .toString(),
              //             latt: subcateservicecontro.allcatelist[index].lat
              //                 .toString(),
              //             longg: subcateservicecontro.allcatelist[index].lon
              //                 .toString(),
              //           ),
              //           transition: Transition.rightToLeft);
              //     }
              //     );
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
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w500)
              ],
            ),
          );
  }

  // Widget allstore() {
  //   return subcateservicecontro.allcatelist.length > 0
  //       ? ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: subcateservicecontro.allcatelist.length,
  //           physics: BouncingScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             if (index == subcateservicecontro.allcatelist.length) {
  //               return isLoadingMore // Check if more data is being loaded
  //                   ? Center(
  //                       child: Column(
  //                         children: [
  //                           sizeBoxHeight(10),
  //                           CircularProgressIndicator(
  //                             color: AppColors.blue,
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   : SizedBox.shrink(); // If no more data, show nothing
  //             }

  //             return Column(
  //               children: [
  //                 sizeBoxHeight(15),
  //                 GestureDetector(
  //                   onTap: () {
  //                     Get.to(
  //                         Details(
  //                           serviceid: subcateservicecontro
  //                               .allcatelist[index].id
  //                               .toString(),
  //                         ),
  //                         transition: Transition.rightToLeft);
  //                   },
  //                   child: Container(
  //                     height: getProportionateScreenHeight(120),
  //                     width: Get.width,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         border: Border.all(color: Colors.grey.shade300)),
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           height: getProportionateScreenHeight(120),
  //                           width: getProportionateScreenWidth(130),
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.only(
  //                                   topLeft: Radius.circular(9),
  //                                   bottomLeft: Radius.circular(9)),
  //                               border: Border.all(color: Colors.white),
  //                               image: DecorationImage(
  //                                   image: NetworkImage(subcateservicecontro
  //                                       .allcatelist[index].serviceImages
  //                                       .toString()),
  //                                   fit: BoxFit.fill)),
  //                         ),
  //                         Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             sizeBoxHeight(5),
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 sizeBoxWidth(10),
  //                                 Container(
  //                                   height: 13,
  //                                   width: 45,
  //                                   decoration: BoxDecoration(
  //                                     color: AppColors.blue,
  //                                     borderRadius: BorderRadius.circular(3),
  //                                   ),
  //                                   child: Center(
  //                                     child: Text(
  //                                       subcateservicecontro
  //                                           .allcatelist[index].categoryName
  //                                           .toString(),
  //                                       style: TextStyle(
  //                                           color: Colors.white, fontSize: 5),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 sizeBoxWidth(130),
  //                                 GestureDetector(
  //                                   onTap: () {
  //                                     if (subcateservicecontro
  //                                             .subcateservicemodel
  //                                             .value!
  //                                             .guestUser ==
  //                                         1) {
  //                                       snackBar(
  //                                           'Please login to like this service');
  //                                     } else {
  //                                       likecontro.likeApi(subcateservicecontro
  //                                           .allcatelist[index].id
  //                                           .toString());

  //                                       // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
  //                                       setState(() {
  //                                         subcateservicecontro
  //                                             .allcatelist[index]
  //                                             .isLike = subcateservicecontro
  //                                                     .allcatelist[index]
  //                                                     .isLike ==
  //                                                 0
  //                                             ? 1
  //                                             : 0;
  //                                       });
  //                                     }

  //                                     // Call the API to like/unlike the service
  //                                   },
  //                                   child: Container(
  //                                       height: 26,
  //                                       width: 26,
  //                                       decoration: const BoxDecoration(
  //                                           shape: BoxShape.circle,
  //                                           color: AppColors.blue1),
  //                                       child: Padding(
  //                                         padding: const EdgeInsets.all(6.0),
  //                                         child: subcateservicecontro
  //                                                     .allcatelist[index]
  //                                                     .isLike ==
  //                                                 0
  //                                             ? Image.asset(AppAsstes.heart)
  //                                             : Image.asset(
  //                                                 AppAsstes.fill_heart),
  //                                       )),
  //                                 )
  //                               ],
  //                             ),
  //                             label(
  //                               subcateservicecontro
  //                                   .allcatelist[index].serviceName
  //                                   .toString(),
  //                               fontSize: 11,
  //                               textColor: AppColors.brown,
  //                               fontWeight: FontWeight.w600,
  //                             ).paddingOnly(left: 10),
  //                             SizedBox(height: 5),
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 sizeBoxWidth(10),
  //                                 Container(
  //                                     height: 24,
  //                                     width: 24,
  //                                     decoration: BoxDecoration(
  //                                         shape: BoxShape.circle,
  //                                         color: AppColors.blue1),
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.all(6.0),
  //                                       child: Image.asset(
  //                                         'assets/images/location1.png',
  //                                         color: Colors.black,
  //                                       ),
  //                                     )),
  //                                 sizeBoxWidth(10),
  //                                 SizedBox(
  //                                   width: 155,
  //                                   child: label(
  //                                     subcateservicecontro
  //                                         .allcatelist[index].address
  //                                         .toString(),
  //                                     maxLines: 1,
  //                                     fontSize: 9,
  //                                     textColor: AppColors.black,
  //                                     fontWeight: FontWeight.w400,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             sizeBoxHeight(6),
  //                             Row(
  //                               children: [
  //                                 sizeBoxWidth(10),
  //                                 subcateservicecontro.subcatelist.isNotEmpty &&
  //                                         index <
  //                                             subcateservicecontro
  //                                                 .subcatelist.length
  //                                     ? RatingBar.builder(
  //                                         itemPadding:
  //                                             const EdgeInsets.only(left: 1.5),
  //                                         initialRating: (subcateservicecontro
  //                                                         .subcatelist[index]
  //                                                         .totalAvgReview !=
  //                                                     null &&
  //                                                 subcateservicecontro
  //                                                     .subcatelist[index]
  //                                                     .totalAvgReview
  //                                                     .toString()
  //                                                     .isNotEmpty)
  //                                             ? double.tryParse(
  //                                                     subcateservicecontro
  //                                                         .subcatelist[index]
  //                                                         .totalAvgReview
  //                                                         .toString()) ??
  //                                                 0.0
  //                                             : 0.0,
  //                                         minRating: 0,
  //                                         direction: Axis.horizontal,
  //                                         allowHalfRating: true,
  //                                         itemCount: 5,
  //                                         itemSize: 10.5,
  //                                         ignoreGestures: true,
  //                                         unratedColor: Colors.grey.shade400,
  //                                         itemBuilder: (context, _) =>
  //                                             Image.asset(
  //                                           'assets/images/Star.png',
  //                                           height: 6,
  //                                         ),
  //                                         onRatingUpdate: (rating) {},
  //                                       )
  //                                     : SizedBox(),
  //                                 SizedBox(width: 5),
  //                                 label(
  //                                   '(${subcateservicecontro.allcatelist[index].totalReviewCount.toString()} Review)',
  //                                   fontSize: 8,
  //                                   textColor: AppColors.black,
  //                                   fontWeight: FontWeight.w400,
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                   ).paddingSymmetric(horizontal: 20),
  //                 )
  //               ],
  //             );
  //           })
  //       : Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               sizeBoxHeight(Get.height * 0.2),
  //               Image.asset(
  //                 "assets/images/empty_image.png",
  //                 height: 75,
  //               ),
  //               sizeBoxHeight(10),
  //               label("No All Stores Found",
  //                   fontSize: 16,
  //                   textColor: AppColors.black,
  //                   fontWeight: FontWeight.w500)
  //             ],
  //           ),
  //         );
  // }
}
