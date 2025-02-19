// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/theame_switch.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddStore extends StatefulWidget {
  const AddStore({super.key});

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  final ScrollController _scrollController = ScrollController();
  final StoreController storeController = Get.put(StoreController());
  int currentIndex = 1;
  bool featuredon = false;
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> requestPermission() async {
    await Permission.camera.request();
    await Permission.photos.request();
    await Permission.storage.request();
  }

  @override
  void dispose() {
    requestPermission();
    _scrollController.dispose();
    super.dispose();
  }

  scrollAndNextSection() {
    currentIndex++;
    if (currentIndex < 3) {
      _scrollToTop();
    }
    setState(() {});
  }

  double getProgressValue() {
    return currentIndex / 3; // Calculates progress as a fraction
  }

  final businessNameController = TextEditingController();
  final businessDesciptionController = TextEditingController();
  final businessAddressController = TextEditingController();
  final mobilecontroller = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final whpLinkController = TextEditingController();
  final faceBookLinkController = TextEditingController();
  final instaLinkController = TextEditingController();
  final twitterLinkController = TextEditingController();
  final startPeriodController = TextEditingController();
  final endPeriodController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode nameFocus1 = FocusNode();

  FocusNode descFocus = FocusNode();
  FocusNode descFocus1 = FocusNode();

  FocusNode addressFocus = FocusNode();
  FocusNode addressFocus1 = FocusNode();

  FocusNode mobileFocus = FocusNode();
  FocusNode mobileFocus1 = FocusNode();

  FocusNode emailFocus = FocusNode();
  FocusNode emailFocus1 = FocusNode();

  FocusNode webFocus = FocusNode();
  FocusNode webFocus1 = FocusNode();

  FocusNode whpFocus = FocusNode();
  FocusNode whpFocus1 = FocusNode();

  FocusNode fcFocus = FocusNode();
  FocusNode fcFocus1 = FocusNode();

  FocusNode instaFocus = FocusNode();
  FocusNode instaFocus1 = FocusNode();

  FocusNode twiFocus = FocusNode();
  FocusNode twiFocus1 = FocusNode();

