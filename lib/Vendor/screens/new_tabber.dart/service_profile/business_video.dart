// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class BusinessVideo extends StatefulWidget {
  const BusinessVideo({super.key});

  @override
  State<BusinessVideo> createState() => _BusinessVideoState();
}

class _BusinessVideoState extends State<BusinessVideo> {
  StoreController storeController = Get.find();

  //========== multiple video select ============================
  FilePickerResult? pickedFileVideo;
  String? thumbnailPath = '';
  String compressedVideoPath = '';

  double fileSizeInMB = 0.0;
  bool isThumbnail = false;

  Future<void> openVideoPicker() async {
    try {
      setState(() {
        isThumbnail = true;
      });
      pickedFileVideo = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'mp4',
          'mkv',
          'MKV',
          'avi',
        ],
        allowCompression: true,
        allowMultiple: false,
      );
      if (kDebugMode) {
        print("pickedFileVideo${pickedFileVideo!.files.first.path}");
      }
      File file = File(pickedFileVideo!.files.first.path!);
      if (kDebugMode) {
        print("file$file");
      }
      int fileSizeInBytes = file.lengthSync();
      fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      if (kDebugMode) {
        print('fileSizeInMB $fileSizeInMB');
      }
      if (fileSizeInMB <= 30) {
        try {
          // setState(() {
          //   isThumbnail = true;
          // });
          thumbnailPath = await VideoThumbnail.thumbnailFile(
            video: pickedFileVideo!.files.first.path!,
            imageFormat: ImageFormat.WEBP,
            quality: 50,
          );
          setState(() {
            isThumbnail = false;
          });
          if (kDebugMode) {
            print("thumbnailPath$thumbnailPath");
          }
        } catch (e) {
          print("thumbnail error $e");
          pickedFileVideo = null;
        }
      } else {
        snackBar("max video size is 30MB");
      }
      setState(() {
        isThumbnail = false;
      });
    } catch (e) {
      setState(() {
        isThumbnail = false;
      });
    }
  }

  @override
  void initState() {
    if (storeController.storeList[0].businessDetails!.video != "") {
      thumbnailPath =
          storeController.storeList[0].businessDetails!.videoThumbnail!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.white
          : AppColors.darkMainBlack,
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
                    Text("Business Videos",
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
                              " Make your business look more trustworthy by uploding videos of your business premises",
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
                        text1: "Add Business Video",
                        text2: "",
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      sizeBoxHeight(6),
                      GestureDetector(
                        onTap: () {
                          openVideoPicker();
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
                                AppAsstes.videoStore,
                                height: getProportionateScreenHeight(27),
                                width: getProportionateScreenWidth(27),
                              ),
                              sizeBoxHeight(4),
                              label(
                                "Service Video",
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
                      sizeBoxHeight(10),
                      label(
                        "Note: You can upload only one video",
                        maxLines: 2,
                        style: poppinsFont(
                          9,
                          AppColors.colorCCCCCC,
                          FontWeight.w400,
                        ),
                      ),
                      thumbnailPath!.isEmpty
                          ? const SizedBox.shrink()
                          : sizeBoxHeight(12),
                      thumbnailPath!.isEmpty
                          ? isThumbnail == true
                              ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: commonLoading())
                                  .paddingOnly(top: 5)
                              : const SizedBox()
                          : Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorEFEFEF,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.antiAlias,
                                      children: [
                                        storeController.storeList[0]
                                                    .businessDetails!.video ==
                                                ""
                                            ? Image.file(
                                                File(thumbnailPath!),
                                                fit: BoxFit.cover,
                                                height:
                                                    getProportionateScreenHeight(
                                                        53),
                                                width:
                                                    getProportionateScreenWidth(
                                                        68),
                                              )
                                            : Image.network(
                                                thumbnailPath!,
                                                fit: BoxFit.cover,
                                                height:
                                                    getProportionateScreenHeight(
                                                        53),
                                                width:
                                                    getProportionateScreenWidth(
                                                        68),
                                              ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.colorFFFFFF
                                                  .withOpacity(0.06),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: AppColors.colorB0B0B0
                                                    .withOpacity(0.12),
                                                width: 0.33,
                                              )),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 4.9, sigmaY: 4.9),
                                              child: Image.asset(
                                                AppAsstes.play2,
                                                height:
                                                    getProportionateScreenHeight(
                                                        7),
                                                width:
                                                    getProportionateScreenWidth(
                                                        7),
                                              ).paddingAll(3),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -5,
                                  top: -5,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        thumbnailPath = '';
                                        pickedFileVideo = null;
                                      });
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
                          if (thumbnailPath!.isEmpty) {
                            snackBar("Please add business video");
                          } else {
                            storeController.storeVideoUpdateApi(
                              storeVideoThumbnail:
                                  thumbnailPath!.isEmpty ? "" : thumbnailPath!,
                              storeVideo: pickedFileVideo == null
                                  ? ""
                                  : pickedFileVideo!.files.first.path!,
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
