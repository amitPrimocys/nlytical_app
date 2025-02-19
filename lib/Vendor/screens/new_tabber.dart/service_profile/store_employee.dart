import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class StoreEmployee extends StatefulWidget {
  const StoreEmployee({super.key});

  @override
  State<StoreEmployee> createState() => _StoreEmployeeState();
}

class _StoreEmployeeState extends State<StoreEmployee> {
  StoreController storeController = Get.find();
  List<String> employeeList = [
    'Less than 10',
    '10-100',
    '100-500',
    '500-1000',
    '1000-2000',
    '2000-5000',
    '5000-10000',
    'More than 10000'
  ];

  @override
  void initState() {
    selectedVtypes =
        storeController.storeList[0].businessTime!.employeeStrength;
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
                    Text("Number of Employees",
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
                              " Please select the number of employees at your company",
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
                        "Select Number of Employees",
                        style: poppinsFont(
                            14,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w600),
                      ),
                      empWidget()
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
                          if (selectedVtypes == "") {
                            snackBar("Please select  number of emplyees");
                          } else {
                            storeController.storeEmployeeUpdateApi(
                                storeEmplyee: selectedVtypes!);
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

  String? selectedVtypes;
  Widget empWidget() {
    return ListView.builder(
        itemCount: employeeList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: getProportionateScreenHeight(43),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeContro.isLightMode.value
                    ? Colors.white
                    : AppColors.darkGray,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 14.4,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.06))
                ]),
            child: Row(
              children: [
                Radio<String>(
                  activeColor: AppColors.blue,
                  value: employeeList[index],
                  groupValue: selectedVtypes,
                  onChanged: (val) {
                    setState(() {
                      selectedVtypes = val!;
                    });
                  },
                ),
                Text(
                  employeeList[index],
                  style: poppinsFont(
                      11,
                      themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white,
                      FontWeight.w600),
                )
              ],
            ),
          ).paddingOnly(bottom: 10);
        });
  }
}
