// ignore_for_file: deprecated_member_use, avoid_print, unnecessary_null_comparison, use_full_hex_values_for_flutter_colors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/controllers/vendor_controllers/profile_cotroller.dart';
import 'package:nlytical_app/controllers/vendor_controllers/store_controller.dart';
import 'package:nlytical_app/Vendor/screens/auth/payment_history.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/all_service.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/line_chat/main_page.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/my_review_screen.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/profile.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_images.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_social_link.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_video.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/business_website.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/contact_detail.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/edit_service_profile.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/store_time.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/support.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/sponsor/add_campaign.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StoreController storeController = Get.find();
  ProfileCotroller profileCotroller = Get.find();
  final searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  // String currentAddress = "Fetching location...";
  // ignore: unused_field
  Position? _currentPosition;

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, so request the user to enable them.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, so return an error.
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, so return an error.
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location of the device
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    setState(() {
      _currentPosition = position;
    });

    // Get the address from the current latitude and longitude
    _getAddressFromLatLng(position);
  }

  // Convert latitude and longitude to address using geocoding
  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print(position.latitude);
      print(position.longitude);
      SharedPrefs.setString(
          SharedPreferencesKey.LATTITUDE, position.latitude.toString());
      SharedPrefs.setString(
          SharedPreferencesKey.LONGITUDE, position.longitude.toString());

      Placemark place = placemarks[0];

      setState(() {
        storeController.currentAddress =
            "${place.subLocality} ,${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        storeController.currentAddress = "Could not get address";
      });
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      storeController.businessPercentageApi();
      storeController.getStoreDetailApi();
      profileCotroller.getProfleApi();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? AppColors.white
            : AppColors.darkMainBlack,
        body: Column(
          children: [
            myLocationWidget(),
            sizeBoxHeight(50),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  // business percentage
                  percentageWidget(),
                  sizeBoxHeight(20),
                  profetionaldash(),
                  sizeBoxHeight(20),
                  // add service button
                  addServiceBtn(),
                  sizeBoxHeight(20),
                  // quick links
                  quickLinkWidget(),
                  sizeBoxHeight(30),
                  // business tools
                  myBusinessWidget()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

//================================================= PERCENTAGE Widget ===========================================================================================
  Widget percentageWidget() {
    final percentageString = SharedPrefs.getString(
        SharedPreferencesKey.PERCENTAGE); // Fallback to '0'
    final percentageValue =
        double.tryParse(percentageString) ?? 0.0; // Convert to double
    return Container(
      height: getProportionateScreenHeight(110),
      decoration: BoxDecoration(
          border: Border.all(
              color: themeContro.isLightMode.value
                  ? Colors.grey.shade100
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
          color: themeContro.isLightMode.value ? Colors.white : AppColors.blue,
          boxShadow: const [
            BoxShadow(
                blurRadius: 14.4,
                offset: Offset(0, 4),
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.06))
          ]),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              animatedCircularProgressIndicator(value: percentageValue / 100),
              Text(
                percentageString == '0' && percentageString == null
                    ? '0%'
                    : '$percentageString%', // Display the percentage here
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 174, 93, 1),
                ),
              ),
            ],
          ),
          sizeBoxWidth(30),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Increase Business Profile Score",
                style: poppinsFont(
                    14,
                    themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    FontWeight.w600),
              ),
              Text(
                "Reach out to more Customers",
                style: poppinsFont(
                    12,
                    themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    FontWeight.w400),
              ),
              sizeBoxHeight(2),
              Container(
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: themeContro.isLightMode.value
                        ? AppColors.blue
                        : AppColors.white),
                child: Center(
                  child: Text(
                    "Increase Score",
                    style: poppinsFont(
                        10,
                        themeContro.isLightMode.value
                            ? AppColors.white
                            : AppColors.blue,
                        FontWeight.w500),
                  ),
                ),
              ),
            ],
          ))
        ],
      ).paddingOnly(left: 30),
    ).paddingSymmetric(horizontal: 12);
  }

//================================================ Proferional Widget =========================================================================================

  Widget profetionaldash() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            // Get.to(const BudgetDuration());
            Get.to(() => const MainPage());
          },
          child: Container(
            height: getProportionateScreenHeight(80),
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade100
                        : AppColors.darkGray),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.blue1,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 14.4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.06))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label('Professional Dashboard',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white)),
                sizeBoxHeight(8),
                label('11.5K views in last 30 days',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(124, 124, 124, 1)))
              ],
            ).paddingAll(12),
          ).paddingSymmetric(horizontal: 13),
        ),
        Positioned(
            top: -42,
            right: 7,
            child: Image.asset(
              AppAsstes.Darkanalytics,
              height: 150,
              width: 122,
            ))
      ],
    );
  }

