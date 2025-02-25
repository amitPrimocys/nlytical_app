import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class BusinessWebsite extends StatefulWidget {
  const BusinessWebsite({super.key});

  @override
  State<BusinessWebsite> createState() => _BusinessWebsiteState();
}

class _BusinessWebsiteState extends State<BusinessWebsite> {
  StoreController storeController = Get.find();
  final websiteController = TextEditingController();

  final webFocus = FocusNode();
  final webFocus1 = FocusNode();

  @override
  void initState() {
    websiteController.text = storeController.storeList.isNotEmpty
        ? storeController.storeList[0].contactDetails!.serviceWebsite.toString()
        : '';
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
                    Text("Business Website",
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
                        globalTextField3(
                            lable: "Add Business Website",
                            controller: websiteController,
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(webFocus);
                            },
                            focusNode: webFocus1,
                            hintText: 'Website',
                            context: context)
                      ],
                    ).paddingSymmetric(horizontal: 20),
                  ),
                )),
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
                          if (websiteController.text.trim().isEmpty) {
                            snackBar("Please add you business website");
                          } else {
                            storeController.storeWebSiteUpdateApi(
                                storeWebSite: websiteController.text);
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
