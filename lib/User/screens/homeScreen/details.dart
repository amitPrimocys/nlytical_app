// ignore_for_file: prefer_const_constructors, unused_element, must_be_immutable, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, deprecated_member_use, unused_field, curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:intl/intl.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/add_review_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/home_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/service_contro.dart';
import 'package:nlytical_app/models/user_models/service_detail_model.dart';
import 'package:nlytical_app/User/screens/homeScreen/chat_screen.dart';
import 'package:nlytical_app/User/screens/homeScreen/sub_details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/details_loader.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/details_comman_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/google_map.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  String? serviceid;
  String? latt;
  String? longg;
  Details({super.key, this.serviceid, required this.latt, required this.longg});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  ServiceContro servicecontro = Get.put(ServiceContro());
  AddreviewContro addreviewcontro = Get.put(AddreviewContro());
  LikeContro likecontro = Get.put(LikeContro());
  TextEditingController searchcontroller = TextEditingController();
  HomeContro homecontro = Get.put(HomeContro());

  // @override
  // void initState() {

  //   super.initState();
  // }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print("😀😀😀😀USER_ID:$userID");
    servicecontro.servicedetailApi(
      serviceID: widget.serviceid!,
    );
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update the widget whenever the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchResult.clear();
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
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.white
          : AppColors.darkMainBlack,
      bottomNavigationBar: BottomAppBar(
        height: 73,
        elevation: 0,
        color: themeContro.isLightMode.value
            ? Colors.white
            : AppColors.darkMainBlack,
        child: bottam(),
      ),
      body: Obx(() {
        return servicecontro.isservice.value
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
                                SizedBox(height: Get.height * 0.12)
                                // sizeBoxHeight(120),
                                // profileDetailsField(),
                                // profileHeaderWidget(context),
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
                                  : AppColors
                                      .darkMainBlack, // Background color for the tab bar
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
                                color: Colors.white,
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
                                bool isSelected = _tabController.index == index;
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
                              // physics: _tabController.index == 2 &&
                              //         (servicecontro
                              //             .servicemodel
                              //             .value!
                              //             .serviceDetail!
                              //             .serviceImages!
                              //             .isEmpty)
                              //     ? AlwaysScrollableScrollPhysics()
                              //     : NeverScrollableScrollPhysics(),
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
    );
  }

  int _currentIndex = 0;
  Widget _buildIndicators() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: servicecontro.servicemodel.value!.serviceDetail!.serviceImages!
          .asMap()
          .entries
          .map((entry) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = entry.key;
            });
          },
          child: Container(
            height: 9,
            width: 9,
            margin: const EdgeInsets.symmetric(
                vertical: 3.0), // Adjusted for vertical spacing
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: entry.key == _currentIndex
                    ? AppColors.white
                    : AppColors.white,
                border: Border.all(color: AppColors.blue)),
            child: Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(
                  vertical: 2.5), // Adjusted for vertical spacing
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: entry.key == _currentIndex
                      ? AppColors.blue
                      : Colors.transparent,
                  border: Border.all(color: AppColors.blue)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _poster2(BuildContext context) {
    Widget carousel =
        servicecontro.servicemodel.value!.serviceDetail!.serviceImages!.isEmpty
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
                      isLoop: servicecontro.servicemodel.value!.serviceDetail!
                              .serviceImages!.length >
                          1,
                      height: 250,
                      indicatorColor: AppColors.blue,
                      indicatorBackgroundColor: Colors.white,
                      indicatorRadius: 3,
                      onPageChanged: (value) {
                        setState(() {
                          _currentIndex = value;
                        });
                      },
                      children: servicecontro
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

  Widget posterDialog2(BuildContext context) {
    Widget carousel =
        servicecontro.servicemodel.value!.serviceDetail!.serviceImages!.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              )
            : Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  // Update the borderRadius here to 40
                  ImageSlideshow(
                    autoPlayInterval: null,
                    isLoop: true,
                    // height: 230,
                    // width: 300,
                    indicatorColor: AppColors.blue,
                    indicatorBackgroundColor: AppColors.white,
                    indicatorRadius: 3,
                    children: servicecontro
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
                  ),
                ],
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
                          fontSize: 13,
                          textColor: themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 5),
                        ExpandableText(
                          servicecontro.servicemodel.value!.serviceDetail!
                              .serviceDescription!
                              .toString(),
                          expandText: 'Read More',
                          collapseText: 'Show Less',
                          maxLines: 3,
                          linkColor: AppColors.blue,
                          linkStyle: TextStyle(fontWeight: FontWeight.w600),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: themeContro.isLightMode.value
                                  ? AppColors.black
                                  : AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).paddingSymmetric(horizontal: 10),
            sizeBoxHeight(5),
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
                    label('Address',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white),
                    sizeBoxHeight(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/location1.png',
                          height: 20,
                          color: themeContro.isLightMode.value
                              ? Colors.black
                              : AppColors.blue,
                        ),
                        sizeBoxWidth(5),
                        SizedBox(
                          width: Get.width * 0.70,
                          child: Text(
                            servicecontro
                                .servicemodel.value!.serviceDetail!.address!
                                .toString(),
                            style: poppinsFont(
                                11,
                                themeContro.isLightMode.value
                                    ? AppColors.black
                                    : AppColors.white,
                                FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    sizeBoxHeight(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openGoogleMaps(
                                originLat: Latitude,
                                originLong: Longitude,
                                destLat: servicecontro
                                    .servicemodel.value!.serviceDetail!.lat!
                                    .toString(),
                                destLong: servicecontro
                                    .servicemodel.value!.serviceDetail!.lon!
                                    .toString());
                          },
                          child: Container(
                            height: 22,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: themeContro.isLightMode.value
                                    ? AppColors.blue
                                    : AppColors.white,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Get Direction',
                                style: poppinsFont(
                                    8,
                                    themeContro.isLightMode.value
                                        ? AppColors.blue
                                        : AppColors.white,
                                    FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        sizeBoxWidth(8),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                              text: servicecontro
                                  .servicemodel.value!.serviceDetail!.address!
                                  .toString(),
                            ));
                            snackBar('Location Copied');
                          },
                          child: Container(
                            height: 22,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: themeContro.isLightMode.value
                                    ? AppColors.blue
                                    : AppColors.white,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Copy',
                                style: poppinsFont(
                                    8,
                                    themeContro.isLightMode.value
                                        ? AppColors.blue
                                        : AppColors.white,
                                    FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 20),
                    sizeBoxHeight(12),
                    label('Business Hours',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: themeContro.isLightMode.value
                            ? Color(0xff3E5155)
                            : AppColors.blue),
                    sizeBoxHeight(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        label(
                            '${servicecontro.servicemodel.value!.serviceDetail!.openTime.toString()} to ${servicecontro.servicemodel.value!.serviceDetail!.closeTime.toString()}',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            textColor: themeContro.isLightMode.value
                                ? AppColors.black
                                : AppColors.white),
                        GestureDetector(
                          onTap: () {
                            _buisnessHour();
                          },
                          child: Row(
                            children: [
                              label(
                                isBusinessOpen() ? 'Open Now' : 'Closed',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                textColor: isBusinessOpen()
                                    ? Color(0xff4CAF50)
                                    : Colors.red,
                              ),
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
                        final url = servicecontro
                            .servicemodel.value!.serviceDetail!.serviceWebsite!;
                        _launchURL(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          label('Visit Website',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              textColor: themeContro.isLightMode.value
                                  ? Color(0xff3E5155)
                                  : AppColors.white),
                          Row(
                            children: [
                              SizedBox(
                                width: 75,
                                child: GestureDetector(
                                  child: Text(
                                    servicecontro.servicemodel.value!
                                        .serviceDetail!.serviceWebsite!
                                        .toString(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 2,
                                      decorationColor: Colors.transparent,
                                      fontFamily: "Poppins",
                                      color: Colors.transparent,
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
                        String email = Uri.encodeComponent(servicecontro
                            .servicemodel.value!.serviceDetail!.vendorEmail!
                            .toString());
                        Uri mail = Uri.parse("mailto:$email");
                        if (await launchUrl(mail)) {
                          //email app opened
                          snackBar("email app opened");
                        } else {
                          //email app is not opened
                          snackBar("email app is not opened");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          label('Email on',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              textColor: themeContro.isLightMode.value
                                  ? Color(0xff3E5155)
                                  : AppColors.white),
                          sizeBoxWidth(5),
                          label(
                              servicecontro.servicemodel.value!.serviceDetail!
                                  .vendorEmail!
                                  .toString(),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.blue),
                        ],
                      ),
                    ),
                    sizeBoxHeight(10),
                    label('Follow us on',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: themeContro.isLightMode.value
                            ? Color(0xff3E5155)
                            : AppColors.white),
                    sizeBoxHeight(10),
                    servicecontro.servicemodel.value!.serviceDetail!
                                    .whatsappLink ==
                                "" &&
                            servicecontro.servicemodel.value!.serviceDetail!
                                    .facebookLink ==
                                "" &&
                            servicecontro.servicemodel.value!.serviceDetail!
                                    .instagramLink ==
                                "" &&
                            servicecontro.servicemodel.value!.serviceDetail!
                                    .twitterLink ==
                                ""
                        ? SizedBox.shrink()
                        : SizedBox(
                            width: getProportionateScreenWidth(330),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  servicecontro.servicemodel.value!
                                              .serviceDetail!.whatsappLink !=
                                          ""
                                      ? GestureDetector(
                                          onTap: () async {
                                            if (userID.isEmpty) {
                                              snackBar(
                                                  "Contact on Whatsapp kidly login in");
                                            } else {
                                              _launchWhatsapp(servicecontro
                                                  .servicemodel
                                                  .value!
                                                  .serviceDetail!
                                                  .whatsappLink);
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 72,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.blue
                                                        : AppColors.white)),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/whatsapp.png',
                                                  height: 15,
                                                ),
                                                sizeBoxWidth(5),
                                                label('Whatsapp',
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white),
                                              ],
                                            ).paddingSymmetric(horizontal: 4),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  servicecontro.servicemodel.value!
                                              .serviceDetail!.whatsappLink !=
                                          ""
                                      ? sizeBoxWidth(9)
                                      : SizedBox.shrink(),
                                  servicecontro.servicemodel.value!
                                              .serviceDetail!.facebookLink !=
                                          ""
                                      ? GestureDetector(
                                          onTap: () {
                                            if (userID.isEmpty) {
                                              snackBar(
                                                  "Contact on Facebook kidly login in");
                                            } else {
                                              _launchSocial(servicecontro
                                                  .servicemodel
                                                  .value!
                                                  .serviceDetail!
                                                  .facebookLink!);
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 72,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.blue
                                                        : AppColors.white)),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/Facebook.png',
                                                  height: 15,
                                                ),
                                                sizeBoxWidth(5),
                                                label('Facebook',
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white),
                                              ],
                                            ).paddingSymmetric(horizontal: 5),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  servicecontro.servicemodel.value!
                                              .serviceDetail!.facebookLink !=
                                          ""
                                      ? sizeBoxWidth(9)
                                      : SizedBox.shrink(),
                                  servicecontro.servicemodel.value!
                                              .serviceDetail!.instagramLink !=
                                          ""
                                      ? GestureDetector(
                                          onTap: () {
                                            if (userID.isEmpty) {
                                              snackBar(
                                                  "Contact on instagram kidly login in");
                                            } else {
                                              launchUrl(
                                                Uri.parse(servicecontro
                                                    .servicemodel
                                                    .value!
                                                    .serviceDetail!
                                                    .instagramLink!),
                                                // Uri.parse('https://www.instagram.com/forwheel_app/'),
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 72,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.blue
                                                        : AppColors.white)),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/instagram.png',
                                                  height: 15,
                                                ),
                                                sizeBoxWidth(5),
                                                label('Instagram',
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white),
                                              ],
                                            ).paddingSymmetric(horizontal: 4),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  servicecontro.servicemodel.value!
                                              .serviceDetail!.instagramLink !=
                                          ""
                                      ? sizeBoxWidth(9)
                                      : SizedBox.shrink(),
                                  servicecontro.servicemodel.value!
                                              .serviceDetail!.twitterLink !=
                                          ""
                                      ? InkWell(
                                          onTap: () {
                                            if (userID.isEmpty) {
                                              snackBar(
                                                  "Contact on Twitter kidly login in");
                                            } else {
                                              launchUrl(
                                                Uri.parse(servicecontro
                                                    .servicemodel
                                                    .value!
                                                    .serviceDetail!
                                                    .twitterLink!),
                                                // Uri.parse("http://twitter.com/example"),
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 68,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.blue
                                                        : AppColors.white)),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/twitter.png',
                                                  height: 15,
                                                ),
                                                sizeBoxWidth(5),
                                                label('Twitter',
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: themeContro
                                                            .isLightMode.value
                                                        ? AppColors.black
                                                        : AppColors.white),
                                              ],
                                            ).paddingSymmetric(horizontal: 5),
                                          ),
                                        )
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                    servicecontro.servicemodel.value!.serviceDetail!
                                    .whatsappLink ==
                                "" &&
                            servicecontro.servicemodel.value!.serviceDetail!
                                    .facebookLink ==
                                "" &&
                            servicecontro.servicemodel.value!.serviceDetail!
                                    .instagramLink ==
                                "" &&
                            servicecontro.servicemodel.value!.serviceDetail!
                                    .twitterLink ==
                                ""
                        ? SizedBox.shrink()
                        : sizeBoxHeight(5),
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: 20),
            servicecontro.servicemodel.value!.stores!.isNotEmpty
                ? sizeBoxHeight(10)
                : SizedBox.shrink(),
            servicecontro.servicemodel.value!.stores!.isNotEmpty
                ? Align(
                    alignment: Alignment.topLeft,
                    child: label('Services',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        textColor: themeContro.isLightMode.value
                            ? AppColors.black
                            : AppColors.white),
                  ).paddingSymmetric(horizontal: 20)
                : SizedBox.shrink(),
            servicecontro.servicemodel.value!.stores!.isNotEmpty
                ? sizeBoxHeight(10)
                : SizedBox.shrink(),
            servicecontro.servicemodel.value!.stores!.isNotEmpty
                ? Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: themeContro.isLightMode.value
                            ? AppColors.white
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
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          servicecontro.servicemodel.value!.stores!.isNotEmpty
                              ? ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: themeContro.isLightMode.value
                                          ? Color(0xffCCCCCC)
                                          : AppColors.darkBorder,
                                      thickness: 1,
                                    );
                                  },
                                  itemCount: servicecontro
                                      .servicemodel.value!.stores!.length
                                      .clamp(0, 2),
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return overviewservicedata(
                                      servicecontro
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
                          servicecontro.servicemodel.value!.stores!.isNotEmpty
                              ? servicecontro
                                          .servicemodel.value!.stores!.length >
                                      2
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Get.to(AllService(),
                                          //     transition: Transition.downToUp);

                                          //  services();
                                          _tabController.index = 1;
                                        },
                                        child: Container(
                                          height: 22,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: AppColors.blue)),
                                          child: Center(
                                            child: label('See All Services',
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                                textColor: AppColors.blue),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  textColor: themeContro.isLightMode.value
                      ? AppColors.black
                      : AppColors.white),
            ).paddingSymmetric(horizontal: 20),
            sizeBoxHeight(10),
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
                          itemCount: servicecontro.servicemodel.value!
                              .serviceDetail!.serviceImages!.length,
                          padding: EdgeInsets.zero,
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
                                              child: posterDialog2(context)),
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
                                        image: NetworkImage(servicecontro
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
                                          image: NetworkImage(servicecontro
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
                                            "\n+${servicecontro.servicemodel.value!.serviceDetail!.serviceImages!.length - 5}",
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
            servicecontro.servicemodel.value!.serviceDetail!.reviews!.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      label(
                        'Customer Review',
                        fontSize: 13,
                        textColor: themeContro.isLightMode.value
                            ? Colors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      servicecontro.servicemodel.value!.serviceDetail!.reviews!
                              .isNotEmpty
                          ? servicecontro.servicemodel.value!.serviceDetail!
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
                  ).paddingOnly(left: 22, right: 22, bottom: 10)
                : SizedBox.shrink(),
            servicecontro.servicemodel.value!.serviceDetail!.reviews!.isNotEmpty
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
                        label(
                          'Start Your Review',
                          fontSize: 12,
                          textColor: themeContro.isLightMode.value
                              ? Colors.black
                              : AppColors.white,
                          fontWeight: FontWeight.w500,
                        ).paddingOnly(left: 14, right: 14, top: 14, bottom: 5),
                        sizeBoxHeight(5),
                        Row(
                          children: [
                            SizedBox(
                              height: 35,
                              child: ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Call the API to like/unlike the service
                                          if (userID.isEmpty) {
                                            snackBar(
                                                'Please login to review this service');
                                          } else {
                                            _confirmReview();
                                          }
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color:
                                                  themeContro.isLightMode.value
                                                      ? Color(0xffE8E8E8)
                                                      : Color(0xff323232)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/images/star1.png',
                                              height: 25,
                                              width: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ).paddingSymmetric(horizontal: 10),
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
                                    servicecontro.servicemodel.value!
                                        .serviceDetail!.totalAvgReview
                                        .toString(),
                                    fontSize: 14,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            sizeBoxWidth(10),
                            label(
                              '${servicecontro.servicemodel.value!.serviceDetail!.totalReviewCount.toString()} rattings',
                              fontSize: 11,
                              textColor: themeContro.isLightMode.value
                                  ? Colors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ).paddingSymmetric(horizontal: 15),
                        sizeBoxHeight(18),
                        servicecontro.servicemodel.value!.serviceDetail!
                                .reviews!.isNotEmpty
                            ? ListView.builder(
                                itemCount: servicecontro.servicemodel.value!
                                    .serviceDetail!.reviews!.length
                                    .clamp(0, 2),
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return review(
                                          fname:
                                              '${servicecontro.servicemodel.value!.serviceDetail!.reviews![index].firstName.toString() + " " + servicecontro.servicemodel.value!.serviceDetail!.reviews![index].lastName.toString()}',
                                          descname: servicecontro
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .reviews![index]
                                              .reviewMessage
                                              .toString(),
                                          // content: 'super',
                                          imagepath: servicecontro
                                              .servicemodel
                                              .value!
                                              .serviceDetail!
                                              .reviews![index]
                                              .image
                                              .toString(),
                                          ratingCount: servicecontro
                                                      .servicemodel
                                                      .value!
                                                      .serviceDetail!
                                                      .reviews![index]
                                                      .reviewStar
                                                      .toString() !=
                                                  ''
                                              ? double.parse(servicecontro
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

  // Assuming you're using GetX

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
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
            SizedBox(height: 4),
            label(
              'Start Your Review',
              fontSize: 12,
              textColor: themeContro.isLightMode.value
                  ? Colors.black
                  : AppColors.white,
              fontWeight: FontWeight.w500,
            ).paddingOnly(left: 22, right: 14, top: 14, bottom: 5),
            sizeBoxHeight(5),
            Row(
              children: [
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              if (userID.isEmpty) {
                                snackBar('Please login to review this service');
                              } else {
                                _confirmReview();
                              }
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: themeContro.isLightMode.value
                                      ? Color(0xffE8E8E8)
                                      : Color(0xff323232)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/star1.png',
                                  color: Colors.white,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ).paddingSymmetric(horizontal: 17),
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
                        servicecontro
                            .servicemodel.value!.serviceDetail!.totalAvgReview
                            .toString(),
                        fontSize: 14,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                sizeBoxWidth(10),
                label(
                  '${servicecontro.servicemodel.value!.serviceDetail!.totalReviewCount.toString()} rattings',
                  fontSize: 11,
                  textColor: themeContro.isLightMode.value
                      ? Colors.black
                      : AppColors.white,
                  fontWeight: FontWeight.w500,
                )
              ],
            ).paddingSymmetric(horizontal: 22),
            sizeBoxHeight(18),
            servicecontro.servicemodel.value!.serviceDetail!.reviews!.isNotEmpty
                ? ListView.builder(
                    itemCount: servicecontro
                        .servicemodel.value!.serviceDetail!.reviews!.length
                        .clamp(0, 3),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return review(
                              fname:
                                  '${servicecontro.servicemodel.value!.serviceDetail!.reviews![index].firstName.toString() + " " + servicecontro.servicemodel.value!.serviceDetail!.reviews![index].lastName.toString()}',
                              descname: servicecontro.servicemodel.value!
                                  .serviceDetail!.reviews![index].reviewMessage
                                  .toString(),
                              // content: 'super',
                              imagepath: servicecontro.servicemodel.value!
                                  .serviceDetail!.reviews![index].image
                                  .toString(),
                              ratingCount: servicecontro
                                          .servicemodel
                                          .value!
                                          .serviceDetail!
                                          .reviews![index]
                                          .reviewStar
                                          .toString() !=
                                      ''
                                  ? double.parse(servicecontro
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
                      padding: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            sizeBoxHeight(Get.height * 0.2),
                            Image.asset(
                              "assets/images/empty_image.png",
                              height: 55,
                            ),
                            sizeBoxHeight(10),
                            label("No Reviews found",
                                fontSize: 16,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ),
                    ),
                  )
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
                    : AppColors.grey1,
                thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: SizedBox(
                // Set an appropriate height for the GridView
                child: servicecontro.servicemodel.value!.serviceDetail!
                        .serviceImages!.isNotEmpty
                    ? GridView.builder(
                        padding: EdgeInsets.all(0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 items per row
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: servicecontro.servicemodel.value!
                            .serviceDetail!.serviceImages!.length,
                        shrinkWrap: true, // Number of items in the grid
                        itemBuilder: (context, index) {
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
                                      insetPadding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      content: Container(
                                          height: 200,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: posterDialog2(context)),
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
                                    servicecontro.servicemodel.value!
                                        .serviceDetail!.serviceImages![index]
                                        .toString(),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: SizedBox(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                sizeBoxHeight(Get.height * 0.2),
                                Image.asset(
                                  "assets/images/empty_image.png",
                                  height: 55,
                                ),
                                sizeBoxHeight(10),
                                label("No Photos found",
                                    fontSize: 16,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                          ),
                        ),
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
                    : AppColors.grey1,
                thickness: 1),
            SizedBox(height: 4),
            searchBar(),
            sizeBoxHeight(10),
            label(
              servicecontro.servicemodel.value!.serviceDetail!.serviceName
                  .toString(),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textColor: themeContro.isLightMode.value
                  ? AppColors.black
                  : AppColors.white,
            ).paddingSymmetric(horizontal: 20),
            sizeBoxHeight(10),
            servicecontro.servicemodel.value!.stores!.isNotEmpty
                ? (_searchResult.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Color(0xffCCCCCC),
                            thickness: 1,
                          ).paddingSymmetric(horizontal: 20);
                        },
                        itemCount: _searchResult.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return servicedata(_searchResult[index], index);
                        },
                      )
                    : searchController.text.trim().isNotEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 80),
                              child: SizedBox(
                                height: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    sizeBoxHeight(Get.height * 0.2),
                                    Image.asset(
                                      "assets/images/empty_image.png",
                                      height: 55,
                                    ),
                                    sizeBoxHeight(10),
                                    label("No Service found",
                                        fontSize: 16,
                                        textColor: themeContro.isLightMode.value
                                            ? AppColors.black
                                            : AppColors.brown,
                                        fontWeight: FontWeight.w500)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Color(0xffCCCCCC),
                                thickness: 1,
                              ).paddingSymmetric(horizontal: 20);
                            },
                            itemCount: servicecontro
                                .servicemodel.value!.stores!.length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return servicedata(
                                servicecontro
                                    .servicemodel.value!.stores![index],
                                index,
                              );
                            },
                          ))
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            sizeBoxHeight(Get.height * 0.2),
                            Image.asset(
                              "assets/images/empty_image.png",
                              height: 55,
                            ),
                            sizeBoxHeight(10),
                            label("No Service found",
                                fontSize: 16,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget overviewservicedata(Stores store, index) {
    return GestureDetector(
      onTap: () {
        Get.to(
            SubDetails(
              index: index,
            ),
            transition: Transition.rightToLeft);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade200
                        : AppColors.darkBorder)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: store.storeImages![0].toString(),
                  placeholder: (context, url) {
                    return CupertinoActivityIndicator();
                  },
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Icon(Icons.error);
                  },
                )),
          ),
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
                      fontWeight: FontWeight.w500,
                      textColor: themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.blue,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            SubDetails(
                              index: index,
                            ),
                            transition: Transition.rightToLeft);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: AppColors.blue,
                      ),
                    )
                  ],
                ),
                sizeBoxHeight(5),
                SizedBox(
                  width: 195,
                  child: Text(
                    store.storeDescription.toString(),
                    style: poppinsFont(
                      11,
                      themeContro.isLightMode.value
                          ? Colors.black
                          : AppColors.colorFFFFFF,
                      FontWeight.w500,
                    ),
                  ).paddingOnly(right: 10),
                ),
                sizeBoxHeight(10),
              ],
            ).paddingSymmetric(horizontal: 9),
          ),
        ],
      ),
    );
  }

  Widget servicedata(Stores store, index) {
    return GestureDetector(
      onTap: () {
        Get.to(
            SubDetails(
              index: index,
            ),
            transition: Transition.rightToLeft);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(store.storeImages![0].toString()),
                    fit: BoxFit.cover)),
          ),
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
                      fontWeight: FontWeight.w500,
                      textColor: themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                            SubDetails(
                              index: index,
                            ),
                            transition: Transition.rightToLeft);
                      },
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: AppColors.blue,
                      ),
                    )
                  ],
                ),
                sizeBoxHeight(5),
                SizedBox(
                  width: 195,
                  child: Text(
                    store.storeDescription.toString(),
                    style: poppinsFont(
                      11,
                      themeContro.isLightMode.value
                          ? Colors.black
                          : AppColors.white,
                      FontWeight.w500,
                    ),
                  ).paddingOnly(right: 10),
                ),
                sizeBoxHeight(10),
              ],
            ).paddingSymmetric(horizontal: 9),
          ),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }

  final searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 0,
      child: TextField(
        controller: searchController,
        cursorColor: Colors.grey.shade400,
        onChanged: onSearchTextChanged,
        style: poppinsFont(
            13,
            themeContro.isLightMode.value
                ? Colors.grey.shade400
                : AppColors.white,
            FontWeight.w500),
        decoration: InputDecoration(
            fillColor: themeContro.isLightMode.value
                ? const Color(0xffF3F3F3)
                : AppColors.darkGray,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
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
      ).paddingSymmetric(horizontal: 18),
    );
  }

  Widget bottam() {
    return Row(children: [
      Expanded(
        child: GestureDetector(
          // onTap: onTapcall,
          onTap: () async {
            if (userID.isEmpty) {
              snackBar("Login must need for see mobile number");
            } else {
              String phoneNum = Uri.encodeComponent(servicecontro
                  .servicemodel.value!.serviceDetail!.servicePhone!
                  .toString());
              Uri tel = Uri.parse("tel:$phoneNum");
              if (await launchUrl(tel)) {
                //phone dail app is opened
              } else {
                //phone dail app is not opened
                snackBar('Phone dail not opened');
              }
            }
          },
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/call.png',
                  height: 12,
                  color: AppColors.white,
                ),
                sizeBoxWidth(5),
                label(
                  'Call',
                  fontSize: 10,
                  textColor: AppColors.white,
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
            if (userID.isEmpty) {
              snackBar("Login must need for chat with vendor");
            } else {
              Get.to(
                  ChatScreen(
                    toUserID: servicecontro
                        .servicemodel.value!.vendorDetails!.id
                        .toString(),
                    isRought: true,
                    fname: servicecontro
                        .servicemodel.value!.vendorDetails!.firstName,
                    lname: servicecontro
                        .servicemodel.value!.vendorDetails!.lastName,
                    profile:
                        servicecontro.servicemodel.value!.vendorDetails!.image,
                    lastSeen: servicecontro
                        .servicemodel.value!.vendorDetails!.lastSeen,
                  ),
                  transition: Transition.rightToLeft);
            }
          },
          // onTap: onTapcall,
          child: Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/message-2.png',
                  height: 12,
                  color: AppColors.white,
                ),
                sizeBoxWidth(5),
                label(
                  'Chat',
                  fontSize: 10,
                  textColor: AppColors.white,
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
          onTap: () async {
            if (userID.isEmpty) {
              snackBar("Login must need for see whatsapp number");
            } else {
              whatsapp();
            }
          },

          // onTap: onTapwhatsup,
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: AppColors.blue),
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
                  'Whatsapp',
                  fontSize: 10,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  bool isBusinessOpen() {
    String today = DateFormat('E').format(DateTime.now());
    if (servicecontro.servicemodel.value!.serviceDetail!.closedDays!
        .contains(today)) {
      return false;
    }
    return true;
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
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.black,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.black,
                                  ))
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
                                      servicecontro.servicemodel.value!
                                              .serviceDetail!.closedDays!
                                              .contains(days[index]
                                                  .toString()
                                                  .substring(0, 3))
                                          ? label(
                                              'Closed',
                                              fontSize: 11,
                                              textColor: Colors.red,
                                              fontWeight: FontWeight.w500,
                                            )
                                          : label(
                                              '${servicecontro.servicemodel.value!.serviceDetail!.openTime.toString()} - ${servicecontro.servicemodel.value!.serviceDetail!.closeTime.toString()}',
                                              fontSize: 11,
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
                                    // filled: true,
                                    // fillColor: Theme.of(context).brightness == Brightness.dark
                                    //     ? AppColors.appColorBlack
                                    //     : AppColors.scaffoldColor,
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
                                Obx(() {
                                  return addreviewcontro.isaddreview.value
                                      ? loader()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                height:
                                                    getProportionateScreenHeight(
                                                        50),
                                                width:
                                                    getProportionateScreenWidth(
                                                        140),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                  child: label(
                                                    'Cancel',
                                                    fontSize: 14,
                                                    textColor: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            sizeBoxWidth(10),
                                            GestureDetector(
                                              onTap: () async {
                                                addreviewcontro.addreviewApi(
                                                    widget.serviceid!,
                                                    rateValue
                                                        .toString()
                                                        .replaceAll(".0", ""),
                                                    msgController.text);
                                                msgController.clear();
                                                addreviewcontro.addreviewmodel
                                                    .refresh();
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height:
                                                    getProportionateScreenHeight(
                                                        50),
                                                width:
                                                    getProportionateScreenWidth(
                                                        140),
                                                decoration: BoxDecoration(
                                                    color: AppColors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                  child: label(
                                                    'Send',
                                                    fontSize: 14,
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                })
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

  Widget imagelistt() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 250,
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
          right: 20,
          child: GestureDetector(
            onTap: () {
              if (userID.isEmpty) {
                snackBar('Please login to like this service');
              } else {
                likecontro.likeApi(servicecontro
                    .servicemodel.value!.serviceDetail!.id
                    .toString());

                // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                setState(() {
                  servicecontro.servicemodel.value!.serviceDetail!.isLike =
                      servicecontro.servicemodel.value!.serviceDetail!.isLike ==
                              0
                          ? 1
                          : 0;

                  for (int i = 0; i < homecontro.allcatelist.length; i++) {
                    if (homecontro.allcatelist[i].id ==
                        servicecontro.servicemodel.value!.serviceDetail!.id) {
                      homecontro.allcatelist[i].isLike = servicecontro
                          .servicemodel.value!.serviceDetail!.isLike;
                      homecontro.allcatelist.refresh();
                    }
                  }

                  for (int i = 0; i < homecontro.nearbylist.length; i++) {
                    if (homecontro.nearbylist[i].id ==
                        servicecontro.servicemodel.value!.serviceDetail!.id) {
                      homecontro.nearbylist[i].isLike = servicecontro
                          .servicemodel.value!.serviceDetail!.isLike;
                      homecontro.nearbylist.refresh();
                    }
                  }
                });
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: servicecontro
                                .servicemodel.value!.serviceDetail!.isLike ==
                            0
                        ? Image.asset(AppAsstes.heart) // Unlike
                        : Image.asset(AppAsstes.fill_heart), // Liked
                  ),
                ),
              ),
            ),
          ),
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
          bottom: -90,
          // right: 20,
          // left: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height * 0.16,
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
                          Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(servicecontro
                                            .servicemodel
                                            .value!
                                            .vendorDetails!
                                            .image
                                            .toString()),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(width: 5),
                              label(
                                servicecontro.servicemodel.value!.vendorDetails!
                                    .firstName
                                    .toString(),
                                fontSize: 11,
                                textColor: themeContro.isLightMode.value
                                    ? AppColors.black
                                    : AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          label(
                            servicecontro
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
                                    initialRating: servicecontro
                                            .servicemodel
                                            .value!
                                            .serviceDetail!
                                            .totalAvgReview!
                                            .isNotEmpty
                                        ? double.parse(servicecontro
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
                                    '(${servicecontro.servicemodel.value!.serviceDetail!.totalReviewCount!.toString()} Review)',
                                    fontSize: 10,
                                    textColor: themeContro.isLightMode.value
                                        ? AppColors.black
                                        : AppColors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ).paddingOnly(right: 14),
                              label(
                                '${servicecontro.servicemodel.value!.serviceDetail!.totalYearsCount!.toString()} Years in Business',
                                // ${avrageReview} Years in Business,
                                fontSize: 11,
                                textColor: themeContro.isLightMode.value
                                    ? AppColors.black
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
                                    'assets/images/routing.png',
                                    height: 15,
                                  ),
                                  sizeBoxWidth(5),
                                  label(
                                    servicecontro.servicemodel.value!
                                        .serviceDetail!.distance!
                                        .toString(),
                                    // ${avrageReview} Years in Business,
                                    fontSize: 11,
                                    textColor: themeContro.isLightMode.value
                                        ? AppColors.black
                                        : AppColors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              isBusinessOpen()
                                  ? Row(
                                      children: [
                                        label(
                                          'Open',
                                          fontSize: 11,
                                          textColor: Color(0xff4CAF50),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        label(
                                          ' Until ${servicecontro.servicemodel.value!.serviceDetail!.closeTime!.toString()}',
                                          fontSize: 11,
                                          textColor:
                                              themeContro.isLightMode.value
                                                  ? AppColors.black
                                                  : AppColors.white,
                                          fontWeight: FontWeight.w400,
                                        )
                                      ],
                                    )
                                  : label(
                                      'Closed',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.red,
                                    ),
                            ],
                          ),
                          sizeBoxHeight(6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -8,
                right: 20,
                child: servicecontro
                            .servicemodel.value!.serviceDetail!.isFeatured ==
                        0
                    ? SizedBox.shrink()
                    : Container(
                        height: 15,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/energy.png',
                                height: 9,
                                width: 9,
                              ),
                              sizeBoxWidth(3),
                              label(
                                'Featured',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ).paddingOnly(left: 4, right: 4),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
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
                child: DetailsCommanWidgets(
                  sname: servicecontro
                      .servicemodel.value!.serviceDetail!.serviceName
                      .toString(),
                  ratingCount: servicecontro.servicemodel.value!.serviceDetail!
                          .totalAvgReview!.isNotEmpty
                      ? double.parse(servicecontro
                          .servicemodel.value!.serviceDetail!.totalAvgReview!)
                      : 0,
                  year:
                      '${servicecontro.servicemodel.value!.serviceDetail!.totalYearsCount!.toString()} Years in Business',
                  km: servicecontro.servicemodel.value!.serviceDetail!.distance!
                      .toString(),
                  avrageReview: servicecontro
                      .servicemodel.value!.serviceDetail!.totalReviewCount!
                      .toString(),
                  isLike: userID.isEmpty
                      ? 0
                      : servicecontro
                          .servicemodel.value!.serviceDetail!.isLike!,
                  onTaplike: () {
                    if (userID.isEmpty) {
                      snackBar('Please login to like this service');
                    } else {
                      likecontro.likeApi(servicecontro
                          .servicemodel.value!.serviceDetail!.id
                          .toString());

                      // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                      setState(() {
                        servicecontro.servicemodel.value!.serviceDetail!
                            .isLike = servicecontro.servicemodel.value!
                                    .serviceDetail!.isLike ==
                                0
                            ? 1
                            : 0;

                        for (int i = 0;
                            i < homecontro.allcatelist.length;
                            i++) {
                          if (homecontro.allcatelist[i].id ==
                              servicecontro
                                  .servicemodel.value!.serviceDetail!.id) {
                            homecontro.allcatelist[i].isLike = servicecontro
                                .servicemodel.value!.serviceDetail!.isLike;
                            homecontro.allcatelist.refresh();
                          }
                        }

                        for (int i = 0; i < homecontro.nearbylist.length; i++) {
                          if (homecontro.nearbylist[i].id ==
                              servicecontro
                                  .servicemodel.value!.serviceDetail!.id) {
                            homecontro.nearbylist[i].isLike = servicecontro
                                .servicemodel.value!.serviceDetail!.isLike;
                            homecontro.nearbylist.refresh();
                          }
                        }
                      });
                    }
                  },
                )),
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
                    servicecontro
                        .servicemodel.value!.serviceDetail!.categoryName!,
                    fontSize: 8,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ).paddingSymmetric(horizontal: 8),
                ),
              ),
            ),
            Positioned(top: 10, right: 10, child: _buildIndicators())
          ],
        ));
  }

  whatsapp() async {
    var contact = servicecontro.servicemodel.value!.serviceDetail!.servicePhone!
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
                        // child: VideoViewFix(
                        //   url: servicecontro
                        //       .servicemodel.value!.serviceDetail!.video!,
                        //   play: true,
                        //   mute: false,
                        // ),
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

  void onSearchTextChanged(String text) {
    _searchResult.clear();

    if (text.isEmpty) {
      setState(() {
        _searchResult.addAll(servicecontro.servicemodel.value!.stores!);
      });
      return;
    }

    for (var userDetail in servicecontro.servicemodel.value!.stores!) {
      if (userDetail.storeName != null) if (userDetail.storeName!
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _searchResult.add(userDetail);
      }
    }

    setState(() {});
  }
}

List _searchResult = [];
