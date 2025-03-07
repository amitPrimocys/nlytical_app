import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

Widget globalTextField({
  String? lable,
  String? lable2,
  required TextEditingController controller,
  required void Function()? onEditingComplete,
  void Function(String)? onChanged,
  required String hintText,
  required BuildContext context,
  isBackgroundWhite = false,
  FormFieldValidator? validator,
  isNumber = false,
  isOnlyRead = false,
  isForPhoneNumber = false,
  bool isLabel = false,
  FocusNode? focusNode,
  isEmail = false,
  bool isForProfile = false,
  String imagePath = '',
  int maxLines = 1,
  Widget? suffixIcon,
  Widget? preffixIcon,
  int? maxLength,
  EdgeInsetsGeometry? contentPadding,
  Color? focusedBorderColor,
  void Function()? onTap,
  bool? filled,
  Color? fillColor,
}) {
  return Column(
    children: [
      twoText(
        text1: lable ?? "",
        text2: lable2 ?? "",
        style1: poppinsFont(
          10,
          themeContro.isLightMode.value ? Colors.black : AppColors.white,
          FontWeight.w500,
        ),
        style2: poppinsFont(11, Colors.redAccent, FontWeight.w600),
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      (lable == null || lable == "")
          ? const SizedBox.shrink()
          : sizeBoxHeight(5),
      Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: AppColors.blue,
            cursorColor: AppColors.blue,
            selectionColor: AppColors.blue.withOpacity(0.5),
          ),
        ),
        child: TextFormField(
          controller: controller,
          onTap: onTap,
          textCapitalization:
              isEmail ? TextCapitalization.none : TextCapitalization.sentences,
          onEditingComplete: onEditingComplete,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: poppinsFont(
            14,
            themeContro.isLightMode.value ? AppColors.black : AppColors.white,
            FontWeight.normal,
          ),
          focusNode: focusNode,
          maxLength: maxLength,
          onFieldSubmitted: (value) {
            // FocusScope.of(context).unfocus();
          },
          onSaved: (newValue) {
            FocusScope.of(context).nextFocus();
          },
          // textAlignVertical: hintText == "Address"
          //     ? TextAlignVertical.top
          //     : TextAlignVertical.center,
          onChanged: onChanged,
          readOnly: isOnlyRead,
          // minLines: 1,
          maxLines: maxLines == 1 ? 1 : maxLines,
          // null
          keyboardType:
              isNumber ? TextInputType.number : TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: preffixIcon,

            // suffix: suffixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: (hintText == "Comments" ||
                          hintText == "Address" ||
                          hintText == "Business Description")
                      ? 12
                      : hintText == "Notes"
                          ? 14
                          : 0,
                ),
            fillColor: themeContro.isLightMode.value
                ? Colors.transparent
                : AppColors.darkGray,
            filled: true,
            hintText: hintText,
            hintStyle: poppinsFont(14, AppColors.colorB0B0B0, FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: focusedBorderColor ?? AppColors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: themeContro.isLightMode.value
                    ? AppColors.colorEFEFEF
                    : AppColors.grey1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            errorStyle: poppinsFont(12, Colors.redAccent, FontWeight.normal),
            labelText: isLabel ? hintText : null,
            counterStyle: poppinsFont(
              0,
              AppColors.colorB4B4B4,
              FontWeight.normal,
            ),
            labelStyle: poppinsFont(12, AppColors.colorB0B0B0, FontWeight.w400),
          ),
          // validator: validator
          validator: (value) {
            if (hintText == "First Name*" ||
                hintText == "Last Name*" ||
                hintText == "Room name*" ||
                hintText == "User Name" ||
                hintText == "First Name" ||
                hintText == "Password" ||
                hintText == "Last Name" ||
                hintText == "Room name") {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your $hintText';
              }
              return null;
            }

            if (hintText == "Email Address") {
              if (controller.text.isEmail) {
                return null;
              } else {
                return "Please Enter Valid Email ";
              }
            } else {
              return null;
            }
          },
        ),
      ),
    ],
  );
}
