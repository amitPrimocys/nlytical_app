// ignore_for_file: avoid_print, must_be_immutable, unused_element, non_constant_identifier_names, use_key_in_widget_constructors

import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

String contrycode = '+91';
// String countryCode = '+91';
SharedPreferences? preferences;
String userID = '';
String userEmail = '';
String userIMAGE = '';
String Latitude = '';
String Longitude = '';

closekeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

int getMonthNumber(String month) {
  const Map<String, int> monthMapping = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12,
  };

  return monthMapping[month] ?? 1; // Default to January if not found
}

String maskPhoneNumber(String phoneNumber) {
  // Use a regular expression to extract the country code and the rest of the phone number
  RegExp regExp = RegExp(r'^(\+\d{1,3})(\d+)$');
  Match? match = regExp.firstMatch(phoneNumber);

  if (match != null) {
    String countryCode = match.group(1)!; // The country code (e.g., +91)
    String remainingNumber = match.group(2)!; // The rest of the phone number

    // Ensure the remaining number has at least 4 digits to mask
    if (remainingNumber.length > 4) {
      String masked =
          '$countryCode${remainingNumber.substring(remainingNumber.length - 9)}';
      return masked;
    }
  }

  // Return the original phone number if it doesn't match the expected pattern
  return phoneNumber;
}

class PDFViewerScreen extends StatelessWidget {
  final String pdfUrl;
  const PDFViewerScreen(this.pdfUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          appBarWidget(),
          Expanded(
            child: SfPdfViewer.network(
              pdfUrl,
            ),
          ),
        ],
      ),
    );
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
                    Get.back();
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              label(
                'PDF Viewer',
                fontSize: 20,
                textColor: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }
}

String formatDate1(String dateString) {
  DateTime date = parseDate(dateString);
  DateTime now = DateTime.now();
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today';
  } else if (date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day) {
    return 'Yesterday';
  } else if (now.difference(date).inDays < 6) {
    return DateFormat('EEEE').format(date); // Day of the week
  } else {
    return DateFormat('dd MMM yyyy').format(date); // Custom date format
  }
}

DateTime parseDate(String dateString) {
  return DateTime.parse(
      dateString); // Directly parses ISO 8601 formatted strings
}

String convertUTCTimeTo12HourFormat(String? utcTimeString) {
  if (utcTimeString == null || utcTimeString.isEmpty) {
    return "Invalid Time";
  }
  try {
    DateTime utcDate = DateFormat("h:mm a").parse(utcTimeString, true).toUtc();
    String formattedTime = DateFormat('h:mm a').format(utcDate.toLocal());
    return formattedTime;
  } catch (e) {
    print("Error parsing date: $e");
    return "Invalid Time";
  }
}

void main() {
  String input = "2024-12-13T11:51:25.000000Z";

  // Example usage
  print(formatDate1(input)); // Outputs 'Today', 'Yesterday', or formatted date
  print(convertUTCTimeTo12HourFormat(input)); // Outputs time in 12-hour format
}

//  -------------------------------------------------------------------------- Online ---------------------------------------------------------------------------

String formatLastSeen(String lastSeenString) {
  DateTime lastSeen = DateTime.parse(lastSeenString).toLocal();

  final now = DateTime.now();
  final difference = now.difference(lastSeen);

  // Use DateFormat to format the time part
  String formattedTime = DateFormat("h:mm a").format(lastSeen);

  if (difference.inDays >= 365) {
    final years = (difference.inDays / 365).floor();
    return 'Last seen $years ${years == 1 ? 'year' : 'years'} ago';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return 'Last seen $months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays >= 1) {
    if (difference.inDays == 1) {
      return 'Last seen yesterday at $formattedTime';
    } else if (difference.inDays == 0) {
      return 'Last seen today, ${DateFormat("d MMMM y").format(lastSeen)}, $formattedTime';
    } else {
      return 'Last seen ${DateFormat("d MMMM y").format(lastSeen)}';
    }
  } else {
    return 'Last seen today at $formattedTime';
  }
}

//============================== Text Style ======================================================================================================================================
Text label(
  String title, {
  TextStyle? style,
  TextAlign? textAlign,
  double fontSize = 12,
  Color textColor = AppColors.black,
  FontWeight fontWeight = FontWeight.normal,
  int? maxLines,
  TextHeightBehavior? textHeightBehavior,
  TextOverflow? overflow,
}) {
  return Text(
    title.tr,
    textAlign: textAlign,
    style: style ?? poppinsFont(fontSize, textColor, fontWeight),
    maxLines: maxLines,
    textHeightBehavior: textHeightBehavior,
    overflow: overflow ?? TextOverflow.ellipsis,
  );
}

Widget twoText({
  required String text1,
  String text2 = "",
  Color colorText2 = Colors.red,
  Color colorText1 = AppColors.black,
  double size = 10,
  FontWeight? fontWeight,
  TextStyle? style1,
  TextStyle? style2,
  void Function()? onTap2,
  MainAxisAlignment? mainAxisAlignment,
  MainAxisSize? mainAxisSize,
}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
    mainAxisSize: mainAxisSize ?? MainAxisSize.max,
    children: [
      label(
        "${text1.tr} ",
        style: style1 ??
            poppinsFont(
                size,
                themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
                fontWeight ?? FontWeight.normal),
      ),
      GestureDetector(
        onTap: onTap2,
        child: label(
          text2.tr,
          style: style2 ??
              poppinsFont(size, colorText2, fontWeight ?? FontWeight.normal),
        ),
      ),
    ],
  );
}

Widget loader() {
  return Center(
    child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: AppColors.blue),
          child: const Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
              )),
        )),
  );
}

//===================================================================================================================================================================
class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  const ImageViewerScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          appBarWidget(),
          Expanded(
            child: PhotoView(
              backgroundDecoration: const BoxDecoration(color: Colors.white),
              imageProvider: NetworkImage(imageUrl),
            ),
          ),
        ],
      ),
    );
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
            color: Colors.grey.shade400)
      ], color: Colors.white),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              label(
                'Image Viewer',
                fontSize: 20,
                textColor: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 18, right: 20, top: 25),
    );
  }
}