// mutiple image select
  FilePickerResult? pickedFileImage;
  List<File?> files = [];
  List<String> filePaths = [];

  List<File?> coverfiles = [];
  List<String> coverfilePaths = [];

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

  Future<void> openCoverImagePicker() async {
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
      coverfiles = pickedFileImage!.paths.map((path) => File(path!)).toList();
      coverfilePaths = pickedFileImage!.paths.map((path) => (path!)).toList();
      setState(() {});
      print("files $coverfiles");
      print("files Paths $coverfilePaths");
    }
  }

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

  TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context, bool isForStartTime) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: poppinsFont(
                  16,
                  AppColors.black,
                  FontWeight.w500,
                ),
              ),
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  _selectedTime = TimeOfDay.fromDateTime(newDateTime);
                  String period;
                  if (newDateTime.hour < 12) {
                    period = "AM";
                  } else {
                    period = "PM";
                  }
                  String hours = _selectedTime.hour < 10
                      ? "0${_selectedTime.hour}"
                      : "${_selectedTime.hour}";
                  String hour = hours == '12' && period == "PM"
                      ? '24'
                      : hours == '00' && period == "AM"
                          ? "12"
                          : hours;
                  String minute = _selectedTime.minute < 10
                      ? "0${_selectedTime.minute}"
                      : "${_selectedTime.minute}";
                  if (isForStartTime) {
                    if (kDebugMode) {
                      _selectedTime.periodOffset;
                      print(_selectedTime.format(context));
                    }
                    startPeriodController.text = period;
                    startTimeController.text = "$hour:$minute";
                  } else {
                    endPeriodController.text = period;
                    endTimeController.text = "$hour:$minute";
                  }
                  if (kDebugMode) {
                    print(_selectedTime);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  final List<String> _monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String? selectedMonthValue;

  final List<String> _yearList = List.generate(
    DateTime.now().year - 1990 + 1,
    (index) => (DateTime.now().year - index).toString(),
  );

  String? selectedYearValue; // To store the selected year

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAsstes.line_design), fit: BoxFit.cover),
          color: AppColors.blue),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          // leading: Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: GestureDetector(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: Image.asset(
          //         'assets/images/arrow-left1.png',
          //         color: Colors.white,
          //         height: 15,
          //       )),
          // ),
          titleSpacing: 20,
          title: Text(
            currentIndex == 1
                ? "Add Store"
                : currentIndex == 2
                    ? "Contact Details"
                    : "Business Time",
            style: poppinsFont(20, AppColors.white, FontWeight.w500),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: AppColors.blueeShine),
            child: Column(
              children: [
                sizeBoxHeight(20),
                progress(),
                sizeBoxHeight(20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: AppColors.white),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizeBoxHeight(20),
                          currentIndex == 1
                              ? businessDetails()
                                  .paddingSymmetric(horizontal: 20)
                              : currentIndex == 2
                                  ? contactDetails()
                                      .paddingSymmetric(horizontal: 20)
                                  : businessTime()
                                      .paddingSymmetric(horizontal: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      // scrollAndNextSection();
                      addStore();
                    },
                    child: Container(
                      height: getProportionateScreenHeight(45),
                      color: AppColors.blue,
                      child: storeController.addStoreLoad.value
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeAlign: -6,
                                  strokeWidth: 2,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator.adaptive(
                                      strokeWidth: 2,
                                      strokeAlign: -6,
                                      strokeCap: StrokeCap.round,
                                      value:
                                          getProgressValue(), // Update progress based on index
                                      backgroundColor: AppColors.bluee1,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                    Text(
                                      currentIndex
                                          .toString(), // Display the percentage here
                                      style: poppinsFont(
                                          10, AppColors.white, FontWeight.w500),
                                    )
                                  ],
                                ),
                                sizeBoxWidth(10),
                                Text(
                                  "Next Step",
                                  style: poppinsFont(
                                      14, AppColors.white, FontWeight.w400),
                                )
                              ],
                            ),
                    ),
                  ).paddingOnly(bottom: 20);
                }),
              ],
            ),
          ).paddingOnly(top: 10),
        ),
      ),
    );
  }

  addStore() {
    if (currentIndex == 1) {
      if (businessNameController.text.trim().isNotEmpty &&
          businessDesciptionController.text.trim().isNotEmpty &&
          businessAddressController.text.isNotEmpty &&
          coverfiles.isNotEmpty &&
          files.isNotEmpty && // Corrected this condition
          storeController.caategoryName.isNotEmpty &&
          storeController.subCategoryNames.isNotEmpty &&
          selectedVtypes != "" &&
          selectedMonthValue != "" &&
          selectedYearValue != "") {
        scrollAndNextSection();
      } else {
        snackBar("Fill the mandatory fields");
      }
    } else if (currentIndex == 2) {
      if (mobilecontroller.text.trim().isNotEmpty &&
          emailController.text.trim().isNotEmpty) {
        scrollAndNextSection();
      } else {
        snackBar("Fill the mandatory fields");
      }
    } else {
      if (storeController.openingAndClosingDays.isNotEmpty &&
          startTimeController.text.trim().isNotEmpty &&
          endTimeController.text.trim().isNotEmpty) {
        storeController.addSotreApi(
          featured: featuredon ? "1" : "0",
          storeName: businessNameController.text.trim(),
          storeDescription: businessDesciptionController.text.trim(),
          address: businessAddressController.text.trim(),
          lat: storeController.searchLatitude.toString(),
          lon: storeController.searchLongitude.toString(),
          // Fixed lon
          coverImages: coverfilePaths,
          storeImages: filePaths,
          storeVideoThumbnail: thumbnailPath!.isEmpty ? "" : thumbnailPath!,
          storeVideo:
              pickedFileVideo == null ? "" : pickedFileVideo!.files.first.path!,
          categoryId: storeController.categoryData.value.data!
              .where(
                (element) =>
                    element.categoryName == storeController.caategoryName.value,
              )
              .first
              .id
              .toString(),
          subCategoryId: storeController.categoryData.value.data!
              .where(
                (category) =>
                    category.categoryName ==
                    storeController.caategoryName.value,
              )
              .first
              .subCategoryData!
              .where((subCategory) => storeController.subCategoryNames
                  .contains(subCategory.subcategoryName))
              .map((subCategory) => subCategory.id.toString())
              .toList()
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll(' ', ''),
          employeeStrength: selectedVtypes.toString(),
          publishedMonth: selectedMonthValue.toString(),
          publishedYear: selectedYearValue.toString(),
          openDays: storeController.openingAndClosingDays
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
          closeDays: storeController.days
              .toSet()
              .difference(storeController.openingAndClosingDays.toSet())
              .toList()
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
          openTime:
              "${startTimeController.text.trim()} ${startPeriodController.text.trim()}",
          closeTime:
              "${endTimeController.text.trim()} ${endPeriodController.text.trim()}",
          countryCode: contrycode,
          storePhone: contrycode + mobilecontroller.text.trim(),
          storeEmail: emailController.text.trim(),
          storeSite: websiteController.text.trim(),
          facebooklink: faceBookLinkController.text.trim().isNotEmpty
              ? faceBookLinkController.text.trim()
              : "",
          instagramlink: instaLinkController.text.trim().isNotEmpty
              ? instaLinkController.text.trim()
              : "",
          twitterlink: twitterLinkController.text.trim().isNotEmpty
              ? twitterLinkController.text.trim()
              : "",
          whatsapplink: whpLinkController.text.trim().isNotEmpty
              ? whpLinkController.text.trim()
              : "",
        );
        storeController.caategoryName.value = '';
        storeController.subCategoryNames.value = [];
        storeController.subCategories = [];
      } else {
        snackBar("Fill the mandatory fields");
      }
    }
  }

