// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  StoreController storeController = Get.find();
  final addressController = TextEditingController();

  final addressFocus = FocusNode();
  final addressFocus1 = FocusNode();

  @override
  void initState() {
    addressController.text =
        storeController.storeList[0].contactDetails!.address ?? '';
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
                    Text("Business Address",
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
                          "Business Address",
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
                                " Enter the address details that would be used by customers to locate your workplace",
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
                        sizeBoxHeight(20),
                        globalTextField3(
                            lable: "Business Address",
                            lable2: " *",
                            maxLines: 4,
                            controller: addressController,
                            onChanged: (p0) async {
                              setState(() {});
                              await storeController.getLonLat(p0);
                              await storeController.getsuggestion(p0);
                              setState(() {});
                            },
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(addressFocus);
                            },
                            focusNode: addressFocus1,
                            hintText: "Business Address",
                            context: context),
                        addressController.text.isEmpty
                            ? const SizedBox()
                            : storeController.mapresult.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          storeController.mapresult.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              addressController.text =
                                                  storeController
                                                          .mapresult[index]
                                                      ['description'];
                                              storeController.mapresult.clear();
                                              storeController.getLonLat(
                                                  addressController.text);
                                            });
                                          },
                                          child: Text(storeController
                                                      .mapresult[index]
                                                  ['description'])
                                              .paddingOnly(
                                                  left: 12,
                                                  bottom: storeController
                                                                  .mapresult
                                                                  .length -
                                                              1 ==
                                                          index
                                                      ? 0
                                                      : 15),
                                        );
                                      },
                                    ),
                                  ),
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
                          if (addressController.text.trim().isEmpty) {
                            snackBar("Please add your business address");
                          } else {
                            print(storeController.searchLatitude.toString());
                            print(storeController.searchLongitude.toString());
                            storeController.storeAddressUpdateApi(
                              address: addressController.text,
                              lat: storeController.searchLatitude.toString(),
                              long: storeController.searchLongitude.toString(),
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
          ],
        ),
      ),
    );
  }
}