//===================================================================================================================================================================
String formatDateTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  bool isToday = dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day;

  if (isToday) {
    // Format time as 4 : 54 PM
    return DateFormat('d MMMM, h:mm a').format(dateTime.toLocal());
  } else {
    // Format as 29 April, 4 : 54 PM
    return DateFormat('d MMMM, h:mm a').format(dateTime.toLocal());
  }
}

Widget commonScaffold({
  required Widget body,
  Widget? bottomNavigationBar,
  bool? resizeToAvoidBottomInset,
}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: AppColors.color0046AE.withOpacity(0.01),
    ),
    child: Scaffold(
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    ),
  );
}

//====================================================================================================================================================================
Widget subsriptionCommonIconText({
  required String title,
  required String image,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        image,
        height: getProportionateScreenHeight(23),
        width: getProportionateScreenWidth(23),
      ),
      sizeBoxWidth(10),
      label(
        title,
        style: poppinsFont(
          14,
          AppColors.color000000,
          FontWeight.w500,
        ),
      ),
    ],
  );
}

//============================================================================================================================================================
Widget commonLoading() {
  return const CircularProgressIndicator(
    strokeWidth: 1.5,
    color: AppColors.color0046AE,
  );
}

//============================================================================================================================================================
Widget commonImage({
  required String image,
  double? height,
  double? width,
  IconData? icon,
  double? radius,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 10),
    child: image.isEmpty
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 10),
                color: Colors.white10),
            child: Icon(
              icon,
              color: AppColors.white,
            ),
          )
        : SizedBox(
            height: height,
            width: width,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(radius ?? 10)),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius ?? 5),
                      color: Colors.white10),
                  child: Icon(
                    icon,
                    color: AppColors.white,
                  ),
                );
              },
            ),
          ),
  );
}

//==================================================================================================================================
Widget globButton({
  required String name,
  void Function()? onTap,
  Gradient? gradient,
  double? radius,
  bool isOuntLined = false,
  double? height,
  double horizontal = 0.0,
  double vertical = 15,
  TextStyle? textStyle,
  Widget? child,
  Color color = AppColors.blue,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      // height: height ?? 50,
      decoration: isOuntLined == false
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 40),
              gradient: gradient ?? AppColors.logoColorWith60Opacity,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 40),
              color: themeContro.isLightMode.value
                  ? AppColors.white
                  : AppColors.darkGray,
              border: Border.all(
                color: color,
              ),
            ),
      child: child ??
          Center(
            child: textStyle != null
                ? label(
                    name,
                    style: textStyle,
                  )
                : label(
                    name,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textColor: isOuntLined == false
                        ? AppColors.white
                        : AppColors.black,
                  ),
          ).paddingSymmetric(
            horizontal: horizontal,
            vertical: vertical,
          ),
    ),
  );
}

Widget customBtn({
  required Function()? onTap,
  required String title,
  required double fontSize,
  required FontWeight weight,
  required BorderRadius radius,
  required double width,
  required double height,
}) {
  return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          backgroundColor: AppColors.blue,
          shape: RoundedRectangleBorder(borderRadius: radius)),
      child: Center(
        child: Text(
          title,
          style: poppinsFont(fontSize, AppColors.white, weight),
        ),
      ));
}

class CustomButtom extends StatelessWidget {
  final Color? color; // Button background color
  final String title;
  final Function() onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final double borderRadius;
  const CustomButtom({
    super.key,
    this.color,
    required this.title,
    required this.onPressed,
    required this.fontSize,
    required this.fontWeight,
    required this.height,
    required this.width,
    this.borderRadius = 10.0,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
            color: AppColors.blue, borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          constraints: BoxConstraints(maxWidth: width, minHeight: height),
          alignment: Alignment.center,
          child: Text(title,
              textAlign: TextAlign.center,
              style: poppinsFont(fontSize, Colors.white, fontWeight)),
        ),
      ),
    );
  }
}

class CustomButtonBorder extends StatelessWidget {
  final Color? color; // Button background color
  final String title;
  final Function() onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final Color fontColor;
  final double borderRadius;

  const CustomButtonBorder({
    super.key,
    this.color,
    required this.title,
    required this.onPressed,
    required this.fontSize,
    required this.fontWeight,
    required this.height,
    required this.width,
    required this.fontColor,
    this.borderRadius = 10.0, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        // backgroundColor:
        //     color ?? AppColors.white, // Use color parameter if provided
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
              color: themeContro.isLightMode.value
                  ? AppColors.blue
                  : AppColors.white),
          color: themeContro.isLightMode.value
              ? Colors.white
              : AppColors.darkMainBlack,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: width,
            minHeight: height,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: poppinsFont(
              fontSize,
              fontColor,
              fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}

Widget globalTextField2({
  String? lable,
  String? lable2,
  required TextEditingController controller,
  required void Function()? onEditingComplete,
  void Function(String)? onChanged,
  required String hintText,
  required BuildContext context,
  bool isBackgroundWhite = false,
  bool isNumber = false,
  bool isOnlyRead = false,
  bool isForPhoneNumber = false,
  bool isLabel = false,
  FocusNode? focusNode,
  bool isEmail = false,
  bool isForProfile = false,
  String imagePath = '',
  int maxLines = 1,
  Widget? suffixIcon,
  Widget? preffixIcon,
  int? maxLength,
  EdgeInsetsGeometry? contentPadding,
  Color? focusedBorderColor,
  void Function()? onTap,
}) {
  // Function to check if a string is a valid URL
  bool isValidUrl(String url) {
    final regex = RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$');
    return regex.hasMatch(url);
  }

  // Function to get the text style based on whether it's a URL
  TextStyle getTextStyle(String text) {
    if (isValidUrl(text)) {
      return const TextStyle(color: Colors.blue); // Blue color for URLs
    }
    return const TextStyle(color: Colors.black); // Default color
  }

  return Column(
    children: [
      twoText(
        text1: lable ?? "",
        text2: lable2 ?? "",
        style1: poppinsFont(
            10,
            themeContro.isLightMode.value ? AppColors.black : AppColors.white,
            FontWeight.w600),
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      (lable == null || lable == "")
          ? const SizedBox.shrink()
          : sizeBoxHeight(5),
      Theme(
        data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
                selectionHandleColor: AppColors.bluee4,
                cursorColor: AppColors.bluee4,
                selectionColor: AppColors.blue.withOpacity(0.5))),
        child: TextFormField(
          controller: controller,
          onTap: onTap,
          textCapitalization:
              isEmail ? TextCapitalization.none : TextCapitalization.words,
          onEditingComplete: onEditingComplete,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: poppinsFont(
              14,
              themeContro.isLightMode.value ? AppColors.black : AppColors.white,
              FontWeight.normal),
          focusNode: focusNode,
          maxLength: maxLength,
          onChanged: onChanged,
          readOnly: isOnlyRead,
          maxLines: maxLines == 1 ? 1 : maxLines,
          keyboardType:
              isNumber ? TextInputType.number : TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: preffixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: (hintText == "Comments" ||
                            hintText == "Address" ||
                            hintText == "Business Description" ||
                            hintText == "Business Address" ||
                            hintText == "Write Your Review....")
                        ? 12
                        : hintText == "Notes"
                            ? 14
                            : 0),
            fillColor: themeContro.isLightMode.value
                ? Colors.transparent
                : AppColors.darkGray,
            filled: true,
            hintText: hintText,
            hintStyle: poppinsFont(12, AppColors.colorB0B0B0, FontWeight.w400),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? AppColors.bluee4
                        : AppColors.darkBorder)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? AppColors.colorEFEFEF
                        : AppColors.darkBorder)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.redAccent)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.redAccent)),
            errorStyle: poppinsFont(12, Colors.redAccent, FontWeight.normal),
            labelText: isLabel ? hintText : null,
            counterStyle:
                poppinsFont(0, AppColors.colorB4B4B4, FontWeight.normal),
            labelStyle: poppinsFont(12, AppColors.colorB0B0B0, FontWeight.w400),
          ),
          validator: (value) {
            if ([
                  'First Name*',
                  'Last Name*',
                  'Room name*',
                  'First Name',
                  'Last Name',
                  'Room name',
                  'User Name'
                ].contains(hintText) &&
                (value == null || value.isEmpty)) {
              return 'Please enter $hintText';
            }
            if (hintText == "Email Address") {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(controller.text)) {
                return "Please enter a valid email address";
              }
            }
            return null;
          },
        ),
      ),
    ],
  );
}

