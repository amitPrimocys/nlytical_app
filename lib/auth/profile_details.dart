// ignore_for_file: must_be_immutable, avoid_print

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/spinkit_loader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nlytical_app/controllers/user_controllers/get_profile_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/profile_detail_contro.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';

class ProfileDetails extends StatefulWidget {
  String? number;
  String? email;
  ProfileDetails({super.key, this.number, this.email});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  GetprofileContro getprofilecontro = Get.put(GetprofileContro());

  FocusNode usernamepassFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode phonenamepassFocusNode = FocusNode();
  FocusNode phonenameFocusNode = FocusNode();
  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();
  FocusNode firstnamepassFocusNode = FocusNode();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnamepassFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();
  final GlobalKey<FormState> _keyform = GlobalKey();

  ProfileDetailContro profiledetailcontro = Get.put(ProfileDetailContro());

  bool isselected = false;

  void fieldcheck() {
    setState(() {
      isselected = lnamecontroller.text.isNotEmpty &&
          fnamecontroller.text.isNotEmpty &&
          emailcontroller.text.isEmail;
    });
  }

  @override
  void initState() {
    phonecontroller.text = widget.number.toString();
    emailcontroller.text = widget.email.toString();
    usernamecontroller.addListener(fieldcheck);
    lnamecontroller.addListener(fieldcheck);
    fnamecontroller.addListener(fieldcheck);
    emailcontroller.addListener(fieldcheck);
    getprofilecontro.getprofileApi();
    super.initState();
  }

