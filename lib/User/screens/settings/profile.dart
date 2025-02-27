// ignore_for_file: prefer_const_constructors, dead_code, non_constant_identifier_names, prefer_null_aware_operators, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/get_profile_contro.dart';
import 'package:nlytical_app/User/screens/controller/user_tab_controller.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/profile_detail_loader.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // String contrycode = '';
  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode signUpPhoneFocusNode = FocusNode();

  // FocusNode signUpEmailIDFocusNode = FocusNode();

  File? file;
  String filePath = '';
  bool isTermsPrivacy = false;
  bool isRemoveImage = false;
  bool readonlyauth = false;

  GetprofileContro getprofilecontro = Get.find();
  GetprofileContro updateController = Get.find();
  // UpdateContro updatecontro = Get.put(UpdateContro());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getprofilecontro.getprofileApi();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: themeContro.isLightMode.value
              ? AppColors.white
              : AppColors.darkMainBlack,
          body: SizedBox(
            height: Get.height,
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
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
                        sizeBoxWidth(120),
                        Align(
                          alignment: Alignment.center,
                          child: label(
                            "Profile",
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
                  top: 100,
                  child: Container(
                    width: Get.width,
                    height: getProportionateScreenHeight(800),
                    decoration: BoxDecoration(
                        color: themeContro.isLightMode.value
                            ? AppColors.white
                            : AppColors.darkMainBlack,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        sizeBoxHeight(10),
                        Expanded(child: profillist()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )

          //  Column(
          //   children: [
          //     appBarWidget(),
          //     Expanded(
          //       child: profillist(),
          //     ),
          //   ],
          // ),
          ),
    );
  }

  Widget profillist() {
    return Obx(() {
      return getprofilecontro.isprofile.value
          ? profiledetailsLoader(context)
          //  Center(
          //     child: CircularProgressIndicator(
          //     color: AppColors.blue,
          //   ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeBoxHeight(30),
                  profileImage(context),
                  sizeBoxHeight(8),
                  GestureDetector(
                    onTap: () {
                      bottomSheetGobal(
                          bottomsheetHeight: 200,
                          title: "Profile Photo",
                          child: openBottomDailog());
                    },
                    child: Center(
                      child: label(
                        "Select Your Profile",
                        maxLines: 2,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  sizeBoxHeight(28),
                  globalTextField(
                    controller: getprofilecontro.FnameController,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(lastNameFocusNode);
                    },
                    focusNode: firstNameFocusNode,
                    lable: "First Name",
                    hintText: 'First Name',
                    context: context,
                  ),
                  sizeBoxHeight(17),
                  globalTextField(
                    controller: getprofilecontro.LnameController,
                    onEditingComplete: () {
                      FocusScope.of(context)
                          .requestFocus(signUpEmailIDFocusNode);
                    },
                    focusNode: lastNameFocusNode,
                    lable: "Last Name",
                    hintText: 'Last Name',
                    context: context,
                  ),
                  sizeBoxHeight(17),
                  label(
                    'Email Address',
                    fontSize: 10,
                    textColor: themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  sizeBoxHeight(4),
                  TextFormField(
                    enabled: getprofilecontro.emailcontroller.text.isEmpty
                        ? true
                        : false,
                    controller: getprofilecontro.emailcontroller,
                    readOnly: getprofilecontro.emailcontroller.text.isEmpty
                        ? false
                        : true,
                    style: TextStyle(
                        fontSize: 14,
                        color: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      fillColor: themeContro.isLightMode.value
                          ? AppColors.blue1
                          : AppColors.darkGray,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          borderSide: themeContro.isLightMode.value
                              ? BorderSide.none
                              : const BorderSide(color: AppColors.darkBorder)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none),
                      hintText: "Email Address",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.blue,
                          fontWeight: FontWeight.w400),
                      suffixIcon: getprofilecontro.emailcontroller.text.isEmpty
                          ? null
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                'assets/images/Frame (1).png',
                                height: 14,
                              ),
                            ),
                    ),
                  ),
                  sizeBoxHeight(15),
                  label(
                    'Mobile Number',
                    fontSize: 10,
                    textColor: themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  sizeBoxHeight(4),
                  IntlPhoneField(
                    enabled: getprofilecontro.phoneController.text.isNotEmpty
                        ? false
                        : true,
                    initialValue: getprofilecontro.contrycode.value,
                    showCountryFlag: true,
                    showDropdownIcon: true,
                    onCountryChanged: (value) {
                      getprofilecontro.contrycode.value = value.dialCode;

                      // print('COUNTRY CODE :- +${getprofilecontro.contrycode.value}');
                    },
                    dropdownTextStyle: TextStyle(
                      fontSize: 14,
                      color: themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white, // ✅ Country Code Color
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (number) {
                      getprofilecontro.contrycode.value = number.completeNumber;
                      print('COUNTRY CODE$number');
                      print('COUNTRY CODE$Value');
                    },
                    readOnly: getprofilecontro.phoneController.text.isNotEmpty
                        ? false
                        : true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                        fontSize: 14,
                        color: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w400),
                    controller: getprofilecontro.phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: themeContro.isLightMode.value
                          ? AppColors.blue1
                          : AppColors.darkGray,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          borderSide: themeContro.isLightMode.value
                              ? BorderSide.none
                              : const BorderSide(color: AppColors.darkBorder)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none),
                      hintText: "Mobile Number",
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.blue,
                          fontWeight: FontWeight.w400),
                      suffixIcon: getprofilecontro.phoneController.text.isEmpty
                          ? null
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                'assets/images/Frame (1).png',
                                height: 14,
                              ),
                            ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 15, bottom: 16, top: 11),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.transparent, fontSize: 10),
                    ),
                  ),

                  sizeBoxHeight(17),
                  sizeBoxHeight(25),
                  // Obx(() => getprofilecontro.isupdate.value
                  //     ? commonLoading()
                  //     : globButton(
                  //         name: "Save",
                  //         gradient: AppColors.logoColork,
                  //         onTap: () async {
                  //           // Call update API with the values from the text controllers
                  //           getprofilecontro.updateApi(
                  //             // ignore: prefer_null_aware_operators
                  //             selectedImages != null
                  //                 ? selectedImages!.path
                  //                 : null,
                  //             countryCode:
                  //                 "+${getprofilecontro.contrycode.value}",
                  //             fname: getprofilecontro.FnameController.text,
                  //             lname: getprofilecontro.LnameController.text,
                  //             email: getprofilecontro.emailcontroller.text,
                  //             phone: getprofilecontro.phoneController.text,
                  //           );
                  //           Get.put(UserTabController())
                  //               .currentTabIndex
                  //               .value = 4;
                  //         },
                  //       ).paddingSymmetric(horizontal: 20)),
                  Center(
                    child: Obx(() {
                      return getprofilecontro.isupdate.value
                          ? commonLoading()
                          : GestureDetector(
                              onTap: () async {
                                // Call update API with the values from the text controllers
                                getprofilecontro.updateApi(
                                  file: selectedImages != null
                                      ? selectedImages!.path
                                      : null,
                                  countryCode:
                                      getprofilecontro.contrycode.value,
                                  fname: getprofilecontro.FnameController.text,
                                  lname: getprofilecontro.LnameController.text,
                                  email: getprofilecontro.emailcontroller.text,
                                  // phone: getprofilecontro.phoneController.text,
                                  phone:
                                      "${getprofilecontro.contrycode.value}${getprofilecontro.phoneController.text}",

                                  isUpdateProfile: true,
                                );
                                // getprofilecontro.updateApi(
                                //   // ignore: prefer_null_aware_operators
                                //   selectedImages != null
                                //       ? selectedImages!.path
                                //       : null,

                                //   "${getprofilecontro.contrycode.value}",
                                //   getprofilecontro.FnameController.text,
                                //   getprofilecontro.LnameController.text,
                                //   getprofilecontro.emailcontroller.text,
                                //   getprofilecontro.phoneController.text,
                                //   isUpdateProfile: true,
                                // );
                                Get.put(UserTabController())
                                    .currentTabIndex
                                    .value = 4;
                              },
                              child: Container(
                                height: 50,
                                width: Get.width * 0.7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.blue),
                                child: Center(
                                  child: label(
                                    "Submit",
                                    textColor: AppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                    }),
                  ),
                  sizeBoxHeight(50),
                ],
              ).paddingSymmetric(horizontal: 20),
            );
    });
  }

  Widget appBarWidget() {
    return Container(
      height: getProportionateScreenHeight(100),
      width: Get.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
            color: Colors.grey.shade300)
      ], color: Colors.white),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              label(
                "Profile",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }

  Widget profileImage(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          bottomSheetGobal(
              bottomsheetHeight: 200,
              title: "Profile Photo",
              child: openBottomDailog());
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: getProportionateScreenHeight(100),
              width: getProportionateScreenWidth(100),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue1,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: AppColors.blue1,
                    )
                  ]),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  border: Border.all(
                    width: 2.5,
                    color: AppColors.blue,
                  ),
                ),
                child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: selectedImages == null
                            ? getprofilecontro.getprofilemodel.value!
                                        .userDetails!.image !=
                                    null
                                ? Image.network(
                                    getprofilecontro.getprofilemodel.value!
                                        .userDetails!.image!,
                                    fit: BoxFit.cover, loadingBuilder:
                                        (BuildContext ctx, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                          child: SpinKitSpinningLines(
                                              size: 30, color: AppColors.blue));
                                    }
                                  }, errorBuilder: (BuildContext? context,
                                        Object? exception,
                                        StackTrace? stackTrace) {
                                    return Image.asset(
                                      AppAsstes.default_user,
                                      fit: BoxFit.cover,
                                    );
                                  })
                                : Image.asset(
                                    AppAsstes.default_user,
                                    fit: BoxFit.cover,
                                  )
                            : Image.file(selectedImages!, fit: BoxFit.cover))
                    .paddingAll(3),
              ).paddingAll(3),
            ),
            Positioned(
              bottom: 5,
              right: 6,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  border: Border.all(
                    width: 1.5,
                    color: AppColors.blue1,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.blue,
                  size: 15,
                ).paddingAll(0),
              ),
            )
          ],
        ),
      ),
    );
  }

  openBottomDailog() {
    return Column(
      children: [
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cotainer(
              onTap: () {
                getImageFromcamera();
                Get.back();
              },
              title: "Camera",
              img: AppAsstes.camera2,
            ),
            sizeBoxWidth(30),
            cotainer(
              onTap: () {
                getImageFromGallery();
                Get.back();
              },
              title: "Gallery",
              img: AppAsstes.gallery2,
            ),
            sizeBoxWidth(30),
            cotainer(
              onTap: () {
                deleteImage();
                Get.back();
              },
              title: "Delete",
              img: AppAsstes.trash,
            ),
          ],
        )
      ],
    );
  }

  Widget cotainer({
    required Function() onTap,
    required String title,
    required String img,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: getProportionateScreenHeight(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55),
                  color: AppColors.blue),
              child: Image.asset(img).paddingAll(10),
            ),
            sizeBoxHeight(10),
            Text(
              title,
              style: poppinsFont(12, Colors.grey, FontWeight.w400),
            )
          ],
        ));
  }

  File? selectedImages;
  final picker = ImagePicker();

  void deleteImage() {
    setState(() {
      selectedImages = null; // Clear the selected image
    });
  }

  Future getImageFromcamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        selectedImages = File(pickedFile.path);

        // profileController.getProfile(selectedImages!);
      } else {
        print("No image selected");
      }
    });
  }

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        selectedImages = File(pickedFile.path);
        // profileController.getProfile(selectedImages!);
      } else {
        print("No image selected");
      }
    });
  }
}
