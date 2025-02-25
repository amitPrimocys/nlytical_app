import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/address.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_category.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_images.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_name.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_social_link.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_website.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_years.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/contact_detail.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/store_employee.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/store_time.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class EditServiceProfile extends StatefulWidget {
  const EditServiceProfile({super.key});

  @override
  State<EditServiceProfile> createState() => _EditServiceProfileState();
}

class _EditServiceProfileState extends State<EditServiceProfile> {
  StoreController storeController = Get.find();

  @override
  void initState() {
    if (storeController.storeList.isNotEmpty) {
      storeController.caategoryName.value =
          storeController.categoryData.value.data?.firstWhere(
                (element) {
                  return element.id.toString() ==
                      storeController.storeList[0].businessDetails!.categoryId!
                          .toString();
                },
              ).categoryName ??
              '';
    }
    super.initState();
  }

  int _getMonthNumber(String month) {
    const Map<String, int> monthMapping = {
      "January": 1,
      "February": 2,
      "March": 3,
      "April": 4,
      "May": 5,
      "June": 6,
      "July": 7,
      "August": 8,
      "September": 9,
      "October": 10,
      "November": 11,
      "December": 12,
    };

    return monthMapping[month] ?? 1; // Default to January if not found
  }

  @override
  Widget build(BuildContext context) {
    String publishedYearString = storeController.storeList.isNotEmpty
        ? storeController.storeList[0].businessTime!.publishedYear ?? ''
        : '';
    String publishedMonthString = storeController.storeList.isNotEmpty
        ? storeController.storeList[0].businessTime!.publishedMonth ?? ''
        : '';

    // Parse the year
    int publishedYear = int.tryParse(publishedYearString) ?? 0;

    // Convert the month name to a DateTime-compatible integer (1-12)
    int publishedMonth = _getMonthNumber(publishedMonthString);

    // Create a DateTime object for the published year and month
    DateTime publishedDate = DateTime(publishedYear, publishedMonth);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference
    int totalMonths = (currentDate.year - publishedDate.year) * 12 +
        (currentDate.month - publishedDate.month);
    int years = totalMonths ~/ 12;
    int months = totalMonths % 12;

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
                    Text("Business",
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
                child: Column(
                  children: [
                    sizeBoxHeight(5),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          sizeBoxHeight(30),
                          businessContainer(
                            onTap: () {
                              Get.to(() => const BusinessNameScreen())!
                                  .then((_) {
                                setState(() {
                                  storeController.storeDetailModel.refresh();
                                  storeController.storeList.refresh();
                                });
                              });
                            },
                            img: AppAsstes.handshake,
                            imgheight: 20,
                            title: "Business Name",
                            subTitle: storeController.storeList.isNotEmpty
                                ? storeController.storeList[0].businessDetails!
                                        .serviceName ??
                                    ""
                                : "No any business added",
                          ).paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          //============= contact detail =====================
                          contacContainer().paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          //============= address detail =====================
                          addressContainer().paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          businessContainer(
                            onTap: () {
                              Get.to(() => const StoreTimeScreen())!.then((_) {
                                setState(() {
                                  storeController.storeDetailModel.refresh();
                                  storeController.storeList.refresh();
                                });
                              });
                            },
                            img: AppAsstes.time,
                            imgheight: 20,
                            title: "Business Timings",
                            subTitle: "Open Now",
                          ).paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          businessContainer(
                            onTap: () {
                              Get.to(() => const BusinessYears())!.then((_) {
                                setState(() {
                                  storeController.storeDetailModel.refresh();
                                  storeController.storeList.refresh();
                                });
                              });
                            },
                            img: AppAsstes.barchart,
                            imgheight: 20,
                            title: "Year of Establishment",
                            subTitle: "$years Year $months month",
                          ).paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          businessContainer(
                            onTap: () {
                              Get.to(() => const BusinessCategory())!.then((_) {
                                setState(() {
                                  storeController.storeDetailModel.refresh();
                                  storeController.storeList.refresh();
                                });
                              });
                            },
                            img: AppAsstes.networking,
                            imgheight: 20,
                            title: "Business categories",
                            subTitle: storeController.caategoryName.value,
                          ).paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          businessContainer(
                            onTap: () {
                              Get.to(() => const StoreEmployee())!.then((_) {
                                setState(() {
                                  storeController.storeDetailModel.refresh();
                                  storeController.storeList.refresh();
                                });
                              });
                            },
                            img: AppAsstes.emp1,
                            imgheight: 20,
                            title: "Number of Employees",
                            subTitle: storeController.storeList.isNotEmpty
                                ? "${storeController.storeList[0].businessTime!.employeeStrength ?? ''} Employees"
                                : "0 Employees",
                          ).paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          // business service images
                          businessImage().paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          businessContainer(
                            onTap: () {
                              Get.to(() => const BusinessWebsite())!.then((_) {
                                setState(() {
                                  storeController.storeDetailModel.refresh();
                                  storeController.storeList.refresh();
                                });
                              });
                            },
                            img: AppAsstes.worldwide,
                            imgheight: 20,
                            title: "Business Website",
                            subTitle: storeController.storeList.isNotEmpty
                                ? storeController
                                    .storeList[0].contactDetails!.serviceWebsite
                                    .toString()
                                : '',
                          ).paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(20),
                          businessFollowSocialMedia()
                              .paddingSymmetric(horizontal: 17),
                          sizeBoxHeight(100),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget businessContainer(
      {required Function() onTap,
      required String img,
      required double imgheight,
      required String title,
      required String subTitle}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeContro.isLightMode.value
                ? AppColors.white
                : AppColors.darkGray,
            boxShadow: const [
              BoxShadow(
                blurRadius: 14.4,
                offset: Offset(2, 4),
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.06),
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(img, height: imgheight),
                sizeBoxWidth(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: poppinsFont(
                          14,
                          themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          FontWeight.w500),
                    ),
                    sizeBoxHeight(10),
                    Text(
                      subTitle,
                      style: poppinsFont(12, AppColors.grey1, FontWeight.w400),
                    )
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.blue,
            )
          ],
        ).paddingSymmetric(horizontal: 17, vertical: 12),
      ),
    );
  }

//==================================================== BUSINESS IMAGE ===========================================================================
//==================================================== BUSINESS IMAGE ===========================================================================
//==================================================== BUSINESS IMAGE ===========================================================================
  Widget businessFollowSocialMedia() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const BusinessSocialLink());
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeContro.isLightMode.value
                  ? AppColors.white
                  : AppColors.darkGray,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 14.4,
                  offset: Offset(2, 4),
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(AppAsstes.computer, height: 20),
                  sizeBoxWidth(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Follow on Social Media",
                        style: poppinsFont(
                            14,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w500),
                      ),
                      sizeBoxHeight(10),
                      SizedBox(
                        width: getProportionateScreenWidth(270),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              followContainer(
                                  img: AppAsstes.whatsapp, title: 'What’s app'),
                              sizeBoxWidth(5),
                              followContainer(
                                  img: AppAsstes.Facebook, title: 'Facebook'),
                              sizeBoxWidth(5),
                              followContainer(
                                  img: AppAsstes.instagram, title: 'Instagram'),
                              sizeBoxWidth(5),
                              followContainer(
                                  img: AppAsstes.twitter, title: 'Twitter'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 17,
                  color: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.blue)
            ],
          ).paddingSymmetric(horizontal: 17, vertical: 12)),
    );
  }

  Widget followContainer({required String img, required String title}) {
    return Container(
      decoration: BoxDecoration(
          color: themeContro.isLightMode.value
              ? AppColors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.blue)),
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

  //======================================================= IMAGES ==============================================================
  Widget businessImage() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const BusinessImages())!.then((_) {
          setState(() {
            storeController.storeDetailModel.refresh();
            storeController.storeList.refresh();
          });
        });
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeContro.isLightMode.value
                  ? AppColors.white
                  : AppColors.darkGray,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 14.4,
                  offset: Offset(2, 4),
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(AppAsstes.computer1, height: 20),
                  sizeBoxWidth(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Business Images",
                        style: poppinsFont(
                            14,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w500),
                      ),
                      sizeBoxHeight(10),
                      SizedBox(
                        height: getProportionateScreenHeight(50),
                        width: getProportionateScreenWidth(270),
                        child: storeController.storeList.isNotEmpty
                            ? ListView.builder(
                                itemCount: storeController.storeList[0]
                                    .businessDetails!.serviceImages!.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: getProportionateScreenHeight(48),
                                    width: getProportionateScreenWidth(48),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        storeController
                                            .storeList[0]
                                            .businessDetails!
                                            .serviceImages![index]
                                            .url
                                            .toString(),
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Icon(Icons.error, size: 20),
                                      ),
                                    ),
                                  ).paddingOnly(right: 10);
                                })
                            : const SizedBox.shrink(),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 17,
                  color: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.blue)
            ],
          ).paddingSymmetric(horizontal: 17, vertical: 12)),
    );
  }