Widget globalTextField3({
  String? lable,
  String? lable2,
  required TextEditingController controller,
  required void Function()? onEditingComplete,
  void Function(String)? onChanged,
  required String hintText,
  required BuildContext context,
  bool isBackgroundWhite = false,
  bool isNumber = false,
  bool isOnlyRead = false,
  bool isForPhoneNumber = false,
  bool isLabel = false,
  FocusNode? focusNode,
  bool isEmail = false,
  bool isForProfile = false,
  String imagePath = '',
  int maxLines = 1,
  Widget? suffixIcon,
  Widget? preffixIcon,
  int? maxLength,
  EdgeInsetsGeometry? contentPadding,
  Color? focusedBorderColor,
  void Function()? onTap,
}) {
  // Function to check if a string is a valid URL
  final RegExp urlRegex = RegExp(r'^(https?:\/\/|www\.)');

  return Column(
    children: [
      twoText(
        text1: lable ?? "",
        text2: lable2 ?? "",
        style1: poppinsFont(
            10,
            themeContro.isLightMode.value ? AppColors.black : AppColors.white,
            FontWeight.w600),
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      (lable == null || lable == "")
          ? const SizedBox.shrink()
          : sizeBoxHeight(5),
      Theme(
        data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
                selectionHandleColor: AppColors.bluee4,
                cursorColor: AppColors.bluee4,
                selectionColor: AppColors.blue.withOpacity(0.5))),
        child: TextFormField(
          controller: controller,
          onTap: onTap,
          textCapitalization:
              isEmail ? TextCapitalization.none : TextCapitalization.words,
          onEditingComplete: onEditingComplete,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: poppinsFont(
              14,
              urlRegex.hasMatch(controller.text)
                  ? AppColors.blue // Change text color to blue if URL
                  : themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
              FontWeight.normal),
          focusNode: focusNode,
          maxLength: maxLength,
          onChanged: onChanged,
          readOnly: isOnlyRead,
          maxLines: maxLines == 1 ? 1 : maxLines,
          keyboardType:
              isNumber ? TextInputType.number : TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: preffixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: (hintText == "Comments" ||
                            hintText == "Address" ||
                            hintText == "Business Description" ||
                            hintText == "Business Address" ||
                            hintText == "Service Description" ||
                            hintText == "Write Your Review....")
                        ? 12
                        : hintText == "Notes"
                            ? 14
                            : 0),
            fillColor: themeContro.isLightMode.value
                ? Colors.transparent
                : AppColors.darkGray,
            filled: true,
            hintText: hintText,
            hintStyle: poppinsFont(12, AppColors.colorB0B0B0, FontWeight.w400),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    BorderSide(color: focusedBorderColor ?? AppColors.bluee4)),
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
                borderSide: const BorderSide(color: Colors.redAccent)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.redAccent)),
            errorStyle: poppinsFont(12, Colors.redAccent, FontWeight.normal),
            labelText: isLabel ? hintText : null,
            counterStyle:
                poppinsFont(0, AppColors.colorB4B4B4, FontWeight.normal),
            labelStyle: poppinsFont(12, AppColors.colorB0B0B0, FontWeight.w400),
          ),
          validator: (value) {
            if ([
                  'First Name*',
                  'Last Name*',
                  'Room name*',
                  'First Name',
                  'Last Name',
                  'Room name',
                  'User Name',
                  'Service Description'
                ].contains(hintText) &&
                (value == null || value.isEmpty)) {
              return 'Please enter $hintText';
            }
            if (hintText == "Email Address") {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(controller.text)) {
                return "Please enter a valid email address";
              }
            }
            return null;
          },
        ),
      ),
    ],
  );
}

