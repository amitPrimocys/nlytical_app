// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/models/user_models/search_model.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/favourite_loader.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  final ApiHelper apiHelper = ApiHelper();
  LikeContro likecontro = Get.put(LikeContro());

  bool isLoading = false;
  SearchModel model = SearchModel();

  searchApi(String xyz) async {
    setState(() {
      isLoading = true;
    });
    var uri = Uri.parse(apiHelper.search);
    var request = http.MultipartRequest('POST', uri);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    request.headers.addAll(headers);

    request.fields['service_name'] = xyz;
    request.fields['user_id'] =
        SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERID);

    var response = await request.send();
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    // ignore: avoid_print
    print(response.statusCode);
    // ignore: avoid_print
    print(request.fields);
    // ignore: avoid_print
    print(responseData);

    model = SearchModel.fromJson(userData);

    if (model.status == true) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? Colors.white
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      sizeBoxWidth(110),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "Search",
                          textAlign: TextAlign.center,
                          fontSize: 20,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              sizeBoxHeight(15),
                              searchBar(),
                              sizeBoxHeight(15),
                              allstore()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 0,
      child: TextField(
        controller: searchController,
        cursorColor:
            themeContro.isLightMode.value ? AppColors.blue : AppColors.white,
        onChanged: searchApi,
        style: poppinsFont(
            13,
            themeContro.isLightMode.value ? AppColors.black : AppColors.white,
            FontWeight.w500),
        decoration: InputDecoration(
            fillColor: themeContro.isLightMode.value
                ? const Color(0xffF3F3F3)
                : AppColors.darkGray,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.greyColor, width: 5)),
            hintText: "Search Services",
            hintStyle: poppinsFont(13, Colors.grey.shade400, FontWeight.w500),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 15, top: 15),
              child: Image.asset(
                AppAsstes.search,
                color: Colors.grey.shade400,
                height: 10,
              ),
            )),
      ).paddingSymmetric(horizontal: 20),
    );
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
              label(
                "Search",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 21, right: 20, top: 25),
    );
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
    return Column(
      children: [
        searchController.text.isEmpty
            ? searchempty()
            : isLoading
                ? wishListLoader(context)
                : model.serviceSearch!.isEmpty
                    ? searchempty()
                    : GridView.builder(
                        itemCount: model.serviceSearch!.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 items in a row
                          childAspectRatio:
                              0.58, // Adjust for image and text ratio
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return CommanScreen(
                            storeImages: model
                                .serviceSearch![index].serviceImages![0]
                                .toString(),
                            sname: model.serviceSearch![index].serviceName!
                                .capitalizeFirst
                                .toString(),
                            cname: model.serviceSearch![index].categoryName!
                                .capitalizeFirst
                                .toString(),
                            vname: model.serviceSearch![index].vendorFirstName
                                .toString(),
                            vendorImages: model
                                .serviceSearch![index].vendorImage
                                .toString(),
                            isfeatured: model.serviceSearch![index].isFeatured!,
                            ratingCount: model.serviceSearch![index]
                                    .totalAvgReview!.isNotEmpty
                                ? double.parse(
                                    model.serviceSearch![index].totalAvgReview!)
                                : 0,
                            avrageReview: model
                                .serviceSearch![index].totalReviewCount!
                                .toString(),
                            isLike: SharedPrefs.getString(
                                        SharedPreferencesKey.LOGGED_IN_USERID)
                                    .isEmpty
                                ? 0
                                : model.serviceSearch![index].isLike!,
                            onTaplike: () {
                              if (SharedPrefs.getString(
                                      SharedPreferencesKey.LOGGED_IN_USERID)
                                  .isEmpty) {
                                snackBar('Please login to like this service');
                              } else {
                                likecontro.likeApi(
                                    model.serviceSearch![index].id.toString());

                                // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                                setState(() {
                                  model.serviceSearch![index].isLike =
                                      model.serviceSearch![index].isLike == 0
                                          ? 1
                                          : 0;
                                });
                              }

                              // Call the API to like/unlike the service
                            },
                            onTapstore: () {
                              Get.to(
                                  Details(
                                    serviceid: model.serviceSearch![index].id
                                        .toString(),
                                    latt: model.serviceSearch![index].lat
                                        .toString(),
                                    longg: model.serviceSearch![index].lon
                                        .toString(),
                                  ),
                                  transition: Transition.rightToLeft);
                            },
                            location:
                                model.serviceSearch![index].address.toString(),
                            price: 'From \$252-565',
                          );
                        },
                      ).paddingSymmetric(horizontal: 20),
      ],
    );
  }

  Widget searchempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(170),
          SizedBox(
            height: 160,
            child: Image.asset(
              'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
              width: 200,
              height: 180,
            ),
          ),
          label(
            "No Search Found",
            fontSize: 18,
            textColor: themeContro.isLightMode.value
                ? AppColors.black
                : AppColors.colorFFFFFF,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
