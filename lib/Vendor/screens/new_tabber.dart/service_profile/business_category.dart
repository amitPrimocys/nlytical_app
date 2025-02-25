import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class BusinessCategory extends StatefulWidget {
  const BusinessCategory({super.key});

  @override
  State<BusinessCategory> createState() => _BusinessCategoryState();
}

class _BusinessCategoryState extends State<BusinessCategory> {
  StoreController storeController = Get.find();

  @override
  void initState() {
    storeController.filteredSubCategoryNames.clear();

    if (storeController.storeList.isNotEmpty) {
      var businessDetails = storeController.storeList[0].businessDetails;

      if (businessDetails != null) {
        var categoryId = businessDetails.categoryId?.toString();

        // Ensure category data is available
        if (storeController.categoryData.value.data != null &&
            storeController.categoryData.value.data!.isNotEmpty) {
          var categoryList = storeController.categoryData.value.data!
              .where((element) => element.id.toString() == categoryId)
              .toList();

          if (categoryList.isNotEmpty) {
            var selectedCategory = categoryList.first;

            storeController.caategoryName.value =
                selectedCategory.categoryName!;
            storeController.subCategories = selectedCategory.subCategoryData!
                .map((e) => e.subcategoryName!)
                .toList();

            String subcategoryIdsString =
                businessDetails.subcategoryId.toString();
            List<String> subcategoryIds =
                subcategoryIdsString.split(',').map((id) => id.trim()).toList();

            storeController.subCategoryNames.value = selectedCategory
                .subCategoryData!
                .where((subCategory) =>
                    subcategoryIds.contains(subCategory.id.toString()))
                .map((subCategory) => subCategory.subcategoryName!)
                .toList();
          }
        }
      }
    }

    setState(() {});
    // storeController.filteredSubCategoryNames.clear();
    // storeController.caategoryName.value =
    //     storeController.categoryData.value.data!.firstWhere(
    //   (element) {
    //     return element.id.toString() ==
    //         storeController.storeList[0].businessDetails!.categoryId!
    //             .toString();
    //   },
    // ).categoryName!;
    // storeController.subCategories = storeController.categoryData.value.data!
    //     .firstWhere((element) =>
    //         element.categoryName == storeController.caategoryName.value)
    //     .subCategoryData!
    //     .map((e) => e.subcategoryName!)
    //     .toList();
    // String subcategoryIdsString =
    //     storeController.storeList[0].businessDetails!.subcategoryId.toString();
    // List<String> subcategoryIds =
    //     subcategoryIdsString.split(',').map((id) => id.trim()).toList();
    // storeController.subCategoryNames.value = storeController
    //     .categoryData.value.data!
    //     .firstWhere(
    //       (element) {
    //         return element.id.toString() ==
    //             storeController.storeList[0].businessDetails!.categoryId!
    //                 .toString();
    //       },
    //     )
    //     .subCategoryData!
    //     .where(
    //         (subCategory) => subcategoryIds.contains(subCategory.id.toString()))
    //     .map((subCategory) => subCategory
    //         .subcategoryName!) // Assuming each subcategory has a `name` property
    //     .toList();
    // setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: Get.width,
              height: getProportionateScreenHeight(150),
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(AppAsstes.line_design)),
                  color: AppColors.blue),
            ),
            Positioned(
                top: getProportionateScreenHeight(50),
                child: Row(
                  children: [
                    sizeBoxWidth(20),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/arrow-left1.png',
                          color: Colors.white,
                          height: 24,
                        )),
                    sizeBoxWidth(10),
                    Text("Business categories",
                        style:
                            poppinsFont(20, AppColors.white, FontWeight.w500))
                  ],
                )),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizeBoxHeight(30),
                      Text(
                        "Business categories",
                        style: poppinsFont(
                            14,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w600),
                      ),
                      sizeBoxHeight(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.error_outline,
                              color: themeContro.isLightMode.value
                                  ? AppColors.blue
                                  : AppColors.white,
                              size: 15),
                          Flexible(
                            child: Text(
                              " Categories describe what your business is and the products abd services your business offers. please add atleast one category for customers to find your business",
                              style: poppinsFont(
                                  10,
                                  themeContro.isLightMode.value
                                      ? AppColors.blue
                                      : AppColors.white,
                                  FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      sizeBoxHeight(30),
                      twoText(
                        text1: "Categories",
                        text2: " *",
                        fontWeight: FontWeight.w600,
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      sizeBoxHeight(7),
                      DropDown(forWhat: "Categories"),
                      sizeBoxHeight(15),
                      Obx(
                        () => storeController.caategoryName.isEmpty
                            ? const SizedBox.shrink()
                            : globButton(
                                name: storeController.caategoryName.value,
                                gradient: AppColors.logoColork,
                                radius: 6,
                                vertical: 5,
                                horizontal: 15,
                                isOuntLined: true,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    label(
                                      storeController.caategoryName.value,
                                      style: poppinsFont(
                                        9,
                                        themeContro.isLightMode.value
                                            ? AppColors.black
                                            : AppColors.white,
                                        FontWeight.w500,
                                      ),
                                    ),
                                    sizeBoxWidth(8),
                                    GestureDetector(
                                      onTap: () {
                                        storeController.caategoryName.value =
                                            '';
                                        storeController.subCategoryNames.value =
                                            [];
                                        storeController.subCategories = [];
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: themeContro.isLightMode.value
                                            ? AppColors.black
                                            : AppColors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 12, vertical: 7),
                              ),
                      ),
                      sizeBoxHeight(20),
                      twoText(
                        text1: "Sub Categories",
                        text2: " *",
                        fontWeight: FontWeight.w600,
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      sizeBoxHeight(7),
                      DropDown(forWhat: "Sub Categories"),
                      sizeBoxHeight(16),
                      Obx(() => storeController.subCategoryNames.isEmpty
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: getProportionateScreenHeight(35),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount:
                                    storeController.subCategoryNames.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return globButton(
                                    name: "",
                                    gradient: AppColors.logoColork,
                                    radius: 6,
                                    vertical: 5,
                                    horizontal: 15,
                                    isOuntLined: true,
                                    child: Row(
                                      children: [
                                        label(
                                          storeController
                                              .subCategoryNames[index],
                                          style: poppinsFont(
                                            9,
                                            themeContro.isLightMode.value
                                                ? AppColors.black
                                                : AppColors.white,
                                            FontWeight.w500,
                                          ),
                                        ),
                                        sizeBoxWidth(8),
                                        GestureDetector(
                                          onTap: () {
                                            storeController.subCategoryNames
                                                .removeAt(index);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: themeContro.isLightMode.value
                                                ? AppColors.black
                                                : AppColors.white,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(
                                      horizontal: 15,
                                    ),
                                  ).paddingOnly(
                                      right: storeController
                                                      .subCategoryNames.length -
                                                  1 ==
                                              index
                                          ? 0
                                          : 10);
                                },
                              ),
                            )),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
            ),
            Positioned(
              bottom: keyboardHeight > 0
                  ? keyboardHeight + -280 // Place above the keyboard
                  : 30, // Default position
              left: (Get.width - getProportionateScreenWidth(260)) / 2,
              child: Obx(() {
                return storeController.isUpdate.value
                    ? Center(child: commonLoading()).paddingSymmetric(
                        horizontal: getProportionateScreenWidth(100))
                    : customBtn(
                        onTap: () {
                          if (storeController.caategoryName.isEmpty) {
                            snackBar("Please select category");
                          } else if (storeController.subCategoryNames.isEmpty) {
                            snackBar("Please select subcategory");
                          } else {
                            storeController.storeCategoryUpdateApi(
                              categoryId:
                                  storeController.categoryData.value.data!
                                      .where(
                                        (element) =>
                                            element.categoryName ==
                                            storeController.caategoryName.value,
                                      )
                                      .first
                                      .id
                                      .toString(),
                              subCategoryId: storeController
                                  .categoryData.value.data!
                                  .where(
                                    (category) =>
                                        category.categoryName ==
                                        storeController.caategoryName.value,
                                  )
                                  .first
                                  .subCategoryData!
                                  .where((subCategory) => storeController
                                      .subCategoryNames
                                      .contains(subCategory.subcategoryName))
                                  .map((subCategory) =>
                                      subCategory.id.toString())
                                  .toList()
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', '')
                                  .replaceAll(' ', ''),
                            );
                            storeController.caategoryName.value = '';
                            storeController.subCategoryNames.value = [];
                            storeController.subCategories = [];
                          }
                        },
                        title: "Save",
                        fontSize: 15,
                        weight: FontWeight.w400,
                        radius: BorderRadius.circular(10),
                        width: getProportionateScreenWidth(260),
                        height: getProportionateScreenHeight(55),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