String getMobile(String number) {
  return number
      .toString()
      .trim()
      .replaceAll(' ', '')
      .replaceAll(' ', '')
      .replaceAll('  ', '')
      .replaceAll("(", "")
      .replaceAll(")", "")
      .replaceAll("+93", "")
      .replaceAll("+358", "")
      .replaceAll("+355", "")
      .replaceAll("+213", "")
      .replaceAll("+1", "")
      .replaceAll("+376", "")
      .replaceAll("+244", "")
      .replaceAll("+1", "")
      .replaceAll("+1", "")
      .replaceAll("+54", "")
      .replaceAll("+374", "")
      .replaceAll("+297", "")
      .replaceAll("+247", "")
      .replaceAll("+61", "")
      .replaceAll("+672", "")
      .replaceAll("+43", "")
      .replaceAll("+994", "")
      .replaceAll("+1", "")
      .replaceAll("+973", "")
      .replaceAll("+880", "")
      .replaceAll("+1", "")
      .replaceAll("+375", "")
      .replaceAll("+32", "")
      .replaceAll("+501", "")
      .replaceAll("+229", "")
      .replaceAll("+93", "")
      .replaceAll("+355", "")
      .replaceAll("+213", "")
      .replaceAll("+1-684", "")
      .replaceAll("+376", "")
      .replaceAll("+244", "")
      .replaceAll("+1-264", "")
      .replaceAll("+672", "")
      .replaceAll("+1-268", "")
      .replaceAll("+54", "")
      .replaceAll("+374", "")
      .replaceAll("+297", "")
      .replaceAll("+61", "")
      .replaceAll("+43", "")
      .replaceAll("+994", "")
      .replaceAll("+1-242", "")
      .replaceAll("+973", "")
      .replaceAll("+880", "")
      .replaceAll("+1-246", "")
      .replaceAll("+375", "")
      .replaceAll("+32", "")
      .replaceAll("+501", "")
      .replaceAll("+229", "")
      .replaceAll("+1-441", "")
      .replaceAll("+975", "")
      .replaceAll("+591", "")
      .replaceAll("+387", "")
      .replaceAll("+267", "")
      .replaceAll("+55", "")
      .replaceAll("+246", "")
      .replaceAll("+1-284", "")
      .replaceAll("+673", "")
      .replaceAll("+359", "")
      .replaceAll("+226", "")
      .replaceAll("+257", "")
      .replaceAll("+855", "")
      .replaceAll("+237", "")
      .replaceAll("+1", "")
      .replaceAll("+238", "")
      .replaceAll("+1-345", "")
      .replaceAll("+236", "")
      .replaceAll("+235", "")
      .replaceAll("+56", "")
      .replaceAll("+86", "")
      .replaceAll("+61", "")
      .replaceAll("+61", "")
      .replaceAll("+57", "")
      .replaceAll("+269", "")
      .replaceAll("+682", "")
      .replaceAll("+506", "")
      .replaceAll("+385", "")
      .replaceAll("+53", "")
      .replaceAll("+599", "")
      .replaceAll("+357", "")
      .replaceAll("+420", "")
      .replaceAll("+243", "")
      .replaceAll("+45", "")
      .replaceAll("+253", "")
      .replaceAll("+1-767", "")
      .replaceAll("+1-809", "")
      .replaceAll("+1-829", "")
      .replaceAll("+1-849", "")
      .replaceAll("+670", "")
      .replaceAll("+593", "")
      .replaceAll("+20", "")
      .replaceAll("+503", "")
      .replaceAll("+240", "")
      .replaceAll("+291", "")
      .replaceAll("+372", "")
      .replaceAll("+251", "")
      .replaceAll("+500", "")
      .replaceAll("+298", "")
      .replaceAll("+679", "")
      .replaceAll("+358", "")
      .replaceAll("+33", "")
      .replaceAll("+689", "")
      .replaceAll("+241", "")
      .replaceAll("+220", "")
      .replaceAll("+995", "")
      .replaceAll("+49", "")
      .replaceAll("+233", "")
      .replaceAll("+350", "")
      .replaceAll("+30", "")
      .replaceAll("+299", "")
      .replaceAll("+1-473", "")
      .replaceAll("+1-671", "")
      .replaceAll("+502", "")
      .replaceAll("+44-1481", "")
      .replaceAll("+224", "")
      .replaceAll("+245", "")
      .replaceAll("+592", "")
      .replaceAll("+509", "")
      .replaceAll("+504", "")
      .replaceAll("+852", "")
      .replaceAll("+36", "")
      .replaceAll("+354", "")
      .replaceAll("+91", "")
      .replaceAll("+62", "")
      .replaceAll("+98", "")
      .replaceAll("+964", "")
      .replaceAll("+353", "")
      .replaceAll("+44-1624", "")
      .replaceAll("+972", "")
      .replaceAll("+39", "")
      .replaceAll("+225", "")
      .replaceAll("+1-876", "")
      .replaceAll("+81", "")
      .replaceAll("+44-1534", "")
      .replaceAll("+962", "")
      .replaceAll("+7", "")
      .replaceAll("+254", "")
      .replaceAll("+686", "")
      .replaceAll("+383", "")
      .replaceAll("+965", "")
      .replaceAll("+996", "")
      .replaceAll("+856", "")
      .replaceAll("+371", "")
      .replaceAll("+961", "")
      .replaceAll("+266", "")
      .replaceAll("+231", "")
      .replaceAll("+218", "")
      .replaceAll("+423", "")
      .replaceAll("+370", "")
      .replaceAll("+352", "")
      .replaceAll("+853", "")
      .replaceAll("+389", "")
      .replaceAll("+261", "")
      .replaceAll("+265", "")
      .replaceAll("+60", "")
      .replaceAll("+960", "")
      .replaceAll("+223", "")
      .replaceAll("+356", "")
      .replaceAll("+692", "")
      .replaceAll("+222", "")
      .replaceAll("+230", "")
      .replaceAll("+262", "")
      .replaceAll("+52", "")
      .replaceAll("+691", "")
      .replaceAll("+373", "")
      .replaceAll("+377", "")
      .replaceAll("+976", "")
      .replaceAll("+382", "")
      .replaceAll("+1-664", "")
      .replaceAll("+212", "")
      .replaceAll("+258", "")
      .replaceAll("+95", "")
      .replaceAll("+264", "")
      .replaceAll("+674", "")
      .replaceAll("+977", "")
      .replaceAll("+31", "")
      .replaceAll("+599", "")
      .replaceAll("+687", "")
      .replaceAll("+64", "")
      .replaceAll("+505", "")
      .replaceAll("+227", "")
      .replaceAll("+234", "")
      .replaceAll("+683", "")
      .replaceAll("+850", "")
      .replaceAll("+1-670", "")
      .replaceAll("+47", "")
      .replaceAll("+968", "")
      .replaceAll("+92", "")
      .replaceAll("+680", "")
      .replaceAll("+970", "")
      .replaceAll("+507", "")
      .replaceAll("+675", "")
      .replaceAll("+595", "")
      .replaceAll("+51", "")
      .replaceAll("+63", "")
      .replaceAll("+64", "")
      .replaceAll("+48", "")
      .replaceAll("+351", "")
      .replaceAll("+1-787", "")
      .replaceAll("+1-939", "")
      .replaceAll("+974", "")
      .replaceAll("+242", "")
      .replaceAll("+262", "")
      .replaceAll("+40", "")
      .replaceAll("+7", "")
      .replaceAll("+250", "")
      .replaceAll("+590", "")
      .replaceAll("+290", "")
      .replaceAll("+1-869", "")
      .replaceAll("+1-758", "")
      .replaceAll("+590", "")
      .replaceAll("+508", "")
      .replaceAll("+1-784", "")
      .replaceAll("+685", "")
      .replaceAll("+378", "")
      .replaceAll("+239", "")
      .replaceAll("+966", "")
      .replaceAll("+221", "")
      .replaceAll("+381", "")
      .replaceAll("+248", "")
      .replaceAll("+232", "")
      .replaceAll("+65", "")
      .replaceAll("+1-721", "")
      .replaceAll("+421", "")
      .replaceAll("+386", "")
      .replaceAll("+677", "")
      .replaceAll("+252", "")
      .replaceAll("+27", "")
      .replaceAll("+82", "")
      .replaceAll("+211", "")
      .replaceAll("+34", "")
      .replaceAll("+94", "")
      .replaceAll("+249", "")
      .replaceAll("+597", "")
      .replaceAll("+47", "")
      .replaceAll("+268", "")
      .replaceAll("+46", "")
      .replaceAll("+41", "")
      .replaceAll("+963", "")
      .replaceAll("+886", "")
      .replaceAll("+992", "")
      .replaceAll("+255", "")
      .replaceAll("+66", "")
      .replaceAll("+228", "")
      .replaceAll("+690", "")
      .replaceAll("+676", "")
      .replaceAll("+1-868", "")
      .replaceAll("+216", "")
      .replaceAll("+90", "")
      .replaceAll("+993", "")
      .replaceAll("+1-649", "")
      .replaceAll("+688", "")
      .replaceAll("+1-340", "")
      .replaceAll("+256", "")
      .replaceAll("+380", "")
      .replaceAll("+971", "")
      .replaceAll("+44", "")
      .replaceAll("+1", "")
      .replaceAll("+598", "")
      .replaceAll("+998", "")
      .replaceAll("+678", "")
      .replaceAll("+379", "")
      .replaceAll("+58", "")
      .replaceAll("+84", "")
      .replaceAll("+681", "")
      .replaceAll("+212", "")
      .replaceAll("+967", "")
      .replaceAll("+260", "")
      .replaceAll("+263", "")
      .replaceAll("+92", "")
      .replaceAll(RegExp(r'^0+(?=.)'), '')
      .replaceFirst(RegExp(r'^0+'), '')
      .replaceAll("-", "")
      .replaceAll(" ", "")
      .replaceAll(".", "")
      .replaceAll('  ', "")
      .replaceAll("+91", "")
      .trim();
}

