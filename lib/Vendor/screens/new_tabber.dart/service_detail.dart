// ignore_for_file: prefer_const_constructors, unused_element, must_be_immutable, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, deprecated_member_use, unused_field, avoid_print, empty_catches
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/details_loader.dart';
import 'package:nlytical_app/shared_preferences/prefrences_key.dart';
import 'package:nlytical_app/shared_preferences/shared_prefkey.dart';
import 'package:nlytical_app/utils/google_map.dart';
import 'package:nlytical_app/controllers/vendor_controllers/service_controller.dart';
import 'package:nlytical_app/models/vendor_models/service_detail_model.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/review_widget.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/my_widget2.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global_fonts.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TextEditingController searchcontroller = TextEditingController();
  ServiceController serviceController = Get.find();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print("😀😀😀😀USER_ID:$userID");
    serviceController.servicedetailApi();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update the widget whenever the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();
  final msgController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  // VideoPlayerController? controller;

  Duration? duration, position;
  late AnimationController _animationController;
  bool isPlay = true;
  double videoProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
        body: Obx(() {
          return serviceController.isservice.value
              ? detailLoader(context)
              : DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: Scaffold(
                      backgroundColor: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkMainBlack,
                      body: NestedScrollView(
                        // controller: scrollCtrl,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          debugPrint("InnerBoxIS SCROLLED $innerBoxIsScrolled");
                          return [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  imagelistt(),
                                  sizeBoxHeight(150),
                                ],
                              ),
                            ),
                          ];
                        },
                        body: Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: themeContro.isLightMode.value
                                    ? Colors.white
                                    : AppColors.darkMainBlack,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                dividerColor: Colors.transparent,
                                indicatorSize: TabBarIndicatorSize.tab,
                                unselectedLabelStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                indicatorWeight: 1,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                labelPadding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 8),
                                unselectedLabelColor: Colors.black,
                                indicator: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                tabs: List.generate(4, (index) {
                                  bool isSelected =
                                      _tabController.index == index;
                                  return Tab(
                                      child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.5, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? themeContro.isLightMode.value
                                              ? AppColors.coloropcity
                                              : AppColors.blue
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: themeContro.isLightMode.value
                                              ? AppColors.blue
                                              : isSelected
                                                  ? AppColors.black
                                                  : AppColors
                                                      .grey1), // Blue border for all tabs
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      [
                                        'Overview',
                                        'Services',
                                        'Photos',
                                        'Reviews'
                                      ][index],
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: themeContro.isLightMode.value
                                            ? Colors.black
                                            : isSelected
                                                ? AppColors.white
                                                : AppColors.grey1,
                                      ),
                                    ),
                                  ));
                                }),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                physics: AlwaysScrollableScrollPhysics(),
                                children: [
                                  info(),
                                  services(),
                                  photos(),
                                  customerreview(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                );
        }),
      ),
    );
  }

  Widget imagelistt() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 220,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: _poster2(context),
        ),
        Positioned(
          top: 35,
          left: 20,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/arrow-left1.png',
                height: 24,
              )),
        ),
        Positioned(
          bottom: -125,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: themeContro.isLightMode.value
                          ? Colors.white
                          : AppColors.darkGray,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: themeContro.isLightMode.value
                              ? AppColors.color909092
                              : AppColors.darkShadowColor,
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              0.0, 0.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 11, bottom: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: themeContro.isLightMode.value
                                    ? AppColors.color0046AE1A
                                    : Colors.black26),
                            child: Center(
                              child: Text(
                                serviceController.servicemodel.value!
                                    .serviceDetail!.categoryName!,
                                style: poppinsFont(
                                    8,
                                    themeContro.isLightMode.value
                                        ? AppColors.blue
                                        : AppColors.white,
                                    FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          label(
                            serviceController
                                .servicemodel.value!.serviceDetail!.serviceName
                                .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            textColor: themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    initialRating: serviceController
                                            .servicemodel
                                            .value!
                                            .serviceDetail!
                                            .totalAvgReview!
                                            .isNotEmpty
                                        ? double.parse(serviceController
                                            .servicemodel
                                            .value!
                                            .serviceDetail!
                                            .totalAvgReview!)
                                        : 0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 12.5,
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey.shade400,
                                    itemBuilder: (context, _) => Image.asset(
                                      'assets/images/Star.png',
                                      height: 16,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  const SizedBox(width: 5),
                                  label(
                                    '(${serviceController.servicemodel.value!.serviceDetail!.totalReviewCount!.toString()} Review)',
                                    // '(${avrageReview} Review)',
                                    fontSize: 10,
                                    textColor: themeContro.isLightMode.value
                                        ? AppColors.color5C5C5C
                                        : AppColors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ).paddingOnly(right: 14),
                              label(
                                '${serviceController.servicemodel.value!.serviceDetail!.totalYearsCount!.toString()} Years in Business',
                                // ${avrageReview} Years in Business,
                                fontSize: 10,
                                textColor: themeContro.isLightMode.value
                                    ? AppColors.color5C5C5C
                                    : AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          sizeBoxHeight(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location1.png',
                                    height: 15,
                                    color: AppColors.blue,
                                  ),
                                  sizeBoxWidth(5),
                                  label(
                                    serviceController.servicemodel.value!
                                        .serviceDetail!.distance!
                                        .toString(),
                                    // ${avrageReview} Years in Business,
                                    fontSize: 10,
                                    textColor: themeContro.isLightMode.value
                                        ? AppColors.color5C5C5C
                                        : AppColors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  label(
                                    'Open',
                                    fontSize: 10,
                                    textColor: Color(0xff4CAF50),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  label(
                                    ' Until ${serviceController.servicemodel.value!.serviceDetail!.closeTime!.toString()}',
                                    fontSize: 10,
                                    textColor: themeContro.isLightMode.value
                                        ? AppColors.color5C5C5C
                                        : AppColors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          themeContro.isLightMode.value
                              ? CustomButtonBorder(
                                  title: "From \$252-565",
                                  onPressed: () {},
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  height: 35,
                                  width: Get.width,
                                  fontColor: AppColors.blue)
                              : InkWell(
                                  child: Container(
                                    height: 40,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.color0046AE1A,
                                        border:
                                            Border.all(color: AppColors.blue)),
                                    child: Center(
                                      child: Text(
                                        "From \$252-565",
                                        style: poppinsFont(13, AppColors.white,
                                            FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ).paddingSymmetric(horizontal: 5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _poster2(BuildContext context) {
    Widget carousel = serviceController
            .servicemodel.value!.serviceDetail!.serviceImages!.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.blue,
            ),
          )
        : Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: ImageSlideshow(
                  initialPage: 0,
                  autoPlayInterval: 3000,
                  isLoop: true,
                  height: 200,
                  indicatorColor: AppColors.blue,
                  indicatorBackgroundColor: Colors.white,
                  indicatorRadius: 3,
                  children: serviceController
                      .servicemodel.value!.serviceDetail!.serviceImages!
                      .map((img) {
                    return Image.network(
                      img, // Use the image URL from your API
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ); // Handle image loading error
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );

    return SizedBox(
      height: Get.height * 0.35,
      width: Get.width,
      child: carousel,
    );
  }

  Widget _posterDialog2(BuildContext context) {
    Widget carousel = serviceController
            .servicemodel.value!.serviceDetail!.serviceImages!.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.blue,
            ),
          )
        : ImageSlideshow(
            autoPlayInterval: null,
            isLoop: true,
            // height: 230,
            // width: 300,
            indicatorColor: AppColors.blue,
            indicatorBackgroundColor: AppColors.white,
            indicatorRadius: 3,
            children: serviceController
                .servicemodel.value!.serviceDetail!.serviceImages!
                .map((img) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  img, // Use the image URL from your API
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ); // Handle image loading error
                  },
                ),
              );
            }).toList(),
          );

    return SizedBox(
      width: Get.width,
      child: carousel,
    );
  }

  _launchWhatsapp(url) async {
    url = url;
    //"https://wa.me/?text=Hey buddy, try this super cool new app!";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchSocial(String urll
      //, String fallbackUrl
      ) async {
    //url = url;
    // 'fb://page/109225061600007','https://www.facebook.com/Username'
    // try {
    //   final Uri uri = Uri.parse(url);
    //   await launchUrl(uri, mode: LaunchMode.platformDefault);
    // } catch (e) {
    //   final Uri fallbackUri = Uri.parse(fallbackUrl);
    //   await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    // }
    var url = urll;
    //'fb://facewebmodal/f?href=https://www.facebook.com/al.mamun.me12';
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget info() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Get.width * 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeContro.isLightMode.value
                        ? Colors.white
                        : AppColors.darkGray,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: themeContro.isLightMode.value
                            ? AppColors.color909092
                            : AppColors.darkShadowColor,
                        blurRadius: 14.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 4.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        label(
                          'Business Information',
                          fontSize: 12,
                          textColor: themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 5),
                        ExpandableText(
                          serviceController.servicemodel.value!.serviceDetail!
                              .serviceDescription!
                              .toString(),
                          expandText: 'Read More',
                          collapseText: 'Show Less',
                          maxLines: 3,
                          linkColor: AppColors.blue,
                          linkStyle: TextStyle(fontWeight: FontWeight.w600),
                          style: TextStyle(
                              fontSize: 11,
                              color: themeContro.isLightMode.value
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).paddingSymmetric(horizontal: 10),
            sizeBoxHeight(10),
            Container(
              // height: 70,
              width: Get.width,
              decoration: BoxDecoration(
                  color: themeContro.isLightMode.value
                      ? Colors.white
                      : AppColors.darkGray,
                  boxShadow: [
                    BoxShadow(
                      color: themeContro.isLightMode.value
                          ? AppColors.color909092
                          : AppColors.darkShadowColor,
                      blurRadius: 14.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 4.0), // shadow direction: bottom right
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label(
                      'Address',
                      fontSize: 14,
                      textColor: themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    sizeBoxHeight(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/location3.png',
                            height: 14,
                            color: themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.blue),
                        sizeBoxWidth(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(280),
                              child: label(
                                serviceController
                                    .servicemodel.value!.serviceDetail!.address!
                                    .toString(),
                                maxLines: 2,
                                fontSize: 11,
                                textColor: themeContro.isLightMode.value
                                    ? AppColors.black
                                    : AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            sizeBoxHeight(10),
                            RichText(
                                text: TextSpan(children: [
                              WidgetSpan(
                                  child: containerDesign(
                                      onTap: () {
                                        openGoogleMaps(
                                            originLat: SharedPrefs.getString(
                                                SharedPreferencesKey.LATTITUDE),
                                            originLong: SharedPrefs.getString(
                                                SharedPreferencesKey.LONGITUDE),
                                            destLat: serviceController
                                                .servicemodel
                                                .value!
                                                .serviceDetail!
                                                .lat!,
                                            destLong: serviceController
                                                .servicemodel
                                                .value!
                                                .serviceDetail!
                                                .lon!);
                                      },
                                      title: "Get Direction")),
                              WidgetSpan(child: SizedBox(width: 10)),
                              WidgetSpan(
                                  child: containerDesign(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: serviceController
                                                .servicemodel
                                                .value!
                                                .serviceDetail!
                                                .address!));
                                        snackBar("Location Copied");
                                      },
                                      title: "   Copy   "))
                            ]))
                          ],
                        ),
                      ],
                    ),
                    sizeBoxHeight(12),
                    label('Business Hours',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.brown1
                            : AppColors.blue),
                    sizeBoxHeight(7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        label(
                            '${serviceController.servicemodel.value!.serviceDetail!.openTime.toString()} to ${serviceController.servicemodel.value!.serviceDetail!.closeTime.toString()}',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            textColor: themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white),
                        GestureDetector(
                          onTap: () {
                            _buisnessHour();
                          },
                          child: Row(
                            children: [
                              label('Open Now',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  textColor: Color(0xff0C9400)),
                              sizeBoxWidth(5),
                              Image.asset(
                                'assets/images/arrow-left (1).png',
                                height: 13,
                                width: 13,
                                color: themeContro.isLightMode.value
                                    ? AppColors.blue
                                    : AppColors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizeBoxHeight(10),
                    InkWell(
                      onTap: () {
                        final url = serviceController
                            .servicemodel.value!.serviceDetail!.serviceWebsite!;
                        _launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          label('Visit Website',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              textColor: themeContro.isLightMode.value
                                  ? AppColors.brown1
                                  : AppColors.white),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.4,
                                child: GestureDetector(
                                  child: Text(
                                    serviceController.servicemodel.value!
                                        .serviceDetail!.serviceWebsite!
                                        .toString(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 2,
                                      decorationColor: Colors.transparent,
                                      fontFamily: "Poppins",
                                      color: themeContro.isLightMode.value
                                          ? Colors.blue
                                          : AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              sizeBoxWidth(5),
                              Image.asset(
                                'assets/images/export.png',
                                height: 12,
                                color: AppColors.blue,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    sizeBoxHeight(10),
                    GestureDetector(
                      onTap: () async {
                        String email = Uri.encodeComponent(serviceController
                            .servicemodel.value!.serviceDetail!.vendorEmail!
                            .toString());
                        Uri mail = Uri.parse("mailto:$email");
                        if (await launchUrl(mail)) {
                          //email app opened
                          snackBar("email app opened");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          label('Email on',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              textColor: themeContro.isLightMode.value
                                  ? AppColors.brown1
                                  : AppColors.white),
                          sizeBoxWidth(5),
                          label(
                              serviceController.servicemodel.value!
                                  .serviceDetail!.vendorEmail!
                                  .toString(),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.blue),
                        ],
                      ),
                    ),
                    sizeBoxHeight(10),
                    label('Follow us on',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.brown1
                            : AppColors.white),
                    sizeBoxHeight(10),
                    serviceController.servicemodel.value!.serviceDetail!
                                    .whatsappLink ==
                                "" &&
                            serviceController.servicemodel.value!.serviceDetail!
                                    .facebookLink ==
                                "" &&
                            serviceController.servicemodel.value!.serviceDetail!
                                    .instagramLink ==
                                "" &&
                            serviceController.servicemodel.value!.serviceDetail!
                                    .twitterLink ==
                                ""
                        ? SizedBox.shrink()
                        : Row(
                            children: [
                              serviceController.servicemodel.value!
                                          .serviceDetail!.whatsappLink !=
                                      ""
                                  ? socialLinkContainerDesign(
                                      onTap: () async {
                                        if (SharedPreferencesKey
                                            .LOGGED_IN_VENDORID.isEmpty) {
                                          snackBar(
                                              "Contact on Whatsapp kidly login in");
                                        } else {
                                          _launchWhatsapp(serviceController
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .whatsappLink);
                                        }
                                      },
                                      img: 'assets/images/whatsapp.png',
                                      imgHeigh: 18,
                                      title: 'Whatsapp')
                                  : SizedBox.shrink(),
                              serviceController.servicemodel.value!
                                          .serviceDetail!.whatsappLink !=
                                      ""
                                  ? sizeBoxWidth(9)
                                  : SizedBox.shrink(),
                              serviceController.servicemodel.value!
                                          .serviceDetail!.facebookLink !=
                                      ""
                                  ? socialLinkContainerDesign(
                                      onTap: () {
                                        if (SharedPreferencesKey
                                            .LOGGED_IN_VENDORID.isEmpty) {
                                          snackBar(
                                              "Contact on Facebook kidly login in");
                                        } else {
                                          _launchSocial(serviceController
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .facebookLink!);
                                        }
                                      },
                                      img: 'assets/images/Facebook.png',
                                      imgHeigh: 18,
                                      title: 'Facebook')
                                  : SizedBox.shrink(),
                              serviceController.servicemodel.value!
                                          .serviceDetail!.facebookLink !=
                                      ""
                                  ? sizeBoxWidth(9)
                                  : SizedBox.shrink(),
                              serviceController.servicemodel.value!
                                          .serviceDetail!.instagramLink !=
                                      ""
                                  ? socialLinkContainerDesign(
                                      onTap: () {
                                        if (SharedPreferencesKey
                                            .LOGGED_IN_VENDORID.isEmpty) {
                                          snackBar(
                                              "Contact on instagram kidly login in");
                                        } else {
                                          launchUrl(
                                            Uri.parse(serviceController
                                                .servicemodel
                                                .value!
                                                .serviceDetail!
                                                .instagramLink!),
                                            // Uri.parse('https://www.instagram.com/forwheel_app/'),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      },
                                      img: 'assets/images/instagram.png',
                                      imgHeigh: 15,
                                      title: 'Instagram')
                                  : SizedBox.shrink(),
                              serviceController.servicemodel.value!
                                          .serviceDetail!.instagramLink !=
                                      ""
                                  ? sizeBoxWidth(9)
                                  : SizedBox.shrink(),
                              serviceController.servicemodel.value!
                                          .serviceDetail!.twitterLink !=
                                      ""
                                  ? socialLinkContainerDesign(
                                      onTap: () {
                                        if (SharedPreferencesKey
                                            .LOGGED_IN_VENDORID.isEmpty) {
                                          snackBar(
                                              "Contact on Twitter kidly login in");
                                        } else {
                                          launchUrl(
                                            Uri.parse(serviceController
                                                .servicemodel
                                                .value!
                                                .serviceDetail!
                                                .twitterLink!),
                                            // Uri.parse("http://twitter.com/example"),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      },
                                      img: 'assets/images/twitter.png',
                                      imgHeigh: 15,
                                      title: 'Twitter')
                                  : SizedBox.shrink()
                            ],
                          ),
                    serviceController.servicemodel.value!.serviceDetail!
                                    .whatsappLink ==
                                "" &&
                            serviceController.servicemodel.value!.serviceDetail!
                                    .facebookLink ==
                                "" &&
                            serviceController.servicemodel.value!.serviceDetail!
                                    .instagramLink ==
                                "" &&
                            serviceController.servicemodel.value!.serviceDetail!
                                    .twitterLink ==
                                ""
                        ? SizedBox.shrink()
                        : sizeBoxHeight(5),
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: 20),
            serviceController.servicemodel.value!.stores!.isNotEmpty
                ? sizeBoxHeight(12)
                : SizedBox.shrink(),
            serviceController.servicemodel.value!.stores!.isNotEmpty
                ? Align(
                    alignment: Alignment.topLeft,
                    child: label('Services',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white),
                  ).paddingSymmetric(horizontal: 20)
                : SizedBox.shrink(),
            serviceController.servicemodel.value!.stores!.isNotEmpty
                ? sizeBoxHeight(12)
                : SizedBox.shrink(),
            serviceController.servicemodel.value!.stores!.isNotEmpty
                ? Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: themeContro.isLightMode.value
                            ? Colors.white
                            : AppColors.darkGray,
                        boxShadow: [
                          BoxShadow(
                              color: themeContro.isLightMode.value
                                  ? AppColors.color909092
                                  : AppColors.darkShadowColor,
                              blurRadius: 14.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 4.0))
                        ],
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          serviceController
                                  .servicemodel.value!.stores!.isNotEmpty
                              ? ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: Color(0xffCCCCCC),
                                      thickness: 1,
                                    ).paddingSymmetric(horizontal: 20);
                                  },
                                  itemCount: serviceController
                                      .servicemodel.value!.stores!.length
                                      .clamp(0, 2),
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return overviewservicedata(
                                      serviceController
                                          .servicemodel.value!.stores![index],
                                      index,
                                    );
                                  },
                                )
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: SizedBox(
                                      height: 80,
                                      child: label(
                                        "No Services Found",
                                        fontSize: 16,
                                        textColor: AppColors.brown,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                          sizeBoxHeight(10),
                          serviceController.servicemodel.value!.stores!.length >
                                  2
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _tabController.index = 1;
                                    },
                                    child: Container(
                                      height: 22,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: label('See All Services',
                                            fontSize: 7,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.white),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 20)
                : SizedBox.shrink(),
            sizeBoxHeight(12),
            Align(
              alignment: Alignment.topLeft,
              child: label('Photos',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textColor: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white),
            ).paddingSymmetric(horizontal: 20),
            sizeBoxHeight(12),
            Container(
              height: 70,
              width: Get.width,
              decoration: BoxDecoration(
                  color: themeContro.isLightMode.value
                      ? Colors.white
                      : AppColors.darkGray,
                  boxShadow: [
                    BoxShadow(
                      color: themeContro.isLightMode.value
                          ? AppColors.color909092
                          : AppColors.darkShadowColor,
                      blurRadius: 14.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 4.0), // shadow direction: bottom right
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // Use the length of the entire serviceImages! list, not just the first element
                          itemCount: serviceController.servicemodel.value!
                              .serviceDetail!.serviceImages!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index < 4) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    builder: (BuildContext context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5.0, sigmaY: 5.0),
                                        child: AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                          content: Container(
                                              height: 200,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: _posterDialog2(context)),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(serviceController
                                            .servicemodel
                                            .value!
                                            .serviceDetail!
                                            .serviceImages![index]
                                            .toString()),
                                        fit: BoxFit.fill),
                                  ),
                                ).paddingSymmetric(horizontal: 5),
                              );
                            } else if (index == 4) {
                              return GestureDetector(
                                onTap: () {
                                  _tabController.index = 2;
                                },
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(serviceController
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .serviceImages![index]
                                              .toString()),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: label(
                                            "\n+${serviceController.servicemodel.value!.serviceDetail!.serviceImages!.length - 5}",
                                            textAlign: TextAlign.center,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.white)),
                                  ).paddingSymmetric(horizontal: 5),
                                ),
                              );
                            }
                            return null;
                          }),
                    )
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: 20),
            sizeBoxHeight(12),
            serviceController
                    .servicemodel.value!.serviceDetail!.reviews!.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      label(
                        'Customer Review',
                        fontSize: 14,
                        textColor: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      serviceController.servicemodel.value!.serviceDetail!
                              .reviews!.isNotEmpty
                          ? serviceController.servicemodel.value!.serviceDetail!
                                      .reviews!.length >
                                  2
                              ? GestureDetector(
                                  onTap: () {
                                    // Get.to(StoreReview())
                                    _tabController.index = 3;
                                  },
                                  child: label(
                                    'See all',
                                    fontSize: 11,
                                    textColor: AppColors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : SizedBox.shrink()
                          : SizedBox.shrink(),
                    ],
                  ).paddingOnly(left: 22, right: 22, bottom: 12)
                : SizedBox.shrink(),
            serviceController
                    .servicemodel.value!.serviceDetail!.reviews!.isNotEmpty
                ? Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: themeContro.isLightMode.value
                            ? Colors.white
                            : AppColors.darkGray,
                        boxShadow: [
                          BoxShadow(
                            color: themeContro.isLightMode.value
                                ? AppColors.color909092
                                : AppColors.darkShadowColor,
                            blurRadius: 14.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 4.0), // shadow direction: bottom right
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizeBoxHeight(15),
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.blue),
                              child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: label(
                                    serviceController.servicemodel.value!
                                        .serviceDetail!.totalAvgReview
                                        .toString(),
                                    fontSize: 14,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            sizeBoxWidth(10),
                            label(
                              '${serviceController.servicemodel.value!.serviceDetail!.totalReviewCount.toString()} rattings',
                              fontSize: 11,
                              textColor: themeContro.isLightMode.value
                                  ? Colors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ).paddingSymmetric(horizontal: 15),
                        sizeBoxHeight(30),
                        serviceController.servicemodel.value!.serviceDetail!
                                .reviews!.isNotEmpty
                            ? ListView.builder(
                                itemCount: serviceController.servicemodel.value!
                                    .serviceDetail!.reviews!.length
                                    .clamp(0, 3),
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return review(
                                          fname:
                                              '${serviceController.servicemodel.value!.serviceDetail!.reviews![index].firstName.toString() + " " + serviceController.servicemodel.value!.serviceDetail!.reviews![index].lastName.toString()}',
                                          descname: serviceController
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .reviews![index]
                                              .reviewMessage
                                              .toString(),
                                          // content: 'super',
                                          imagepath: serviceController
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .reviews![index]
                                              .image
                                              .toString(),
                                          ratingCount: serviceController
                                                      .servicemodel
                                                      .value!
                                                      .serviceDetail!
                                                      .reviews![index]
                                                      .reviewStar
                                                      .toString() !=
                                                  ''
                                              ? double.parse(serviceController
                                                  .servicemodel
                                                  .value!
                                                  .serviceDetail!
                                                  .reviews![index]
                                                  .reviewStar
                                                  .toString())
                                              : 0.0)
                                      .paddingSymmetric(horizontal: 15, vertical: 15);
                                })
                            : SizedBox.shrink()
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 20)
                : SizedBox.shrink(),
            sizeBoxHeight(15),
          ],
        ),
      ),
    );
  }

  Widget overviewservicedata(Stores store, index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
                imageUrl: store.storeImages![0], fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 7),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  label(
                    store.storeName.toString(),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.blue,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: AppColors.blue,
                  )
                ],
              ),
              sizeBoxHeight(5),
              label(
                store.storeDescription.toString(),
                fontSize: 9,
                maxLines: 5,
                fontWeight: FontWeight.w500,
                textColor: themeContro.isLightMode.value
                    ? AppColors.black
                    : Colors.grey.shade400,
              ),
              sizeBoxHeight(10),
            ],
          ).paddingSymmetric(horizontal: 8),
        ),
      ],
    );
  }

  Widget customerreview() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: label(
                'Reviews',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                textColor: themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
              ),
            ),
            const Divider(color: Color(0xffCCCCCC), thickness: 1),
            sizeBoxHeight(15),
            Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.blue),
                  child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: label(
                        serviceController
                            .servicemodel.value!.serviceDetail!.totalAvgReview
                            .toString(),
                        fontSize: 14,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                sizeBoxWidth(10),
                label(
                  '${serviceController.servicemodel.value!.serviceDetail!.totalReviewCount.toString()} rattings',
                  fontSize: 11,
                  textColor: themeContro.isLightMode.value
                      ? Colors.black
                      : AppColors.white,
                  fontWeight: FontWeight.w500,
                )
              ],
            ).paddingSymmetric(horizontal: 22),
            sizeBoxHeight(30),
            serviceController
                    .servicemodel.value!.serviceDetail!.reviews!.isNotEmpty
                ? ListView.builder(
                    itemCount: serviceController
                        .servicemodel.value!.serviceDetail!.reviews!.length
                        .clamp(0, 3),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return review(
                              fname:
                                  '${serviceController.servicemodel.value!.serviceDetail!.reviews![index].firstName.toString() + " " + serviceController.servicemodel.value!.serviceDetail!.reviews![index].lastName.toString()}',
                              descname: serviceController.servicemodel.value!
                                  .serviceDetail!.reviews![index].reviewMessage
                                  .toString(),
                              // content: 'super',
                              imagepath: serviceController.servicemodel.value!
                                  .serviceDetail!.reviews![index].image
                                  .toString(),
                              ratingCount: serviceController
                                          .servicemodel
                                          .value!
                                          .serviceDetail!
                                          .reviews![index]
                                          .reviewStar
                                          .toString() !=
                                      ''
                                  ? double.parse(serviceController
                                      .servicemodel
                                      .value!
                                      .serviceDetail!
                                      .reviews![index]
                                      .reviewStar
                                      .toString())
                                  : 0.0)
                          .paddingSymmetric(horizontal: 13, vertical: 15);
                    }).paddingSymmetric(horizontal: 10)
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: SizedBox(
                        height: 100,
                        child: label("No Reviews Found",
                            fontSize: 16,
                            textColor: AppColors.brown,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget photos() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: label(
                'Photos',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                textColor: themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
              ),
            ),
            Divider(
                color: themeContro.isLightMode.value
                    ? Color(0xffCCCCCC)
                    : AppColors.darkGray,
                thickness: 1),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                // Set an appropriate height for the GridView
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: serviceController
                      .servicemodel.value!.serviceDetail!.serviceImages!.length,
                  shrinkWrap: true, // Number of items in the grid
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.5),
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: AlertDialog(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                insetPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                content: Container(
                                    height: 200,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: _posterDialog2(context)),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              serviceController.servicemodel.value!
                                  .serviceDetail!.serviceImages![index]
                                  .toString(),
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget services() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: label(
                'Services',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                textColor: themeContro.isLightMode.value
                    ? AppColors.black
                    : AppColors.white,
              ),
            ),
            Divider(
                color: themeContro.isLightMode.value
                    ? Color(0xffCCCCCC)
                    : AppColors.darkGray,
                thickness: 1),
            SizedBox(height: 4),
            label(
              serviceController.servicemodel.value!.serviceDetail!.serviceName
                  .toString(),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textColor: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
            ).paddingSymmetric(horizontal: 20),
            sizeBoxHeight(10),
            serviceController.servicemodel.value!.stores!.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(color: Color(0xffCCCCCC), thickness: 1)
                          .paddingSymmetric(horizontal: 20);
                    },
                    itemCount:
                        serviceController.servicemodel.value!.stores!.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                label(
                                  serviceController.servicemodel.value!
                                      .stores![index].storeName
                                      .toString(),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  textColor: themeContro.isLightMode.value
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Get.to(
                                    //     SubDetails(
                                    //       index: index,
                                    //     ),
                                    //     transition: Transition.rightToLeft);
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13,
                                    color: AppColors.blue,
                                  ),
                                )
                              ],
                            ).paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(5),
                            label(
                              serviceController.servicemodel.value!
                                  .stores![index].storeDescription
                                  .toString(),
                              fontSize: 9,
                              maxLines: 5,
                              fontWeight: FontWeight.w500,
                              textColor: themeContro.isLightMode.value
                                  ? AppColors.black
                                  : Colors.grey.shade500,
                            ).paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(10),
                            // Row(children: [
                            //   GestureDetector(
                            //     // onTap: onTapcall,
                            //     onTap: () async {
                            //       if (SharedPreferencesKey
                            //           .LOGGED_IN_VENDORID.isEmpty) {
                            //         snackBar(
                            //             "Login must need for see mobile number ");
                            //       } else {
                            //         String phoneNum = Uri.encodeComponent(
                            //             serviceController.servicemodel.value!
                            //                 .stores![index].mobile
                            //                 .toString());
                            //         Uri tel = Uri.parse("tel:$phoneNum");
                            //         if (await launchUrl(tel)) {
                            //           //phone dail app is opened
                            //         } else {
                            //           // Fluttertoast.showToast(
                            //           //     msg: "phone dail not opened");
                            //         }
                            //       }
                            //     },
                            //     child: Container(
                            //       height: 25,
                            //       width: 55,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(6),
                            //           border: Border.all(
                            //             color: AppColors.blue,
                            //           )),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         children: [
                            //           Image.asset(
                            //             'assets/images/call.png',
                            //             height: 12,
                            //             color: AppColors.blue,
                            //           ),
                            //           sizeBoxWidth(5),
                            //           label(
                            //             'Call',
                            //             fontSize: 10,
                            //             textColor: AppColors.blue,
                            //             fontWeight: FontWeight.w400,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            //   sizeBoxWidth(10),
                            //   GestureDetector(
                            //     // onTap: onTapwhatsup,
                            //     onTap: () async {
                            //       var contact = serviceController
                            //           .servicemodel.value!.stores![index].mobile
                            //           .toString();

                            //       var androidUrl =
                            //           "whatsapp://send?phone=$contact&text=Hi, I need some help";
                            //       var iosUrl =
                            //           "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

                            //       try {
                            //         if (Platform.isIOS) {
                            //           await launchUrl(Uri.parse(iosUrl));
                            //         } else {
                            //           await launchUrl(Uri.parse(androidUrl));
                            //         }
                            //       } on Exception {}
                            //     },
                            //     child: Container(
                            //       height: 25,
                            //       width: 90,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(6),
                            //           border: Border.all(
                            //             color: const Color(0x0000001e)
                            //                 .withOpacity(0.19),
                            //           )),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         children: [
                            //           Image.asset(
                            //             'assets/images/whatsapp.png',
                            //             height: 12,
                            //           ),
                            //           sizeBoxWidth(5),
                            //           label(
                            //             'What’s app',
                            //             fontSize: 10,
                            //             textColor: AppColors.black,
                            //             fontWeight: FontWeight.w400,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ]).paddingSymmetric(horizontal: 20),
                            sizeBoxHeight(10),
                          ],
                        ),
                      );
                    })
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: SizedBox(
                        height: 100,
                        child: label("No Services Found",
                            fontSize: 16,
                            textColor: AppColors.brown,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget bottam() {
    return Row(children: [
      Expanded(
        child: GestureDetector(
          // onTap: onTapcall,
          onTap: () async {
            if (SharedPreferencesKey.LOGGED_IN_VENDORID.isEmpty) {
              snackBar("Login must need for see mobile number ");
            } else {
              String phoneNum = Uri.encodeComponent(serviceController
                  .servicemodel.value!.serviceDetail!.servicePhone!
                  .toString());
              Uri tel = Uri.parse("tel:$phoneNum");
              if (await launchUrl(tel)) {
                //phone dail app is opened
              } else {
                //phone dail app is not opened
                snackBar('Phone dail not opened');
                //  Fluttertoast.showToast(msg: "phone dail not opened");
              }
            }
          },
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.blue,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/call.png',
                  height: 12,
                  color: AppColors.blue,
                ),
                sizeBoxWidth(5),
                label(
                  'Call',
                  fontSize: 10,
                  textColor: AppColors.blue,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
      sizeBoxWidth(10),
      Expanded(
        child: GestureDetector(
          onTap: () {
            whatsapp();
          },
          // onTap: onTapcall,
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.blue,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/message-2.png',
                  height: 12,
                  color: AppColors.blue,
                ),
                sizeBoxWidth(5),
                label(
                  'Chat',
                  fontSize: 10,
                  textColor: AppColors.blue,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
      sizeBoxWidth(10),
      Expanded(
        child: GestureDetector(
          // onTap: onTapwhatsup,
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0x0000001e).withOpacity(0.19),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/whatsapp.png',
                  height: 12,
                ),
                sizeBoxWidth(5),
                label(
                  'What’s app',
                  fontSize: 10,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  _buisnessHour() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              insetPadding: EdgeInsets.only(top: 5),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: StatefulBuilder(builder: (context, kk) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      height: getProportionateScreenHeight(350),
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              label(
                                'Business Hours',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.black,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.close, size: 15))
                            ],
                          )
                              .paddingSymmetric(
                                horizontal: 20,
                              )
                              .paddingOnly(top: 10),
                          sizeBoxHeight(6),
                          Divider(color: Color(0xffCCCCCC), thickness: 1),
                          sizeBoxHeight(5),
                          ListView.builder(
                              itemCount: 7,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/addtime.png',
                                            height: 12,
                                            width: 12,
                                            color: AppColors.blue,
                                          ),
                                          sizeBoxWidth(6),
                                          label(
                                            days[index],
                                            fontSize: 13,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      serviceController.servicemodel.value!
                                              .serviceDetail!.closedDays!
                                              .contains(days[index]
                                                  .toString()
                                                  .substring(0, 3))
                                          ? label(
                                              'Closed',
                                              fontSize: 9,
                                              textColor: Colors.red,
                                              fontWeight: FontWeight.w400,
                                            )
                                          : label(
                                              '${serviceController.servicemodel.value!.serviceDetail!.openTime.toString()} - ${serviceController.servicemodel.value!.serviceDetail!.closeTime.toString()}',
                                              fontSize: 9,
                                              textColor: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                    ],
                                  ).paddingSymmetric(horizontal: 15),
                                );
                              })
                        ],
                      ),
                    )
                  ],
                ));
              }),
            ),
          );
        });
  }

  _confirmReview() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              insetPadding: EdgeInsets.only(),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: StatefulBuilder(builder: (context, kk) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: getProportionateScreenHeight(380),
                            width: Get.width,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sizeBoxHeight(30),
                                label(
                                  'Feel Free to share your review and ratings',
                                  fontSize: 14,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ).paddingSymmetric(horizontal: 25),
                                sizeBoxHeight(12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBar.builder(
                                      initialRating:
                                          0, // Start with 3 stars selected
                                      minRating:
                                          1, // The minimum rating the user can give is 1 star
                                      direction: Axis
                                          .horizontal, // Stars are laid out horizontally
                                      allowHalfRating:
                                          false, // Full stars only, no half-star ratings
                                      unratedColor: Colors.grey
                                          .shade400, // Color for unselected stars
                                      itemCount:
                                          5, // Total number of stars is 5
                                      itemSize: 25,
                                      itemPadding: EdgeInsets.symmetric(
                                          horizontal: 4), // Space between stars
                                      itemBuilder: (context, _) => Image.asset(
                                        'assets/images/star1.png',
                                        color: Color(0xffFFA41C),
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          rateValue =
                                              rating; // Update the rating value
                                        });
                                        print(
                                            'Select Review :- ${rateValue.toString().replaceAll(".0", "")}');
                                      },
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 25),
                                sizeBoxHeight(22),
                                TextFormField(
                                  cursorColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : AppColors.black,
                                  autofocus: false,
                                  controller: msgController,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w400),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  readOnly: false,
                                  keyboardType: TextInputType.text,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: const BorderSide(
                                            color: AppColors.blue)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    hintText: "Write Your Review....",
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    errorStyle: const TextStyle(
                                        color: Colors.redAccent, fontSize: 10),
                                  ),
                                ).paddingSymmetric(horizontal: 25),
                                sizeBoxHeight(20),
                              ],
                            ),
                          ),
                          Positioned(
                              top: -40,
                              child: Container(
                                height: 58,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.12),
                                        blurRadius: 10.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(0.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(22),
                                        topLeft: Radius.circular(22),
                                        bottomRight: Radius.circular(22),
                                        topRight: Radius.circular(22))),
                                child: Center(
                                  child: label(
                                    'Review & Rating',
                                    fontSize: 18,
                                    textAlign: TextAlign.center,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }

  Widget imagelist() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 220,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 0,
                    color: Colors.grey.shade300,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: _poster2(context),
            ),
            Positioned.fill(
              top: 20,
              bottom: -1,
              child: FeaturedScreen(
                sname: serviceController
                    .servicemodel.value!.serviceDetail!.serviceName
                    .toString(),
                businessMonth: serviceController
                    .servicemodel.value!.serviceDetail!.publishedMonth
                    .toString(),
                businessYear: serviceController
                    .servicemodel.value!.serviceDetail!.publishedYear
                    .toString(),
                ratingCount: double.parse(serviceController
                    .servicemodel.value!.serviceDetail!.totalAvgReview!),
                avrageReview: serviceController
                    .servicemodel.value!.serviceDetail!.totalReviewCount
                    .toString(),
                onTapEdit: () {},
              ),
            ),
            Positioned(
              top: 14,
              child: Container(
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.blue,
                ),
                child: Center(
                  child: label(
                    serviceController
                        .servicemodel.value!.serviceDetail!.categoryName!,
                    fontSize: 8,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ).paddingSymmetric(horizontal: 8),
                ),
              ),
            ),
          ],
        ));
  }

  whatsapp() async {
    var contact = serviceController
        .servicemodel.value!.serviceDetail!.servicePhone!
        .toString();

    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {}
  }

  _vidio() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AlertDialog(
              alignment: Alignment.center,
              insetPadding:
                  const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: StatefulBuilder(builder: (context, kk) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: getProportionateScreenHeight(35),
                        width: getProportionateScreenWidth(35),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                              child: Icon(
                            Icons.close,
                            size: 15,
                          )),
                        ),
                      ),
                    ),
                    sizeBoxHeight(10),
                    Container(
                      height: getProportionateScreenHeight(290),
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        });
  }

  double rateValue = 0;

  containerDesign({required Function() onTap, required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: themeContro.isLightMode.value
                    ? AppColors.blue
                    : AppColors.white)),
        child: Center(
                child: Text(title,
                    style: poppinsFont(
                        8,
                        themeContro.isLightMode.value
                            ? AppColors.blue
                            : AppColors.white,
                        FontWeight.w500)))
            .paddingSymmetric(horizontal: 5),
      ),
    );
  }

  socialLinkContainerDesign({
    required Function() onTap,
    required String img,
    double? imgHeigh,
    required String title,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: themeContro.isLightMode.value
                    ? AppColors.blue
                    : AppColors.white)),
        child: Center(
            child: Row(
          children: [
            Image.asset(img, height: imgHeigh),
            SizedBox(width: 5),
            Text(title,
                style: poppinsFont(
                    8,
                    themeContro.isLightMode.value
                        ? AppColors.blue
                        : AppColors.white,
                    FontWeight.w500)),
          ],
        )).paddingSymmetric(horizontal: 5),
      ),
    );
  }

  containerDesign1({
    required Function() onTap,
    required String title,
    required bool isBorder,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: isBorder ? AppColors.blue : AppColors.colorA4A4A4)),
        child: Center(
                child: Text(title,
                    style: poppinsFont(8, AppColors.blue, FontWeight.w500)))
            .paddingSymmetric(horizontal: 5),
      ),
    );
  }
}
