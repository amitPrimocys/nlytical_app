// ignore_for_file: avoid_print

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class BusinessImages extends StatefulWidget {
  const BusinessImages({super.key});

  @override
  State<BusinessImages> createState() => _BusinessImagesState();
}

class _BusinessImagesState extends State<BusinessImages> {
  StoreController storeController = Get.find();

  // // mutiple image select
  // FilePickerResult? pickedFileImage;
  // List<File?> files = [];
  // List<String> filePaths = [];

  // Future<void> openImagePicker() async {
  //   pickedFileImage = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: [
  //       'jpg',
  //       'jpeg',
  //       'png',
  //       'webp',
  //     ],
  //     allowCompression: true,
  //     allowMultiple: true,
  //   );
  //   if (pickedFileImage != null) {
  //     files = pickedFileImage!.paths.map((path) => File(path!)).toList();
  //     filePaths = pickedFileImage!.paths.map((path) => (path!)).toList();
  //     setState(() {});
  //     print("files $files");
  //     print("files Paths $filePaths");
  //   }
  // }

  FilePickerResult? pickedFileImage;
  List<File?> files = [];
  List<String> filePaths = [];

  Future<void> openImagePicker() async {
    pickedFileImage = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'webp',
      ],
      allowCompression: true,
      allowMultiple: true,
    );
    if (pickedFileImage != null) {
      // Update the files and filePaths
      files = pickedFileImage!.paths.map((path) => File(path!)).toList();
      filePaths = pickedFileImage!.paths.map((path) => (path!)).toList();

      // Update combinedImages to include both the existing service images and the newly picked images
      setState(() {
        combinedImages = [
          if (storeController.storeList.isNotEmpty)
            ...storeController.storeList[0].businessDetails!.serviceImages!,
          ...files, // Newly added files
        ];
      });

      print("files $files");
      print("files Paths $filePaths");
      print("combinedImages $combinedImages");
    }
  }

  List<dynamic> combinedImages = [];

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    // Check if storeController.storeList is not empty before accessing the first item
    // List<dynamic> combinedImages = [];

    if (storeController.storeList.isNotEmpty &&
        storeController.storeList[0].businessDetails?.serviceImages != null) {
      combinedImages = [
        ...storeController.storeList[0].businessDetails!.serviceImages!,
        ...files
      ];
    } else {
      // Handle the case where storeList is empty or serviceImages is null
      combinedImages = [...files];
    }

    // double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // List<dynamic> combinedImages = [
    //   if (storeController.storeList[0].businessDetails?.serviceImages != null)
    //     ...storeController.storeList[0].businessDetails!.serviceImages!,
    //   ...files
    // ];

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
                    Text("Business Images",
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
                              " Make your business look more trustworthy by uploding images of your business premises",
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
                      twoText(
                        fontWeight: FontWeight.w600,
                        text1: "Add Business Images",
                        text2: " *",
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      sizeBoxHeight(6),
                      GestureDetector(
                        onTap: () {
                          openImagePicker();
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: themeContro.isLightMode.value
                                ? Colors.transparent
                                : AppColors.darkGray,
                            border: Border.all(
                              color: themeContro.isLightMode.value
                                  ? AppColors.colorEFEFEF
                                  : AppColors.grey1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                AppAsstes.add_business1,
                                height: getProportionateScreenHeight(27),
                                width: getProportionateScreenWidth(27),
                                color: themeContro.isLightMode.value
                                    ? Colors.transparent
                                    : AppColors.blue,
                              ),
                              sizeBoxHeight(4),
                              label(
                                "Service Image",
                                style: poppinsFont(
                                  8,
                                  AppColors.colorB0B0B0,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ).paddingSymmetric(vertical: 25),
                        ),
                      ),
                      sizeBoxHeight(5),
                      Text(
                        "Note: You can upload images with ‘jpg’, ‘png’, ‘jpeg’ extensions & you can select multiple images",
                        style: poppinsFont(
                            9, AppColors.colorCCCCCC, FontWeight.w500),
                      ),
                      combinedImages.isEmpty
                          ? const SizedBox.shrink()
                          : sizeBoxHeight(12),
                      combinedImages.isEmpty
                          ? (storeController.storeList.isEmpty
                              ? const Center(child: Text('No images available'))
                              : const SizedBox.shrink())
                          : SizedBox(
                              height: getProportionateScreenHeight(58),
                              child: ListView.separated(
                                clipBehavior: Clip.none,
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: combinedImages.length,
                                separatorBuilder: (context, index) {
                                  return sizeBoxWidth(15);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  bool isEventImage =
                                      storeController.storeList.isEmpty
                                          ? false
                                          : index <
                                              storeController
                                                  .storeList[0]
                                                  .businessDetails!
                                                  .serviceImages!
                                                  .length;
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.colorB0B0B0,
                                                width: 1)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: isEventImage
                                              ? Image.network(
                                                  combinedImages[index]
                                                      .url
                                                      .toString(),
                                                  height:
                                                      getProportionateScreenHeight(
                                                          52),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          52),
                                                  fit: BoxFit.cover)
                                              : Image.file(
                                                  File(combinedImages[index]!
                                                      .path),
                                                  // files[index]!,
                                                  fit: BoxFit.cover,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          52),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          52),
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        right: -5,
                                        top: -5,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isEventImage) {
                                              storeController
                                                  .removeServiceImgApi(
                                                      serviceIMGID:
                                                          storeController
                                                              .storeList[0]
                                                              .businessDetails!
                                                              .serviceImages![
                                                                  index]
                                                              .id
                                                              .toString());
                                              setState(() {
                                                storeController
                                                    .storeList[0]
                                                    .businessDetails!
                                                    .serviceImages!
                                                    .removeAt(index);
                                              });
                                            } else {
                                              setState(() {
                                                files.removeAt(index -
                                                    storeController
                                                        .storeList[0]
                                                        .businessDetails!
                                                        .serviceImages!
                                                        .length);
                                                //files;
                                                print(files);
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                                color: AppColors.colorBABABA,
                                                shape: BoxShape.circle),
                                            child: const Icon(
                                              Icons.close,
                                              size: 8,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
            ),
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
                          if (files.isEmpty && combinedImages.isEmpty) {
                            snackBar("Please add you store images");
                          } else {
                            storeController.storeIMAGEUpdateApi(
                                storeImages: filePaths);
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
