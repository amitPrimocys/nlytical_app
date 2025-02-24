// ignore_for_file: must_be_immutable, prefer_const_constructors, override_on_non_overriding_member, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/controllers/vendor_controllers/campaign_controller.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/sponsor/budget_duration.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/sponsor/sponsor_explor.dart';
import 'package:nlytical_app/utils/global.dart';

class AddCampaign extends StatefulWidget {
  String? latt;
  String? lonn;
  String? vendorid;
  String? serviceid;
  String? addrss;
  AddCampaign(
      {super.key,
      this.latt,
      this.lonn,
      this.vendorid,
      this.serviceid,
      this.addrss});

  @override
  State<AddCampaign> createState() => _AddCampaignState();
}

class _AddCampaignState extends State<AddCampaign> {
  CampaignController campaignController = Get.put(CampaignController());

  @override
  void initState() {
    campaignController.GetCampaignApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? AppColors.white
          : AppColors.darkMainBlack,
      bottomNavigationBar: Obx(() {
        return campaignController.getLoading.value
            ? SizedBox.shrink()
            : campaignController.camplist.isNotEmpty
                ? BottomAppBar(
                    color: themeContro.isLightMode.value
                        ? Colors.transparent
                        : AppColors.darkMainBlack,
                    height: 70,
                    child: button(),
                  ).paddingOnly(bottom: 30)
                : SizedBox.shrink();
      }),
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
                    sizeBoxWidth(80),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Add Campaign",
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
                  child: Obx(() {
                    return campaignController.getLoading.value &&
                            campaignController.camplist.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                            color: AppColors.blue,
                          ))
                        : campaignController.camplist.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sizeBoxHeight(20),
                                  GestureDetector(
                                    onTap: () {
                                      // Get.to(const SelectPayment());
                                      Get.to(() => SponsorExplor(
                                            latt: widget.latt,
                                            lonn: widget.lonn,
                                            serviceid: widget.serviceid,
                                            vendorid: widget.vendorid,
                                            addrss: widget.addrss,
                                          ));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/add.png',
                                              height: 20,
                                            ),
                                            sizeBoxWidth(5),
                                            label('Add New Campaign',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                textColor: Colors.white),
                                          ],
                                        ),
                                      ),
                                    ).paddingSymmetric(
                                      horizontal: 20,
                                    ),
                                  ),
                                  sizeBoxHeight(20),
                                  label('Campaigns',
                                          fontSize: 18,
                                          textColor:
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : AppColors.white,
                                          fontWeight: FontWeight.w600)
                                      .paddingSymmetric(horizontal: 20),
                                  sizeBoxHeight(10),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          campaignController.camplist.length,
                                      shrinkWrap:
                                          true, // Still needed for proper rendering
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            campaignController
                                                    .selectedIndex.value =
                                                index; // Update selected campaign
                                          },
                                          child: Container(
                                                  height: 50,
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.white
                                                        : AppColors.darkGray,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        blurRadius: 14,
                                                        spreadRadius: 0,
                                                        offset:
                                                            const Offset(4, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Obx(
                                                            () => Container(
                                                              height: 18,
                                                              width: 18,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .blue,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child:
                                                                    Container(
                                                                  height: 8,
                                                                  width: 8,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: campaignController.selectedIndex.value ==
                                                                            index
                                                                        ? AppColors
                                                                            .blue // Highlight the selected item
                                                                        : Colors
                                                                            .transparent,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          sizeBoxWidth(10),
                                                          label(
                                                            campaignController
                                                                .camplist[index]
                                                                .campaignName
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: themeContro
                                                                      .isLightMode
                                                                      .value
                                                                  ? Colors.black
                                                                  : AppColors
                                                                      .white,
                                                            ),
                                                          ),
                                                          // sizeBoxWidth(30),
                                                        ],
                                                      ).paddingSymmetric(
                                                          horizontal: 10),
                                                      SizedBox(
                                                        width: 150,
                                                        child: label(
                                                          campaignController
                                                              .camplist[index]
                                                              .address
                                                              .toString(),
                                                          maxLines: 2,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromRGBO(
                                                                    123,
                                                                    123,
                                                                    123,
                                                                    1),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ).paddingOnly(right: 5)

                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.spaceBetween,
                                                  //   children: [
                                                  //     Row(
                                                  //       children: [
                                                  //         GestureDetector(
                                                  //             onTap: () {
                                                  //               campaignController
                                                  //                           .selectedList[
                                                  //                       index] =
                                                  //                   !campaignController
                                                  //                           .selectedList[
                                                  //                       index];
                                                  //             },
                                                  //             child: Container(
                                                  //               height: 18,
                                                  //               width: 18,
                                                  //               decoration: BoxDecoration(
                                                  //                 shape: BoxShape.circle,
                                                  //                 border: Border.all(
                                                  //                   color: AppColors.blue,
                                                  //                   width: 1,
                                                  //                 ),
                                                  //               ),
                                                  //               child: Padding(
                                                  //                 padding:
                                                  //                     const EdgeInsets.all(
                                                  //                         3.0),
                                                  //                 child: Container(
                                                  //                   height: 8,
                                                  //                   width: 8,
                                                  //                   decoration:
                                                  //                       BoxDecoration(
                                                  //                     shape:
                                                  //                         BoxShape.circle,
                                                  //                     color: campaignController
                                                  //                                 .selectedList[
                                                  //                             index]
                                                  //                         ? AppColors.blue
                                                  //                         : Colors
                                                  //                             .transparent,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             )),
                                                  //         sizeBoxWidth(10),
                                                  //         label(
                                                  //           campaignController
                                                  //               .camplist[index]
                                                  //               .campaignName
                                                  //               .toString(),
                                                  //           style: const TextStyle(
                                                  //             fontSize: 14,
                                                  //             fontWeight: FontWeight.w500,
                                                  //             color: Colors.black,
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //     label(
                                                  //       campaignController
                                                  //           .camplist[index].address
                                                  //           .toString(),
                                                  //       maxLines: 1,
                                                  //       style: const TextStyle(
                                                  //         fontSize: 10,
                                                  //         fontWeight: FontWeight.w400,
                                                  //         color: Color.fromRGBO(
                                                  //             123, 123, 123, 1),
                                                  //         overflow: TextOverflow.ellipsis,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ).paddingSymmetric(horizontal: 10),

                                                  )
                                              .paddingSymmetric(
                                                  horizontal: 20, vertical: 5),
                                        );
                                      },
                                    ),
                                  ),
                                  sizeBoxHeight(40),
                                ],
                              )
                            :
                            //  Center(
                            //     child: CircularProgressIndicator(
                            //       color: AppColors.blue,
                            //     ),
                            //   );
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/mic.png',
                                    height: 100,
                                  ),
                                  sizeBoxHeight(10),
                                  label(
                                      'You don’t have any campaigns \n start creating one',
                                      textAlign: TextAlign.center,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  sizeBoxHeight(10),
                                  CustomButtom(
                                      title: "Add Campaign",
                                      onPressed: () {
                                        // serviceController
                                        //     .serviceIndex.value = -1;
                                        print('lattitude${widget.latt}');
                                        print('longitude${widget.lonn}');
                                        Get.to(() => SponsorExplor(
                                              latt: widget.latt,
                                              lonn: widget.lonn,
                                              serviceid: widget.serviceid,
                                              vendorid: widget.vendorid,
                                              addrss: widget.addrss,
                                            ));
                                      },
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      height: getProportionateScreenHeight(45),
                                      width: getProportionateScreenWidth(200)),
                                ],
                              );
                  }),
                ))
          ],
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      // onTap: () {
      //   if (usernamecontroller.text.isEmpty) {
      //     snackBar('Please enter the campaign name');
      //   } else {
      //     campaignController.AddCampaignApi(
      //         addres: widget.addrss,
      //         areadistance:
      //             '${(widget.mindistance.toString()) + ',' + (widget.distance.toString())}',
      //         lat: widget.latt,
      //         lon: widget.lonn,
      //         campaignName: usernamecontroller.text);
      //   }
      //   // Get.to(const SelectPayment());
      // },

      // onTap: () {
      //   campaignController.selectedIndex.value
      //   Get.to(BudgetDuration(
      //     campaignid: campaignController
      //         .camplist[campaignController.selectedIndex.value!].id
      //         .toString(),
      //   ));
      // },
      onTap: () {
        if (campaignController.selectedIndex.value != null) {
          print(
              "Campaign Id: ${campaignController.camplist[campaignController.selectedIndex.value!].id.toString()}");
          Get.to(BudgetDuration(
            campaignid: campaignController
                .camplist[campaignController.selectedIndex.value!].id
                .toString(),
          ));
        } else {
          snackBar("Please select campaigns");
        }
      },
      child: Container(
        height: 30,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColors.blue, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: label('Next',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              textColor: Colors.white),
        ),
      ).paddingSymmetric(
        horizontal: 20,
      ),
    );
  }
}
