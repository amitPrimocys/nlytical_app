// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/service_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class AddSrvice extends StatefulWidget {
  final bool isvalue;
  const AddSrvice({super.key, required this.isvalue});

  @override
  State<AddSrvice> createState() => _AddSrviceState();
}

class _AddSrviceState extends State<AddSrvice> {
  ServiceController serviceController = Get.find();
  final serviceNameController = TextEditingController();
  final serviceDescController = TextEditingController();
  final servicePriceController = TextEditingController();

  final nameFocus = FocusNode();
  final nameFocus1 = FocusNode();
  final descFocus = FocusNode();
  final descFocus1 = FocusNode();
  final prieFocus = FocusNode();
  final priceFocus1 = FocusNode();

  @override
  void initState() {
    if (serviceController.serviceIndex.value != -1) {
      serviceNameController.text = serviceController
          .serviceList[serviceController.serviceIndex.value].storeName
          .toString();
      serviceDescController.text = serviceController
          .serviceList[serviceController.serviceIndex.value].storeDescription
          .toString();
      servicePriceController.text = serviceController
          .serviceList[serviceController.serviceIndex.value].price
          .toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    // service image
    List<dynamic> combinedImages = serviceController.serviceIndex.value == -1
        ? [...files]
        : [
            if (serviceController
                    .serviceList[serviceController.serviceIndex.value]
                    .storeImages !=
                null)
              ...serviceController
                  .serviceList[serviceController.serviceIndex.value]
                  .storeImages!,
            ...files
          ];

    // service attachment
    List<dynamic> combinedAttchment = serviceController.serviceIndex.value == -1
        ? [...selectedFile]
        : [
            if (serviceController
                    .serviceList[serviceController.serviceIndex.value]
                    .storeAttachments !=
                null)
              ...serviceController
                  .serviceList[serviceController.serviceIndex.value]
                  .storeAttachments!,
            ...selectedFile
          ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
        elevation: 0,
        height: 70,
        child: button(),
      ),
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
                    Text(widget.isvalue ? "Update Service" : "Add Service",
                        style:
                            poppinsFont(20, AppColors.white, FontWeight.w500))
                  ],
                )),
            Positioned(
              top: 100,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
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
                        sizeBoxHeight(50),
                        twoText(
                          fontWeight: FontWeight.w600,
                          text1: "Add Business Images",
                          text2: " *",
                          size: 11,
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        sizeBoxHeight(7),
                        GestureDetector(
                          onTap: () {
                            print("pressed");
                            openImagePicker();
                          },
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.colorEFEFEF,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  AppAsstes.add_business1,
                                  height: getProportionateScreenHeight(27),
                                  width: getProportionateScreenWidth(27),
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
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: getProportionateScreenHeight(58),
                                child: serviceController.serviceIndex.value ==
                                        -1
                                    ? ListView.separated(
                                        clipBehavior: Clip.none,
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: combinedImages.length,
                                        separatorBuilder: (context, index) {
                                          return sizeBoxWidth(15);
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Stack(
                                            clipBehavior: Clip.none,
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .colorB0B0B0,
                                                        width: 1)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    File(combinedImages[index]!
                                                        .path),
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
                                                    setState(() {
                                                      files.removeAt(index);
                                                      files;
                                                      print(files);
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                AppColors
                                                                    .colorBABABA,
                                                            shape: BoxShape
                                                                .circle),
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
                                      )
                                    : ListView.separated(
                                        clipBehavior: Clip.none,
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: combinedImages.length,
                                        separatorBuilder: (context, index) {
                                          return sizeBoxWidth(15);
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          bool isEventImage = index <
                                              serviceController
                                                  .serviceList[serviceController
                                                      .serviceIndex.value]
                                                  .storeImages!
                                                  .length;

                                          return Stack(
                                            clipBehavior: Clip.none,
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .colorB0B0B0,
                                                        width: 1)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: isEventImage
                                                      ? Image.network(
                                                          combinedImages[index]!
                                                              .url
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  52),
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  52),
                                                        )
                                                      : Image.file(
                                                          File(combinedImages[
                                                                  index]!
                                                              .path),
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
                                                      serviceController.removeServiceImgApi(
                                                          serviceID: serviceController
                                                              .serviceList[
                                                                  serviceController
                                                                      .serviceIndex
                                                                      .value]
                                                              .id
                                                              .toString(),
                                                          serviceIMGID: serviceController
                                                              .serviceList[
                                                                  serviceController
                                                                      .serviceIndex
                                                                      .value]
                                                              .storeImages![
                                                                  index]
                                                              .id
                                                              .toString());
                                                      setState(() {
                                                        serviceController
                                                            .serviceList[
                                                                serviceController
                                                                    .serviceIndex
                                                                    .value]
                                                            .storeImages!
                                                            .removeAt(index);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        files.removeAt(index -
                                                            serviceController
                                                                .serviceList[
                                                                    serviceController
                                                                        .serviceIndex
                                                                        .value]
                                                                .storeImages!
                                                                .length);
                                                        //files;
                                                        print(files);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                AppColors
                                                                    .colorBABABA,
                                                            shape: BoxShape
                                                                .circle),
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
                        sizeBoxHeight(20),
                        globalTextField3(
                            lable: "Service Name",
                            lable2: " *",
                            controller: serviceNameController,
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(nameFocus);
                            },
                            focusNode: nameFocus1,
                            hintText: "Service Name",
                            context: context),
                        sizeBoxHeight(20),
                        globalTextField3(
                            lable: "Service Description",
                            lable2: " *",
                            controller: serviceDescController,
                            maxLines: 5,
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(descFocus);
                            },
                            focusNode: descFocus1,
                            hintText: "Service Description",
                            context: context),
                        sizeBoxHeight(20),
                        globalTextField3(
                            lable: "Price",
                            lable2: " *",
                            controller: servicePriceController,
                            onEditingComplete: () {
                              Focus.of(context).requestFocus(prieFocus);
                            },
                            focusNode: priceFocus1,
                            hintText: "Add Price",
                            context: context),
                        sizeBoxHeight(20),
                        label(
                          "Attach Files",
                          style: poppinsFont(
                            10,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w600,
                          ),
                        ),
                        sizeBoxHeight(7),
                        GestureDetector(
                          onTap: () {
                            openDocPicker();
                          },
                          child: Container(
                            height: getProportionateScreenHeight(100),
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.colorEFEFEF)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppAsstes.file, height: 25),
                                sizeBoxHeight(5),
                                Text(
                                  "Add Files",
                                  style: poppinsFont(11, AppColors.colorB4B4B4,
                                      FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        combinedAttchment.isEmpty
                            ? const SizedBox.shrink()
                            : sizeBoxHeight(12),
                        combinedAttchment.isEmpty
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: getProportionateScreenHeight(30),
                                child: serviceController.serviceIndex.value ==
                                        -1
                                    ? ListView.builder(
                                        clipBehavior: Clip.none,
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: combinedAttchment.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color:
                                                              AppColors.blue)),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        extractFilename(
                                                                combinedAttchment[
                                                                        index]!
                                                                    .path)
                                                            .toString()
                                                            .split("-")
                                                            .last,
                                                        style: poppinsFont(
                                                            8,
                                                            themeContro
                                                                    .isLightMode
                                                                    .value
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .white,
                                                            FontWeight.w500),
                                                      ),
                                                      sizeBoxWidth(5),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedFile
                                                                .removeAt(
                                                                    index);
                                                            selectedFile;
                                                            print(files);
                                                          });
                                                        },
                                                        child: Image.asset(
                                                            AppAsstes.close,
                                                            height: 10),
                                                      )
                                                    ],
                                                  ).paddingAll(5))
                                              .paddingOnly(right: 5);
                                        })
                                    : ListView.builder(
                                        clipBehavior: Clip.none,
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: combinedAttchment.length,
                                        itemBuilder: (context, index) {
                                          bool isAttachment = index <
                                              serviceController
                                                  .serviceList[serviceController
                                                      .serviceIndex.value]
                                                  .storeAttachments!
                                                  .length;
                                          return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color:
                                                              AppColors.blue)),
                                                  child: isAttachment
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              extractFilename(combinedAttchment[
                                                                          index]
                                                                      .url
                                                                      .toString())
                                                                  .toString()
                                                                  .split("-")
                                                                  .last,
                                                              style: poppinsFont(
                                                                  8,
                                                                  themeContro
                                                                          .isLightMode
                                                                          .value
                                                                      ? AppColors
                                                                          .black
                                                                      : AppColors
                                                                          .white,
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            sizeBoxWidth(5),
                                                            GestureDetector(
                                                              onTap: () {
                                                                serviceController.removeServiceAttachApi(
                                                                    serviceID: serviceController
                                                                        .serviceList[serviceController
                                                                            .serviceIndex
                                                                            .value]
                                                                        .id
                                                                        .toString(),
                                                                    serviceIMGID: serviceController
                                                                        .serviceList[serviceController
                                                                            .serviceIndex
                                                                            .value]
                                                                        .storeAttachments![
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                                setState(() {
                                                                  serviceController
                                                                      .serviceList[serviceController
                                                                          .serviceIndex
                                                                          .value]
                                                                      .storeAttachments!
                                                                      .removeAt(
                                                                          index);
                                                                  print(
                                                                      combinedAttchment);
                                                                });
                                                              },
                                                              child: Image.asset(
                                                                  AppAsstes
                                                                      .close,
                                                                  height: 10),
                                                            )
                                                          ],
                                                        ).paddingAll(5)
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              extractFilename(
                                                                      combinedAttchment[
                                                                              index]!
                                                                          .path)
                                                                  .toString()
                                                                  .split("-")
                                                                  .last,
                                                              style: poppinsFont(
                                                                  8,
                                                                  themeContro
                                                                          .isLightMode
                                                                          .value
                                                                      ? AppColors
                                                                          .black
                                                                      : AppColors
                                                                          .white,
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            sizeBoxWidth(5),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedFile.removeAt(index -
                                                                      serviceController
                                                                          .serviceList[serviceController
                                                                              .serviceIndex
                                                                              .value]
                                                                          .storeAttachments!
                                                                          .length);
                                                                  print(files);
                                                                });
                                                              },
                                                              child: Image.asset(
                                                                  AppAsstes
                                                                      .close,
                                                                  height: 10),
                                                            )
                                                          ],
                                                        ).paddingAll(5))
                                              .paddingOnly(right: 5);
                                        }),
                              ),
                        sizeBoxHeight(250),
                      ],
                    ).paddingOnly(left: 20, right: 20),
                  ),
                ),
              ),
            ),
            // Positioned(
            //     bottom: keyboardHeight > 0
            //         ? keyboardHeight + -280 // Place above the keyboard
            //         : 30, // Default position
            //     left: (Get.width - getProportionateScreenWidth(260)) / 2,
            //     child: Obx(() {
            //       if (serviceController.serviceIndex.value == -1) {
            //         return serviceController.isloading.value
            //             ? Center(child: commonLoading()).paddingSymmetric(
            //                 horizontal: getProportionateScreenWidth(100))
            //             : customBtn(
            //                 onTap: () {
            //                   serviceController.addServiceApi(
            //                       name: serviceNameController.text,
            //                       desc: serviceDescController.text,
            //                       price: servicePriceController.text,
            //                       storeImages: filePaths,
            //                       storeAttachment: selectedFilePaths);
            //                 },
            //                 title: "Save",
            //                 fontSize: 15,
            //                 weight: FontWeight.w400,
            //                 radius: BorderRadius.circular(10),
            //                 width: getProportionateScreenWidth(260),
            //                 height: getProportionateScreenHeight(55),
            //               );
            //       } else {
            //         return serviceController.isUpdate.value
            //             ? Center(child: commonLoading()).paddingSymmetric(
            //                 horizontal: getProportionateScreenWidth(100))
            //             : customBtn(
            //                 onTap: () {
            //                   serviceController.updateServiceApi(
            //                       serviceID: serviceController
            //                           .serviceList[
            //                               serviceController.serviceIndex.value]
            //                           .id
            //                           .toString(),
            //                       name: serviceNameController.text,
            //                       desc: serviceDescController.text,
            //                       price: servicePriceController.text,
            //                       storeImages: filePaths,
            //                       storeAttachment: selectedFilePaths);
            //                 },
            //                 title: "Save",
            //                 fontSize: 15,
            //                 weight: FontWeight.w400,
            //                 radius: BorderRadius.circular(10),
            //                 width: getProportionateScreenWidth(260),
            //                 height: getProportionateScreenHeight(55),
            //               );
            //       }
            //     })),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Obx(() {
      if (serviceController.serviceIndex.value == -1) {
        return serviceController.isloading.value
            ? Center(child: commonLoading())
                .paddingSymmetric(horizontal: getProportionateScreenWidth(100))
            : customBtn(
                onTap: () {
                  serviceController.addServiceApi(
                      name: serviceNameController.text,
                      desc: serviceDescController.text,
                      price: servicePriceController.text,
                      storeImages: filePaths,
                      storeAttachment: selectedFilePaths);
                },
                title: "Save",
                fontSize: 15,
                weight: FontWeight.w400,
                radius: BorderRadius.circular(10),
                width: getProportionateScreenWidth(260),
                height: getProportionateScreenHeight(55),
              );
      } else {
        return serviceController.isUpdate.value
            ? Center(child: commonLoading())
                .paddingSymmetric(horizontal: getProportionateScreenWidth(100))
            : customBtn(
                onTap: () {
                  serviceController.updateServiceApi(
                      serviceID: serviceController
                          .serviceList[serviceController.serviceIndex.value].id
                          .toString(),
                      name: serviceNameController.text,
                      desc: serviceDescController.text,
                      price: servicePriceController.text,
                      storeImages: filePaths,
                      storeAttachment: selectedFilePaths);
                },
                title: "Save",
                fontSize: 15,
                weight: FontWeight.w400,
                radius: BorderRadius.circular(10),
                width: getProportionateScreenWidth(260),
                height: getProportionateScreenHeight(55),
              );
      }
    }).paddingSymmetric(horizontal: 35);
  }

// mutiple image select
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
      files = pickedFileImage!.paths.map((path) => File(path!)).toList();
      filePaths = pickedFileImage!.paths.map((path) => (path!)).toList();
      setState(() {});
      print("files $files");
      print("files Paths $filePaths");
    }
  }

  FilePickerResult? pickedFileDoc;
  List<File?> selectedFile = [];
  List<String> selectedFilePaths = [];

  Future<void> openDocPicker() async {
    pickedFileDoc = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx',
      ],
      dialogTitle: "Nlytical Vendor",
      allowCompression: true,
      allowMultiple: true, // Allow only a single file
    );

    if (pickedFileDoc != null && pickedFileDoc!.files.isNotEmpty) {
      // Get the single selected file
      selectedFile = pickedFileDoc!.paths.map((path) => File(path!)).toList();
      selectedFilePaths = pickedFileDoc!.paths.map((path) => (path!)).toList();
      setState(() {});
      print("Selected Document file: $selectedFile");
    }
  }
}
