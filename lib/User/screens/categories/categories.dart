import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
import 'package:nlytical_app/User/screens/categories/subcategories.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/categories_loader.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CategoriesContro catecontro = Get.put(CategoriesContro());

  @override
  void initState() {
    catecontro.cateApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: AppColors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.white,
        //   automaticallyImplyLeading: false,
        //   scrolledUnderElevation: 0,
        //   shadowColor: Colors.white,
        //   elevation: 5,
        //   title: Row(
        //     children: [
        //       // GestureDetector(
        //       //     onTap: () {
        //       //       Navigator.pop(context);
        //       //     },
        //       //     child: Image.asset(
        //       //       'assets/images/arrow-left1.png',
        //       //       height: 24,
        //       //     )),
        //       sizeBoxWidth(10),
        //       label(
        //         'Categories',
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
                  alignment: Alignment.center, // Aligns content to the center
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      label(
                        "Categories",
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w500,
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
                  height: getProportionateScreenHeight(750),
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

                      Expanded(child: catlist()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget catlist() {
    return Obx(() {
      return catecontro.iscat.value
          ? cat(context)
          // const Center(
          //     child: CircularProgressIndicator(
          //       color: AppColors.blue,
          //     ),
          //   )
          : SingleChildScrollView(child: category());
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
          child: label(
            "Categories",
            fontSize: 20,
            textColor: AppColors.black,
            fontWeight: FontWeight.w500,
          )).paddingOnly(left: 21, right: 20, top: 25),
    );
  }

  Widget category() {
    return catecontro.catelist.isNotEmpty
        ? SizedBox(
            height: Get.height,
            child: GridView.builder(
              itemCount: catecontro.catelist.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 3),
              // padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1, // To ensure the grid is square
              ),
              itemBuilder: (context, index) {
                return cateWidgets(
                  imagepath:
                      catecontro.catelist[index].categoryImage.toString(),
                  cname:
                      '${catecontro.catelist[index].categoryName!.capitalizeFirst} (${catecontro.catelist[index].subcategoriesCount})',
                  cateOnTap: () {
                    Get.to(
                        SubCategories(
                          cat: catecontro.catelist[index].id.toString(),
                        ),
                        transition: Transition.rightToLeft);
                  },
                );
              },
            ).paddingSymmetric(horizontal: 15, vertical: 15),
          )
        : Center(
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
                  "Categories Not Found",
                  fontSize: 18,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          );
  }
}
