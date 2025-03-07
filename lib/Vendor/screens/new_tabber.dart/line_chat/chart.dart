// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/insights_controller.dart';
import 'package:nlytical_app/models/vendor_models/insights_model.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  InsightsController insightsController = Get.find();

  // late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    insightsController.selectionBehavior = SelectionBehavior(enable: true);
    insightsController.selectedMonthValue.value =
        insightsController.monthList[now.month - 1];
    String fullMonthName = insightsController.fullMonthList[insightsController
        .monthList
        .indexOf(insightsController.selectedMonthValue.value)];
    insightsController.graphApi(monthName: fullMonthName).then((_) {
      setState(() {});
    });
    // _zoomPanBehavior = ZoomPanBehavior(
    //     enableDoubleTapZooming: false,
    //     enablePanning: true,
    //     enablePinching: true,
    //     enableSelectionZooming: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
        body: SizedBox(
            height: Get.height,
            child: Stack(clipBehavior: Clip.antiAlias, children: [
              Container(
                width: Get.width,
                height: getProportionateScreenHeight(150),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAsstes.line_design)),
                    color: AppColors.blue),
              ),
              Positioned(
                top: getProportionateScreenHeight(70),
                left:
                    0, // Ensures alignment is calculated across the entire width
                right: 0,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/arrow-left1.png',
                            color: AppColors.white,
                            height: 24,
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "View Insights",
                          textAlign: TextAlign.center,
                          fontSize: 20,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox()
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
              Positioned(
                  top: 105,
                  child: Container(
                    width: Get.width,
                    height: getProportionateScreenHeight(760),
                    decoration: BoxDecoration(
                        color: themeContro.isLightMode.value
                            ? Colors.white
                            : AppColors.darkMainBlack,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Obx(() {
                      return Column(
                        children: [
                          sizeBoxHeight(10),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Overview",
                                      style: poppinsFont(
                                          14,
                                          themeContro.isLightMode.value
                                              ? AppColors.black
                                              : AppColors.white,
                                          FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Monthly",
                                          style: poppinsFont(
                                              12,
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              FontWeight.w600),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: 80,
                                          height: 32,
                                          child: FormField<String>(
                                            builder:
                                                (FormFieldState<String> state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                  fillColor: themeContro
                                                          .isLightMode.value
                                                      ? AppColors.colorEBEBEB
                                                      : AppColors.darkGray,
                                                  filled: true,
                                                  errorStyle: const TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 16.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          BorderSide.none),
                                                ),
                                                isEmpty: insightsController
                                                        .selectedMonthValue
                                                        .value ==
                                                    '',
                                                child:
                                                    DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                  isExpanded: true,
                                                  dropdownColor: themeContro
                                                          .isLightMode.value
                                                      ? Colors.white
                                                      : AppColors.darkGray,
                                                  menuMaxHeight:
                                                      getProportionateScreenHeight(
                                                          300),
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down_rounded),
                                                  iconEnabledColor: themeContro
                                                          .isLightMode.value
                                                      ? Colors.black
                                                      : AppColors.white,
                                                  iconDisabledColor: themeContro
                                                          .isLightMode.value
                                                      ? Colors.black
                                                      : AppColors.white,
                                                  value: insightsController
                                                      .selectedMonthValue.value,
                                                  isDense: true,
                                                  hint: Text("Select",
                                                      style: poppinsFont(
                                                          12,
                                                          themeContro
                                                                  .isLightMode
                                                                  .value
                                                              ? AppColors.black
                                                              : AppColors.white,
                                                          FontWeight.w600)),
                                                  style: poppinsFont(
                                                      12,
                                                      themeContro
                                                              .isLightMode.value
                                                          ? AppColors.black
                                                          : AppColors.white,
                                                      FontWeight.w600),
                                                  onChanged:
                                                      (String? newValue) async {
                                                    setState(() {
                                                      insightsController
                                                          .selectedMonthValue
                                                          .value = newValue!;
                                                      state.didChange(newValue);
                                                      String fullMonthName =
                                                          insightsController
                                                                  .fullMonthList[
                                                              insightsController
                                                                  .monthList
                                                                  .indexOf(insightsController
                                                                      .selectedMonthValue
                                                                      .value)];
                                                      insightsController
                                                          .graphApi(
                                                              monthName:
                                                                  fullMonthName);
                                                    });
                                                  },
                                                  items: insightsController
                                                      .monthList
                                                      .map((String month) {
                                                    return DropdownMenuItem(
                                                      value: month,
                                                      child: Text(
                                                        month.toString(),
                                                        style: poppinsFont(
                                                            12,
                                                            themeContro
                                                                    .isLightMode
                                                                    .value
                                                                ? Colors.black
                                                                : AppColors
                                                                    .white,
                                                            FontWeight.w600),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )),
                                              );
                                            },
                                            validator: (value) {
                                              if (insightsController
                                                          .selectedMonthValue
                                                          .value ==
                                                      null ||
                                                  insightsController
                                                      .selectedMonthValue
                                                      .value!
                                                      .isEmpty) {
                                                return 'Please select a month';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ).paddingOnly(left: 20, right: 20, top: 20),
                                const SizedBox(height: 30),
                                Container(
                                  height: Get.height * 0.14,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 20.23,
                                            offset: const Offset(0, 0),
                                            spreadRadius: 0,
                                            color: themeContro.isLightMode.value
                                                ? Colors.grey.shade300
                                                : AppColors.darkShadowColor)
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: themeContro.isLightMode.value
                                          ? AppColors.white
                                          : AppColors.darkGray),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      rowWidget(
                                        title: "Store Visits",
                                        count:
                                            insightsController.isLoading.value
                                                ? "0"
                                                : insightsController.model.value
                                                    .countRetrieved!.storevisits
                                                    .toString(),
                                      ),
                                      Divider(
                                              color:
                                                  themeContro.isLightMode.value
                                                      ? Colors.grey.shade200
                                                      : AppColors.darkgray2)
                                          .paddingSymmetric(horizontal: 20),
                                      rowWidget(
                                        title: "Number of Favorites",
                                        count:
                                            insightsController.isLoading.value
                                                ? "0"
                                                : insightsController.model.value
                                                    .countRetrieved!.storelikes
                                                    .toString(),
                                      ),
                                      Divider(
                                              color:
                                                  themeContro.isLightMode.value
                                                      ? Colors.grey.shade200
                                                      : AppColors.darkgray2)
                                          .paddingSymmetric(horizontal: 20),
                                      rowWidget(
                                        title: "Leads Received",
                                        count:
                                            insightsController.isLoading.value
                                                ? "0"
                                                : insightsController.model.value
                                                    .countRetrieved!.leads
                                                    .toString(),
                                      ),
                                    ],
                                  ),
                                ).paddingSymmetric(horizontal: 20),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Number of users visits daily",
                                      style: poppinsFont(
                                          14,
                                          themeContro.isLightMode.value
                                              ? AppColors.black
                                              : AppColors.white,
                                          FontWeight.w600),
                                    ),
                                    const SizedBox()
                                  ],
                                ).paddingSymmetric(horizontal: 20),
                                sizeBoxHeight(20),
                                SfCartesianChart(
                                  enableAxisAnimation: true,
                                  enableSideBySideSeriesPlacement: true,
                                  onPlotAreaSwipe:
                                      (ChartSwipeDirection direction) =>
                                          insightsController
                                              .performSwipe(direction),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePanning: true,
                                    enableSelectionZooming: true,
                                    enablePinching: true,
                                  ),
                                  primaryXAxis: const CategoryAxis(
                                    labelRotation: 0,
                                    interval: 1,
                                    isVisible: true,
                                    autoScrollingMode: AutoScrollingMode.start,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    initialVisibleMaximum:
                                        insightsController.axisVisibleMax,
                                    initialVisibleMinimum:
                                        insightsController.axisVisibleMin,
                                    // minimum:
                                    //     0, // Ensure the minimum value starts from 0
                                    // maximum:
                                    //     500, // Set the maximum limit to 500
                                    // interval:
                                    //     100, // Adjust intervals for better readability

                                    onRendererCreated:
                                        (NumericAxisController controller) {
                                      insightsController.axisController =
                                          controller;
                                    },
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    minorGridLines:
                                        const MinorGridLines(width: 0),
                                  ),
                                  legend: const Legend(isVisible: true),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  loadMoreIndicatorBuilder:
                                      (BuildContext context,
                                          ChartSwipeDirection direction) {
                                    if (direction == ChartSwipeDirection.end) {
                                      insightsController
                                          .loadNextWeek(); // Load next week when swiping right to left
                                    } else if (direction ==
                                        ChartSwipeDirection.start) {
                                      insightsController
                                          .loadPreviousWeek(); // Load previous week when swiping left to right
                                    }
                                    return const SizedBox.shrink();
                                  },
                                  series: <CartesianSeries<Graphdata, String>>[
                                    AreaSeries<Graphdata, String>(
                                      selectionBehavior:
                                          insightsController.selectionBehavior,
                                      enableTooltip: true,
                                      animationDuration: 300,
                                      isVisibleInLegend: false,
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xffADB7F9),
                                          const Color(0xffB1B9F8).withOpacity(0)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      dataSource: insightsController
                                          .currentWeekData, // Updated to use current week's data
                                      xValueMapper: (Graphdata data, _) {
                                        try {
                                          DateTime parsedDate =
                                              insightsController
                                                  .parseDate(data.date!);
                                          return DateFormat("d MMM").format(
                                              parsedDate); // Format as '1 Mar', '2 Mar', etc.
                                        } catch (e) {
                                          return '';
                                        }
                                      },
                                      yValueMapper: (Graphdata data, _) =>
                                          data.userVisits,
                                      name: 'User Visits',
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                        showZeroValue: false,
                                        isVisible: true,
                                        labelAlignment:
                                            ChartDataLabelAlignment.top,
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.color0046AE),
                                      ),
                                      // markerSettings: const MarkerSettings(
                                      //     isVisible: true,
                                      //     borderColor: Colors.white,
                                      //     shape: DataMarkerType.circle,
                                      //     width: 8,
                                      //     height: 8,
                                      //     color: AppColors.color0046AE),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                customBtn(
                                        onTap: () {},
                                        title: "Already sponsored",
                                        fontSize: 14,
                                        weight: FontWeight.w700,
                                        radius: BorderRadius.circular(10),
                                        width: Get.width,
                                        height: Get.height * 0.06)
                                    .paddingSymmetric(horizontal: 22),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ))
                        ],
                      );
                    }),
                  ))
            ])));
  }

  Widget buildLoadMoreView(
      BuildContext context, ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      return FutureBuilder<String>(
        future: _loadNextWeekData(), // Load next week's data
        builder: (BuildContext futureContext, AsyncSnapshot<String> snapShot) {
          return snapShot.connectionState != ConnectionState.done
              ? const CircularProgressIndicator()
              : SizedBox.fromSize(size: Size.zero);
        },
      );
    } else {
      return SizedBox.fromSize(size: Size.zero);
    }
  }

  Future<String> _loadNextWeekData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    if (insightsController.weeksData.isNotEmpty) {
      int currentWeekIndex = insightsController.weeksData
          .indexWhere((week) => week == insightsController.graphdataList);

      if (currentWeekIndex != -1 &&
          currentWeekIndex < insightsController.weeksData.length - 1) {
        // Load next week's data
        insightsController.graphdataList
            .assignAll(insightsController.weeksData[currentWeekIndex + 1]);
      }
    }

    return "Next week loaded";
  }

  rowWidget({required String title, required String count}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: poppinsFont(
              13,
              themeContro.isLightMode.value ? AppColors.black : AppColors.white,
              FontWeight.w500),
        ),
        Text(
          count,
          style: poppinsFont(
              13,
              themeContro.isLightMode.value ? AppColors.black : AppColors.white,
              FontWeight.w600),
        )
      ],
    ).paddingSymmetric(horizontal: 22);
  }
}
