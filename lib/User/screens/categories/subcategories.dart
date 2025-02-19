// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
import 'package:nlytical_app/User/screens/categories/categories_details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/subcat_loader.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';

import 'package:nlytical_app/utils/size_config.dart';

class SubCategories extends StatefulWidget {
  String? cat;
  SubCategories({super.key, this.cat});

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  CategoriesContro subcatecontro = Get.put(CategoriesContro());

  @override
  void initState() {
    subcatecontro.subcateApi(catId: widget.cat!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.white,
        //   automaticallyImplyLeading: false,
        //   scrolledUnderElevation: 0,
        //   shadowColor: Colors.white70,
        //   elevation: 5,
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
        //       label(
        //         'Sub Categories',
        //         fontSize: 20,
        //         textColor: Colors.black,
        //         fontWeight: FontWeight.w500,
        //       ),
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
                      sizeBoxWidth(80),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "Sub Categories",
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
                          return subcatecontro.issubcat.value
                              ? SubcatLoader(context)
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // sizeBoxHeight(10),
                                      // Align(
                                      //   alignment: Alignment.bottomRight,
                                      //   child: label(
                                      //     'Total Service : ${subcatecontro.subcatemodel.value!.totalSubCategoryCount!.toString()} ',
                                      //     fontSize: 12,
                                      //     textColor: AppColors.black,
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ).paddingOnly(right: 20),
                                      sizeBoxHeight(10),
                                      detail()
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
              label(
                "Sub Categories",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }

  Widget detail() {
    return subcatecontro.subcatelist.isNotEmpty
        ? ListView.builder(
            itemCount: subcatecontro.subcatelist.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.to(Categoriesdetails(
                      cat: subcatecontro.subcatelist[index].categoryId
                          .toString(),
                      subcat: subcatecontro.subcatelist[index].id.toString(),
                    ));
                  },
                  child: Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.white),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 14.0,
                            spreadRadius: 0.0,
                            offset: const Offset(
                                2.0, 4.0), // shadow direction: bottom right
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: NetworkImage(subcatecontro
                                          .subcatelist[index].subcategoryImage
                                          .toString()),
                                      fit: BoxFit.cover)),
                            ),
                            sizeBoxWidth(10),
                            label(
                              subcatecontro.subcatelist[index].subcategoryName
                                  .toString(),
                              fontSize: 12,
                              textColor: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            label(
                              subcatecontro.subcatelist[index].servicesCount
                                  .toString(),
                              fontSize: 12,
                              textColor: AppColors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                            sizeBoxWidth(10),
                            Image.asset(
                              'assets/images/arrow-left (1).png',
                              color: AppColors.black,
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 15),
                  ).paddingSymmetric(horizontal: 15),
                ),
              );
            })
        : subcatempty();
  }

  Widget subcatempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(200),
          SizedBox(
            height: 160,
            child: Image.asset(
              'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
              width: 200,
              height: 180,
            ),
          ),
          label(
            "Sub Categories Not Found",
            fontSize: 18,
            textColor: AppColors.black,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