//=====================================================================================================================================================================
class DropDown extends StatefulWidget {
  String forWhat;
  DropDown({
    super.key,
    required this.forWhat,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final StoreController storeController = Get.find();
  @override
  Widget build(BuildContext context) {
    List<String> items;
    items = dropDownItems(dropDownType(widget.forWhat));
    debugPrint("items :: $items");
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: themeContro.isLightMode.value
                ? AppColors.colorEFEFEF
                : AppColors.darkBorder),
        color: themeContro.isLightMode.value
            ? Colors.transparent
            : AppColors.darkGray,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton(
        dropdownColor:
            themeContro.isLightMode.value ? Colors.white : AppColors.darkGray,
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            widget.forWhat,
            style: poppinsFont(
                12,
                themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
                FontWeight.w500),
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Transform.rotate(
            angle: -pi / 2,
            child: Image.asset(
              "assets/images/arrow-left1.png",
              height: 20,
              color: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
            ),
          ),
        ),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                items,
                style: poppinsFont(
                    12,
                    themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    FontWeight.w500),
              ),
            ),
          );
        }).toList(),
        underline: const SizedBox(),
        onChanged: (String? newValue) {
          onChange(dropDownType(widget.forWhat), newValue!);
        },
      ),
    );
  }

  List<String> dropDownItems(DropDownType forWhat) {
    switch (forWhat) {
      case DropDownType.category:
        return storeController.categories.toList();
      case DropDownType.subCategory:
        return storeController.subCategories.toList();
      default:
        return [];
    }
  }

  onChange(DropDownType forWhat, String newValue) async {
    switch (forWhat) {
      case DropDownType.category:
        storeController.caategoryName.value = newValue;
        storeController.subCategoryNames.value = [];
        // Fetch subcategories for the selected category
        final selectedCategory = storeController.categoryData.value.data!
            .firstWhere((element) => element.categoryName == newValue);
        // Update subCategories with fetched subcategory names
        storeController.subCategories = selectedCategory.subCategoryData!
            .map((e) => e.subcategoryName!)
            .toList();

        print("subCategories ${storeController.subCategories.length}");

        break;
      case DropDownType.subCategory:
        if (!storeController.subCategoryNames.contains(newValue)) {
          storeController.subCategoryNames.add(newValue);
          setState(() {});
        }
        storeController.subCategoryNames.toSet().toList();
        break;
      default:
        break;
    }
  }

  DropDownType dropDownType(String forWhat) {
    switch (forWhat) {
      case 'Categories':
        return DropDownType.category;
      case "Sub Categories":
        return DropDownType.subCategory;
      default:
        return DropDownType.category;
    }
  }
}

enum DropDownType {
  category,
  subCategory,
}

Shimmer shimmerLoader(double height, double width, double radius) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: Colors.grey),
    ),
  );
}

class DynamicTextWidget extends StatelessWidget {
  final String text;

  const DynamicTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // Find the range of the substring "Big Sarvice" in the text
    int startIndex = text.indexOf('Nlytical');
    bool containsBigSarvice = startIndex != -1;

