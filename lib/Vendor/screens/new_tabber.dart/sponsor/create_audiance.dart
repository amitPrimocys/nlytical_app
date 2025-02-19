// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/controllers/vendor_controllers/campaign_controller.dart';
import 'package:nlytical_app/utils/global.dart';

class CreateAudiance extends StatefulWidget {
  String? latt;
  String? lonn;
  String? vendorid;
  String? serviceid;
  String? addrss;
  String? distance;
  String? mindistance;
  CreateAudiance(
      {super.key,
      this.latt,
      this.lonn,
      this.vendorid,
      this.serviceid,
      this.addrss,
      this.distance,
      this.mindistance});

  @override
  State<CreateAudiance> createState() => _CreateAudianceState();
}

class _CreateAudianceState extends State<CreateAudiance> {
  TextEditingController usernamecontroller = TextEditingController();
  FocusNode usernamepassFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();

  CampaignController campaignController = Get.put(CampaignController());
  @override
  void initState() {
    print('Mindistance : ${widget.mindistance}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.white
          : AppColors.darkMainBlack,
      bottomNavigationBar: BottomAppBar(
        color: themeContro.isLightMode.value
            ? Colors.transparent
            : AppColors.darkMainBlack,
        height: 70,
        child: button(),
      ).paddingOnly(bottom: 30),
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
                        "Create audience",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizeBoxHeight(40),
                      globalTextField(
                        lable: 'Campaign Name',
                        lable2: " *",
                        controller: usernamecontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(usernamepassFocusNode);
                        },
                        maxLength: 30,
                        focusNode: usernameFocusNode,
                        hintText: 'Enter campaign title',
                        context: context,
                      ).paddingSymmetric(horizontal: 20),
                      sizeBoxHeight(15),
                      label('Audience Details',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              textColor: themeContro.isLightMode.value
                                  ? AppColors.black
                                  : AppColors.white)
                          .paddingSymmetric(horizontal: 20),
                      sizeBoxHeight(15),
                      Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: themeContro.isLightMode.value
                              ? Colors.white
                              : AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 14,
                              spreadRadius: 0,
                              offset: const Offset(4, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            label(
                              'Location',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: themeContro.isLightMode.value
                                    ? Colors.black
                                    : AppColors.white,
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                width: Get.width * 0.50,
                                child: label(
                                  widget.addrss.toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(123, 123, 123, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 10),
                      ).paddingSymmetric(horizontal: 20),
                      sizeBoxHeight(15),
                      Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: themeContro.isLightMode.value
                              ? Colors.white
                              : AppColors.darkGray,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 14,
                              spreadRadius: 0,
                              offset: const Offset(4, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            label(
                              'Area',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: themeContro.isLightMode.value
                                    ? Colors.black
                                    : AppColors.white,
                              ),
                            ),
                            label(
                              "${widget.distance.toString()}Kms",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(123, 123, 123, 1),
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 10),
                      ).paddingSymmetric(horizontal: 20),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      onTap: () {
        if (usernamecontroller.text.isEmpty) {
          snackBar('Please enter the campaign name');
        } else {
          campaignController.AddCampaignApi(
              addres: widget.addrss,
              areadistance: '${widget.mindistance},${widget.distance}',
              lat: widget.latt,
              lon: widget.lonn,
              campaignName: usernamecontroller.text);
        }
        // Get.to(const SelectPayment());
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
