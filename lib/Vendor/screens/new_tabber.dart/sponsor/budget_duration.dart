// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/controllers/vendor_controllers/budget_controller.dart';
import 'package:nlytical_app/utils/global.dart';

class BudgetDuration extends StatefulWidget {
  String? campaignid;
  BudgetDuration({super.key, this.campaignid});

  @override
  State<BudgetDuration> createState() => _BudgetDurationState();
}

class _BudgetDurationState extends State<BudgetDuration> {
  BudgetController budgetcontro = Get.put(BudgetController());

  TextEditingController startcontroller = TextEditingController();
  FocusNode startnamepassFocusNode = FocusNode();
  FocusNode startnameFocusNode = FocusNode();

  TextEditingController endcontroller = TextEditingController();
  FocusNode endnamepassFocusNode = FocusNode();
  FocusNode endnameFocusNode = FocusNode();

  // int _selectedIndex = 0;
  // DateTime? _startDate;
  // DateTime? _endDate;
  // double _sliderValue = 0.0;

  int _selectedIndex = 0;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime today = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? today : _startDate ?? today,
      firstDate: isStartDate ? today : _startDate ?? today,
      lastDate: isStartDate
          ? DateTime(2101)
          : _startDate!.add(const Duration(days: 30)),
      selectableDayPredicate: (DateTime day) {
        if (isStartDate) {
          return day.isAfter(today.subtract(const Duration(days: 1)));
        } else {
          return day.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
              day.isBefore(_startDate!.add(const Duration(days: 31)));
        }
      },
      builder: (context, child) {
        return Theme(
          data: themeContro.isLightMode.value
              ? ThemeData.light().copyWith(
                  primaryColor: AppColors.blue,
                  colorScheme: const ColorScheme.light(primary: AppColors.blue),
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                )
              : ThemeData.dark().copyWith(
                  primaryColor: AppColors.blue,
                  colorScheme: const ColorScheme.dark(primary: AppColors.blue),
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          startcontroller.text =
              '${_startDate!.day.toString().padLeft(2, '0')}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.year}';
          _endDate = null; // Reset end date when start date changes
          endcontroller.text = '';
        } else {
          _endDate = pickedDate;
          endcontroller.text =
              '${_endDate!.day.toString().padLeft(2, '0')}-${_endDate!.month.toString().padLeft(2, '0')}-${_endDate!.year}';
        }

        // Update slider max value
        if (_startDate != null && _endDate != null) {
          int diffDays = _endDate!.difference(_startDate!).inDays;
          _selectedIndex =
              diffDays; // Set the slider position to the number of days between start and end date
          _sliderMax = 30.0; // Set the maximum value of the slider to 30 days
        }
      });
    }
  }

  double _sliderMax = 1.0;

  int getTotalDays() {
    if (_startDate == null || _endDate == null) return 1;
    return _endDate!.difference(_startDate!).inDays + 1;
  }

  int getSelectedDay() {
    return _selectedIndex + 0; // 1-based index
  }

  String getSelectedPrice() {
    if (_selectedIndex >= 0 && _selectedIndex < budgetcontro.getbudget.length) {
      return "\$${budgetcontro.getbudget[_selectedIndex].price}";
    }
    return "\$0"; // Default agar kuch bhi na mile
  }

  double getTotalPrice() {
    if (budgetcontro.getbudget.isNotEmpty &&
        _startDate != null &&
        _endDate != null) {
      int totalDays =
          _endDate!.difference(_startDate!).inDays + 0; // Including start day
      double startPrice = (budgetcontro.getbudget.first.price ?? 0)
          .toDouble(); // Ensure it's double
      return startPrice * totalDays;
    }
    return 0.0; // Default if data is missing
  }

  @override
  @override
  void initState() {
    budgetcontro.getbudgetAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.transparent
          : AppColors.darkMainBlack,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 70,
        child: button(),
      ).paddingOnly(bottom: 30),
      body: SizedBox(
        height: Get.height,
        child: Stack(
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
              top: getProportionateScreenHeight(60),
              left:
                  0, // Ensures alignment is calculated across the entire width
              right: 0,
              child: Container(
                // Aligns content to the center
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
                    sizeBoxWidth(70),
                    Align(
                      alignment: Alignment.center,
                      child: label(
                        "Budget & duration",
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Uncomment and use if required
                    // sizeBoxWidth(240),
                    // Image.asset(
                    //   AppAsstes.search,
                    //   scale: 3.5,
                    //   color: Colors.white,
                    // ),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
            Positioned.fill(
                top: 100,
                child: Container(
                  width: Get.width,
                  height: getProportionateScreenHeight(800),
                  decoration: BoxDecoration(
                      color: themeContro.isLightMode.value
                          ? Colors.transparent
                          : AppColors.darkMainBlack,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Obx(() {
                    return budgetcontro.isloading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.blue,
                          ))
                        : Column(
                            children: [
                              sizeBoxHeight(30),
                              label('What’s your ad budget?',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  textColor: themeContro.isLightMode.value
                                      ? AppColors.black
                                      : AppColors.white),
                              sizeBoxHeight(5),
                              label(
                                  'Excludes apple service fee and applicable taxes',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  textColor:
                                      const Color.fromRGBO(78, 78, 78, 1)),
                              sizeBoxHeight(20),
                              Row(
                                children: [
                                  Expanded(
                                    child: globalTextField(
                                      lable: 'Start Date',
                                      lable2: " *",
                                      controller: startcontroller,
                                      onTap: () => _selectDate(context, true),
                                      isOnlyRead: true,
                                      onEditingComplete: () {
                                        FocusScope.of(context).requestFocus(
                                            startnamepassFocusNode);
                                      },
                                      focusNode: startnameFocusNode,
                                      hintText: _startDate == null
                                          ? "Start Date"
                                          : "${_startDate!.toLocal()}"
                                              .split(' ')[0],
                                      context: context,
                                    ).paddingOnly(left: 20, right: 10),
                                  ),
                                  Expanded(
                                    child: globalTextField(
                                      lable: 'End Date',
                                      lable2: " *",
                                      controller: endcontroller,
                                      onTap: () => _selectDate(context, false),
                                      isOnlyRead: true,
                                      onEditingComplete: () {
                                        FocusScope.of(context)
                                            .requestFocus(endnamepassFocusNode);
                                      },
                                      focusNode: endnameFocusNode,
                                      hintText: _endDate == null
                                          ? "End Date"
                                          : "${_endDate!.toLocal()}"
                                              .split(' ')[0],
                                      context: context,
                                    ).paddingOnly(left: 10, right: 20),
                                  ),
                                ],
                              ),
                              sizeBoxHeight(20),
                              Container(
                                height: 125,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: themeContro.isLightMode.value
                                      ? Colors.white
                                      : AppColors.darkGray,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/Frame (4).png',
                                          color: themeContro.isLightMode.value
                                              ? Colors.black
                                              : AppColors.blue,
                                          height: 13,
                                        ),
                                        const SizedBox(width: 8),
                                        label("Daily Budget",
                                            fontSize: 12,
                                            textColor:
                                                themeContro.isLightMode.value
                                                    ? AppColors.black
                                                    : AppColors.white,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ).paddingSymmetric(horizontal: 18),
                                    const SizedBox(height: 5),

                                    /// **Day Row**
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        label(
                                            "${budgetcontro.getbudget.first.days}",
                                            fontSize: 10,
                                            textColor:
                                                themeContro.isLightMode.value
                                                    ? AppColors.black
                                                    : Colors.grey,
                                            fontWeight: FontWeight.w600),
                                        label(
                                          "${getSelectedDay()} Days",
                                          style: const TextStyle(
                                            color: AppColors.blue,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        label(
                                          "30 Days",
                                          fontSize: 10,
                                          textColor:
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: 20),

                                    IgnorePointer(
                                      ignoring: true,
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                            activeTrackColor: AppColors.blue,
                                            inactiveTrackColor: Colors.grey,
                                            inactiveTickMarkColor:
                                                AppColors.blue,
                                            thumbColor: AppColors.blue,
                                            overlayColor: AppColors.blue,
                                            activeTickMarkColor: AppColors.blue,
                                            overlappingShapeStrokeColor:
                                                AppColors.blue),
                                        child: Slider(
                                          value: _selectedIndex.toDouble(),
                                          min: 0,
                                          max: _sliderMax,
                                          // divisions: _sliderMax.toInt(),
                                          onChanged: (double value) {
                                            // setState(() {
                                            //   _selectedIndex = value.toInt();
                                            // });
                                          },
                                          // onChanged: null,
                                        ),
                                      ),
                                    ),

                                    /// **Price Row**
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        label(
                                            "\$${budgetcontro.getbudget.first.price}",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600)),
                                        // label(
                                        //     "\$${budgetcontro.getbudget[_selectedIndex].price}",
                                        //     style: const TextStyle(
                                        //         color: AppColors.blue,
                                        //         fontSize: 10,
                                        //         fontWeight: FontWeight.w600)),

                                        label(
                                          getSelectedPrice(),
                                          style: const TextStyle(
                                            color: AppColors.blue,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        // label(
                                        //     "\$${budgetcontro.getbudget.last.price}",
                                        //     style: const TextStyle(
                                        //         color: Colors.grey,
                                        //         fontSize: 10,
                                        //         fontWeight: FontWeight.w600)),

                                        label(
                                          // "\$${getTotalPrice()}"
                                          //     .replaceAll('.0', ''),
                                          "\$${budgetcontro.getbudget.last.price}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: 20),
                                  ],
                                ),
                              ).paddingSymmetric(horizontal: 20),
                              const SizedBox(height: 20),
                            ],
                          );
                  }),
                ))
          ],
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      onTap: () {
        print('**${startcontroller.text}');
        print(endcontroller.text);
        print(getSelectedDay());
        print(getSelectedPrice());
        if (startcontroller.text.isEmpty || endcontroller.text.isEmpty) {
          snackBar('Please select both Start Date and End Date');
        } else {
          budgetcontro.addBudgetApi(
            campaignID: widget.campaignid,
            startDate: startcontroller.text,
            endDate: endcontroller.text,
            dayss: getSelectedDay().toString(),
            pricee: getSelectedPrice(),
          );
        }
      },
      child: Container(
        height: 30,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColors.blue, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: label('Next',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              textColor: Colors.white),
        ),
      ).paddingSymmetric(
        horizontal: 20,
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class DateSliderScreen extends StatefulWidget {
//   @override
//   _DateSliderScreenState createState() => _DateSliderScreenState();
// }

// class _DateSliderScreenState extends State<DateSliderScreen> {
//   DateTime? _startDate;
//   DateTime? _endDate;
//   int _selectedIndex = 0;

//   TextEditingController startController = TextEditingController();
//   TextEditingController endController = TextEditingController();

//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     DateTime today = DateTime.now();
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: isStartDate ? today : _startDate ?? today,
//       firstDate: isStartDate ? today : _startDate ?? today,
//       lastDate: isStartDate
//           ? DateTime(2101)
//           : _startDate!.add(const Duration(days: 30)),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = pickedDate;
//           startController.text =
//               '${_startDate!.day}-${_startDate!.month}-${_startDate!.year}';
//           _endDate = null;
//           endController.text = '';
//           _selectedIndex = 0;
//         } else {
//           _endDate = pickedDate;
//           endController.text =
//               '${_endDate!.day}-${_endDate!.month}-${_endDate!.year}';
//           _selectedIndex = 0;
//         }
//       });
//     }
//   }

//   int getTotalDays() {
//     if (_startDate == null || _endDate == null) return 1;
//     return _endDate!.difference(_startDate!).inDays + 1;
//   }

//   DateTime getSelectedDate() {
//     if (_startDate == null) return DateTime.now();
//     return _startDate!.add(Duration(days: _selectedIndex));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Date Range Slider")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Select Start Date:"),
//             TextField(
//               controller: startController,
//               readOnly: true,
//               onTap: () => _selectDate(context, true),
//               decoration: InputDecoration(
//                 hintText: "Pick Start Date",
//                 suffixIcon: Icon(Icons.calendar_today),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text("Select End Date:"),
//             TextField(
//               controller: endController,
//               readOnly: true,
//               onTap: () => _selectDate(context, false),
//               decoration: InputDecoration(
//                 hintText: "Pick End Date",
//                 suffixIcon: Icon(Icons.calendar_today),
//               ),
//             ),
//             SizedBox(height: 30),
//             if (_startDate != null && _endDate != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Select Day in Range:"),
//                   SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       activeTrackColor: Colors.blue, // Active range blue color
//                       inactiveTrackColor:
//                           Colors.grey, // Remaining range grey color
//                       thumbColor: Colors.blue, // Thumb color blue
//                       overlayColor: Colors.blue
//                           .withOpacity(0.2), // Overlay effect on thumb
//                     ),
//                     child: Slider(
//                       min: 0,
//                       max: _startDate == null || _endDate == null
//                           ? 1.0
//                           : _endDate!.difference(_startDate!).inDays.toDouble(),
//                       value: _selectedIndex.toDouble().clamp(
//                           0.0,
//                           _endDate == null || _startDate == null
//                               ? 1.0
//                               : _endDate!
//                                   .difference(_startDate!)
//                                   .inDays
//                                   .toDouble()),
//                       divisions: _startDate == null || _endDate == null
//                           ? 1
//                           : _endDate!.difference(_startDate!).inDays,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedIndex = value.toInt();
//                         });
//                       },
//                     ),
//                   ),
//                   Text(
//                     "Selected Date: ${getSelectedDate().day}-${getSelectedDate().month}-${getSelectedDate().year}",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
