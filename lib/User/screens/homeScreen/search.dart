// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/like_contro.dart';
import 'package:nlytical_app/models/user_models/search_model.dart';
import 'package:nlytical_app/User/screens/homeScreen/details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/favourite_loader.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_screen.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  final ApiHelper apiHelper = ApiHelper();
  LikeContro likecontro = Get.put(LikeContro());

  bool isLoading = false;
  SearchModel model = SearchModel();

  searchApi(String xyz) async {
    setState(() {
      isLoading = true;
    });
    var uri = Uri.parse(apiHelper.search);
    var request = http.MultipartRequest('POST', uri);

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    request.headers.addAll(headers);

    request.fields['service_name'] = xyz;
    request.fields['user_id'] = userID;

    var response = await request.send();
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    // ignore: avoid_print
    print(response.statusCode);
    // ignore: avoid_print
    print(request.fields);
    // ignore: avoid_print
    print(responseData);

    model = SearchModel.fromJson(userData);

    if (model.status == true) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.appbar,
        //   automaticallyImplyLeading: false,
        //   title: Row(
        //     children: [
        //       GestureDetector(
        //           onTap: () {
        //             Get.back();
        //           },
        //           child: Image.asset(
        //             'assets/images/arrow-left1.png',
        //             height: 24,
        //           )),
        //       sizeBoxWidth(10),
        //       label(
        //         'Search',
        //         fontSize: 20,
        //         textColor: Colors.black,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ],
        //   ),
        // ),
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
                      sizeBoxWidth(110),
                      Align(
                        alignment: Alignment.center,
                        child: label(
                          "Search",
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
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      sizeBoxHeight(10),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Color.fromRGBO(0, 0, 0, 0.12),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black54,
                      //         blurRadius: 10,
                      //         spreadRadius: 0,
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              sizeBoxHeight(15),
                              search(),
                              sizeBoxHeight(15),
                              allstore()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget search() {
    return Column(
      children: [
        // TextFormField(
        //   onChanged: searchApi,
        //   cursorColor: Theme.of(context).brightness == Brightness.dark
        //       ? Colors.white
        //       : AppColors.black,
        //   autofocus: false,
        //   style: TextStyle(
        //       fontSize: 14,
        //       color: Theme.of(context).brightness == Brightness.dark
        //           ? Colors.white
        //           : AppColors.black,
        //       fontWeight: FontWeight.w400),
        //   autovalidateMode: AutovalidateMode.onUserInteraction,
        //   readOnly: false,
        //   keyboardType: TextInputType.text,
        //   controller: searchController,
        //   decoration: InputDecoration(
        //     // filled: true,
        //     // fillColor: Theme.of(context).brightness == Brightness.dark
        //     //     ? AppColors.appColorBlack
        //     //     : AppColors.scaffoldColor,
        //     contentPadding:
        //         const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        //     focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(13),
        //         borderSide: const BorderSide(color: AppColors.blue)),
        //     enabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(13),
        //         borderSide: BorderSide(color: Colors.grey)),
        //     disabledBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(13),
        //         borderSide: BorderSide(color: Colors.grey)),
        //     hintText: "Search Services...",
        //     hintStyle: TextStyle(
        //         fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400),
        //     prefixIcon: Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Padding(
        //         padding: const EdgeInsets.all(8),
        //         child: Image.asset(
        //           AppAsstes.search,
        //           color: Colors.grey,
        //           height: 7,
        //         ),
        //       ),
        //     ),
        //     errorBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(13),
        //         borderSide: BorderSide(color: Colors.grey)),
        //     border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(13),
        //         borderSide: BorderSide(color: Colors.grey)),
        //     errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
        //   ),
        // ).paddingSymmetric(horizontal: 20),
        searchBar(),
        sizeBoxHeight(10),
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: label('Clear all',
        //       fontSize: 10,
        //       fontWeight: FontWeight.w400,
        //       textColor: Colors.grey),
        // ).paddingSymmetric(horizontal: 20),
        // sizeBoxHeight(15),
        // SizedBox(
        //   height: getProportionateScreenHeight(35),
        //   child: ListView.builder(
        //       itemCount: 8,
        //       shrinkWrap: true,
        //       padding: EdgeInsets.symmetric(horizontal: 20),
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 6),
        //           child: Container(
        //             height: getProportionateScreenHeight(35),
        //             width: getProportionateScreenWidth(110),
        //             decoration: BoxDecoration(
        //                 border: Border.all(color: AppColors.blue, width: 2),
        //                 borderRadius: BorderRadius.circular(6)),
        //             child: Center(
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   label('Plumbing',
        //                       fontSize: 12,
        //                       fontWeight: FontWeight.w400,
        //                       textColor: Colors.black),
        //                   sizeBoxWidth(8),
        //                   Icon(
        //                     Icons.close,
        //                     color: Colors.grey,
        //                     size: 10,
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //         );
        //       }),
        // )
      ],
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 0,
      child: TextField(
        controller: searchController,
        cursorColor: AppColors.blue,
        onChanged: searchApi,
        decoration: InputDecoration(
            fillColor: const Color(0xffF3F3F3),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300)),
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
      ).paddingSymmetric(horizontal: 20),
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
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              label(
                "Search",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 21, right: 20, top: 25),
    );
  }

  Widget allstore() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the maxCrossAxisExtent based on the screen width
    double maxCrossAxisExtent =
        screenWidth / 2; // You can adjust this value as needed

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Column(
      children: [
        searchController.text.isEmpty
            ? searchempty()
            : isLoading
                ? wishListLoader(context)
                : model.serviceSearch!.isEmpty
                    ? searchempty()
                    : GridView.builder(
                        itemCount: model.serviceSearch!.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        //   maxCrossAxisExtent: maxCrossAxisExtent,
                        //   childAspectRatio: (itemWidth / itemHeight * 1.6),
                        //   mainAxisSpacing: 14,
                        //   crossAxisSpacing: 14,
                        // ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 items in a row
                          childAspectRatio:
                              0.58, // Adjust for image and text ratio
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return CommanScreen(
                            storeImages: model
                                .serviceSearch![index].serviceImages![0]
                                .toString(),
                            sname: model.serviceSearch![index].serviceName!
                                .capitalizeFirst
                                .toString(),
                            cname: model.serviceSearch![index].categoryName!
                                .capitalizeFirst
                                .toString(),
                            vname: model.serviceSearch![index].vendorFirstName
                                .toString(),
                            vendorImages: model
                                .serviceSearch![index].vendorImage
                                .toString(),
                            isfeatured: model.serviceSearch![index].isFeatured!,
                            ratingCount: model.serviceSearch![index]
                                    .totalAvgReview!.isNotEmpty
                                ? double.parse(
                                    model.serviceSearch![index].totalAvgReview!)
                                : 0,
                            avrageReview: model
                                .serviceSearch![index].totalReviewCount!
                                .toString(),
                            isLike: userID.isEmpty
                                ? 0
                                : model.serviceSearch![index].isLike!,
                            onTaplike: () {
                              if (userID.isEmpty) {
                                snackBar('Please login to like this service');
                              } else {
                                likecontro.likeApi(
                                    model.serviceSearch![index].id.toString());

                                // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                                setState(() {
                                  model.serviceSearch![index].isLike =
                                      model.serviceSearch![index].isLike == 0
                                          ? 1
                                          : 0;
                                });
                              }

                              // Call the API to like/unlike the service
                            },
                            onTapstore: () {
                              Get.to(
                                  Details(
                                    serviceid: model.serviceSearch![index].id
                                        .toString(),
                                    latt: model.serviceSearch![index].lat
                                        .toString(),
                                    longg: model.serviceSearch![index].lon
                                        .toString(),
                                  ),
                                  transition: Transition.rightToLeft);
                            },
                            location:
                                model.serviceSearch![index].address.toString(),
                            price: 'From \$252-565',
                          );
                          // findstore(
                          //     imagepath: model
                          //         .serviceSearch![index].serviceImages![0]
                          //         .toString(),
                          //     sname: model.serviceSearch![index].serviceName!,
                          //     cname: model.serviceSearch![index].categoryName!,
                          //     ratingCount: model.serviceSearch![index]
                          //             .totalAvgReview!.isEmpty
                          //         ? 0.00
                          //         : double.parse(model
                          //             .serviceSearch![index].totalAvgReview!),
                          //     avrageReview: model
                          //         .serviceSearch![index].totalReviewCount!
                          //         .toString(),
                          //     isLike: model.guestUser == 1
                          //         ? 0
                          //         : model.serviceSearch![index].isLike!,
                          //     onTaplike: () {
                          //       if (model.guestUser == 1) {
                          //         snackBar('Please login to like this service');
                          //       } else {
                          //         likecontro.likeApi(model
                          //             .serviceSearch![index].id
                          //             .toString());

                          //         // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
                          //         setState(() {
                          //           model.serviceSearch![index].isLike =
                          //               model.serviceSearch![index].isLike == 0
                          //                   ? 1
                          //                   : 0;
                          //         });
                          //       }

                          //       // Call the API to like/unlike the service
                          //     },
                          //     storeOnTap: () {
                          //       Get.to(
                          //           Details(
                          //             serviceid: model.serviceSearch![index].id
                          //                 .toString(),
                          //             latt: model.serviceSearch![index].lat
                          //                 .toString(),
                          //             longg: model.serviceSearch![index].lon
                          //                 .toString(),
                          //           ),
                          //           transition: Transition.rightToLeft);
                          //     });
                        },
                      ).paddingSymmetric(horizontal: 20),
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: model.serviceSearch!.length,
        //     physics: BouncingScrollPhysics(),
        //     itemBuilder: (context, index) {
        //       return Column(
        //         children: [
        //           sizeBoxHeight(15),
        //           GestureDetector(
        //             onTap: () {
        //               Get.to(
        //                   Details(
        //                     serviceid: model
        //                         .serviceSearch![index].id
        //                         .toString(),
        //                   ),
        //                   transition: Transition.rightToLeft);
        //             },
        //             child: Container(
        //               height: getProportionateScreenHeight(120),
        //               width: Get.width,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10),
        //                   border: Border.all(
        //                       color: Colors.grey.shade300)),
        //               child: Row(
        //                 children: [
        //                   Container(
        //                     height:
        //                         getProportionateScreenHeight(120),
        //                     width: getProportionateScreenWidth(130),
        //                     decoration: BoxDecoration(
        //                         borderRadius:
        //                             const BorderRadius.only(
        //                                 topLeft: Radius.circular(9),
        //                                 bottomLeft:
        //                                     Radius.circular(9)),
        //                         border:
        //                             Border.all(color: Colors.white),
        //                         image: DecorationImage(
        //                             image: NetworkImage(model
        //                                 .serviceSearch![index]
        //                                 .serviceImages![0]
        //                                 .toString()),
        //                             fit: BoxFit.fill)),
        //                   ),
        //                   Column(
        //                     mainAxisAlignment:
        //                         MainAxisAlignment.start,
        //                     crossAxisAlignment:
        //                         CrossAxisAlignment.start,
        //                     children: [
        //                       sizeBoxHeight(5),
        //                       Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           sizeBoxWidth(10),
        //                           Container(
        //                             height: 13,
        //                             width: 45,
        //                             decoration: BoxDecoration(
        //                               color: AppColors.blue,
        //                               borderRadius:
        //                                   BorderRadius.circular(3),
        //                             ),
        //                             child: Center(
        //                               child: Text(
        //                                 model.serviceSearch![index]
        //                                     .categoryName
        //                                     .toString(),
        //                                 style: TextStyle(
        //                                     color: Colors.white,
        //                                     fontSize: 5),
        //                               ),
        //                             ),
        //                           ),
        //                           sizeBoxWidth(130),
        //                           GestureDetector(
        //                             onTap: () {
        //                               if (model.guestUser == 1) {
        //                                 snackBar(
        //                                     'Please login to like this service');
        //                               } else {
        //                                 likecontro.likeApi(model
        //                                     .serviceSearch![index]
        //                                     .id
        //                                     .toString());

        //                                 // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
        //                                 setState(() {
        //                                   model
        //                                       .serviceSearch![index]
        //                                       .isLike = model
        //                                               .serviceSearch![
        //                                                   index]
        //                                               .isLike ==
        //                                           0
        //                                       ? 1
        //                                       : 0;
        //                                 });
        //                               }

        //                               // Call the API to like/unlike the service
        //                             },
        //                             child: Container(
        //                                 height: 26,
        //                                 width: 26,
        //                                 decoration:
        //                                     const BoxDecoration(
        //                                         shape:
        //                                             BoxShape.circle,
        //                                         color: AppColors
        //                                             .blue1),
        //                                 child: Padding(
        //                                   padding:
        //                                       const EdgeInsets.all(
        //                                           6.0),
        //                                   child: model
        //                                               .serviceSearch![
        //                                                   index]
        //                                               .isLike ==
        //                                           0
        //                                       ? Image.asset(
        //                                           AppAsstes.heart)
        //                                       : Image.asset(
        //                                           AppAsstes
        //                                               .fill_heart),
        //                                 )),
        //                           )
        //                         ],
        //                       ),
        //                       // label(
        //                       //   model.serviceSearch![index]
        //                       //       .serviceName
        //                       //       .toString(),
        //                       //   fontSize: 11,
        //                       //   textColor: AppColors.brown,
        //                       //   fontWeight: FontWeight.w600,
        //                       // ).paddingOnly(left: 10),

        //                       SizedBox(
        //                         width: 200,
        //                         child: label(
        //                           model.serviceSearch![index]
        //                               .serviceName
        //                               .toString(),
        //                           fontSize: 11,
        //                           maxLines: 1,
        //                           overflow: TextOverflow.ellipsis,
        //                           textColor: AppColors.brown,
        //                           fontWeight: FontWeight.w600,
        //                         ).paddingOnly(
        //                           left: 10,
        //                         ),
        //                       ),
        //                       SizedBox(height: 5),
        //                       Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           sizeBoxWidth(10),
        //                           Container(
        //                               height: 24,
        //                               width: 24,
        //                               decoration: BoxDecoration(
        //                                   shape: BoxShape.circle,
        //                                   color: AppColors.blue1),
        //                               child: Padding(
        //                                 padding:
        //                                     const EdgeInsets.all(
        //                                         6.0),
        //                                 child: Image.asset(
        //                                   'assets/images/location1.png',
        //                                   color: Colors.black,
        //                                 ),
        //                               )),
        //                           sizeBoxWidth(10),
        //                           SizedBox(
        //                             width: 155,
        //                             child: label(
        //                               model.serviceSearch![index]
        //                                   .address
        //                                   .toString(),
        //                               maxLines: 1,
        //                               fontSize: 9,
        //                               textColor: AppColors.black,
        //                               fontWeight: FontWeight.w400,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       sizeBoxHeight(6),
        //                       Row(
        //                         children: [
        //                           sizeBoxWidth(10),
        //                           model.serviceSearch!.isNotEmpty &&
        //                                   index <
        //                                       model.serviceSearch!
        //                                           .length
        //                               ? RatingBar.builder(
        //                                   itemPadding:
        //                                       const EdgeInsets.only(
        //                                           left: 1.5),
        //                                   initialRating: (model
        //                                                   .serviceSearch![
        //                                                       index]
        //                                                   .totalAvgReview !=
        //                                               null &&
        //                                           model
        //                                               .serviceSearch![
        //                                                   index]
        //                                               .totalAvgReview
        //                                               .toString()
        //                                               .isNotEmpty)
        //                                       ? double.tryParse(model
        //                                               .serviceSearch![
        //                                                   index]
        //                                               .totalAvgReview
        //                                               .toString()) ??
        //                                           0.0
        //                                       : 0.0,
        //                                   minRating: 0,
        //                                   direction:
        //                                       Axis.horizontal,
        //                                   allowHalfRating: true,
        //                                   itemCount: 5,
        //                                   itemSize: 10.5,
        //                                   ignoreGestures: true,
        //                                   unratedColor:
        //                                       Colors.grey.shade400,
        //                                   itemBuilder:
        //                                       (context, _) =>
        //                                           Image.asset(
        //                                     'assets/images/Star.png',
        //                                     height: 6,
        //                                   ),
        //                                   onRatingUpdate:
        //                                       (rating) {},
        //                                 )
        //                               : SizedBox(),
        //                           SizedBox(width: 5),
        //                           label(
        //                             // ignore: unnecessary_string_escapes
        //                             '(${model.serviceSearch![index].totalReviewCount.toString()} \Review)',
        //                             fontSize: 8,
        //                             textColor: AppColors.black,
        //                             fontWeight: FontWeight.w400,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             ).paddingSymmetric(horizontal: 20),
        //           )
        //         ],
        //       );
        //     }),
      ],
    );
  }

  Widget searchempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(170),
          SizedBox(
            height: 160,
            child: Image.asset(
              'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
              width: 200,
              height: 180,
            ),
          ),
          label(
            "No Search Found",
            fontSize: 18,
            textColor: AppColors.black,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );

    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       sizeBoxHeight(Get.height * 0.30),
    //       Image.asset(
    //         "assets/images/empty_image.png",
    //         height: 75,
    //       ),
    //       sizeBoxHeight(10),
    //       label("No Search Found",
    //           fontSize: 16,
    //           textColor: AppColors.brown,
    //           fontWeight: FontWeight.w500)
    //     ],
    //   ),
    // );
  }
}