//==================================================== Add Service Btn =========================================================================================
  Widget addServiceBtn() {
    return Container(
      height: getProportionateScreenHeight(65),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Grow Your ",
                        style: poppinsFont(
                            14,
                            themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            FontWeight.w600)),
                    TextSpan(
                        text: "Business 🚀",
                        style: poppinsFont(
                            14,
                            const Color.fromRGBO(255, 82, 73, 1),
                            FontWeight.w600)),
                  ])),
                ],
              ).paddingSymmetric(horizontal: 15),
            ],
          ).paddingSymmetric(vertical: 5),
          customBtn(
                  onTap: () {
                    Get.to(() => AddCampaign(
                          latt: storeController.storeDetailModel.value
                              .serviceDetails![0].contactDetails!.lat
                              .toString(),
                          lonn: storeController.storeDetailModel.value
                              .serviceDetails![0].contactDetails!.lon
                              .toString(),
                          serviceid: storeController.storeDetailModel.value
                              .serviceDetails![0].businessDetails!.id
                              .toString(),
                          vendorid: storeController.storeDetailModel.value
                              .serviceDetails![0].businessDetails!.vendorId
                              .toString(),
                          addrss: storeController.storeDetailModel.value
                              .serviceDetails![0].contactDetails!.address
                              .toString(),
                        ));
                  },
                  title: "Sponsor Now",
                  fontSize: 11,
                  weight: FontWeight.w500,
                  radius: const BorderRadius.all(Radius.circular(11)),
                  width: getProportionateScreenWidth(140),
                  height: getProportionateScreenHeight(27))
              .paddingSymmetric(vertical: 8, horizontal: 12),
        ],
      ),
    ).paddingSymmetric(
      horizontal: 13,
    );
  }

//=========================================================== QUICK LINKS =======================================================================================
  Widget quickLinkWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Links",
          style: poppinsFont(
              14,
              themeContro.isLightMode.value ? AppColors.black : AppColors.white,
              FontWeight.w600),
        ).paddingOnly(left: 15),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            linkContainer(
              onTap: () {
                Get.to(const EditServiceProfile());
              },
              color: const Color.fromRGBO(255, 220, 220, 1),
              img: AppAsstes.vision,
              height: 24,
              title: "Edit Profile",
            ),
            linkContainer(
              onTap: () {
                Get.to(() => const BusinessImages())!.then((_) {
                  setState(() {
                    storeController.storeDetailModel.refresh();
                    storeController.storeList.refresh();
                  });
                });
              },
              color: const Color.fromRGBO(197, 225, 205, 1),
              img: AppAsstes.photo,
              height: 23,
              title: "Add Photos",
            ),
            linkContainer(
              onTap: () {
                Get.to(() => const ContactDetail())!.then((_) {
                  setState(() {
                    storeController.storeDetailModel.refresh();
                    storeController.storeList.refresh();
                  });
                });
              },
              color: const Color.fromRGBO(220, 235, 255, 1),
              img: AppAsstes.contact,
              height: 23,
              title: "Add Contact",
            ),
            linkContainer(
              onTap: () {
                Get.to(() => const StoreTimeScreen())!.then((_) {
                  setState(() {
                    storeController.storeDetailModel.refresh();
                    storeController.storeList.refresh();
                  });
                });
              },
              color: const Color.fromRGBO(230, 220, 255, 1),
              img: AppAsstes.clock1,
              height: 24,
              title: "Business Timings",
            ),
          ],
        ).paddingSymmetric(horizontal: 30),
        sizeBoxHeight(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            linkContainer(
              onTap: () {
                Get.to(() => const MyReviewScreen());
              },
              color: const Color.fromRGBO(181, 226, 255, 1),
              img: AppAsstes.discussion,
              height: 24,
              title: "Reviews",
            ),
            linkContainer(
              onTap: () {
                Get.to(() => const BusinessWebsite())!.then((_) {
                  setState(() {
                    storeController.storeDetailModel.refresh();
                    storeController.storeList.refresh();
                  });
                });
              },
              color: const Color.fromRGBO(255, 220, 253, 1),
              img: AppAsstes.Group,
              height: 23,
              title: "Add Website",
            ),
            linkContainer(
              onTap: () {
                Get.to(() => const BusinessVideo())!.then((_) {
                  setState(() {
                    storeController.storeDetailModel.refresh();
                    storeController.storeList.refresh();
                  });
                });
              },
              color: const Color.fromRGBO(255, 225, 170, 1),
              img: AppAsstes.video,
              height: 23,
              title: "Add Video",
            ),
            linkContainer(
              onTap: () {
                Get.to(() => const BusinessSocialLink())!.then((_) {
                  setState(() {
                    storeController.storeDetailModel.refresh();
                    storeController.storeList.refresh();
                  });
                });
              },
              color: const Color.fromRGBO(183, 253, 247, 1),
              img: AppAsstes.lock1,
              height: 24,
              title: "Add Social Links",
            ),
          ],
        ).paddingSymmetric(horizontal: 30)
      ],
    );
  }

  Widget linkContainer(
      {required Function() onTap,
      required Color color,
      required String img,
      required String title,
      required double height}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: getProportionateScreenHeight(50),
            width: getProportionateScreenWidth(50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: color),
            child: Center(
              child: Image.asset(img, height: height),
            ),
          ),
          sizeBoxHeight(5),
          SizedBox(
            width: 50,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: poppinsFont(
                  10,
                  themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
                  FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

//===================================================== MY BUSINESS ============================================================================================
  Widget myBusinessWidget() {
    return Container(
      width: Get.width,
      height: getProportionateScreenHeight(555),
      decoration: BoxDecoration(
          color:
              themeContro.isLightMode.value ? Colors.white : AppColors.darkGray,
          boxShadow: [
            BoxShadow(
                blurRadius: 11.9,
                spreadRadius: 0,
                offset: const Offset(6, 8),
                color: themeContro.isLightMode.value
                    ? Colors.grey
                    : const Color(0xff0000000f))
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: [
          sizeBoxHeight(10),
          Container(
            height: 3,
            width: 70,
            color: Colors.grey,
          ),
          sizeBoxHeight(20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "My Business",
              style: poppinsFont(
                  14,
                  themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white,
                  FontWeight.w600),
            ),
          ),
          sizeBoxHeight(20),
          businessContainer(
            onTap: () {
              Get.to(const EditServiceProfile());
            },
            img: AppAsstes.tools,
            title: "Business Tools",
            subTitle: "Manage Offers, Reviews and more",
          ),
          sizeBoxHeight(20),
          businessContainer(
            onTap: () {
              Get.to(() => const AllServiceScreen());
            },
            img: AppAsstes.group1,
            title: "Services",
            subTitle: "Add Services, List, and Edit it",
          ),
          sizeBoxHeight(20),
          businessContainer(
            onTap: () {
              Get.to(() => const PaymentHistory());
            },
            img: AppAsstes.payment,
            title: "Payment History",
            subTitle: "See all the sponsored payment history",
          ),
          sizeBoxHeight(20),
          businessContainer(
            onTap: () {
              Get.to(const Support());
              //Get.to(const CustomContaine());
            },
            img: AppAsstes.contact1,
            title: "Support",
            subTitle: "Connect with Us",
          ),
        ],
      ).paddingSymmetric(horizontal: 15),
    );
  }

  Widget businessContainer(
      {required Function() onTap,
      required String img,
      required String title,
      required String subTitle}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getProportionateScreenHeight(80),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.14,
                  spreadRadius: 0,
                  offset: const Offset(0.2, 0.4),
                  color: themeContro.isLightMode.value
                      ? Colors.grey
                      : const Color(0xff0000000f))
            ],
            borderRadius: BorderRadius.circular(10),
            color: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkMainBlack),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(img, height: 19),
                sizeBoxWidth(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: poppinsFont(
                          14,
                          themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          FontWeight.w600),
                    ),
                    sizeBoxHeight(5),
                    Text(
                      subTitle,
                      style: poppinsFont(10, Colors.grey, FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: AppColors.blue,
            ).paddingOnly(bottom: 15)
          ],
        ).paddingOnly(left: 15, right: 10, top: 15),
      ),
    );
  }

