import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/line_chat/line_chart_view.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final List<String> _monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  String? selectedMonthValue;

  final _heightChart = 250.0;
  final _refreshChart$ = StreamController<Key>();

  @override
  void initState() {
    super.initState();
    selectedMonthValue = _monthList.first;
    _refreshChart$.add(UniqueKey());
  }

  @override
  void dispose() {
    _refreshChart$.close();
    super.dispose();
  }

  void _refreshChart() {
    _refreshChart$.add(UniqueKey());
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
                top: getProportionateScreenHeight(60),
                left:
                    0, // Ensures alignment is calculated across the entire width
                right: 0,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      sizeBoxWidth(100),
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
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
              Positioned(
                  top: 110,
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
                                                    const EdgeInsets.symmetric(
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
                                              isEmpty: selectedMonthValue == '',
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
                                                value: selectedMonthValue,
                                                isDense: true,
                                                hint: Text("Select",
                                                    style: poppinsFont(
                                                        12,
                                                        themeContro.isLightMode
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
                                                    selectedMonthValue =
                                                        newValue!;
                                                    state.didChange(newValue);
                                                  });
                                                },
                                                items: _monthList
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
                                                              : AppColors.white,
                                                          FontWeight.w600),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    rowWidget(
                                      title: "Store Visits",
                                      count: "4500",
                                    ),
                                    Divider(
                                            color: themeContro.isLightMode.value
                                                ? Colors.grey.shade200
                                                : AppColors.darkgray2)
                                        .paddingSymmetric(horizontal: 20),
                                    rowWidget(
                                      title: "Number of Favorites",
                                      count: "47",
                                    ),
                                    Divider(
                                            color: themeContro.isLightMode.value
                                                ? Colors.grey.shade200
                                                : AppColors.darkgray2)
                                        .paddingSymmetric(horizontal: 20),
                                    rowWidget(
                                      title: "Leads Received",
                                      count: "50",
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
                                  IconButton(
                                    color: themeContro.isLightMode.value
                                        ? AppColors.black
                                        : AppColors.white,
                                    iconSize: 20,
                                    onPressed: _refreshChart,
                                    icon: const Icon(Icons.refresh),
                                  ),
                                ],
                              ).paddingSymmetric(horizontal: 20),
                              StreamBuilder<Key>(
                                stream: _refreshChart$.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return const SizedBox.shrink();
                                  }
                                  return LineChartView(
                                    key: snapshot.data,
                                    heightChart: _heightChart,
                                  );
                                },
                              ).paddingSymmetric(horizontal: 20),
                              const SizedBox(height: 40),
                              customBtn(
                                      onTap: () {},
                                      title: "Already sponsored",
                                      fontSize: 14,
                                      weight: FontWeight.w700,
                                      radius: BorderRadius.circular(10),
                                      width: Get.width,
                                      height: Get.height * 0.06)
                                  .paddingSymmetric(horizontal: 22)
                            ],
                          ),
                        ))
                      ],
                    ),
                  ))
            ])));
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