    return RichText(
      text: TextSpan(
        style: const TextStyle(
            fontWeight: FontWeight.normal), // Default text style
        children: [
          if (containsBigSarvice)
            TextSpan(
              text: text.substring(0, startIndex), // Text before "Big Sarvice"
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: themeContro.isLightMode.value
                    ? Colors.black
                    : AppColors.white,
              ), // Normal text for the part before "Big Sarvice"
            ),
          TextSpan(
            text: containsBigSarvice
                ? 'Nlytical' // Bold text for "Big Sarvice"
                : text, // Full text if "Big Sarvice" is not found
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
            ),
          ),
          if (containsBigSarvice)
            TextSpan(
              text: text.substring(
                  startIndex + 'Nlytical'.length), // Text after "Big Sarvice"
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: themeContro.isLightMode.value
                    ? Colors.black
                    : AppColors.white,
              ), // Normal text for the part after "Big Sarvice"
            ),
        ],
      ),
    );
  }
}

appMainDesignAppBar() {
  return Container(
    width: Get.width,
    height: getProportionateScreenHeight(150),
    decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(AppAsstes.line_design)),
        color: AppColors.blue),
  );
}

String? extractFilename(String url) {
  String fullFilename = url.split('/').last; // Extract full filename from URL

  RegExp regExp = RegExp(r'\d+\.\w+$');
  RegExpMatch? match = regExp.firstMatch(fullFilename);

  String filename = match != null ? match.group(0)! : fullFilename;
  String extension = filename.contains('.') ? filename.split('.').last : '';

  // Remove extension from filename
  String nameWithoutExt = filename.replaceAll(".$extension", "");

  // Check if filename length exceeds 50
  if (nameWithoutExt.length > 25) {
    return "${nameWithoutExt.substring(0, 20)}...$extension";
  } else {
    return filename;
  }
}

Future<dynamic> bottomSheetGobal(
    {required double bottomsheetHeight,
    required String title,
    required Widget child}) {
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
          decoration: BoxDecoration(
            color: themeContro.isLightMode.value
                ? AppColors.white
                : AppColors.darkMainBlack,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: getProportionateScreenHeight(bottomsheetHeight),
          width: Get.width,
          child: Column(
            children: [
              Container(
                height: getProportionateScreenHeight(70),
                width: Get.width,
                decoration: BoxDecoration(
                  // color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  color: themeContro.isLightMode.value
                      ? Colors.white
                      : AppColors.darkGray,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.close,
                        size: 22, color: Colors.transparent),
                    Text(
                      title,
                      style: poppinsFont(
                          16,
                          themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          FontWeight.w500),
                    ),
                    // sizeBoxWidth(145),
                    GestureDetector(
                        onTap: () {
                          print("back");
                          Get.back();
                        },
                        child: Icon(Icons.close,
                            size: 22,
                            color: themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white)),
                  ],
                ).paddingSymmetric(horizontal: 15),
              ),
              Expanded(child: child),
            ],
          ),
        )),
  );

  return ap;
}