//================================================== TOP CURRENT LOCATION STATUS WIDGET =========================================================================
  Widget myLocationWidget() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: getProportionateScreenHeight(170),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAsstes.line_design), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: AppColors.blue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello, ${SharedPrefs.getString(SharedPreferencesKey.LOGGED_IN_USERFNAME)}",
                      style: poppinsFont(20, AppColors.white, FontWeight.w500),
                    ),
                    const SizedBox(height: 4), // Space between text lines
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppAsstes.location1,
                          color: AppColors.white,
                          height: 18,
                        ),
                        Expanded(
                            child: Text(
                          " ${storeController.currentAddress}",
                          style:
                              poppinsFont(12, AppColors.white, FontWeight.w400),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ))
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const ProfilePage());
                },
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44),
                      color: Colors.white),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(44),
                      child: Image.network(userIMAGE, fit: BoxFit.cover,
                          loadingBuilder: (BuildContext ctx, Widget child,
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
                        return const Icon(Icons.person, size: 20);
                      })),
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
        Positioned(bottom: -23, left: 9, child: searchBar())
      ],
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: TextField(
        controller: searchController,
        style: poppinsFont(
            13,
            themeContro.isLightMode.value ? Colors.black : AppColors.white,
            FontWeight.w500),
        decoration: InputDecoration(
            fillColor: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkMainBlack,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray,
                    width: 1.5)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.greyColor, width: 5)),
            hintText: "Search Services",
            hintStyle: poppinsFont(13, Colors.grey.shade400, FontWeight.w500),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 15, top: 15),
              child: Image.asset(
                AppAsstes.search,
                color: Colors.grey.shade400,
                height: 10,
              ),
            )),
      ).paddingSymmetric(horizontal: 10),
    );
  }

  Widget animatedCircularProgressIndicator({required double value}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
          begin: 0, end: value), // Animate from 0 to the target value
      duration:
          const Duration(milliseconds: 800), // Adjust the duration as needed
      builder: (context, animatedValue, child) {
        return CircularProgressIndicator.adaptive(
          strokeAlign: 2.7,
          strokeWidth: 7,
          strokeCap: StrokeCap.round,
          value: animatedValue, // Use the animated value here
          backgroundColor: const Color.fromRGBO(113, 239, 180, 0.445),
          valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(0, 174, 93, 1)),
        );
      },
    );
  }
}
