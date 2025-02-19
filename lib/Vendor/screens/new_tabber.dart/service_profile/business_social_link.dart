// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class BusinessSocialLink extends StatefulWidget {
  const BusinessSocialLink({super.key});

  @override
  State<BusinessSocialLink> createState() => _BusinessSocialLinkState();
}

class _BusinessSocialLinkState extends State<BusinessSocialLink> {
  StoreController storeController = Get.find();

  final whpLinkController = TextEditingController();
  final faceBookLinkController = TextEditingController();
  final instaLinkController = TextEditingController();
  final twitterLinkController = TextEditingController();

  FocusNode whpFocus = FocusNode();
  FocusNode whpFocus1 = FocusNode();

  FocusNode fcFocus = FocusNode();
  FocusNode fcFocus1 = FocusNode();

  FocusNode instaFocus = FocusNode();
  FocusNode instaFocus1 = FocusNode();

  FocusNode twiFocus = FocusNode();
  FocusNode twiFocus1 = FocusNode();

  bool whpvalue = false;
  bool fcvalue = false;
  bool instavalue = false;
  bool twvalue = false;

  @override
  void initState() {
    whpLinkController.text =
        storeController.storeList[0].contactDetails!.whatsappLink ?? '';
    faceBookLinkController.text =
        storeController.storeList[0].contactDetails!.facebookLink ?? '';
    instaLinkController.text =
        storeController.storeList[0].contactDetails!.instagramLink ?? '';
    twitterLinkController.text =
        storeController.storeList[0].contactDetails!.twitterLink ?? '';

    boolData();
    super.initState();
  }

  Future boolData() async {
    whpLinkController.text.trim().isNotEmpty
        ? whpvalue = true
        : whpvalue = false;

    faceBookLinkController.text.trim().isNotEmpty
        ? fcvalue = true
        : fcvalue = false;

    instaLinkController.text.trim().isNotEmpty
        ? instavalue = true
        : instavalue = false;

    twitterLinkController.text.trim().isNotEmpty
        ? twvalue = true
        : twvalue = false;
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
            appMainDesignAppBar(),
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
                    Text("Follow on Social Media",
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
                                " Please provide the URL of your business website so customers can reach you.",
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
                        label("Follow Us on",
                            style: poppinsFont(
                                11,
                                themeContro.isLightMode.value
                                    ? AppColors.black
                                    : AppColors.white,
                                FontWeight.w600)),
                        sizeBoxHeight(10),
                        followeUSOnWidget(),
                        sizeBoxHeight(50),
                        Center(
                          child: Obx(() {
                            return storeController.isUpdate.value
                                ? Center(child: commonLoading())
                                    .paddingSymmetric(
                                        horizontal:
                                            getProportionateScreenWidth(100))
                                : customBtn(
                                    onTap: () {
                                      if (whpLinkController.text
                                              .trim()
                                              .isEmpty &&
                                          faceBookLinkController.text
                                              .trim()
                                              .isEmpty &&
                                          instaLinkController.text
                                              .trim()
                                              .isEmpty &&
                                          twitterLinkController.text
                                              .trim()
                                              .isEmpty) {
                                        snackBar(
                                            "Please add social meadia link");
                                      } else {
                                        storeController.storeSocialUpdateApi(
                                          whp: whpLinkController.text,
                                          fc: faceBookLinkController.text,
                                          insta: instaLinkController.text,
                                          twitter: twitterLinkController.text,
                                        );
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
                        sizeBoxHeight(215),
                      ],
                    ).paddingSymmetric(horizontal: 20),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget followeUSOnWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: themeContro.isLightMode.value
                  ? Colors.grey.shade200
                  : AppColors.grey1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              followContainer(
                  img: AppAsstes.whatsapp,
                  title: 'What’s app',
                  isLinkValue: whpvalue),
              followContainer(
                  img: AppAsstes.Facebook,
                  title: 'Facebook',
                  isLinkValue: fcvalue),
              followContainer(
                  img: AppAsstes.instagram,
                  title: 'Instagram',
                  isLinkValue: instavalue),
              followContainer(
                  img: AppAsstes.twitter,
                  title: 'Twitter',
                  isLinkValue: twvalue),
            ],
          ),
          sizeBoxHeight(5),
          globalTextField3(
              controller: whpLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(whpFocus);
                whpvalue = true;
              },
              onChanged: (p0) {
                whpvalue = true;
              },
              focusNode: whpFocus1,
              hintText: 'Add What’s app link',
              context: context),
          sizeBoxHeight(10),
          globalTextField3(
              controller: faceBookLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(fcFocus);
              },
              onChanged: (p0) {
                fcvalue = true;
              },
              focusNode: fcFocus1,
              hintText: 'Add Facebook profile link',
              context: context),
          sizeBoxHeight(10),
          globalTextField3(
              controller: instaLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(instaFocus);
              },
              onChanged: (p0) {
                instavalue = true;
              },
              focusNode: instaFocus1,
              hintText: 'Add Instagram profile link',
              context: context),
          sizeBoxHeight(10),
          globalTextField3(
              controller: twitterLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(twiFocus);
              },
              onChanged: (p0) {
                twvalue = true;
              },
              focusNode: twiFocus1,
              hintText: 'Add Twitter profile link',
              context: context),
        ],
      ).paddingAll(10),
    );
  }

  Widget followContainer(
      {required String img, required String title, bool isLinkValue = false}) {
    return Container(
      decoration: BoxDecoration(
          color: themeContro.isLightMode.value
              ? AppColors.white
              : AppColors.darkGray,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: isLinkValue ? AppColors.blue : Colors.grey)),
      child: Row(
        children: [
          Image.asset(img, height: 16),
          sizeBoxWidth(5),
          Text(title,
              style: poppinsFont(
                  7,
                  themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
                  FontWeight.w500))
        ],
      ).paddingAll(5),
    );
  }
}