//=============================================================== ADD BUSINESS DETAIL ====================================================================================
//=============================================================== ADD BUSINESS DETAIL ====================================================================================
//=============================================================== ADD BUSINESS DETAIL ====================================================================================
  Widget businessDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business Detail",
          style: poppinsFont(14, AppColors.black, FontWeight.w600),
        ),
        sizeBoxHeight(20),
        globalTextField2(
          lable: "Business Name",
          lable2: " *",
          controller: businessNameController,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(nameFocus);
          },
          focusNode: nameFocus1,
          hintText: "Business Name",
          context: context,
        ),
        sizeBoxHeight(20),
        globalTextField2(
          maxLines: 3,
          lable2: " *",
          lable: "Business Description",
          controller: businessDesciptionController,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(descFocus);
          },
          focusNode: descFocus1,
          hintText: "Business Description",
          context: context,
        ),
        sizeBoxHeight(20),
        globalTextField2(
          maxLines: 3,
          lable2: " *",
          lable: "Business Address",
          controller: businessAddressController,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(addressFocus);
          },
          onChanged: (p0) async {
            setState(() {});
            await storeController.getLonLat(p0);
            await storeController.getsuggestion(p0);
            setState(() {});
          },
          focusNode: addressFocus1,
          hintText: "Business Address",
          context: context,
        ),
        businessAddressController.text.isEmpty
            ? const SizedBox()
            : storeController.mapresult.isEmpty
                ? const SizedBox()
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: storeController.mapresult.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              businessAddressController.text = storeController
                                  .mapresult[index]['description'];
                              storeController.mapresult.clear();
                              storeController
                                  .getLonLat(businessAddressController.text);
                            });
                          },
                          child: Text(storeController.mapresult[index]
                                  ['description'])
                              .paddingOnly(
                                  left: 12,
                                  bottom:
                                      storeController.mapresult.length - 1 ==
                                              index
                                          ? 0
                                          : 15),
                        );
                      },
                    ),
                  ),
        sizeBoxHeight(20),
        twoText(
          fontWeight: FontWeight.w600,
          text1: "Add Cover Images",
          text2: " *",
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(6),
        GestureDetector(
          onTap: () {
            openCoverImagePicker();
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
        coverfiles.isEmpty ? const SizedBox.shrink() : sizeBoxHeight(12),
        coverfiles.isEmpty
            ? const SizedBox.shrink()
            : SizedBox(
                height: getProportionateScreenHeight(58),
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: coverfiles.length,
                  separatorBuilder: (context, index) {
                    return sizeBoxWidth(15);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.colorB0B0B0, width: 1)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              coverfiles[index]!,
                              fit: BoxFit.cover,
                              height: getProportionateScreenHeight(52),
                              width: getProportionateScreenWidth(52),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -5,
                          top: -5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                coverfiles.removeAt(index);
                                coverfiles;
                                print(coverfiles);
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
                    );
                  },
                ),
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
          style: poppinsFont(9, AppColors.colorCCCCCC, FontWeight.w500),
        ),
        files.isEmpty ? const SizedBox.shrink() : sizeBoxHeight(12),
        files.isEmpty
            ? const SizedBox.shrink()
            : SizedBox(
                height: getProportionateScreenHeight(58),
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: files.length,
                  separatorBuilder: (context, index) {
                    return sizeBoxWidth(15);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.colorB0B0B0, width: 1)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              files[index]!,
                              fit: BoxFit.cover,
                              height: getProportionateScreenHeight(52),
                              width: getProportionateScreenWidth(52),
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
        sizeBoxHeight(20),
        label(
          "Add Business Video",
          style: poppinsFont(
            10,
            AppColors.black,
            FontWeight.w600,
          ),
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
        thumbnailPath!.isEmpty ? const SizedBox.shrink() : sizeBoxHeight(12),
        thumbnailPath!.isEmpty
            ? isThumbnail == true
                ? SizedBox(height: 20, width: 20, child: commonLoading())
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
                          Image.file(
                            File(thumbnailPath!),
                            fit: BoxFit.cover,
                            height: getProportionateScreenHeight(53),
                            width: getProportionateScreenWidth(68),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorFFFFFF.withOpacity(0.06),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      AppColors.colorB0B0B0.withOpacity(0.12),
                                  width: 0.33,
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 4.9, sigmaY: 4.9),
                                child: Image.asset(
                                  AppAsstes.play2,
                                  height: getProportionateScreenHeight(7),
                                  width: getProportionateScreenWidth(7),
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
        sizeBoxHeight(20),
        twoText(
          text1: "Categories",
          text2: " *",
          fontWeight: FontWeight.w600,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(7),
        DropDown(forWhat: "Categories"),
        sizeBoxHeight(15),
        Obx(
          () => storeController.caategoryName.isEmpty
              ? const SizedBox.shrink()
              : globButton(
                  name: storeController.caategoryName.value,
                  gradient: AppColors.logoColork,
                  radius: 6,
                  vertical: 5,
                  horizontal: 15,
                  isOuntLined: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      label(
                        storeController.caategoryName.value,
                        style: poppinsFont(
                          9,
                          AppColors.black,
                          FontWeight.w500,
                        ),
                      ),
                      sizeBoxWidth(8),
                      GestureDetector(
                        onTap: () {
                          storeController.caategoryName.value = '';
                          storeController.subCategoryNames.value = [];
                          storeController.subCategories = [];
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppColors.black,
                          size: 10,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 12, vertical: 7),
                ),
        ),
        sizeBoxHeight(20),
        twoText(
          text1: "Sub Categories",
          text2: " *",
          fontWeight: FontWeight.w600,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(7),
        DropDown(forWhat: "Sub Categories"),
        sizeBoxHeight(16),
        Obx(() => storeController.subCategoryNames.isEmpty
            ? const SizedBox.shrink()
            : SizedBox(
                height: getProportionateScreenHeight(35),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: storeController.subCategoryNames.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return globButton(
                      name: "",
                      gradient: AppColors.logoColork,
                      radius: 6,
                      vertical: 5,
                      horizontal: 15,
                      isOuntLined: true,
                      child: Row(
                        children: [
                          label(
                            storeController.subCategoryNames[index],
                            style: poppinsFont(
                              9,
                              AppColors.black,
                              FontWeight.w500,
                            ),
                          ),
                          sizeBoxWidth(8),
                          GestureDetector(
                            onTap: () {
                              storeController.subCategoryNames.removeAt(index);
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.black,
                              size: 10,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(
                        horizontal: 15,
                      ),
                    ).paddingOnly(
                        right:
                            storeController.subCategoryNames.length - 1 == index
                                ? 0
                                : 10);
                  },
                ),
              )),
        sizeBoxHeight(7),
        featuredSwitch(),
        sizeBoxHeight(20),
        twoText(
          text1: "Select Number of Employees",
          text2: " *",
          fontWeight: FontWeight.w600,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(7),
        selectEmployee(),
        sizeBoxHeight(20),
        Text(
          "Year of Establishment",
          style: poppinsFont(13, AppColors.black, FontWeight.w600),
        ),
        sizeBoxHeight(10),
        monthYearWidget(),
        sizeBoxHeight(30),
      ],
    );
  }

  Widget featuredSwitch() {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.colorEFEFEF),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              label(
                "Featured Service",
                fontSize: 12,
                textColor: Colors.black,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
          CustomSwitch(
            value: featuredon,
            onChanged: (bool val) {
              setState(() {
                featuredon = val;
                print("STATUS: ${val ? "1" : "0"}");
                print('bool$featuredon');
                // storeController.storeStatus(sotreStatus: val ? "1" : "0");
              });
            },
          )
        ],
      ).paddingSymmetric(horizontal: 15),
    );
  }

  String? selectedVtypes; // Allow null value
  Widget selectEmployee() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorEFEFEF),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: const SizedBox(),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15),
        hint: Text(
          selectedVtypes ?? 'Select an option',
          style: poppinsFont(12, AppColors.black, FontWeight.w500),
        ),
        items: [
          'Less than 10',
          '10-100',
          '100-500',
          '500-1000',
          '1000-2000',
          '2000-5000',
          '5000-10000',
          'More than 10000'
        ].map((String value) {
          return DropdownMenuItem(
            value: value,
            child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 0),
                title: Text(
                  value,
                  style: poppinsFont(12, AppColors.black, FontWeight.w600),
                ),
                leading: Radio<String>(
                  activeColor: AppColors.blue,
                  value: value,
                  groupValue: selectedVtypes,
                  onChanged: (val) {
                    setState(() {
                      selectedVtypes = val!;
                    });
                  },
                ) // Hide radio button if the item is selected
                ),
          );
        }).toList(),
        icon: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Transform.rotate(
            angle: -pi / 2,
            child: Image.asset(
              "assets/images/arrow-left1.png",
              height: 20,
            ),
          ),
        ),
        onChanged: (String? vtype) {
          setState(() {
            selectedVtypes = vtype;
          });
        },
      ),
    );
  }

  DateTime currentDate = DateTime.now();
  Widget monthYearWidget() {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            twoText(
              fontWeight: FontWeight.w600,
              text1: "Month",
              text2: " *",
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            sizeBoxHeight(7),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15, right: 15),
                    fillColor: Colors.white,
                    filled: true,
                    errorStyle: const TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: AppColors.bluee4)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide:
                            BorderSide(color: AppColors.black, width: 1)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColors.black)),
                    disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: AppColors.black)),
                  ),
                  isEmpty: selectedMonthValue == '',
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    menuMaxHeight: getProportionateScreenHeight(300),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    iconEnabledColor: AppColors.black,
                    iconDisabledColor: AppColors.black,
                    value: selectedMonthValue,
                    isDense: true,
                    hint: Text("Select month*",
                        style:
                            poppinsFont(12, AppColors.black, FontWeight.w400)),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) async {
                      setState(() {
                        selectedMonthValue = newValue!;
                        state.didChange(newValue);
                      });
                    },
                    items: _monthList.map((String month) {
                      return DropdownMenuItem(
                        value: month,
                        child: Text(
                          month.toString(),
                          style: poppinsFont(12, Colors.black, FontWeight.w400),
                        ),
                      );
                    }).toList(),
                  )),
                );
              },
              validator: (value) {
                if (selectedMonthValue!.isEmpty) {
                  selectedMonthValue = null;
                  return 'Please select a month';
                }
                return null;
              },
            ),
          ],
        )),
        sizeBoxWidth(20),
        Expanded(
            child: Column(
          children: [
            twoText(
              fontWeight: FontWeight.w600,
              text1: "Year",
              text2: " *",
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            sizeBoxHeight(7),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15, right: 15),
                    fillColor: Colors.white,
                    filled: true,
                    errorStyle: const TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: AppColors.bluee4),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: AppColors.black, width: 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: AppColors.black),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: AppColors.black),
                    ),
                  ),
                  isEmpty: selectedYearValue == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      menuMaxHeight: getProportionateScreenHeight(300),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconEnabledColor: AppColors.black,
                      iconDisabledColor: AppColors.black,
                      value: selectedYearValue,
                      isDense: true,
                      hint: Text(
                        "Select Year*",
                        style:
                            poppinsFont(12, AppColors.black, FontWeight.w400),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) async {
                        setState(() {
                          selectedYearValue = newValue!;
                          state.didChange(newValue);
                        });
                      },
                      items: _yearList.map((String year) {
                        return DropdownMenuItem(
                          value: year,
                          child: Text(
                            year,
                            style:
                                poppinsFont(12, Colors.black, FontWeight.w400),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              validator: (value) {
                if (selectedYearValue == null || selectedYearValue!.isEmpty) {
                  return 'Please select a year';
                }
                return null;
              },
            ),
          ],
        )),
      ],
    );
  }

