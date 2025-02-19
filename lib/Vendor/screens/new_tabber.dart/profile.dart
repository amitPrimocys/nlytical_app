// ignore_for_file: avoid_print
import 'dart:io';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/profile_cotroller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/size_config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileCotroller profileCotroller = Get.find();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  FocusNode fnameFocus = FocusNode();
  FocusNode fnameFocus1 = FocusNode();
  FocusNode lnameFocus = FocusNode();
  FocusNode lnameFocus1 = FocusNode();
  @override
  void initState() {
    profileCotroller.getProfleApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
        body: SizedBox(
          height: Get.height,
          child: Stack(
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
                    child: Column(
                      children: [
                        sizeBoxHeight(10),
                        Expanded(
                          child: Obx(() {
                            return Column(
                              children: [
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      sizeBoxHeight(20),
                                      profileWidget(),
                                      sizeBoxHeight(50),
                                      globalTextField2(
                                        lable: "First Name",
                                        controller:
                                            profileCotroller.fnameController,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(fnameFocus);
                                        },
                                        focusNode: fnameFocus1,
                                        hintText: "",
                                        context: context,
                                      ).paddingSymmetric(horizontal: 20),
                                      sizeBoxHeight(20),
                                      globalTextField2(
                                        lable: "Last Name",
                                        controller:
                                            profileCotroller.lnameController,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(lnameFocus);
                                        },
                                        focusNode: lnameFocus1,
                                        hintText: "",
                                        context: context,
                                      ).paddingSymmetric(horizontal: 20),
                                      sizeBoxHeight(20),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Email Address',
                                          style: poppinsFont(
                                              10,
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              FontWeight.w600),
                                        ),
                                      ).paddingSymmetric(horizontal: 22),
                                      sizeBoxHeight(4),
                                      TextFormField(
                                        controller:
                                            profileCotroller.emailController,
                                        readOnly: profileCotroller
                                                .getDataModel
                                                .value
                                                .userDetails!
                                                .email!
                                                .isEmpty
                                            ? false
                                            : true,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: themeContro.isLightMode.value
                                                ? AppColors.black
                                                : AppColors.white,
                                            fontWeight: FontWeight.w400),
                                        decoration: InputDecoration(
                                          fillColor:
                                              themeContro.isLightMode.value
                                                  ? AppColors.blue1
                                                  : AppColors.darkGray,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4)),
                                              borderSide: themeContro
                                                      .isLightMode.value
                                                  ? BorderSide.none
                                                  : const BorderSide(
                                                      color: AppColors
                                                          .darkBorder)),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide.none),
                                          disabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide.none),
                                          hintText: "Email Address",
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                          hintStyle: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.blue,
                                              fontWeight: FontWeight.w400),
                                          suffixIcon: profileCotroller
                                                  .getDataModel
                                                  .value
                                                  .userDetails!
                                                  .email!
                                                  .isEmpty
                                              ? null
                                              : Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Image.asset(
                                                    'assets/images/Frame (1).png',
                                                    height: 14,
                                                  ),
                                                ),
                                        ),
                                      ).paddingSymmetric(horizontal: 20),
                                      sizeBoxHeight(20),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: label(
                                          'Mobile Number',
                                          fontSize: 10,
                                          textColor:
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ).paddingSymmetric(horizontal: 22),
                                      ),
                                      sizeBoxHeight(5),
                                      IntlPhoneField(
                                        enabled: false,
                                        initialValue:
                                            profileCotroller.contrycode.value,
                                        showCountryFlag: true,
                                        showDropdownIcon: true,
                                        onCountryChanged: (value) {
                                          profileCotroller.contrycode.value =
                                              value.dialCode;

                                          // print('COUNTRY CODE :- +${getprofilecontro.contrycode.value}');
                                        },
                                        dropdownTextStyle: TextStyle(
                                          fontSize: 14,
                                          color: themeContro.isLightMode.value
                                              ? AppColors.black
                                              : AppColors
                                                  .white, // ✅ Country Code Color
                                          fontWeight: FontWeight.w500,
                                        ),
                                        onChanged: (number) {
                                          profileCotroller.contrycode.value =
                                              number.completeNumber;
                                          print('COUNTRY CODE$number');
                                          print('COUNTRY CODE$Value');
                                        },
                                        readOnly: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: themeContro.isLightMode.value
                                                ? AppColors.black
                                                : AppColors.white,
                                            fontWeight: FontWeight.w400),
                                        controller:
                                            profileCotroller.phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10),
                                          filled: true,
                                          fillColor:
                                              themeContro.isLightMode.value
                                                  ? AppColors.blue1
                                                  : AppColors.darkGray,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4)),
                                              borderSide: themeContro
                                                      .isLightMode.value
                                                  ? BorderSide.none
                                                  : const BorderSide(
                                                      color: AppColors
                                                          .darkBorder)),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide.none),
                                          disabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
                                                  borderSide: BorderSide.none),
                                          hintText: "Mobile Number",
                                          hintStyle: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.blue,
                                              fontWeight: FontWeight.w400),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Image.asset(
                                              'assets/images/Frame (1).png',
                                              height: 14,
                                            ),
                                          ),
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 15,
                                                bottom: 16,
                                                top: 11),
                                          ),
                                          errorStyle: const TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 10),
                                        ),
                                      ).paddingSymmetric(horizontal: 20),
                                      sizeBoxHeight(30),
                                      Obx(() {
                                        return profileCotroller.isUpdate.value
                                            ? commonLoading()
                                            : CustomButtom(
                                                title: "Submit",
                                                onPressed: () {
                                                  profileCotroller
                                                      .updateProfileApi(
                                                    selectedImages?.path,
                                                    fname: profileCotroller
                                                        .fnameController.text,
                                                    lname: profileCotroller
                                                        .lnameController.text,
                                                    email: profileCotroller
                                                        .emailController.text,
                                                    countryCode:
                                                        profileCotroller
                                                            .contrycode
                                                            .toString(),
                                                    phone: profileCotroller
                                                        .phoneController.text,
                                                  );
                                                  fnameFocus.unfocus();
                                                  fnameFocus1.unfocus();
                                                  lnameFocus.unfocus();
                                                  lnameFocus1.unfocus();
                                                },
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    getProportionateScreenHeight(
                                                        52),
                                                width:
                                                    getProportionateScreenWidth(
                                                        260),
                                              );
                                      })
                                    ],
                                  ),
                                ))
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
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

  Widget profileWidget() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            bottomSheetGobal(
                bottomsheetHeight: 200,
                title: "Profile Photo",
                child: openBottomDailog());
          },
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6,
                      offset: const Offset(4, 4),
                      spreadRadius: 0,
                      color: themeContro.isLightMode.value
                          ? Colors.grey.shade500
                          : AppColors.darkShadowColor)
                ],
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                    colors: [AppColors.bluee3, AppColors.bluee2],
                    begin: Alignment.topCenter,
                    end: Alignment.centerRight)),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: selectedImages == null
                    ? profileCotroller.getDataModel.value.userDetails!.image !=
                            null
                        ? Image.network(
                            profileCotroller
                                .getDataModel.value.userDetails!.image!,
                            fit: BoxFit.cover, loadingBuilder:
                                (BuildContext ctx, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const Center(
                                  child: CupertinoActivityIndicator(
                                      color: AppColors.blue));
                            }
                          }, errorBuilder: (BuildContext? context,
                                Object? exception, StackTrace? stackTrace) {
                            return const Icon(Icons.person, size: 100);
                          })
                        : Image.asset(
                            AppAsstes.default_user,
                            fit: BoxFit.cover,
                          )
                    : Image.file(selectedImages!, fit: BoxFit.cover),
              ),
            ).paddingAll(5),
          ),
        ),
        Positioned(
          bottom: 7,
          right: 5,
          child: GestureDetector(
            onTap: () {
              bottomSheetGobal(
                  bottomsheetHeight: 200,
                  title: "Profile Photo",
                  child: openBottomDailog());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                      stops: [0.2, 0.7],
                      colors: [AppColors.white, AppColors.bluee2],
                      begin: Alignment.topCenter,
                      end: Alignment.centerRight)),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white),
                child: const Icon(Icons.add, size: 15, color: AppColors.blue),
              ).paddingAll(4),
            ),
          ),
        )
      ],
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
      } else {
        print("No image selected");
      }
    });
  }
}
