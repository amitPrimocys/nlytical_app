// ignore_for_file: curly_braces_in_flow_control_structures, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/support_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  SupportController supportfaqcontro = Get.put(SupportController());
  // List<bool> isExpandedList = [];
  final searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    supportfaqcontro.faqApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        child: Stack(
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
                    sizeBoxWidth(130),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "FAQ",
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
            Positioned.fill(
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
                  child: Obx(() {
                    return supportfaqcontro.isLoading.value
                        //  &&
                        //         supportfaqcontro.faqmodel.value!.data!.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.blue,
                          ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizeBoxHeight(20),
                              searchBar(),
                              sizeBoxHeight(20),
                              Expanded(
                                child: supportfaqcontro
                                            .faqmodel.value?.data?.isNotEmpty ??
                                        false
                                    ? (_searchResult.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: _searchResult.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              return faqlistdata(index);
                                            },
                                          )
                                        : searchController.text
                                                .trim()
                                                .isNotEmpty
                                            ? faqsempty()
                                            : ListView.builder(
                                                itemCount: supportfaqcontro
                                                    .faqmodel
                                                    .value
                                                    ?.data
                                                    ?.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  return faqlistdata(index);
                                                },
                                              ))
                                    : faqsempty(),
                              )
                            ],
                          );
                  }),
                ))
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 0,
      child: TextField(
        controller: searchController,
        cursorColor: Colors.grey.shade400,
        onChanged: onSearchTextChanged,
        style: poppinsFont(
            13,
            themeContro.isLightMode.value ? Colors.black : AppColors.white,
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
                borderSide: themeContro.isLightMode.value
                    ? BorderSide.none
                    : const BorderSide(color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
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
      ).paddingSymmetric(horizontal: 18),
    );
  }

  Widget faqsempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(Get.height * 0.05),
          Image.asset(
            "assets/images/empty_image.png",
            height: 75,
          ),
          sizeBoxHeight(10),
          label("No Faq's Are Found",
              fontSize: 17,
              textColor: AppColors.black,
              fontWeight: FontWeight.w500)
        ],
      ),
    );
  }

  Widget faqlistdata(index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 270,
              child: label(
                  supportfaqcontro.faqmodel.value!.data![index].question
                      .toString(),
                  maxLines: 2,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  textColor: themeContro.isLightMode.value
                      ? Colors.black
                      : AppColors.white),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  supportfaqcontro.isExpandedList[index] =
                      !supportfaqcontro.isExpandedList[index];
                });
              },
              child: Icon(
                supportfaqcontro.isExpandedList[index]
                    ? Icons.remove
                    : Icons.add,
                color: themeContro.isLightMode.value
                    ? Colors.black
                    : AppColors.white,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: supportfaqcontro.isExpandedList[index]
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: themeContro.isLightMode.value
                    ? Colors.grey.shade300
                    : AppColors.darkblue),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: label(
                supportfaqcontro.faqmodel.value!.data![index].answer.toString(),
                fontSize: 9,
                maxLines: 10,
                fontWeight: FontWeight.w500,
                textColor: themeContro.isLightMode.value
                    ? Colors.black
                    : AppColors.white,
              ),
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
        if (index != supportfaqcontro.faqmodel.value!.data!.length - 1)
          const Divider(color: AppColors.darkGray, thickness: 2)
              .paddingSymmetric(horizontal: 20),
        // sizeBoxHeight(20),
      ],
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
                "FAQ's",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }

  void onSearchTextChanged(String text) {
    _searchResult.clear();

    if (text.isEmpty) {
      setState(() {
        _searchResult.addAll(supportfaqcontro.faqmodel.value!.data!);
      });
      return;
    }

    for (var userDetail in supportfaqcontro.faqmodel.value!.data!) {
      if (userDetail.question != null) if (userDetail.question!
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResult.add(userDetail);
      }
    }

    setState(() {});
  }
}

List _searchResult = [];