//==================================================================== CONTACT DETAIL TAB =======================================================================
//==================================================================== CONTACT DETAIL TAB =======================================================================
//==================================================================== CONTACT DETAIL TAB =======================================================================

  String phoneNumber = '';
  Widget contactDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Details",
          style: poppinsFont(14, AppColors.black, FontWeight.w600),
        ),
        sizeBoxHeight(20),
        twoText(
          fontWeight: FontWeight.w600,
          text1: "Mobile Number",
          text2: " *",
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(7),
        IntlPhoneField(
          initialValue: contrycode,
          showCountryFlag: true,
          showDropdownIcon: false,
          initialCountryCode: "IN",
          // onCountryChanged: (value) {
          //   contrycode = '+${value.dialCode}';
          //   print('+$contrycode');
          // },
          // onChanged: (number) {
          //   contrycode = number.completeNumber;
          //   print(number);
          // },
          onCountryChanged: (value) {
            contrycode = '+${value.dialCode}';
            print("Countrycode ::$contrycode");
          },
          onChanged: (number) {
            phoneNumber = number.number;
            // Extract only the phone number
            print("Phone Number ::$phoneNumber");
          },
          focusNode: nameFocus1,
          cursorColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : AppColors.bluee4,
          autofocus: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
          controller: mobilecontroller,
          keyboardType: TextInputType.number,
          flagsButtonPadding: const EdgeInsets.only(left: 5),
          decoration: InputDecoration(
            counterText: '',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: AppColors.bluee4)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: AppColors.colorEFEFEF)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppColors.colorEFEFEF)),
            hintText: "Add Mobile Number".tr,
            hintStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.colorB0B0B0,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: AppColors.colorEFEFEF)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: AppColors.colorEFEFEF)),
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
          ),
        ),
        sizeBoxHeight(20),
        globalTextField2(
          lable: "Email",
          lable2: " *",
          controller: emailController,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(emailFocus);
          },
          focusNode: emailFocus1,
          hintText: "Email",
          context: context,
        ),
        sizeBoxHeight(20),
        globalTextField2(
          lable: "Website",
          lable2: " ",
          controller: websiteController,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(webFocus);
          },
          focusNode: webFocus1,
          hintText: "Website",
          context: context,
        ),
        sizeBoxHeight(20),
        twoText(
          fontWeight: FontWeight.w600,
          text1: "Follow Us on",
          text2: "",
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(7),
        followeUSOnWidget(),
        sizeBoxHeight(10),
      ],
    );
  }

  Widget followeUSOnWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              followContainer(img: AppAsstes.whatsapp, title: 'What’s app'),
              followContainer(img: AppAsstes.Facebook, title: 'Facebook'),
              followContainer(img: AppAsstes.instagram, title: 'Instagram'),
              followContainer(img: AppAsstes.twitter, title: 'Twitter'),
            ],
          ),
          sizeBoxHeight(5),
          globalTextField2(
              controller: whpLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(whpFocus);
              },
              focusNode: whpFocus1,
              hintText: 'Add What’s app link',
              context: context),
          sizeBoxHeight(10),
          globalTextField2(
              controller: faceBookLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(fcFocus);
              },
              focusNode: fcFocus1,
              hintText: 'Add Facebook profile link',
              context: context),
          sizeBoxHeight(10),
          globalTextField2(
              controller: instaLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(instaFocus);
              },
              focusNode: instaFocus1,
              hintText: 'Add Instagram profile link',
              context: context),
          sizeBoxHeight(10),
          globalTextField2(
              controller: twitterLinkController,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(twiFocus);
              },
              focusNode: twiFocus1,
              hintText: 'Add Twitter profile link',
              context: context),
        ],
      ).paddingAll(10),
    );
  }

  Widget followContainer({required String img, required String title}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.blue)),
      child: Row(
        children: [
          Image.asset(img, height: 16),
          sizeBoxWidth(5),
          Text(title, style: poppinsFont(7, AppColors.black, FontWeight.w500))
        ],
      ).paddingAll(5),
    );
  }

