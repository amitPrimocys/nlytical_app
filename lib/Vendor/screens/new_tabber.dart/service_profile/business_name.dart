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

class BusinessNameScreen extends StatefulWidget {
  const BusinessNameScreen({super.key});

  @override
  State<BusinessNameScreen> createState() => _BusinessNameScreenState();
}

class _BusinessNameScreenState extends State<BusinessNameScreen> {
  StoreController storeController = Get.find();
  final businessnameController = TextEditingController();
  final businessdescController = TextEditingController();

  final name = FocusNode();
  final name1 = FocusNode();
  final desc = FocusNode();
  final desc1 = FocusNode();

  @override
  void initState() {
    businessnameController.text = storeController.storeList.isNotEmpty
        ? storeController.storeList[0].businessDetails!.serviceName ?? ""
        : "";
    businessdescController.text = storeController.storeList.isNotEmpty
        ? storeController.storeList[0].businessDetails!.serviceDescription ?? ""
        : "";
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
                    Text("Business Name",
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
                          "Business Detail",
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
                                " Enter your business name exactly how you would like it to look to all users.",
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
                            lable: "Business Name",
                            lable2: " *",
                            controller: businessnameController,
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(name);
                            },
                            focusNode: name1,
                            hintText: "Business Name",
                            context: context),
                        sizeBoxHeight(20),
                        globalTextField3(
                            lable: "Business Description",
                            lable2: " *",
                            maxLines: 4,
                            controller: businessdescController,
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(desc);
                            },
                            focusNode: desc1,
                            hintText: "Business Description",
                            context: context),
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
                          if (businessnameController.text.trim().isEmpty) {
                            snackBar("Please add you business name");
                          } else if (businessdescController.text
                              .trim()
                              .isEmpty) {
                            snackBar("Please add you business description");
                          } else {
                            storeController.storeNameUpdateApi(
                                storeName: businessnameController.text,
                                storeDesc: businessdescController.text);
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
