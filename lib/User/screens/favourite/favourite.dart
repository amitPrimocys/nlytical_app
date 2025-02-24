// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/favourite_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/favourite_loader.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Favourite extends StatefulWidget {
  bool tap = true;
  Favourite({super.key, required this.tap});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  FavouriteContro favcontro = Get.put(FavouriteContro());
  LikeContro likecontro = Get.put(LikeContro());

  @override
  void initState() {
    favcontro.favApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
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
                          "Favorite",
                          textAlign: TextAlign.center,
                          fontSize: 20,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                  decoration: BoxDecoration(
                      color: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkMainBlack,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      sizeBoxHeight(10),
                      Expanded(child: favlist()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget favlist() {
    return Obx(() {
      return (favcontro.isfav.value &&
              favcontro.favemodel.value.message == null)
          ? wishListLoader(context)
          : SingleChildScrollView(
              child: Column(
                children: [store()],
              ),
            );
    });
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
              widget.tap
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/images/arrow-left1.png',
                        height: 24,
                      ))
                  : const SizedBox.shrink(),
              widget.tap ? sizeBoxWidth(8) : const SizedBox.shrink(),
              label(
                "Favorite",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 21, right: 20, top: 25),
    );
  }

  Widget store() {
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
        favcontro.favemodel.value.serviceLikedList!.isNotEmpty
            ? SizedBox(
                height: Get.height,
                child: GridView.builder(
                  itemCount: favcontro.favemodel.value.serviceLikedList!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                    return CommanScreen(
                      storeImages: favcontro.favemodel.value
                          .serviceLikedList![index].serviceImages!,
                      sname: favcontro.favemodel.value.serviceLikedList![index]
                          .serviceName!.capitalizeFirst
                          .toString(),
                      cname: favcontro.favemodel.value.serviceLikedList![index]
                          .categoryName!.capitalizeFirst
                          .toString(),
                      vname: favcontro.favemodel.value.serviceLikedList![index]
                          .vendorFirstName
                          .toString(),
                      vendorImages: favcontro
                          .favemodel.value.serviceLikedList![index].vendorImage
                          .toString(),
                      isfeatured: favcontro
                          .favemodel.value.serviceLikedList![index].isFeatured!,
                      ratingCount: favcontro
                              .favemodel
                              .value
                              .serviceLikedList![index]
                              .totalAvgReview!
                              .isNotEmpty
                          ? double.parse(favcontro.favemodel.value
                              .serviceLikedList![index].totalAvgReview!)
                          : 0,
                      avrageReview: favcontro.favemodel.value
                          .serviceLikedList![index].totalReviewCount!
                          .toString(),
                      isLike: 1,
                      onTaplike: () {
                        likecontro.likeApi(favcontro
                            .favemodel.value.serviceLikedList![index].id
                            .toString());
                        favcontro.favemodel.value.serviceLikedList!
                            .removeAt(index);
                        favcontro.favemodel.refresh();
                        setState(() {});
                      },
                      onTapstore: () {
                        Get.to(
                            Details(
                              serviceid: favcontro
                                  .favemodel.value.serviceLikedList![index].id
                                  .toString(),
                              latt: favcontro
                                  .favemodel.value.serviceLikedList![index].lat
                                  .toString(),
                              longg: favcontro
                                  .favemodel.value.serviceLikedList![index].lon
                                  .toString(),
                            ),
                            transition: Transition.rightToLeft);
                      },
                      location: favcontro
                          .favemodel.value.serviceLikedList![index].address
                          .toString(),
                      price: 'From \$252-565',
                    );
                  },
                ).paddingSymmetric(horizontal: 15),
              )
            : favouriteempty()
      ],
    );
  }

  Widget favouriteempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(Get.height * 0.38),
          Image.asset(
            AppAsstes.empty_image,
            height: 75,
          ),
          sizeBoxHeight(10),
          label("No Favorite List",
              fontSize: 16,
              textColor: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
              fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