  //   String _fcmtoken = "";
  // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // Future<bool> getToken() async {
  //   if (Platform.isIOS) {
  //     await firebaseMessaging.getToken().then((token) {
  //       setState(() {
  //         _fcmtoken = token!;
  //       });
  //       log("DEVICE_TOKEN:$_fcmtoken");
  //     });
  //   } else if (Platform.isAndroid) {
  //     await firebaseMessaging.getToken().then((token) {
  //       setState(() {
  //         _fcmtoken = token!;
  //       });
  //       log("DEVICE_TOKEN:$_fcmtoken");
  //     });
  //   }

  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(AppAsstes.appbackground),
              fit: BoxFit.fitWidth,
            )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _keyform,
                child: Column(
                  children: [
                    sizeBoxHeight(105),
                    Image.asset(
                      AppAsstes.logo,
                      height: 55,
                      width: 180,
                      fit: BoxFit.contain,
                      // width: SizeConfig.blockSizeHorizontal * 50,
                    ).paddingSymmetric(
                      horizontal: 100,
                    ),
                    sizeBoxHeight(15),
                    Center(
                      child: label(
                        "Discover more about our app by registering",
                        maxLines: 2,
                        textColor: const Color.fromRGBO(113, 113, 113, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeBoxHeight(1),
                    Center(
                      child: label(
                        "or logging in",
                        maxLines: 2,
                        textColor: const Color.fromRGBO(113, 113, 113, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeBoxHeight(15),
                    sizeBoxHeight(10),
                    profileImage(context),
                    sizeBoxHeight(20),
                    globalTextField(
                        lable: 'User Name',
                        lable2: " *",
                        controller: usernamecontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(usernamepassFocusNode);
                        },
                        focusNode: usernameFocusNode,
                        hintText: 'User Name',
                        context: context,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/profile1.png',
                                color: Colors.grey.shade500,
                                height: 20,
                              ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
                    globalTextField(
                        lable: 'First Name',
                        lable2: " *",
                        controller: fnamecontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(firstnamepassFocusNode);
                        },
                        focusNode: firstnameFocusNode,
                        hintText: 'First Name',
                        context: context,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/profile1.png',
                                color: Colors.grey.shade500,
                                height: 20,
                              ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
                    globalTextField(
                        lable: "Last Name",
                        lable2: " *",
                        controller: lnamecontroller,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(lastnamepassFocusNode);
                        },
                        focusNode: lastnameFocusNode,
                        hintText: 'Last Name',
                        context: context,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/profile1.png',
                                color: Colors.grey.shade500,
                                height: 20,
                              ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
                    globalTextField(
                        lable: "Email Address",
                        lable2: ' *',
                        controller: emailcontroller,
                        isEmail: true,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(signUpPasswordFocusNode);
                        },
                        focusNode: signUpEmailIDFocusNode,
                        hintText: 'Email Address',
                        context: context,
                        isOnlyRead: widget.email!.isEmpty ? false : true,
                        imagePath: 'assets/images/sms.png',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: widget.email!.isEmpty
                                  ? Image.asset(
                                      'assets/images/sms.png',
                                      color: Colors.grey.shade500,
                                      height: 20,
                                    )
                                  : Image.asset(
                                      'assets/images/Frame (1).png',
                                      height: 20,
                                    ),
                            ),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(10),
                    widget.number!.isNotEmpty
                        ? globalTextField(
                            lable: 'Mobile Number',
                            lable2: " *",
                            isOnlyRead: true,
                            controller: phonecontroller,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(phonenamepassFocusNode);
                            },
                            focusNode: phonenameFocusNode,
                            hintText: 'Mobile Number',
                            context: context,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/Frame (1).png',
                                    // color: Colors.grey.shade500,
                                    height: 20,
                                  ),
                                ),
                              ),
                            )).paddingSymmetric(horizontal: 20)
                        : IntlPhoneField(
                            showCountryFlag: true,
                            showDropdownIcon: false,
                            initialCountryCode: "IN",
                            onCountryChanged: (value) {
                              contrycode = value.dialCode;
                              print('+$contrycode');
                            },
                            onChanged: (number) {
                              print(number);
                            },
                            dropdownTextStyle: TextStyle(
                                fontSize: 14,
                                color: themeContro.isLightMode.value
                                    ? Colors.black
                                    : AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                            cursorColor: themeContro.isLightMode.value
                                ? AppColors.blue
                                : Colors.white,
                            autofocus: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(
                                fontSize: 14,
                                color: themeContro.isLightMode.value
                                    ? Colors.black
                                    : AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                            controller: phonecontroller,
                            keyboardType: TextInputType.number,
                            flagsButtonPadding: const EdgeInsets.only(left: 5),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: themeContro.isLightMode.value
                                  ? Colors.transparent
                                  : AppColors.darkGray,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: AppColors.blue)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: themeContro.isLightMode.value
                                          ? AppColors.colorEFEFEF
                                          : AppColors.grey1)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.redAccent)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.redAccent)),
                              hintText: "Enter Your Mobile Number".tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.colorB0B0B0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.sufcolor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/call.png',
                                      color: Colors.grey.shade500,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                              errorStyle: const TextStyle(
                                  color: Colors.redAccent, fontSize: 11),
                            ),
                          ).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(25),
                    Obx(() {
                      return profiledetailcontro.isLoading.value
                          ? commonLoading()
                          : GestureDetector(
                              onTap: () {
                                // forgotcontro.forgotApi(
                                //   email: emailcontroller.text,
                                //   // device: _fcmtoken
                                // );

                                if (_keyform.currentState!.validate()) {
                                  if (widget.email!.isNotEmpty) {
                                    if (phonecontroller.text
                                        .trim()
                                        .isNotEmpty) {
                                      profiledetailcontro.newupdateApi(
                                          isEmail: true,
                                          file: selectedImages?.path,
                                          uname: usernamecontroller.text,
                                          fname: fnamecontroller.text,
                                          laname: lnamecontroller.text,
                                          email: emailcontroller.text,
                                          code: contrycode,
                                          number: phonecontroller.text);
                                    } else {
                                      snackBar("Enter Valid Mobile number");
                                    }
                                  } else {
                                    profiledetailcontro.newupdateApi(
                                      isEmail: false,
                                      file: selectedImages?.path,
                                      uname: usernamecontroller.text,
                                      fname: fnamecontroller.text,
                                      laname: lnamecontroller.text,
                                      email: emailcontroller.text,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                width: Get.width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: isselected
                                      ? AppColors.logoColork
                                      : AppColors.logoColorWith60Opacityk,
                                ),
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
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget profileImage(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // openBottomForImagePick(context);
          selectPicture();
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: getProportionateScreenHeight(100),
              width: getProportionateScreenWidth(100),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue1,
                  boxShadow: [
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
                  child: selectedImages != null
                      ? Image.file(selectedImages!, fit: BoxFit.cover)
                      : (getprofilecontro.getprofilemodel.value?.userDetails
                                      ?.image !=
                                  null &&
                              getprofilecontro.getprofilemodel.value!
                                  .userDetails!.image!.isNotEmpty)
                          ? Image.network(
                              getprofilecontro
                                  .getprofilemodel.value!.userDetails!.image!,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext ctx, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: SpinKitSpinningLines(
                                        size: 30, color: AppColors.blue),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext? context,
                                  Object? exception, StackTrace? stackTrace) {
                                return Image.asset(AppAsstes.default_user);
                              },
                            )
                          : const Icon(Icons.person, size: 50),
                ).paddingAll(3),
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

  Future<dynamic> selectPicture() {
    final ap = Get.bottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        barrierColor: const Color.fromRGBO(0, 0, 0, 0.57),
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.8,
            sigmaY: 3.8,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: getProportionateScreenHeight(200),
            width: Get.width,
            child: Column(
              children: [
                Container(
                  height: getProportionateScreenHeight(70),
                  width: Get.width,
                  decoration: BoxDecoration(
                    // color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                            0.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Profile Photo",
                        style:
                            poppinsFont(16, AppColors.black, FontWeight.w500),
                      ),
                      sizeBoxWidth(100),
                      GestureDetector(
                          onTap: () {
                            debugPrint("back");
                            Get.back();
                          },
                          child: const Icon(Icons.close, size: 25)
                              .paddingOnly(right: 20))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizeBoxHeight(20),
                        GestureDetector(
                          onTap: () {
                            getImageFromcamera();
                            Navigator.of(context, rootNavigator: true)
                                .pop("Discard");
                          },
                          child: Container(
                            height: getProportionateScreenHeight(60),
                            width: getProportionateScreenWidth(60),
                            decoration: const BoxDecoration(
                              color: AppColors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Image.asset(
                              'assets/images/camera2.png',
                              height: 24,
                            )),
                          ),
                        ),
                        sizeBoxHeight(10),
                        label(
                          "Camera",
                          textColor: AppColors.greyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    sizeBoxWidth(30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizeBoxHeight(20),
                        GestureDetector(
                          onTap: () {
                            getImageFromGallery();
                            Navigator.of(context, rootNavigator: true)
                                .pop("Discard");
                          },
                          child: Container(
                            height: getProportionateScreenHeight(60),
                            width: getProportionateScreenWidth(60),
                            decoration: const BoxDecoration(
                                color: AppColors.blue, shape: BoxShape.circle),
                            child: Center(
                                child: Image.asset(
                              'assets/images/gallery2.png',
                              height: 24,
                            )),
                          ),
                        ),
                        sizeBoxHeight(10),
                        label(
                          "Gallery",
                          textColor: AppColors.greyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
    return ap;
  }

  File? selectedImages;
  final picker = ImagePicker();

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
