// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/service_controller.dart';
import 'package:nlytical_app/models/vendor_models/service_list_model.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/add_srvice.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_detail.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/my_widget.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class AllServiceScreen extends StatefulWidget {
  const AllServiceScreen({super.key});

  @override
  State<AllServiceScreen> createState() => _AllServiceScreenState();
}

class _AllServiceScreenState extends State<AllServiceScreen> {
  ServiceController serviceController = Get.find();

  @override
  void initState() {
    serviceController.serviceListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    Row(
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
                        Text("All Service",
                            style: poppinsFont(
                                20, AppColors.white, FontWeight.w500))
                      ],
                    ),
                    sizeBoxWidth(190),
                    GestureDetector(
                        onTap: () {
                          serviceController.serviceIndex.value = -1;
                          Get.to(() => const AddSrvice(isvalue: false));
                        },
                        child: Image.asset(AppAsstes.addservice, height: 24))
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
                  child: Column(
                    children: [
                      sizeBoxHeight(5),
                      Expanded(
                        child: SingleChildScrollView(child: Obx(() {
                          return serviceController.isGetData.value &&
                                  serviceController.serviceList.isEmpty
                              ? ListView.builder(
                                  itemCount: 3,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return shimmerLoader(
                                            getProportionateScreenHeight(280),
                                            Get.width,
                                            10)
                                        .paddingOnly(
                                            bottom: 20, left: 20, right: 20);
                                  })
                              : serviceController.serviceList.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          serviceController.serviceList.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return containerDesing(
                                                serviceController
                                                    .serviceList[index],
                                                index)
                                            .paddingOnly(bottom: 20);
                                      },
                                    ).paddingSymmetric(horizontal: 20)
                                  : Column(
                                      children: [
                                        sizeBoxHeight(300),
                                        Center(
                                          child: Text(
                                            "No Services is Added",
                                            style: poppinsFont(
                                                12,
                                                AppColors.grey1,
                                                FontWeight.w500),
                                          ),
                                        ),
                                        sizeBoxHeight(30),
                                        CustomButtom(
                                            title: "Add Service",
                                            onPressed: () {
                                              serviceController
                                                  .serviceIndex.value = -1;
                                              Get.to(() => const AddSrvice(
                                                  isvalue: false));
                                            },
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            height:
                                                getProportionateScreenHeight(
                                                    45),
                                            width: getProportionateScreenWidth(
                                                200)),
                                      ],
                                    );
                        })),
                      ),
                      sizeBoxHeight(25),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget containerDesing(StoreList serviceList, index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Details());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: getProportionateScreenHeight(280),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  color: themeContro.isLightMode.value
                      ? Colors.grey.shade300
                      : const Color(0xff0000000f),
                  offset: const Offset(0.0, 3.0),
                ),
              ],
              image: DecorationImage(
                  image: serviceList.storeImages!.isNotEmpty
                      ? NetworkImage(serviceList.storeImages![0].url!)
                      : const AssetImage(AppAsstes.add_business1),
                  onError: (exception, stackTrace) => Image.asset(
                        AppAsstes.add_business1,
                        height: getProportionateScreenHeight(27),
                        width: getProportionateScreenWidth(27),
                      ),
                  fit: BoxFit.fill),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Positioned.fill(
              top: 20,
              bottom: -1,
              child: FeaturedScreen(
                sname: serviceList.storeName.toString(),
                price: serviceList.price.toString(),
                desc: serviceList.storeDescription.toString(),
              )),
          Positioned(
              right: 10,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  // edit_and_review(index);
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: AlertDialog(
                            alignment: Alignment.bottomCenter,
                            insetPadding: const EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            contentPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            content: StatefulBuilder(builder: (context, kk) {
                              return SingleChildScrollView(
                                child: Container(
                                  height: getProportionateScreenHeight(110),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: themeContro.isLightMode.value
                                          ? AppColors.white
                                          : AppColors.darkGray,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      sizeBoxHeight(3),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          serviceController.serviceIndex.value =
                                              index;
                                          Get.to(() => const AddSrvice(
                                                  isvalue: true))!
                                              .then((_) {
                                            setState(() {
                                              serviceController.serviceListModel
                                                  .refresh();
                                              serviceController.serviceList
                                                  .refresh();
                                              // Get.back();
                                            });
                                          });
                                          // Get.to(AddSrvice());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(11.0),
                                          child: Row(
                                            children: [
                                              sizeBoxWidth(10),
                                              Image.asset(
                                                'assets/images/edit-2.png',
                                                color: themeContro
                                                        .isLightMode.value
                                                    ? AppColors.blue
                                                    : AppColors.white,
                                                height: 20,
                                              ),
                                              sizeBoxWidth(15),
                                              label(
                                                'Edit',
                                                fontSize: 14,
                                                textColor: themeContro
                                                        .isLightMode.value
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      sizeBoxHeight(3),
                                      Divider(
                                        color: themeContro.isLightMode.value
                                            ? const Color(0xffF1F1F1)
                                            : AppColors.grey1,
                                        height: 1,
                                      ),
                                      sizeBoxHeight(2),
                                      InkWell(
                                        onTap: () {
                                          serviceController.serviceList
                                              .removeAt(index);
                                          serviceController.deleteserviceApi(
                                              storeid:
                                                  serviceList.id.toString());
                                          Get.back();
                                          snackBar(
                                              'Service deleted successfully');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(11.0),
                                          child: Row(
                                            children: [
                                              sizeBoxWidth(10),
                                              Image.asset(
                                                'assets/images/trash1.png',
                                                height: 20,
                                                color: themeContro
                                                        .isLightMode.value
                                                    ? AppColors.blue
                                                    : AppColors.white,
                                              ),
                                              sizeBoxWidth(15),
                                              label(
                                                'Delete',
                                                fontSize: 14,
                                                textColor: themeContro
                                                        .isLightMode.value
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      });
                },
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: const Icon(
                    Icons.more_vert,
                    color: AppColors.blue,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  // edit_and_review(index) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  //           child: AlertDialog(
  //             alignment: Alignment.bottomCenter,
  //             insetPadding:
  //                 const EdgeInsets.only(bottom: 20, left: 10, right: 10),
  //             contentPadding: EdgeInsets.zero,
  //             backgroundColor: Colors.transparent,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             content: StatefulBuilder(builder: (context, kk) {
  //               return SingleChildScrollView(
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       height: getProportionateScreenHeight(120),
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                           color: AppColors.white,
  //                           borderRadius: BorderRadius.circular(15)),
  //                       child: Column(
  //                         children: [
  //                           sizeBoxHeight(3),
  //                           InkWell(
  //                             onTap: () {
  //                               serviceController.serviceIndex.value = index;
  //                               Get.to(() => const AddSrvice())!.then((_) {
  //                                 setState(() {
  //                                   serviceController.serviceListModel
  //                                       .refresh();
  //                                   serviceController.serviceList.refresh();
  //                                   Get.back();
  //                                 });
  //                               });
  //                               // Get.to(AddSrvice());
  //                             },
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(11.0),
  //                               child: Row(
  //                                 children: [
  //                                   sizeBoxWidth(10),
  //                                   Image.asset(
  //                                     'assets/images/edit-2.png',
  //                                     color: AppColors.blue,
  //                                     height: 20,
  //                                   ),
  //                                   sizeBoxWidth(15),
  //                                   label(
  //                                     'Edit',
  //                                     fontSize: 14,
  //                                     textColor: AppColors.black,
  //                                     fontWeight: FontWeight.w400,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           sizeBoxHeight(3),
  //                           const Divider(
  //                             color: Color(0xffF1F1F1),
  //                             height: 1,
  //                           ),
  //                           sizeBoxHeight(2),
  //                           GestureDetector(
  //                             onTap: () {
  //                               // serviceController.serviceList.removeAt(index);
  //                               serviceController.deleteserviceApi(
  //                                   storeid: serviceList.id.toString());
  //                             },
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(11.0),
  //                               child: Row(
  //                                 children: [
  //                                   sizeBoxWidth(10),
  //                                   Image.asset(
  //                                     'assets/images/trash1.png',
  //                                     height: 20,
  //                                     color: AppColors.blue,
  //                                   ),
  //                                   sizeBoxWidth(15),
  //                                   label(
  //                                     'Delete',
  //                                     fontSize: 14,
  //                                     textColor: AppColors.black,
  //                                     fontWeight: FontWeight.w400,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }),
  //           ),
  //         );
  //       });
  // }
}