Map<String, Map<String, String>> countryCurrency = {
  "Afghanistan": {
    "code": "AFN",
    "currencyName": "Afghani",
    "symbol": "؋",
    "countryCode": "AF",
  },
  "Albania": {
    "code": "ALL",
    "currencyName": "Lek",
    "symbol": "L",
    "countryCode": "AL",
  },
  "Algeria": {
    "code": "DZD",
    "currencyName": "Algerian Dinar",
    "symbol": "د.ج",
    "countryCode": "DZ",
  },
  "Andorra": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "AD",
  },
  "Angola": {
    "code": "AOA",
    "currencyName": "Kwanza",
    "symbol": "Kz",
    "countryCode": "AO",
  },
  "Argentina": {
    "code": "ARS",
    "currencyName": "Argentine Peso",
    "symbol": "\$",
    "countryCode": "DZ",
  },
  "Armenia": {
    "code": "AMD",
    "currencyName": "Armenian Dram",
    "symbol": "֏",
    "countryCode": "AM",
  },
  "Australia": {
    "code": "AUD",
    "currencyName": "Australian Dollar",
    "symbol": "\$",
    "countryCode": "AU",
  },
  "Austria": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "AT",
  },
  "Azerbaijan": {
    "code": "AZN",
    "currencyName": "Azerbaijani Manat",
    "symbol": "₼",
    "countryCode": "AZ",
  },
  "Bahamas": {
    "code": "BSD",
    "currencyName": "Bahamian Dollar",
    "symbol": "\$",
    "countryCode": "BS",
  },
  "Bahrain": {
    "code": "BHD",
    "currencyName": "Bahraini Dinar",
    "symbol": ".د.ب",
    "countryCode": "BH",
  },
  "Bangladesh": {
    "code": "BDT",
    "currencyName": "Taka",
    "symbol": "৳",
    "countryCode": "BD",
  },
  "Barbados": {
    "code": "BBD",
    "currencyName": "Barbadian Dollar",
    "symbol": "\$",
    "countryCode": "BB",
  },
  "Belarus": {
    "code": "BYN",
    "currencyName": "Belarusian Ruble",
    "symbol": "Br",
    "countryCode": "BY",
  },
  "Belgium": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "BE",
  },
  "Belize": {
    "code": "BZD",
    "currencyName": "Belize Dollar",
    "symbol": "\$",
    "countryCode": "BZ",
  },
  "Benin": {
    "code": "XOF",
    "currencyName": "CFA Franc BCEAO",
    "symbol": "CFA",
    "countryCode": "BJ",
  },
  "Bhutan": {
    "code": "BTN",
    "currencyName": "Ngultrum",
    "symbol": "Nu.",
    "countryCode": "BT",
  },
  "Bolivia": {
    "code": "BOB",
    "currencyName": "Boliviano",
    "symbol": "Bs.",
    "countryCode": "BO",
  },
  "Bosnia": {
    "code": "BAM",
    "currencyName": "Convertible Mark",
    "symbol": "KM",
    "countryCode": "BA",
  },
  "Botswana": {
    "code": "BWP",
    "currencyName": "Pula",
    "symbol": "P",
    "countryCode": "BW",
  },
  "Brazil": {
    "code": "BRL",
    "currencyName": "Brazilian Real",
    "symbol": "R\$",
    "countryCode": "BR",
  },
  "Brunei": {
    "code": "BND",
    "currencyName": "Brunei Dollar",
    "symbol": "\$",
    "countryCode": "BN",
  },
  "Bulgaria": {
    "code": "BGN",
    "currencyName": "Bulgarian Lev",
    "symbol": "лв",
    "countryCode": "BG",
  },
  "Burkina Faso": {
    "code": "XOF",
    "currencyName": "CFA Franc BCEAO",
    "symbol": "CFA",
    "countryCode": "BF",
  },
  "Burundi": {
    "code": "BIF",
    "currencyName": "Burundian Franc",
    "symbol": "FBu",
    "countryCode": "BI",
  },
  "Cambodia": {
    "code": "KHR",
    "currencyName": "Riel",
    "symbol": "៛",
    "countryCode": "KH",
  },
  "Cameroon": {
    "code": "XAF",
    "currencyName": "CFA Franc BEAC",
    "symbol": "CFA",
    "countryCode": "CM",
  },
  "Canada": {
    "code": "CAD",
    "currencyName": "Canadian Dollar",
    "symbol": "\$",
    "countryCode": "CA",
  },
  "Chile": {
    "code": "CLP",
    "currencyName": "Chilean Peso",
    "symbol": "\$",
    "countryCode": "CL",
  },
  "China": {
    "code": "CNY",
    "currencyName": "Chinese Yuan",
    "symbol": "¥",
    "countryCode": "CN",
  },
  "Colombia": {
    "code": "COP",
    "currencyName": "Colombian Peso",
    "symbol": "\$",
    "countryCode": "CO",
  },
  "Costa Rica": {
    "code": "CRC",
    "currencyName": "Costa Rican Colón",
    "symbol": "₡",
    "countryCode": "CR",
  },
  "Croatia": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "HR",
  },
  "Cuba": {
    "code": "CUP",
    "currencyName": "Cuban Peso",
    "symbol": "\$",
    "countryCode": "CU",
  },
  "Czechia": {
    "code": "CZK",
    "currencyName": "Czech Koruna",
    "symbol": "Kč",
    "countryCode": "CZ",
  },
  "Denmark": {
    "code": "DKK",
    "currencyName": "Danish Krone",
    "symbol": "kr",
    "countryCode": "DK",
  },
  "Egypt": {
    "code": "EGP",
    "currencyName": "Egyptian Pound",
    "symbol": "E£",
    "countryCode": "EG",
  },
  "Ethiopia": {
    "code": "ETB",
    "currencyName": "Ethiopian Birr",
    "symbol": "Br",
    "countryCode": "ET",
  },
  "Fiji": {
    "code": "FJD",
    "currencyName": "Fijian Dollar",
    "symbol": "\$",
    "countryCode": "FJ",
  },
  "France": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "FR",
  },
  "Germany": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "DE",
  },
  "Ghana": {
    "code": "GHS",
    "currencyName": "Ghanaian Cedi",
    "symbol": "GH₵",
    "countryCode": "GH",
  },
  "Greece": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "GR",
  },
  "Guatemala": {
    "code": "GTQ",
    "currencyName": "Guatemalan Quetzal",
    "symbol": "Q",
    "countryCode": "GT",
  },
  "Hong Kong": {
    "code": "HKD",
    "currencyName": "Hong Kong Dollar",
    "symbol": "\$",
    "countryCode": "HK",
  },
  "Hungary": {
    "code": "HUF",
    "currencyName": "Hungarian Forint",
    "symbol": "Ft",
    "countryCode": "HU",
  },
  "Iceland": {
    "code": "ISK",
    "currencyName": "Icelandic Krona",
    "symbol": "kr",
    "countryCode": "IS",
  },
  "India": {
    "code": "INR",
    "currencyName": "Indian Rupee",
    "symbol": "₹",
    "countryCode": "IN",
  },
  "Indonesia": {
    "code": "IDR",
    "currencyName": "Indonesian Rupiah",
    "symbol": "Rp",
    "countryCode": "ID",
  },
  "Iran": {
    "code": "IRR",
    "currencyName": "Iranian Rial",
    "symbol": "﷼",
    "countryCode": "IR",
  },
  "Iraq": {
    "code": "IQD",
    "currencyName": "Iraqi Dinar",
    "symbol": "د.ع",
    "countryCode": "IQ",
  },
  "Israel": {
    "code": "ILS",
    "currencyName": "Israeli Shekel",
    "symbol": "₪",
    "countryCode": "IL",
  },
  "Italy": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "IT",
  },
  "Jamaica": {
    "code": "JMD",
    "currencyName": "Jamaican Dollar",
    "symbol": "\$",
    "countryCode": "JM",
  },
  "Japan": {
    "code": "JPY",
    "currencyName": "Japanese Yen",
    "symbol": "¥",
    "countryCode": "JP",
  },
  "Jordan": {
    "code": "JOD",
    "currencyName": "Jordanian Dinar",
    "symbol": "د.ا",
    "countryCode": "JO",
  },
  "Kazakhstan": {
    "code": "KZT",
    "currencyName": "Kazakhstani Tenge",
    "symbol": "₸",
    "countryCode": "KZ",
  },
  "Kenya": {
    "code": "KES",
    "currencyName": "Kenyan Shilling",
    "symbol": "KSh",
    "countryCode": "KE",
  },
  "Kuwait": {
    "code": "KES",
    "currencyName": "Kuwaiti Dinar",
    "symbol": "د.ك",
    "countryCode": "KW",
  },
  "Laos": {
    "code": "LAK",
    "currencyName": "Lao Kip",
    "symbol": "₭",
    "countryCode": "LA",
  },
  "Latvia": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "LV",
  },
  "Lebanon": {
    "code": "LBP",
    "currencyName": "Lebanese Pound",
    "symbol": "ل.ل",
    "countryCode": "LB",
  },
  "Malaysia": {
    "code": "MYR",
    "currencyName": "Malaysian Ringgit",
    "symbol": "RM",
    "countryCode": "MY",
  },
  "Mexico": {
    "code": "MXN",
    "currencyName": "Mexican Peso",
    "symbol": "\$",
    "countryCode": "MX",
  },
  "Morocco": {
    "code": "MAD",
    "currencyName": "Moroccan Dirham",
    "symbol": "د.م.",
    "countryCode": "MA",
  },
  "Myanmar": {
    "code": "MMK",
    "currencyName": "Burmese Kyat",
    "symbol": "Ks",
    "countryCode": "MM",
  },
  "Namibia": {
    "code": "NAD",
    "currencyName": "Namibian Dollar",
    "symbol": "Ks",
    "countryCode": "NA",
  },
  "Nepal": {
    "code": "NPR",
    "currencyName": "Nepalese Rupee",
    "symbol": "रु",
    "countryCode": "NP",
  },
  "Netherlands": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "NL",
  },
  "New Zealand": {
    "code": "NZD",
    "currencyName": "New Zealand Dollar",
    "symbol": "\$",
    "countryCode": "NZ",
  },
  "Nigeria": {
    "code": "NGN",
    "currencyName": "Nigerian Naira",
    "symbol": "₦",
    "countryCode": "NG",
  },
  "North Korea": {
    "code": "KPW",
    "currencyName": "North Korean Won",
    "symbol": "₩",
    "countryCode": "KP",
  },
  "Norway": {
    "code": "NOK",
    "currencyName": "Norwegian Krone",
    "symbol": "kr",
    "countryCode": "NO",
  },
  "Oman": {
    "code": "OMR",
    "currencyName": "Omani Rial",
    "symbol": "﷼",
    "countryCode": "OM",
  },
  "Pakistan": {
    "code": "PKR",
    "currencyName": "Pakistani Rupee",
    "symbol": "₨",
    "countryCode": "PK",
  },
  "Philippines": {
    "code": "PHP",
    "currencyName": "Philippine Peso",
    "symbol": "₱",
    "countryCode": "PH",
  },
  "Poland": {
    "code": "PLN",
    "currencyName": "Polish Złoty",
    "symbol": "zł",
    "countryCode": "PL",
  },
  "Portugal": {
    "code": "EUR",
    "currencyName": "Euro",
    "symbol": "€",
    "countryCode": "PT",
  },
  "Qatar": {
    "code": "QAR",
    "currencyName": "Qatari Riyal",
    "symbol": "﷼",
    "countryCode": "QA",
  },
  "Romania": {
    "code": "RON",
    "currencyName": "Romanian Leu",
    "symbol": "lei",
    "countryCode": "RO",
  },
  "Russia": {
    "code": "RUB",
    "currencyName": "Russian Ruble",
    "symbol": "₽",
    "countryCode": "RU",
  },
  "Saudi Arabia": {
    "code": "SAR",
    "currencyName": "Saudi Riyal",
    "symbol": "﷼",
    "countryCode": "SA",
  },
  "Serbia": {
    "code": "RSD",
    "currencyName": "Serbian Dinar",
    "symbol": "дин.",
    "countryCode": "RS",
  },
  "Singapore": {
    "code": "SGD",
    "currencyName": "Singapore Dollar",
    "symbol": "\$",
    "countryCode": "SG",
  },
  "South Africa": {
    "code": "ZAR",
    "currencyName": "South African Rand",
    "symbol": "R",
    "countryCode": "ZA",
  },
  "South Korea": {
    "code": "KRW",
    "currencyName": "South Korean Won",
    "symbol": "₩",
    "countryCode": "KR",
  },
  "Spain": {
    "code": "EUR",
    "currencyName": "South Korean Won",
    "symbol": "€",
    "countryCode": "ES",
  },
  "Sri Lanka": {
    "code": "LKR",
    "currencyName": "Sri Lankan Rupee",
    "symbol": "Rs",
    "countryCode": "LK",
  },
  "Sudan": {
    "code": "SDG",
    "currencyName": "Sudanese Pound",
    "symbol": "ج.س.",
    "countryCode": "SS",
  },
  "Sweden": {
    "code": "SEK",
    "currencyName": "Euro",
    "symbol": "kr",
    "countryCode": "SE",
  },
  "Switzerland": {
    "code": "CHF",
    "currencyName": "Swiss Franc",
    "symbol": "Fr",
    "countryCode": "CH",
  },
  "Syria": {
    "code": "SYP",
    "currencyName": "Syrian Pound",
    "symbol": "£S",
    "countryCode": "SY",
  },
  "Taiwan": {
    "code": "TWD",
    "currencyName": "New Taiwan Dollar",
    "symbol": "NT\$",
    "countryCode": "TW",
  },
  "Thailand": {
    "code": "THB",
    "currencyName": "Thai Baht",
    "symbol": "฿",
    "countryCode": "TH",
  },
  "Turkey": {
    "code": "TRY",
    "currencyName": "Turkish Lira",
    "symbol": "₺",
    "countryCode": "TR",
  },
  "Ukraine": {
    "code": "UAH",
    "currencyName": "Ukrainian Hryvnia",
    "symbol": "₴",
    "countryCode": "UA",
  },
  "United Arab Emirates": {
    "code": "AED",
    "currencyName": "UAE Dirham",
    "symbol": "د.إ",
    "countryCode": "AE",
  },
  "United Kingdom": {
    "code": "GBP",
    "currencyName": "British Pound",
    "symbol": "£",
    "countryCode": "GB",
  },
  "United States": {
    "code": "USD",
    "currencyName": "US Dollar",
    "symbol": "\$",
    "countryCode": "US",
  },
  "Uruguay": {
    "code": "UYU",
    "currencyName": "Uruguayan Peso",
    "symbol": "\$U",
    "countryCode": "UY",
  },
  "Uzbekistan": {
    "code": "UZS",
    "currencyName": "Uzbekistani Som",
    "symbol": "soʻm",
    "countryCode": "UZ",
  },
  "Venezuela": {
    "code": "VES",
    "currencyName": "Venezuelan Bolívar",
    "symbol": "Bs.",
    "countryCode": "VE",
  },
  "Vietnam": {
    "code": "VND",
    "currencyName": "Vietnamese Dong",
    "symbol": "₫",
    "countryCode": "VN",
  },
  "Yemen": {
    "code": "YER",
    "currencyName": "Yemeni Rial",
    "symbol": "﷼",
    "countryCode": "YE",
  },
  "Zambia": {
    "code": "ZMW",
    "currencyName": "Zambian Kwacha",
    "symbol": "ZK",
    "countryCode": "ZM",
  }
};
