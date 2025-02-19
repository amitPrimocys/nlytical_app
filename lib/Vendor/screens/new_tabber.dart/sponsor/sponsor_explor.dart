// ignore_for_file: must_be_immutable, deprecated_member_use, avoid_print, unused_field
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/controllers/vendor_controllers/location_controller.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/sponsor/create_audiance.dart';

class SponsorExplor extends StatefulWidget {
  String? latt;
  String? lonn;
  String? vendorid;
  String? serviceid;
  String? addrss;
  SponsorExplor(
      {super.key,
      this.latt,
      this.lonn,
      this.vendorid,
      this.serviceid,
      this.addrss});

  @override
  State<SponsorExplor> createState() => _SponsorExplorState();
}

class _SponsorExplorState extends State<SponsorExplor> {
  late GoogleMapController mapController;
  LocationController locacontro = Get.put(LocationController());

  final double _minRadius = 1000;
  final double _maxRadius = 10000;
  //  LatLng _center = LatLng(double.tryParse(widget.latt!), double.tryParse(widget.lonn!));

  List<Marker> markerList = <Marker>[];

  addMarker() async {
    if (widget.latt == null || widget.lonn == null) {
      return; // Exit if lat/lon is null
    }

    // Convert string to double safely
    double? latitude = double.tryParse(widget.latt!);
    double? longitude = double.tryParse(widget.lonn!);

    if (latitude == null || longitude == null) {
      return; // Exit if parsing fails
    }

    // Add marker only for the store location
    markerList.add(
      Marker(
        markerId: const MarkerId('StoreMarker'),
        position: LatLng(latitude, longitude),
        icon: await getCustomIcon(),
      ),
    );

    if (mounted) {
      // setState(() {});
    }
  }