//================================================ CONTACT DETAILS ====================================================================
  Widget contacContainer() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ContactDetail())!.then((_) {
          setState(() {
            storeController.storeDetailModel.refresh();
            storeController.storeList.refresh();
          });
        });
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeContro.isLightMode.value
                  ? AppColors.white
                  : AppColors.darkGray,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 14.4,
                  offset: Offset(2, 4),
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(AppAsstes.phonecall, height: 20),
                  sizeBoxWidth(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Details",
                        style: poppinsFont(
                            14,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w500),
                      ),
                      sizeBoxHeight(10),
                      Text(
                        storeController.storeList.isNotEmpty
                            ? storeController.storeList[0].contactDetails!
                                    .servicePhone ??
                                ''
                            : 'No any business contact added',
                        style:
                            poppinsFont(12, AppColors.grey1, FontWeight.w400),
                      ),
                      sizeBoxHeight(10),
                      SizedBox(
                        width: getProportionateScreenWidth(260),
                        child: Text(
                          storeController.storeList.isNotEmpty
                              ? storeController.storeList[0].contactDetails!
                                      .serviceEmail ??
                                  ''
                              : '',
                          maxLines: 2,
                          style:
                              poppinsFont(12, AppColors.grey1, FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 17,
                  color: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.blue)
            ],
          ).paddingSymmetric(horizontal: 17, vertical: 12)),
    );
  }

  Widget addressContainer() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const AddressScreen())!.then((_) {
          setState(() {
            storeController.storeDetailModel.refresh();
            storeController.storeList.refresh();
          });
        });
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeContro.isLightMode.value
                  ? AppColors.white
                  : AppColors.darkGray,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 14.4,
                  offset: Offset(2, 4),
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(AppAsstes.contract, height: 20),
                  sizeBoxWidth(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Business Address",
                        style: poppinsFont(
                            14,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w500),
                      ),
                      sizeBoxHeight(10),
                      SizedBox(
                        width: getProportionateScreenWidth(270),
                        child: Text(
                          storeController.storeList.isNotEmpty
                              ? storeController
                                      .storeList[0].contactDetails!.address ??
                                  ''
                              : 'No any business added',
                          maxLines: 2,
                          style:
                              poppinsFont(12, AppColors.grey1, FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 17,
                  color: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.blue)
            ],
          ).paddingSymmetric(horizontal: 17, vertical: 12)),
    );
  }
}
