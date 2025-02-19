// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/categories_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/filter_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
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
    fetchRestaurants();
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
          rivstar: ratingValue.toString(),
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: Get.height * 0.45,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [sizeBoxHeight(45), profiletab()],
                  ),
                ),
                Positioned(
                    top: -30,
                    child: Container(
                      height: 58,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                              offset: const Offset(
                                  0.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                              topRight: Radius.circular(22))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          label(
                            'Filter',
                            fontSize: 18,
                            textAlign: TextAlign.center,
                            textColor: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.brown,
                              size: 25,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 150, right: 20),
                    ))
              ],
            ),
          ],
        ));
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

  // Widget categories() {
  //   return Column(
  //     children: [
  //       sizeBoxHeight(10),
  //       Container(
  //         height: getProportionateScreenHeight(35),
  //         width: getProportionateScreenWidth(90),
  //         decoration: BoxDecoration(
  //             border: Border.all(
  //               color: AppColors.blue,
  //             ),
  //             borderRadius: BorderRadius.circular(6)),
  //         child: Center(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               label('5 Star',
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w400,
  //                   textColor: Colors.black),
  //               sizeBoxWidth(8),
  //               const Icon(
  //                 Icons.close,
  //                 color: Colors.grey,
  //                 size: 10,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       Spacer(),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           GestureDetector(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: Container(
  //               height: getProportionateScreenHeight(50),
  //               width: getProportionateScreenWidth(150),
  //               decoration: BoxDecoration(
  //                   color: AppColors.white,
  //                   border: Border.all(color: AppColors.blue),
  //                   borderRadius: BorderRadius.circular(12)),
  //               child: Center(
  //                 child: label(
  //                   'Cancel',
  //                   fontSize: 14,
  //                   textColor: Colors.black,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           sizeBoxWidth(30),
  //           GestureDetector(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: Container(
  //               height: getProportionateScreenHeight(50),
  //               width: getProportionateScreenWidth(150),
  //               decoration: BoxDecoration(
  //                   color: AppColors.blue,
  //                   borderRadius: BorderRadius.circular(12)),
  //               child: Center(
  //                 child: label(
  //                   'Send',
  //                   fontSize: 14,
  //                   textColor: Colors.white,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       )
  //     ],
  //   );
  // }

  // String? selectedService;

  // Widget categories_list() {
  //   return Column(
  //     children: [
  //       Wrap(
  //         spacing: 11.0,
  //         runSpacing: 3.0,
  //         children: catecontro.catelist.map((category) {
  //           return ChoiceChip(
  //             showCheckmark: false,
  //             label: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(category.categoryName
  //                     .toString()), // Displaying category name
  //                 if (selectedService == category.categoryName)
  //                   const Padding(
  //                     padding: EdgeInsets.only(left: 8.0),
  //                     child: Icon(
  //                       Icons.close,
  //                       color: AppColors.black,
  //                       size: 14,
  //                     ),
  //                   ),
  //               ],
  //             ),
  //             selected: selectedService == category.categoryName,
  //             onSelected: (bool selected) {
  //               widget.catid = category.id!.toString();
  //               setState(() {
  //                 selectedService = selected ? category.categoryName : null;
  //                 filtercontro.selectedCategory.value = selectedService ??
  //                     ''; // Update the controller's category value
  //               });
  //             },
  //             selectedColor: Colors.white,
  //             labelStyle: TextStyle(
  //               color: selectedService == category.categoryName
  //                   ? AppColors.black
  //                   : Colors.black,
  //               fontWeight: FontWeight.w400,
  //               fontFamily: "Poppins",
  //               fontSize: 12,
  //             ),
  //             side: BorderSide(
  //               color: selectedService == category.categoryName
  //                   ? AppColors.blue
  //                   : Colors.grey.shade200,
  //             ),
  //             backgroundColor: Colors.white,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8.0),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //       sizeBoxHeight(10),
  //       button(), // The button for sending the filter
  //       sizeBoxHeight(10),
  //     ],
  //   ).paddingSymmetric(horizontal: 20);
  // }

  Set<String> selectedServices = {};
  Set<String> selectedServicesName = {};

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
          ? loader()
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
                      rivstar: ratingValue?.toString() ??
                          '', // Pass empty string if no rating
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