  Future<BitmapDescriptor> getCustomIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(2, 2)), // Icon size
      "assets/images/locationpick.png",
    );
  }

  Set<Circle> circlesss = {};

  void _setMapStyle() async {
    String style = await rootBundle.loadString('assets/map_styles/map.json');
    mapController.setMapStyle(style);
  }

  @override
  void initState() {
    addMarker();
    double? lat = double.tryParse(widget.latt ?? '');
    double? lon = double.tryParse(widget.lonn ?? '');

    if (lat != null && lon != null) {
      circlesss.add(
        Circle(
          circleId: const CircleId('1'),
          center: LatLng(lat, lon),
          radius: locacontro.currentDistance.value.toDouble(),
          visible: true,
          strokeWidth: 1,
          strokeColor: AppColors.blue.withOpacity(0.5),
          fillColor: AppColors.blue.withOpacity(0.2),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              left: 0,
              right: 0,
              child: Container(
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
                        "Explore",
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
                          ? Colors.white
                          : AppColors.darkMainBlack,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      location(),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(
      String path, int width, int height) async {
    final byteData = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    final frame = await codec.getNextFrame();
    return (await frame.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Widget location() {
    return FutureBuilder<Uint8List>(
      future: getBytesFromAsset(
        'assets/images/locationpick.png',
        10,
        10,
      ),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Obx(() {
            return SizedBox(
              width: double.infinity, // Set width to full screen
              height: Get.height * 0.89, // Set a fixed height
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: Get.height * 0.89,
                      child: Obx(() {
                        return GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            mapController = controller;
                            themeContro.isLightMode.value
                                ? null
                                : _setMapStyle();
                            _updateCameraPosition(); // Set initial camera position
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              double.parse(widget.latt ?? '0.0'),
                              double.parse(widget.lonn ?? '0.0'),
                            ),
                            zoom: _calculateZoomLevel(
                              locacontro.circleRadius.value,
                              // double.parse(widget.latt ??
                              //     '0.0') // Pass only the latitude
                            ),
                          ),
                          zoomControlsEnabled: false,
                          circles: <Circle>{
                            Circle(
                              circleId: const CircleId('circle_id'),
                              center: LatLng(
                                double.parse(widget.latt ?? '0.0'),
                                double.parse(widget.lonn ?? '0.0'),
                              ),
                              radius: locacontro.circleRadius.value,
                              strokeWidth: 1,
                              strokeColor: AppColors.blue.withOpacity(0.5),
                              fillColor: AppColors.blue.withOpacity(0.2),
                            ),
                          },
                          markers: Set<Marker>.of(markerList),
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: 15,
                    child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: themeContro.isLightMode.value
                                    ? Colors.white
                                    : AppColors.darkMainBlack,
                                borderRadius: BorderRadius.circular(5)),
                            child: RichText(
                                text: TextSpan(children: [
                              WidgetSpan(
                                  child: Image.asset(
                                'assets/images/location.png',
                                height: 20,
                                color: themeContro.isLightMode.value
                                    ? AppColors.black
                                    : AppColors.white,
                              )),
                              TextSpan(
                                  text: " ${widget.addrss.toString()}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: themeContro.isLightMode.value
                                        ? Colors.black
                                        : AppColors.white,
                                  ))
                            ])).paddingAll(5)
                            // Row(
                            //   children: [
                            //     const SizedBox(width: 8),
                            //     Image.asset(
                            //       'assets/images/location.png',
                            //       height: 20,
                            //     ),
                            //     const SizedBox(width: 8),
                            //     label(
                            //       widget.addrss.toString(),
                            //       maxLines: 2,
                            //       style: const TextStyle(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w400,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            )
                        .paddingSymmetric(horizontal: 20),
                  ),
                  Positioned(
                      bottom: 40,
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Container(
                            height: 105,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: themeContro.isLightMode.value
                                  ? Colors.white
                                  : AppColors.darkMainBlack,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.99,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Distance Title Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/pickloc.png',
                                          height: 15,
                                          color: themeContro.isLightMode.value
                                              ? AppColors.black
                                              : AppColors.blue,
                                        ),
                                        const SizedBox(width: 8),
                                        label(
                                          "Distance",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: themeContro.isLightMode.value
                                                ? Colors.black87
                                                : AppColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    label(
                                      "${(locacontro.circleRadius.value / 100).round()} km",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 10),

                                Obx(() {
                                  return SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: AppColors.blue,
                                      inactiveTrackColor: const Color.fromRGBO(
                                          155, 155, 155, 1),
                                      thumbColor: AppColors.blue,
                                      overlayColor:
                                          AppColors.blue.withOpacity(0.2),
                                      valueIndicatorColor: AppColors.blue,
                                    ),
                                    child: Slider(
                                      value: locacontro.circleRadius.value
                                          .toDouble(),
                                      min: 5,
                                      max: _maxRadius,
                                      divisions: 95,
                                      onChanged: (double value) {
                                        locacontro.circleRadius.value = value;
                                        _updateCameraPosition();
                                      },
                                    ),
                                  );
                                }),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    label('1 km',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10)),
                                    label(
                                      "${(locacontro.circleRadius.value / 100).round()}km",
                                      style: const TextStyle(
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10),
                                    ),
                                    label("100 km",
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10)),
                                  ],
                                ).paddingSymmetric(horizontal: 10),
                              ],
                            ),
                          ).paddingSymmetric(horizontal: 15),
                          sizeBoxHeight(20),
                          CustomButtom(
                              title: "Next",
                              onPressed: () {
                                print(
                                    'CurrentDist : ${(locacontro.circleRadius.value / 100).round()}');

                                Get.to(() => CreateAudiance(
                                      addrss: widget.addrss,
                                      latt: widget.latt,
                                      lonn: widget.lonn,
                                      serviceid: widget.serviceid,
                                      vendorid: widget.vendorid,
                                      distance:
                                          (locacontro.circleRadius.value / 100)
                                              .round()
                                              .toString(),
                                      mindistance: '5',
                                    ));
                              },
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: getProportionateScreenHeight(60),
                              width: getProportionateScreenWidth(300)),
                        ],
                      )),
                ],
              ),
            );
          });
        } else {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.blue),
          );
        }
      },
    );
  }

  void _updateCameraPosition() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            double.parse(widget.latt ?? '0.0'),
            double.parse(widget.lonn ?? '0.0'),
          ),
          zoom: _calculateZoomLevel(
            locacontro.circleRadius.value,
            // double.parse(widget.latt ?? '0.0') // Pass only the latitude
          ),
        ),
      ),
    );
  }

  // double _calculateZoomLevel(double radius, double latitude) {
  //   // Calculate zoom level based on radius (in meters) and latitude
  //   return 21 - log((40075017 * cos(latitude * pi / 180)) / radius) / log(2);
  // }

  double _calculateZoomLevel(double radiusInMeters) {
    double scale = radiusInMeters / 500; // Adjust scale factor as needed
    double zoomLevel = 16 - log(scale) / log(2);
    return zoomLevel.clamp(5.0, 18.0); // Ensure zoom stays within a valid range
  }

  // double _getZoomLevel(double distanceInKm) {
  //   double zoomLevel = 11;
  //   double radius =
  //       locacontro.currentDistance.value + locacontro.currentDistance.value / 1;
  //   double scale = radius / 100;
  //   zoomLevel = (16 - scale / 2);
  //   return zoomLevel;
  // }
}
