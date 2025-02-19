// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class StoreTimeScreen extends StatefulWidget {
  const StoreTimeScreen({super.key});

  @override
  State<StoreTimeScreen> createState() => _StoreTimeScreenState();
}

class _StoreTimeScreenState extends State<StoreTimeScreen> {
  StoreController storeController = Get.find();

  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final startPeriodController = TextEditingController();
  final endPeriodController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      storeController.openDaysList.value = storeController
          .storeList[0].businessTime!.openDays!
          .split(', ')
          .toList();

      storeController.openingAndClosingDays
          .addAll(storeController.openDaysList);

      startTimeController.text =
          storeController.storeList[0].businessTime!.openTime!;

      endTimeController.text =
          storeController.storeList[0].businessTime!.closeTime!;
    });

    super.initState();
  }

  TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context, bool isForStartTime) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: themeContro.isLightMode.value
              ? CupertinoColors.systemBackground.resolveFrom(context)
              : AppColors.darkGray,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: poppinsFont(
                  16,
                  themeContro.isLightMode.value
                      ? Colors.black
                      : AppColors.white,
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
                    Text("Business Timings",
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
                          "Business Timings",
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
                                " ELet your customers know when to reach you. you can also configure dual timing slots in a single day.",
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
                        Text(
                          "Business Time",
                          style: poppinsFont(
                              14,
                              themeContro.isLightMode.value
                                  ? AppColors.black
                                  : AppColors.white,
                              FontWeight.w600),
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
                              color: themeContro.isLightMode.value
                                  ? AppColors.colorEFEFEF
                                  : AppColors.grey1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(27),
                                child:
                                    // ListView.builder(
                                    //   shrinkWrap: true,
                                    //   itemCount: storeController.days.length,
                                    //   padding: EdgeInsets.zero,
                                    //   scrollDirection: Axis.horizontal,
                                    //   physics:
                                    //       const AlwaysScrollableScrollPhysics(),
                                    //   itemBuilder: (context, index) {
                                    //     return Obx(
                                    //       () => GestureDetector(
                                    //         onTap: () {
                                    //           if (storeController
                                    //               .openingAndClosingDays
                                    //               .contains(storeController
                                    //                   .days[index])) {
                                    //             storeController
                                    //                 .openingAndClosingDays
                                    //                 .remove(storeController
                                    //                     .days[index]);
                                    //           } else {
                                    //             storeController
                                    //                 .openingAndClosingDays
                                    //                 .add(storeController
                                    //                     .days[index]);
                                    //           }
                                    //           print(
                                    //               "OPENING DAYS:${storeController.openingAndClosingDays}");
                                    //         },
                                    //         child: globButton(
                                    //           name: storeController.days[index],
                                    //           isOuntLined: storeController
                                    //                   .openingAndClosingDays
                                    //                   .contains(storeController
                                    //                       .days[index])
                                    //               ? false
                                    //               : true,
                                    //           gradient: storeController
                                    //                   .openingAndClosingDays
                                    //                   .contains(storeController
                                    //                       .days[index])
                                    //               ? AppColors.logoColork
                                    //               : null,
                                    //           color:
                                    //               AppColors.blue.withOpacity(0.2),
                                    //           textStyle: poppinsFont(
                                    //               10,
                                    //               storeController
                                    //                       .openingAndClosingDays
                                    //                       .contains(storeController
                                    //                           .days[index])
                                    //                   ? AppColors.white
                                    //                   : AppColors.black,
                                    //               FontWeight.w400),
                                    //           radius: 5,
                                    //           horizontal: 7,
                                    //           vertical: 4,
                                    //         ).paddingOnly(right: 10),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),

                                    ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: storeController.days.length,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => globButton(
                                        onTap: () {
                                          if (storeController
                                              .openingAndClosingDays
                                              .contains(storeController
                                                  .days[index])) {
                                            storeController
                                                .openingAndClosingDays
                                                .remove(storeController
                                                    .days[index]);
                                          } else {
                                            storeController
                                                .openingAndClosingDays
                                                .add(storeController
                                                    .days[index]);
                                          }
                                          print(
                                              "OPENING DAYS:${storeController.openingAndClosingDays}");
                                        },
                                        name: storeController.days[index],
                                        isOuntLined: storeController
                                                .openingAndClosingDays
                                                .contains(
                                                    storeController.days[index])
                                            ? false
                                            : true,
                                        gradient: storeController
                                                .openingAndClosingDays
                                                .contains(
                                                    storeController.days[index])
                                            ? AppColors.logoColork
                                            : null,
                                        color: themeContro.isLightMode.value
                                            ? AppColors.blue.withOpacity(0.2)
                                            : AppColors.grey1,
                                        textStyle: poppinsFont(
                                            10,
                                            storeController
                                                    .openingAndClosingDays
                                                    .contains(storeController
                                                        .days[index])
                                                ? AppColors.white
                                                : themeContro.isLightMode.value
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                      hintText: "Start Time",
                                      context: context,
                                      suffixIcon: Container(
                                        margin: const EdgeInsets.all(16),
                                        child: Image.asset(
                                          AppAsstes.clock,
                                          fit: BoxFit.contain,
                                          height:
                                              getProportionateScreenHeight(16),
                                          width:
                                              getProportionateScreenWidth(16),
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
                                          height:
                                              getProportionateScreenHeight(16),
                                          width:
                                              getProportionateScreenWidth(16),
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
                              color: themeContro.isLightMode.value
                                  ? AppColors.colorEFEFEF
                                  : AppColors.grey1,
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
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => globButton(
                                        name: storeController.days[index],
                                        isOuntLined: storeController
                                                .openingAndClosingDays.isEmpty
                                            ? true
                                            : storeController
                                                    .openingAndClosingDays
                                                    .contains(storeController
                                                        .days[index])
                                                ? true
                                                : false,
                                        gradient: storeController
                                                .openingAndClosingDays.isEmpty
                                            ? null
                                            : storeController
                                                    .openingAndClosingDays
                                                    .contains(storeController
                                                        .days[index])
                                                ? null
                                                : AppColors.logoColork,
                                        color: themeContro.isLightMode.value
                                            ? AppColors.blue.withOpacity(0.2)
                                            : AppColors.grey1,
                                        textStyle: poppinsFont(
                                            10,
                                            storeController
                                                    .openingAndClosingDays
                                                    .isEmpty
                                                ? AppColors.black
                                                : storeController
                                                        .openingAndClosingDays
                                                        .contains(
                                                            storeController
                                                                .days[index])
                                                    ? themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white
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
                                color: themeContro.isLightMode.value
                                    ? AppColors.blue.withOpacity(0.2)
                                    : AppColors.grey1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    label(
                                      "Closed" "        ",
                                      style: poppinsFont(
                                        9,
                                        themeContro.isLightMode.value
                                            ? AppColors.black
                                            : AppColors.white,
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
                          if (storeController.openingAndClosingDays.isEmpty) {
                            snackBar(
                                "Please select your business week timings");
                          } else if (startTimeController.text.trim().isEmpty) {
                            snackBar("Please add your business start time");
                          } else if (endTimeController.text.trim().isEmpty) {
                            snackBar("Please add your business end time");
                          } else {
                            storeController.storeTimingsUpdateApi(
                              openDays: storeController.openingAndClosingDays
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              closedDays: storeController.days
                                  .toSet()
                                  .difference(storeController
                                      .openingAndClosingDays
                                      .toSet())
                                  .toList()
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              openTime:
                                  "${startTimeController.text.trim()} ${startPeriodController.text.trim()}",
                              closeTime:
                                  "${endTimeController.text.trim()} ${endPeriodController.text.trim()}",
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