//==================================================================== BUSINESS TIME TAB ========================================================================
//==================================================================== BUSINESS TIME TAB ========================================================================
//==================================================================== BUSINESS TIME TAB ========================================================================
  Widget businessTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business Time",
          style: poppinsFont(14, AppColors.black, FontWeight.w600),
        ),
        sizeBoxHeight(20),
        twoText(
          fontWeight: FontWeight.w600,
          text1: "Business Opening Hours",
          text2: " *",
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(7),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.colorEFEFEF,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(27),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: storeController.days.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          if (storeController.openingAndClosingDays
                              .contains(storeController.days[index])) {
                            storeController.openingAndClosingDays
                                .remove(storeController.days[index]);
                          } else {
                            storeController.openingAndClosingDays
                                .add(storeController.days[index]);
                          }
                        },
                        child: globButton(
                          name: storeController.days[index],
                          isOuntLined: storeController.openingAndClosingDays
                                  .contains(storeController.days[index])
                              ? false
                              : true,
                          gradient: storeController.openingAndClosingDays
                                  .contains(storeController.days[index])
                              ? AppColors.logoColork
                              : null,
                          color: AppColors.blue.withOpacity(0.2),
                          textStyle: poppinsFont(
                              10,
                              storeController.openingAndClosingDays
                                      .contains(storeController.days[index])
                                  ? AppColors.white
                                  : AppColors.black,
                              FontWeight.w400),
                          radius: 5,
                          horizontal: 7,
                          vertical: 4,
                        ).paddingOnly(right: 10),
                      ),
                    );
                  },
                ),
              ),
              sizeBoxHeight(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAsstes.infoCircle,
                    height: getProportionateScreenHeight(15),
                    width: getProportionateScreenWidth(15),
                  ),
                  sizeBoxWidth(9),
                  Expanded(
                    child: label(
                      'Select the multiple days you want to provide the service to the users',
                      fontSize: 8,
                      maxLines: 2,
                      textColor: AppColors.colorB0B0B0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: globalTextField(
                      controller: startTimeController,
                      focusedBorderColor: AppColors.colorEFEFEF,
                      onTap: () {
                        _selectTime(context, true);
                      },
                      isOnlyRead: true,
                      onEditingComplete: () {},
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      hintText: "Start Time",
                      context: context,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(16),
                        child: Image.asset(
                          AppAsstes.clock,
                          fit: BoxFit.contain,
                          height: getProportionateScreenHeight(16),
                          width: getProportionateScreenWidth(16),
                          color: AppColors.colorB4B4B4,
                        ),
                      ),
                    ),
                  ),
                  sizeBoxWidth(20),
                  Expanded(
                    child: globalTextField(
                      controller: endTimeController,
                      focusedBorderColor: AppColors.colorEFEFEF,
                      onTap: () {
                        _selectTime(context, false);
                      },
                      isOnlyRead: true,
                      onEditingComplete: () {
                        // FocusScope.of(context).unfocus();
                      },
                      hintText: "End Time",
                      context: context,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(16),
                        child: Image.asset(
                          AppAsstes.clock,
                          fit: BoxFit.contain,
                          height: getProportionateScreenHeight(16),
                          width: getProportionateScreenWidth(16),
                          color: AppColors.colorB4B4B4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(
            horizontal: 15,
            vertical: 15,
          ),
        ),
        sizeBoxHeight(20),
        twoText(
          text1: "Select Days of the Week",
          text2: " *",
          fontWeight: FontWeight.w600,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        sizeBoxHeight(7),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.colorEFEFEF,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(27),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: storeController.days.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => globButton(
                        name: storeController.days[index],
                        isOuntLined:
                            storeController.openingAndClosingDays.isEmpty
                                ? true
                                : storeController.openingAndClosingDays
                                        .contains(storeController.days[index])
                                    ? true
                                    : false,
                        gradient: storeController.openingAndClosingDays.isEmpty
                            ? null
                            : storeController.openingAndClosingDays
                                    .contains(storeController.days[index])
                                ? null
                                : AppColors.logoColork,
                        color: AppColors.blue.withOpacity(0.2),
                        textStyle: poppinsFont(
                            10,
                            storeController.openingAndClosingDays.isEmpty
                                ? AppColors.black
                                : storeController.openingAndClosingDays
                                        .contains(storeController.days[index])
                                    ? AppColors.black
                                    : AppColors.white,
                            FontWeight.w400),
                        radius: 5,
                        horizontal: 7,
                        vertical: 4,
                      ).paddingOnly(right: 10),
                    );
                  },
                ),
              ),
              sizeBoxHeight(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAsstes.infoCircle,
                    height: getProportionateScreenHeight(15),
                    width: getProportionateScreenWidth(15),
                  ),
                  sizeBoxWidth(9),
                  Expanded(
                    child: label(
                      'Select the multiple days you want to provide the service to the users',
                      fontSize: 8,
                      maxLines: 2,
                      textColor: AppColors.colorB0B0B0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              sizeBoxHeight(20),
              globButton(
                name: "",
                gradient: AppColors.logoColork,
                radius: 6,
                vertical: 5,
                horizontal: 15,
                isOuntLined: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    label(
                      "Closed" "        ",
                      style: poppinsFont(
                        9,
                        AppColors.black,
                        FontWeight.w500,
                      ),
                    ),
                    sizeBoxWidth(8),
                    Image.asset(
                      AppAsstes.close,
                      height: getProportionateScreenHeight(16),
                      width: getProportionateScreenWidth(16),
                    )
                  ],
                ).paddingSymmetric(horizontal: 10, vertical: 5),
              )
            ],
          ).paddingSymmetric(
            horizontal: 15,
            vertical: 15,
          ),
        ),
      ],
    );
  }

