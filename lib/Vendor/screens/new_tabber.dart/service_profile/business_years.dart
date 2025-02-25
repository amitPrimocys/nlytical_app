import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class BusinessYears extends StatefulWidget {
  const BusinessYears({super.key});

  @override
  State<BusinessYears> createState() => _BusinessYearsState();
}

class _BusinessYearsState extends State<BusinessYears> {
  StoreController storeController = Get.find();

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
  void initState() {
    selectedMonthValue = storeController.storeList.isNotEmpty
        ? storeController.storeList[0].businessTime!.publishedMonth ?? ''
        : null;
    selectedYearValue = storeController.storeList.isNotEmpty
        ? storeController.storeList[0].businessTime!.publishedYear ?? ''
        : null;
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
                    Text("Year of Establishment",
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
                        "Year of Establishment",
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
                              " Please note that any changes to the details below can go for verification and take upto 2 working days to go live.",
                              style: poppinsFont(
                                  10,
                                  themeContro.isLightMode.value
                                      ? AppColors.blue
                                      : Colors.grey.shade400,
                                  FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      sizeBoxHeight(30),
                      monthYearWidget()
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
                          if (selectedMonthValue == '') {
                            snackBar("Please select your business start month");
                          } else if (selectedYearValue == '') {
                            snackBar(
                                "Please select your business startup year");
                          } else {
                            storeController.storeMonthYearsUpdateApi(
                              month: selectedMonthValue!,
                              years: selectedYearValue!,
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
                    fillColor: themeContro.isLightMode.value
                        ? Colors.white
                        : AppColors.darkGray,
                    filled: true,
                    errorStyle: const TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: themeContro.isLightMode.value
                                ? AppColors.bluee4
                                : AppColors.grey1)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: AppColors.black, width: 1)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.black)),
                    disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: AppColors.black)),
                  ),
                  isEmpty: selectedMonthValue == '',
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    dropdownColor: themeContro.isLightMode.value
                        ? Colors.white
                        : AppColors.darkGray,
                    menuMaxHeight: getProportionateScreenHeight(300),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    iconEnabledColor: themeContro.isLightMode.value
                        ? Colors.black
                        : AppColors.white,
                    iconDisabledColor: AppColors.black,
                    value: selectedMonthValue,
                    isDense: true,
                    hint: Text("Select Store*",
                        style:
                            poppinsFont(12, AppColors.black, FontWeight.w400)),
                    style: TextStyle(
                        color: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white),
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
                          style: poppinsFont(
                              12,
                              themeContro.isLightMode.value
                                  ? Colors.black
                                  : AppColors.white,
                              FontWeight.w400),
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
                    fillColor: themeContro.isLightMode.value
                        ? Colors.white
                        : AppColors.darkGray,
                    filled: true,
                    errorStyle: const TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: themeContro.isLightMode.value
                              ? AppColors.bluee4
                              : AppColors.grey1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: AppColors.black, width: 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.black),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: AppColors.black),
                    ),
                  ),
                  isEmpty: selectedYearValue == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkGray,
                      menuMaxHeight: getProportionateScreenHeight(300),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconEnabledColor: themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white,
                      iconDisabledColor: AppColors.black,
                      value: selectedYearValue,
                      isDense: true,
                      hint: Text(
                        "Select Year*",
                        style:
                            poppinsFont(12, AppColors.black, FontWeight.w400),
                      ),
                      style: TextStyle(
                          color: themeContro.isLightMode.value
                              ? Colors.black
                              : AppColors.white),
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
                            style: poppinsFont(
                                12,
                                themeContro.isLightMode.value
                                    ? Colors.black
                                    : AppColors.white,
                                FontWeight.w400),
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
}
