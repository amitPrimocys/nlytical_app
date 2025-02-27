// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_build_context_synchronously, avoid_print, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/filter_contro.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Filter extends StatefulWidget {
  String? catid;
  Filter({super.key, this.catid});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  CategoriesContro catecontro = Get.put(CategoriesContro());
  FilterContro filtercontro = Get.put(FilterContro());
  bool isnavfilter = false;
  int page = 1;
  bool isLoadingMore = false;
  // ItemScrollController _scrollController1 = ItemScrollController();
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    // Load initial data
    // fetchRestaurants();
    catecontro.cateApi();
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true; // Start showing the loader
        page++; // Increment the page number
      });
      fetchRestaurants(); // Fetch next page data
    }
  }

  Future<void> fetchRestaurants() async {
    try {
      print('Fetching page: $page'); // Log the page number
      if (selectedRatting != null) {
        int ratingValue = int.parse(selectedRatting!.split(" ")[0]);

        // Store the selected rating
        filtercontro.selectedRating.value = ratingValue;
        await filtercontro.filterApi(
          catId: widget.catid,
          rivstar: ratingValue,
          selectedService: selectedServices,
          page: page.toString(),
        );

        // Set the filter navigation state to true
        filtercontro.isnavfilter.value = true;

        // Navigate back to the previous screen
        Navigator.pop(context);
      } else {
        print("No rating selected");
      }

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
  void dispose() {
    scrollController.dispose();
    if (catecontro.subcatemodel.value!.subCategoryData != null) {
      catecontro.subcatemodel.value!.subCategoryData!.clear();
    }
    super.dispose();
  }

  TextEditingController searchLocationCtrl = TextEditingController();

  bool isvisible1 = true;
  bool isvisible2 = false;
  bool isvisible3 = false;
  int? selectedIndexType;
  int? selectedIndexRating;

  String? selectedType;
  List<String> itemListType = [
    "Featured",
  ];

  List<String> itemListRating = [
    "1 Star",
    "2 Star",
    "3 Star",
    "4 Star",
    "5 Star"
  ];

  // double minPrice = 1000;
  // double maxPrice = 6000;
  // RangeValues rangeValues = const RangeValues(1000, 6000);

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
                      sizeBoxWidth(120),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "Filter",
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
                          ? AppColors.white
                          : AppColors.darkMainBlack,
                      borderRadius: const BorderRadius.only(
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
                              const SizedBox(height: 20),
                              AnimatedContainer(
                                curve: Curves.easeInOut,
                                duration: const Duration(seconds: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: themeContro.isLightMode.value
                                        ? Colors.white
                                        : AppColors.darkGray,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 14.4,
                                          offset: const Offset(2, 4),
                                          spreadRadius: 0,
                                          color: themeContro.isLightMode.value
                                              ? Colors.grey.shade300
                                              : AppColors.darkShadowColor)
                                    ]),
                                child: !isvisible1
                                    ? Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isvisible1 = !isvisible1;
                                                print(isvisible1);
                                              });
                                            },
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                  isvisible1
                                                      ? Icons
                                                          .keyboard_arrow_down
                                                      : Icons
                                                          .keyboard_arrow_up_outlined,
                                                  size: 30,
                                                  color: themeContro
                                                          .isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white),
                                            ).paddingSymmetric(horizontal: 10),
                                          ),
                                          Container(
                                            height: 45,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.grey.shade300
                                                        : AppColors.grey1)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AppAsstes.location1,
                                                  height: 15,
                                                  color: themeContro
                                                          .isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white,
                                                ),
                                                const SizedBox(width: 5),
                                                label("Location",
                                                    fontSize: 12,
                                                    textColor: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                    fontWeight: FontWeight.w600)
                                              ],
                                            ).paddingSymmetric(horizontal: 10),
                                          ).paddingSymmetric(horizontal: 10),
                                          const SizedBox(height: 10),
                                          Container(
                                            height: 45,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.grey.shade300
                                                        : AppColors.grey1)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AppAsstes.category2,
                                                  height: 15,
                                                  color: themeContro
                                                          .isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white,
                                                ),
                                                const SizedBox(width: 5),
                                                label("Categories",
                                                    fontSize: 12,
                                                    textColor: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                    fontWeight: FontWeight.w600)
                                              ],
                                            ).paddingSymmetric(horizontal: 10),
                                          ).paddingSymmetric(horizontal: 10),
                                          const SizedBox(height: 10),
                                          Container(
                                            height: 45,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.grey.shade300
                                                        : AppColors.grey1)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AppAsstes.subcategory,
                                                  height: 15,
                                                  color: themeContro
                                                          .isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white,
                                                ),
                                                const SizedBox(width: 5),
                                                label("Subcategories",
                                                    fontSize: 12,
                                                    textColor: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                    fontWeight: FontWeight.w600)
                                              ],
                                            ).paddingSymmetric(horizontal: 10),
                                          ).paddingSymmetric(horizontal: 10),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isvisible1 = !isvisible1;
                                                print(isvisible1);
                                              });
                                            },
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                  isvisible1
                                                      ? Icons
                                                          .keyboard_arrow_down
                                                      : Icons
                                                          .keyboard_arrow_up_outlined,
                                                  size: 30,
                                                  color: themeContro
                                                          .isLightMode.value
                                                      ? AppColors.black
                                                      : AppColors.white),
                                            ).paddingSymmetric(horizontal: 10),
                                          ),
                                          //============================================ Location
                                          containerDesign(
                                            image: AppAsstes.location1,
                                            title: "Location",
                                            searchCtrl: searchLocationCtrl,
                                            onChanged: (p0) async {
                                              setState(() {});
                                              await filtercontro.getLonLat(p0);
                                              await filtercontro
                                                  .getsuggestion(p0);
                                              setState(() {});
                                            },
                                            child:
                                                searchLocationCtrl.text.isEmpty
                                                    ? Text(
                                                        "Location not found",
                                                        style: poppinsFont(
                                                            12,
                                                            AppColors.brown,
                                                            FontWeight.w500),
                                                      ).paddingSymmetric(
                                                        vertical: 40)
                                                    : filtercontro
                                                            .mapresult.isEmpty
                                                        ? Text(
                                                            "Location not found",
                                                            style: poppinsFont(
                                                                12,
                                                                AppColors.brown,
                                                                FontWeight
                                                                    .w500),
                                                          ).paddingSymmetric(
                                                            vertical: 40)
                                                        : ListView.builder(
                                                            itemCount:
                                                                filtercontro
                                                                    .mapresult
                                                                    .length,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    searchLocationCtrl
                                                                        .text = filtercontro
                                                                            .mapresult[index]
                                                                        [
                                                                        'description'];
                                                                    filtercontro
                                                                        .mapresult
                                                                        .clear();
                                                                    filtercontro
                                                                        .getLonLat(
                                                                            searchLocationCtrl.text);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 36,
                                                                  width:
                                                                      Get.width,
                                                                  decoration: BoxDecoration(
                                                                      border: Border(
                                                                          bottom:
                                                                              BorderSide(color: themeContro.isLightMode.value ? Colors.grey.shade200 : AppColors.darkgray2))),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      filtercontro
                                                                              .mapresult[index]
                                                                          [
                                                                          'description'],
                                                                      style: poppinsFont(
                                                                          12,
                                                                          themeContro.isLightMode.value
                                                                              ? AppColors.black
                                                                              : AppColors.white,
                                                                          FontWeight.w500),
                                                                    ),
                                                                  ).paddingSymmetric(
                                                                      horizontal:
                                                                          15),
                                                                ).paddingSymmetric(
                                                                        horizontal:
                                                                            20),
                                                              );
                                                            },
                                                          ),
                                          ),
                                          const SizedBox(height: 30),
                                          //============================================ CATEGORIES
                                          Obx(
                                            () => containerDesign(
                                              image: AppAsstes.category2,
                                              title: "Categories",
                                              searchCtrl: catecontro
                                                  .searchCategoriesCtrl,
                                              onChanged: (p0) {
                                                setState(() {
                                                  catecontro
                                                      .filterSearchPeople();
                                                });
                                              },
                                              child: catecontro.catemodel.value!
                                                      .data!.isNotEmpty
                                                  ? ListView.builder(
                                                      itemCount: catecontro
                                                          .catemodel
                                                          .value!
                                                          .data!
                                                          .length,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      shrinkWrap: true,
                                                      // physics:
                                                      //     const NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final categoryName =
                                                            catecontro
                                                                .catemodel
                                                                .value!
                                                                .data![index]
                                                                .categoryName!;
                                                        final categoryId =
                                                            catecontro
                                                                .catemodel
                                                                .value!
                                                                .data![index]
                                                                .id!
                                                                .toString();
                                                        final isSelected =
                                                            selectedServicesName
                                                                    .isNotEmpty &&
                                                                selectedServicesName
                                                                        .first ==
                                                                    categoryName;
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedServicesName
                                                                  .clear();
                                                              selectedServices
                                                                  .clear();

                                                              selectedServicesName
                                                                  .add(
                                                                      categoryName);
                                                              selectedServices
                                                                  .add(
                                                                      categoryId);
                                                              print(
                                                                  "selectedServicesName:$selectedServicesName");
                                                              print(
                                                                  "selectedServices:$selectedServices");
                                                              catecontro.subcateApi(
                                                                  catId:
                                                                      selectedServices
                                                                          .first);
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 45,
                                                            width: Get.width,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(isSelected ? 5 : 0),
                                                                color: isSelected
                                                                    ? themeContro.isLightMode.value
                                                                        ? Colors.grey.shade200
                                                                        : AppColors.darkgray2
                                                                    : themeContro.isLightMode.value
                                                                        ? Colors.white
                                                                        : Colors.transparent,
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: (index != catecontro.catemodel.value!.data!.length - 1)
                                                                            ? themeContro.isLightMode.value
                                                                                ? Colors.grey.shade200
                                                                                : AppColors.darkgray2
                                                                            : Colors.transparent))),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                catecontro
                                                                    .catemodel
                                                                    .value!
                                                                    .data![
                                                                        index]
                                                                    .categoryName!,
                                                                style: poppinsFont(
                                                                    12,
                                                                    themeContro
                                                                            .isLightMode
                                                                            .value
                                                                        ? AppColors
                                                                            .black
                                                                        : AppColors
                                                                            .colorFFFFFF,
                                                                    isSelected
                                                                        ? FontWeight
                                                                            .w600
                                                                        : FontWeight
                                                                            .w500),
                                                              ),
                                                            ).paddingSymmetric(
                                                                horizontal: 15),
                                                          ).paddingSymmetric(
                                                              horizontal:
                                                                  isSelected
                                                                      ? 15
                                                                      : 20),
                                                        );
                                                      },
                                                    ).paddingSymmetric(
                                                      vertical: 5)
                                                  : Center(
                                                      child: Text(
                                                        "Category Not found",
                                                        style: poppinsFont(
                                                            12,
                                                            AppColors.brown,
                                                            FontWeight.w500),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          //============================================ SUB Categories
                                          Obx(
                                            () => containerDesign(
                                              image: AppAsstes.subcategory,
                                              title: "Subcategories",
                                              searchCtrl: catecontro
                                                  .searchSubCategoriesCtrl,
                                              onChanged: (p0) {
                                                setState(() {
                                                  catecontro
                                                      .filterSearchSubCate();
                                                });
                                              },
                                              child: catecontro
                                                          .issubcat.value ||
                                                      catecontro
                                                              .subcatemodel
                                                              .value!
                                                              .subCategoryData ==
                                                          null
                                                  ? Text(
                                                      "Subcategory Not found",
                                                      style: poppinsFont(
                                                          12,
                                                          AppColors.brown,
                                                          FontWeight.w500),
                                                    ).paddingSymmetric(
                                                      vertical: 40)
                                                  : catecontro
                                                          .subcatemodel
                                                          .value!
                                                          .subCategoryData!
                                                          .isEmpty
                                                      ? Text(
                                                          "Subcategory Not found",
                                                          style: poppinsFont(
                                                              12,
                                                              AppColors.brown,
                                                              FontWeight.w500),
                                                        ).paddingSymmetric(
                                                          vertical: 40)
                                                      : ListView.builder(
                                                          itemCount: catecontro
                                                              .subcatemodel
                                                              .value!
                                                              .subCategoryData!
                                                              .length,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final categorySubName =
                                                                catecontro
                                                                    .subcatemodel
                                                                    .value!
                                                                    .subCategoryData![
                                                                        index]
                                                                    .subcategoryName!;
                                                            final categorySubId =
                                                                catecontro
                                                                    .subcatemodel
                                                                    .value!
                                                                    .subCategoryData![
                                                                        index]
                                                                    .id!
                                                                    .toString();
                                                            final isSelected = selectedSubServicesName
                                                                    .isNotEmpty &&
                                                                selectedSubServicesName
                                                                        .first ==
                                                                    categorySubName;
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedSubServicesName
                                                                      .clear();
                                                                  selectedSubServices
                                                                      .clear();

                                                                  selectedSubServicesName
                                                                      .add(
                                                                          categorySubName);
                                                                  selectedSubServices
                                                                      .add(
                                                                          categorySubId);

                                                                  print(
                                                                      "SubName:$selectedSubServicesName");
                                                                  print(
                                                                      "SubID:$selectedSubServices");
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 45,
                                                                width:
                                                                    Get.width,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(isSelected ? 5 : 0),
                                                                    color: isSelected
                                                                        ? themeContro.isLightMode.value
                                                                            ? Colors.grey.shade200
                                                                            : AppColors.darkgray2
                                                                        : themeContro.isLightMode.value
                                                                            ? Colors.white
                                                                            : Colors.transparent,
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            color: (index != catecontro.subcatemodel.value!.subCategoryData!.length - 1)
                                                                                ? themeContro.isLightMode.value
                                                                                    ? Colors.grey.shade200
                                                                                    : AppColors.darkgray2
                                                                                : Colors.transparent))),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    catecontro
                                                                        .subcatemodel
                                                                        .value!
                                                                        .subCategoryData![
                                                                            index]
                                                                        .subcategoryName!,
                                                                    style: poppinsFont(
                                                                        12,
                                                                        themeContro.isLightMode.value
                                                                            ? AppColors
                                                                                .black
                                                                            : AppColors
                                                                                .colorFFFFFF,
                                                                        isSelected
                                                                            ? FontWeight.w600
                                                                            : FontWeight.w500),
                                                                  ),
                                                                ).paddingSymmetric(
                                                                    horizontal:
                                                                        15),
                                                              ).paddingSymmetric(
                                                                  horizontal:
                                                                      isSelected
                                                                          ? 15
                                                                          : 20),
                                                            );
                                                          },
                                                        ).paddingSymmetric(
                                                          vertical: 5),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                              ).paddingSymmetric(horizontal: 10),
                              const SizedBox(height: 20),
                              priceIndicator(),
                              const SizedBox(height: 20),
                              starDesign(
                                title: "Type",
                                isonOffArrow: isvisible2,
                                onTap: () {
                                  setState(() {
                                    isvisible2 = !isvisible2;
                                  });
                                },
                                child: ListView.builder(
                                  itemCount: itemListType.length,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    // bool isSelected =
                                    //     selectedIndexType == index;
                                    bool isSelected =
                                        selectedType == itemListType[index];
                                    return Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: isSelected
                                              ? themeContro.isLightMode.value
                                                  ? Colors.grey.shade200
                                                  : AppColors.darkgray2
                                              : themeContro.isLightMode.value
                                                  ? Colors.white
                                                  : Colors.transparent,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: isSelected
                                                      ? (index !=
                                                              itemListType
                                                                      .length -
                                                                  1)
                                                          ? themeContro
                                                                  .isLightMode
                                                                  .value
                                                              ? Colors
                                                                  .grey.shade200
                                                              : AppColors
                                                                  .darkgray2
                                                          : Colors.transparent
                                                      : Colors.grey.shade300))),
                                      child: RadioListTile<String>(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0),
                                        dense: true,
                                        title: Text(
                                          itemListType[index],
                                          style: poppinsFont(
                                              12,
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : AppColors.colorFFFFFF,
                                              isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w500),
                                        ),
                                        value: itemListType[index],
                                        groupValue:
                                            selectedType, // This controls selection
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedType = value;
                                            print(
                                                "Selected Type: $selectedType");
                                          });
                                        },
                                        activeColor: AppColors
                                            .blue, // Change color if needed
                                      ),
                                    ).paddingSymmetric(horizontal: 20);
                                  },
                                ).paddingSymmetric(vertical: 10),
                              ),
                              const SizedBox(height: 20),
                              starDesign(
                                title: "Rating",
                                isonOffArrow: isvisible3,
                                onTap: () {
                                  setState(() {
                                    isvisible3 = !isvisible3;
                                  });
                                },
                                child: ListView.builder(
                                  itemCount: itemListRating.length,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    bool isSelected =
                                        selectedIndexRating == index + 1;
                                    return Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              isSelected ? 5 : 0),
                                          color: isSelected
                                              ? themeContro.isLightMode.value
                                                  ? Colors.grey.shade200
                                                  : AppColors.darkgray2
                                              : themeContro.isLightMode.value
                                                  ? Colors.white
                                                  : Colors.transparent,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: (index !=
                                                          itemListRating
                                                                  .length -
                                                              1)
                                                      ? themeContro
                                                              .isLightMode.value
                                                          ? Colors.grey.shade200
                                                          : AppColors.darkgray2
                                                      : Colors.transparent))),
                                      child: RadioListTile<int>(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0),
                                        dense: true,
                                        title: Text(
                                          itemListRating[index],
                                          style: poppinsFont(
                                              12,
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : AppColors.colorFFFFFF,
                                              isSelected
                                                  ? FontWeight.w500
                                                  : FontWeight.w600),
                                        ),
                                        value: index + 1,
                                        groupValue: selectedIndexRating,
                                        onChanged: (int? value) {
                                          setState(() {
                                            selectedIndexRating = value;
                                            print(
                                                "RatingStar:$selectedIndexRating");
                                          });
                                        },
                                        activeColor: AppColors
                                            .blue, // Change color if needed
                                      ),
                                    ).paddingSymmetric(horizontal: 20);
                                  },
                                ).paddingSymmetric(vertical: 10),
                              )
                            ],
                          ).paddingOnly(bottom: 25),
                        ),
                      ),
                      // const SizedBox(height: 25)
                      Obx(() {
                        return filtercontro.isfilter.value
                            ? commonLoading()
                            : CustomButtom(
                                    title: "Apply",
                                    onPressed: () {
                                      print("catId:$selectedServices");
                                      print("subCatId:$selectedSubServices");
                                      print("type:$selectedType");
                                      print("rivstar:$selectedIndexRating");
                                      print(
                                          "selectedService:$selectedServices");

                                      filtercontro.isnavfilter.value = false;
                                      filtercontro.filterApi(
                                        catId: selectedServices.isNotEmpty
                                            ? selectedServices.first
                                            : "", // Empty string if not selected
                                        catName: selectedServicesName.isNotEmpty
                                            ? selectedServicesName.first
                                            : "",
                                        subCatId: selectedSubServices.isNotEmpty
                                            ? selectedSubServices.first
                                            : "",
                                        subCatName:
                                            selectedSubServicesName.isNotEmpty
                                                ? selectedSubServicesName.first
                                                : "",
                                        type: selectedType ?? "",
                                        price: filtercontro.circleRadius
                                            .round()
                                            .toString(),
                                        rivstar: selectedIndexRating,
                                        selectedService: selectedServices,
                                        page: page.toString(),
                                      );
                                    },
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 45,
                                    width: Get.width)
                                .paddingSymmetric(horizontal: 30);
                      }),
                      const SizedBox(height: 27)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        // DefaultTabController(
        //     length: 2,
        //     initialIndex: 0,
        //     child: Stack(
        //       clipBehavior: Clip.none,
        //       children: [
        //         Container(
        //           height: Get.height * 0.45,
        //           width: Get.width,
        //           decoration: const BoxDecoration(
        //             color: Colors.white,
        //           ),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [sizeBoxHeight(45), profiletab()],
        //           ),
        //         ),
        //       ],
        //     )),
        );
  }

  containerDesign({
    required String image,
    required String title,
    required TextEditingController searchCtrl,
    required Function(String) onChanged,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeContro.isLightMode.value
              ? Colors.white
              : AppColors.darkgray1,
          border: Border.all(
              color: themeContro.isLightMode.value
                  ? Colors.grey.shade300
                  : const Color(0xff0000001a))),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 45,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: themeContro.isLightMode.value
                    ? Colors.white
                    : AppColors.darkgray2,
                border: Border.all(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 16,
                  color: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.darkgray3,
                ),
                const SizedBox(width: 5),
                label(
                  title,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.darkgray3,
                )
              ],
            ).paddingSymmetric(horizontal: 10),
          ).paddingSymmetric(horizontal: 10),
          const SizedBox(height: 10),
          searchBar(searchCtrl: searchCtrl, onChanged: onChanged)
              .paddingSymmetric(horizontal: 15),
          const SizedBox(height: 4),
          ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300), child: child)
        ],
      ),
    ).paddingSymmetric(horizontal: 20);
  }

  Widget searchBar(
      {required TextEditingController searchCtrl,
      required Function(String) onChanged}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      height: 40,
      child: TextField(
        controller: searchCtrl,
        onChanged: onChanged,
        style: poppinsFont(
            13,
            themeContro.isLightMode.value ? Colors.black : AppColors.white,
            FontWeight.w500),
        cursorColor:
            themeContro.isLightMode.value ? AppColors.blue : AppColors.white,
        readOnly: false,
        decoration: InputDecoration(
            fillColor: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkGray,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? AppColors.bluee4
                        : AppColors.darkGray,
                    width: 1.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? AppColors.bluee4
                        : AppColors.darkGray,
                    width: 1.5)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.greyColor, width: 5)),
            hintText: "Search...",
            hintStyle: poppinsFont(
                13,
                themeContro.isLightMode.value
                    ? Colors.black
                    : AppColors.colorFFFFFF,
                FontWeight.w500),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 11, top: 11),
              child: Image.asset(
                AppAsstes.search,
                color: AppColors.blue,
                height: 10,
              ),
            )),
      ).paddingSymmetric(horizontal: 10),
    );
  }

  priceIndicator() {
    return Container(
      height: Get.height / 6,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              themeContro.isLightMode.value ? Colors.white : AppColors.darkGray,
          boxShadow: [
            BoxShadow(
                blurRadius: 14.4,
                offset: const Offset(2, 4),
                spreadRadius: 0,
                color: themeContro.isLightMode.value
                    ? Colors.grey.shade300
                    : AppColors.darkShadowColor)
          ]),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Image.asset(
                    AppAsstes.doller,
                    height: 20,
                    color: themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.colorFFFFFF,
                  )),
              TextSpan(
                  text: "  Pricing Filter",
                  style: poppinsFont(
                      13,
                      themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.colorFFFFFF,
                      FontWeight.w600))
            ])),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.blue,
                inactiveTrackColor: const Color.fromRGBO(155, 155, 155, 1),
                thumbColor: AppColors.blue,
                overlayColor: AppColors.blue.withOpacity(0.2),
                valueIndicatorColor: AppColors.blue,
              ),
              child: Slider(
                value: filtercontro.circleRadius.toDouble(),
                min: filtercontro.minPrice.value,
                max: filtercontro.maxPrice.value,
                divisions: (filtercontro.maxPrice.value -
                        filtercontro.minPrice.value) ~/
                    100,
                onChanged: (double value) {
                  setState(() {
                    filtercontro.circleRadius.value = value;
                    print("Price:${filtercontro.circleRadius.value}");
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                label('\$100',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 10)),
                label(
                  "\$${filtercontro.circleRadius.round()}",
                  style: const TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 10),
                ),
                label("\$10000",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 10)),
              ],
            ).paddingSymmetric(horizontal: 10),
            // SliderTheme(
            //   data: SliderTheme.of(context).copyWith(
            //       activeTrackColor: AppColors.blue,
            //       inactiveTrackColor: const Color.fromRGBO(155, 155, 155, 1),
            //       thumbColor: AppColors.blue,
            //       overlayColor: AppColors.blue.withOpacity(0.2),
            //       valueIndicatorColor: AppColors.blue,
            //       showValueIndicator: ShowValueIndicator.never),
            //   child: RangeSlider(
            //     values: rangeValues,
            //     min: minPrice,
            //     max: maxPrice,
            //     divisions: ((maxPrice - minPrice) / 100)
            //         .round(), // Creates step divisions
            //     labels: RangeLabels(
            //       '\$${rangeValues.start.round()}',
            //       '\$${rangeValues.end.round()}',
            //     ),
            //     onChanged: (RangeValues values) {
            //       setState(() {
            //         rangeValues = values;
            //         print("rangeValues:$rangeValues");
            //       });
            //     },
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     label('\$${rangeValues.start.round()}',
            //         style: const TextStyle(
            //             color: Colors.grey,
            //             fontWeight: FontWeight.w600,
            //             fontSize: 10)),
            //     label("\$${rangeValues.end.round()}",
            //         style: const TextStyle(
            //             color: Colors.grey,
            //             fontWeight: FontWeight.w600,
            //             fontSize: 10)),
            //   ],
            // ).paddingSymmetric(horizontal: 10),
          ],
        ).paddingAll(20);
      }),
    ).paddingSymmetric(horizontal: 10);
  }

  starDesign({
    required String title,
    required bool isonOffArrow,
    required Function() onTap,
    required Widget child,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeContro.isLightMode.value
                ? AppColors.white
                : AppColors.darkGray,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14.4,
                  offset: const Offset(2, 4),
                  spreadRadius: 0,
                  color: themeContro.isLightMode.value
                      ? Colors.grey.shade300
                      : AppColors.darkShadowColor)
            ]),
        child: Column(
          children: [
            Container(
              height: 45,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: themeContro.isLightMode.value
                      ? Colors.white
                      : AppColors.darkgray2,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 14.4,
                        offset: const Offset(2, 4),
                        spreadRadius: 0,
                        color: themeContro.isLightMode.value
                            ? Colors.grey.shade300
                            : AppColors.darkShadowColor)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(AppAsstes.Star_border,
                          height: 20,
                          color: themeContro.isLightMode.value
                              ? Colors.black
                              : AppColors.colorFFFFFF),
                      const SizedBox(width: 5),
                      Text(
                        title,
                        style: poppinsFont(
                            13.5,
                            themeContro.isLightMode.value
                                ? Colors.black
                                : AppColors.colorFFFFFF,
                            FontWeight.w600),
                      )
                    ],
                  ),
                  Icon(
                    isonOffArrow
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up_outlined,
                    color: themeContro.isLightMode.value
                        ? Colors.black
                        : AppColors.colorFFFFFF,
                  )
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
            isonOffArrow
                ? ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: child)
                : const SizedBox.shrink()
          ],
        ),
      ).paddingSymmetric(horizontal: 10),
    );
  }

  Widget profiletab() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: Get.width,
            decoration: const BoxDecoration(),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    offset: const Offset(
                        0.0, 2.0), // shadow direction: bottom right
                  )
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1.0, color: AppColors.blue),
                    insets: EdgeInsets.symmetric(horizontal: 2.0)),
                dividerColor: Colors.transparent,
                labelColor: AppColors.blue,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                indicatorColor: AppColors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(child: Text('   Categories   ')),
                  Tab(child: Text('    Ratings    ')),
                ],
              ),
            ).paddingSymmetric(horizontal: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SizedBox(
              height: Get.height * 0.45,
              child: TabBarView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(child: categories_list()),
                  SingleChildScrollView(child: ratting())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Set<String> selectedServices = {};
  Set<String> selectedServicesName = {};

  Set<String> selectedSubServices = {};
  Set<String> selectedSubServicesName = {};

  Widget categories_list() {
    return Obx(() {
      return Column(
        children: [
          Wrap(
            spacing: 11.0,
            runSpacing: 3.0,
            children: catecontro.catelist.map((category) {
              final isSelected =
                  selectedServicesName.contains(category.categoryName);

              return ChoiceChip(
                showCheckmark: false,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(category.categoryName
                        .toString()), // Displaying category name
                    if (isSelected)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.close,
                          color: AppColors.black,
                          size: 14,
                        ),
                      ),
                  ],
                ),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filtercontro.selectedCategories.clear();
                      selectedServicesName.add(category.categoryName!);

                      selectedServices.add(category.id!.toString());
                      filtercontro.selectedCategories
                          .addAll(selectedServicesName);
                    } else {
                      selectedServicesName.remove(category.categoryName!);
                      selectedServices.remove(category.id!.toString());
                      filtercontro.selectedCategories.clear();
                    }
                    // Update the controller's category value
                    // filtercontro.selectedCategories.value =
                    //     selectedServices.toList();

                    print("Category Name :$selectedServicesName");
                    print('Selected Category ID: $selectedServices');
                    print("****${filtercontro.selectedCategories}");
                  });
                },
                selectedColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.black : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: isSelected ? AppColors.blue : Colors.grey.shade200,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              );
            }).toList(),
          ),
          sizeBoxHeight(10),
          button(), // The button for sending the filter
          sizeBoxHeight(10),
        ],
      ).paddingSymmetric(horizontal: 20);
    });
  }

  List<String> rattings = [
    "1 Star",
    "2 Star",
    "3 Star",
    "4 Star",
    "5 Star",
  ];

  String? selectedRatting; // No pre-selection

  Widget ratting() {
    return Column(
      children: [
        Wrap(
          spacing: 20.0,
          runSpacing: 3.0,
          children: rattings.map((service) {
            return ChoiceChip(
              showCheckmark: false,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(service),
                  if (selectedRatting == service)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                        size: 14, // Adjust the size of the icon if needed
                      ),
                    ),
                ],
              ),
              selected: selectedRatting == service,
              onSelected: (bool selected) {
                setState(() {
                  // Toggle selection
                  selectedRatting = selected ? service : null;
                });
              },
              selectedColor: Colors.white,
              labelStyle: TextStyle(
                color:
                    selectedRatting == service ? AppColors.black : Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
                fontSize: 12,
              ),
              side: BorderSide(
                color: selectedRatting == service
                    ? AppColors.blue
                    : Colors.grey.shade200,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          }).toList(),
        ),
        sizeBoxHeight(50),
        button(),
        sizeBoxHeight(10),
      ],
    ).paddingSymmetric(horizontal: 20);
  }

  Widget button() {
    return Obx(() {
      return filtercontro.isfilter.value
          ? commonLoading()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(150),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: label(
                        'Cancel',
                        fontSize: 14,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                sizeBoxWidth(30),
                GestureDetector(
                  // onTap: () async {
                  //   if (selectedRatting != null) {
                  //     int ratingValue =
                  //         int.parse(selectedRatting!.split(" ")[0]);

                  //     // Store the selected rating
                  //     filtercontro.selectedRating.value = ratingValue;
                  //     await filtercontro.filterApi(
                  //       catId: widget.catid,
                  //       widget.catid.toString(),
                  //       rivstar: ratingValue.toString(),
                  //       selectedService: selectedService,
                  //       page: page.toString(),
                  //     );

                  //     // Set the filter navigation state to true
                  //     filtercontro.isnavfilter.value = true;

                  //     // Navigate back to the previous screen
                  //     Navigator.pop(context);
                  //   } else {
                  //     print("No rating selected");
                  //   }
                  // },

                  // onTap: () async {
                  //   // Default rating value if none is selected
                  //   setState(() async {
                  //     int? ratingValue = selectedRatting != null
                  //         ? int.parse(selectedRatting!.split(" ")[0])
                  //         : null;

                  //     // Store the selected rating (if any)
                  //     if (ratingValue != null) {
                  //       filtercontro.selectedRating.value = ratingValue;
                  //     }

                  //     // Call the filter API with or without a rating
                  //     await filtercontro.filterApi(
                  //       catId: widget.catid,
                  //       widget.catid.toString(),
                  //       rivstar: ratingValue?.toString() ??
                  //           0, // Pass empty string if no rating
                  //       selectedService: selectedServices,
                  //       page: page.toString(),
                  //     );

                  //     // Set the filter navigation state to true
                  //     filtercontro.isnavfilter.value = true;
                  //     filtercontro.filtermarkerList.clear();
                  //     filtercontro.addMarker1();

                  //     // Navigate back to the previous screen
                  //     Navigator.pop(context);
                  //   });
                  // },

                  // onTap: () async {
                  //   // Default rating value if none is selected
                  //   int? ratingValue = selectedRatting != null
                  //       ? int.parse(selectedRatting!.split(" ")[0])
                  //       : null;

                  //   // Store the selected rating (if any), or reset it to 0 if none
                  //   filtercontro.selectedRating.value = ratingValue ?? 0;

                  //   // Debug category ID
                  //   print('Selected Category ID: ${widget.catid}');

                  //   // Call the filter API with or without a rating
                  //   await filtercontro.filterApi(
                  //     catId: widget.catid.toString(), // Pass catId as a string
                  //     rivstar: ratingValue?.toString() ??
                  //         '', // Pass empty string if no rating
                  //     selectedService: selectedServices,
                  //     page: page.toString(),
                  //   );

                  //   // Set the filter navigation state to true
                  //   filtercontro.isnavfilter.value = true;
                  //   filtercontro.filtermarkerList.clear();
                  //   filtercontro.addMarker1();

                  //   // Navigate back to the previous screen
                  //   Navigator.pop(context);
                  // },

                  onTap: () async {
                    // Default rating value if none is selected
                    int? ratingValue = selectedRatting != null
                        ? int.parse(selectedRatting!.split(" ")[0])
                        : null;

                    // Store the selected rating (if any), or reset it to 0 if none
                    filtercontro.selectedRating.value = ratingValue ?? 0;

                    // Convert selectedServices to a comma-separated string
                    String selectedCategories = selectedServices.join(',');

                    // Debug selected categories
                    print('Selected Categories: $selectedCategories');

                    // Call the filter API with multiple categories
                    await filtercontro.filterApi(
                      catId:
                          selectedCategories, // Pass selected categories as a comma-separated string
                      rivstar: ratingValue, // Pass empty string if no rating
                      selectedService:
                          selectedServices, // Pass the original Set if needed
                      page: page.toString(),
                    );

                    // Set the filter navigation state to true
                    filtercontro.isnavfilter.value = true;
                    filtercontro.filtermarkerList.clear();
                    filtercontro.addMarker1();

                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  },

                  child: Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(150),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: label(
                        'Send',
                        fontSize: 14,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            );
    });
  }
}