//========================================================================== TOP PROGRESS BAR ====================================================================
//========================================================================== TOP PROGRESS BAR ====================================================================
//========================================================================== TOP PROGRESS BAR ====================================================================
  Widget progress() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            prItem(
              image: AppAsstes.addshop,
              title: "Business Detail",
              index: 1,
            ),
            prItem(
              image: AppAsstes.addlocation,
              title: "Contact Details",
              index: 2,
            ),
            prItem(
              image: AppAsstes.addtime,
              title: "Business Time",
              index: 3,
            ),
          ],
        ).paddingSymmetric(horizontal: 65),
        sizeBoxHeight(10),
        prBar(index: currentIndex).paddingOnly(right: 22, left: 22),
      ],
    );
  }

  Widget prBar({required int index}) {
    return TweenAnimationBuilder<double>(
      tween:
          Tween<double>(begin: 0, end: index / 3), // Smoothly animate the value
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(colors: const [
                AppColors.prColor1,
                AppColors.prColor,
                Colors.white,
              ], stops: [
                value / 2,
                value,
                value,
              ])),
          child: const SizedBox(height: 5),
        );
        // LinearProgressIndicator(
        //   borderRadius: BorderRadius.circular(5),
        //   backgroundColor: AppColors.white,
        //   value: value, // Use the animated value here
        //   minHeight: 5,
        //   valueColor: const AlwaysStoppedAnimation<Color>(AppColors.blue),
        // );
      },
    );
  }

  Widget prItem({
    required String image,
    required String title,
    required int index,
  }) {
    return Column(
      children: [
        Container(
          height: getProportionateScreenHeight(35),
          width: getProportionateScreenWidth(35),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index <= currentIndex ? AppColors.blue : AppColors.bluee4,
          ),
          child: Image.asset(
            image,
          ).paddingAll(7),
        ),
        sizeBoxHeight(7),
      ],
    );
  }
}
