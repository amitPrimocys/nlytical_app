// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class CommanScreen extends StatelessWidget {
  String cname;
  String sname;
  String vname;
  String vendorImages;
  int isfeatured;
  String location;
  String price;
  String avrageReview;
  String storeImages;
  double ratingCount;
  int isLike;
  Function() onTaplike;
  Function() onTapstore;

  CommanScreen(
      {super.key,
      required this.cname,
      required this.sname,
      required this.vname,
      required this.vendorImages,
      required this.isfeatured,
      required this.location,
      required this.price,
      required this.avrageReview,
      required this.storeImages,
      required this.ratingCount,
      required this.isLike,
      required this.onTaplike,
      required this.onTapstore});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapstore,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: Get.height * 0.6,
            width: Get.width,
            decoration: BoxDecoration(
                border: Border.all(
                    color: themeContro.isLightMode.value
                        ? AppColors.white
                        : Colors.white10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    spreadRadius: 0,
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkShadowColor,
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                    image: NetworkImage(storeImages), fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: themeContro.isLightMode.value
                    ? Colors.white
                    : AppColors.darkGray,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, top: 5, right: 12, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    sizeBoxHeight(10),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: themeContro.isLightMode.value
                                      ? Colors.grey.shade100
                                      : AppColors.darkgray2)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: vendorImages,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  AppAsstes.default_user,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        label(
                          vname,
                          fontSize: 10,
                          textColor: themeContro.isLightMode.value
                              ? Color.fromRGBO(99, 99, 99, 1)
                              : AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    label(
                      sname,
                      fontSize: 12,
                      textColor: themeContro.isLightMode.value
                          ? AppColors.black
                          : AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar.builder(
                          itemPadding: const EdgeInsets.only(left: 1.5),
                          initialRating: ratingCount,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 12,
                          ignoreGestures: true,
                          unratedColor: Colors.grey.shade400,
                          itemBuilder: (context, _) => Image.asset(
                            'assets/images/Star.png',
                            height: 6,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(width: 5),
                        label(
                          '($avrageReview Review)',
                          fontSize: 10,
                          textColor: themeContro.isLightMode.value
                              ? Color.fromRGBO(99, 99, 99, 1)
                              : AppColors.colorFFFFFF,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/location.png',
                          height: 13,
                          width: 13,
                          color: themeContro.isLightMode.value
                              ? AppColors.black
                              : AppColors.grey1,
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          width: 110,
                          child: label(
                            location,
                            fontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textColor: themeContro.isLightMode.value
                                ? Color.fromRGBO(99, 99, 99, 1)
                                : AppColors.colorFFFFFF,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 28,
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blue),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: Center(
                        child: label(
                          price,
                          fontSize: 10,
                          textColor: themeContro.isLightMode.value
                              ? AppColors.blue
                              : AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onTaplike,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLike == 0
                          ? Image.asset(AppAsstes.heart) // Unlike
                          : Image.asset(AppAsstes.fill_heart), // Liked
                    ),
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: onTaplike,

            //   child: Container(
            //     height: 26,
            //     width: 26,
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.white,
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(6.0),
            //       child: isLike == 0
            //           ? Image.asset(AppAsstes.heart) // Unlike
            //           : Image.asset(AppAsstes.fill_heart), // Liked
            //     ),
            //   ),
            // ),
          ),
          Positioned(
            top: 12,
            left: 0,
            child: Container(
              height: 15,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3),
                    bottomRight: Radius.circular(3)),
              ),
              child: Center(
                child: label(
                  cname,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ).paddingOnly(left: 4, right: 4),
              ),
            ),
          ),
          isfeatured == 0
              ? SizedBox.shrink()
              : Positioned(
                  bottom: 136,
                  right: 8,
                  child: Container(
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
    );
  }
}


// Widget alllist(
// String cname;
// {

//   int isLike;
//   Function() onTaplike;
// }
// ) {
//   return 
//   Stack(
//     clipBehavior: Clip.none,
//     children: [
//       Container(
//         height: Get.height * 0.6,
//         width: Get.width,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 2,
//               spreadRadius: 0,
//               color: Colors.grey.shade300,
//               offset: const Offset(0.0, 3.0),
//             ),
//           ],
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(15),
//               topRight: Radius.circular(15),
//               bottomLeft: Radius.circular(15),
//               bottomRight: Radius.circular(15)),
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(15),
//               topRight: Radius.circular(15),
//               bottomLeft: Radius.circular(15),
//               bottomRight: Radius.circular(15)),
//           child: Image.network(
//             'https://images.pexels.com/photos/28638641/pexels-photo-28638641/free-photo-of-dramatic-view-of-manhattan-bridge-from-brooklyn-street.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
//             fit: BoxFit.fill,
//           ),
//         ),
//       ),
//       Positioned(
//         bottom: 0,
//         left: 0,
//         right: 0,
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//                 bottomLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10)),
//           ),
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(left: 12, top: 5, right: 12, bottom: 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 sizeBoxHeight(5),
//                 Row(
//                   children: [
//                     Container(
//                       height: 20,
//                       width: 20,
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               image: NetworkImage(
//                                   'https://images.pexels.com/photos/28638641/pexels-photo-28638641/free-photo-of-dramatic-view-of-manhattan-bridge-from-brooklyn-street.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load'),
//                               fit: BoxFit.cover)),
//                     ),
//                     SizedBox(width: 5),
//                     label(
//                       'Fatima Al-Amari',
//                       fontSize: 10,
//                       textColor: AppColors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 label(
//                   'Mapplin Electronic',
//                   fontSize: 11,
//                   textColor: AppColors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 // ignore: prefer_const_constructors
//                 SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     RatingBar.builder(
//                       itemPadding: const EdgeInsets.only(left: 1.5),
//                       // initialRating: allServices.totalAvgReview != ''
//                       //     ? double.parse(allServices.totalAvgReview!)
//                       //     : 0.0,
//                       initialRating: 2,
//                       minRating: 0,
//                       direction: Axis.horizontal,
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemSize: 12,
//                       ignoreGestures: true,
//                       unratedColor: Colors.grey.shade400,
//                       itemBuilder: (context, _) => Image.asset(
//                         'assets/images/Star.png',
//                         height: 6,
//                       ),
//                       onRatingUpdate: (rating) {},
//                     ),
//                     SizedBox(width: 5),
//                     label(
//                       '(${2} Review)',
//                       fontSize: 10,
//                       textColor: AppColors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Image.asset(
//                       'assets/images/location.png',
//                       height: 13,
//                       width: 13,
//                     ),
//                     SizedBox(width: 5),
//                     label(
//                       '20 Bin Afan Street..',
//                       fontSize: 10,
//                       textColor: AppColors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//                   height: 28,
//                   width: Get.width,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.blue),
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10),
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10)),
//                   ),
//                   child: Center(
//                     child: label(
//                       'From \$252-565',
//                       fontSize: 8,
//                       textColor: AppColors.blue,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//               ],
//             ),
//           ),
//         ),
//       ),
//       Positioned(
//         top: 8,
//         right: 8,
//         child: GestureDetector(
//           // onTap: () {
//           //   // Call the API to like/unlike the service
//           //   if (homecontro.homemodel.value!.guestUser == 1) {
//           //     snackBar('Please login to like this service');
//           //   } else {
//           //     likecontro.likeApi(allServices.id.toString());

//           //     // Toggle the isLike value for the UI update (you may want to update this dynamically after the API call succeeds)
//           //     setState(() {
//           //       allServices.isLike = allServices.isLike == 0 ? 1 : 0;
//           //     });
//           //   }
//           // },
//           child: Container(
//             height: 26,
//             width: 26,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: Image.asset(AppAsstes.fill_heart), // Liked
//             ),
//           ),
//         ),
//       ),
//       Positioned(
//         top: 8,
//         left: 8,
//         child: Container(
//           height: 15,
//           decoration: BoxDecoration(
//             color: AppColors.blue,
//             borderRadius: BorderRadius.circular(3),
//           ),
//           child: Center(
//             child: label(
//              cname,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 8,
//               ),
//             ).paddingOnly(left: 4, right: 4),
//           ),
//         ),
//       ),
//       Positioned(
//         bottom: 128,
//         right: 8,
//         child: Container(
//           height: 15,
//           decoration: BoxDecoration(
//             color: AppColors.blue,
//             borderRadius: BorderRadius.circular(3),
//           ),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/energy.png',
//                   height: 9,
//                   width: 9,
//                 ),
//                 sizeBoxWidth(3),
//                 label(
//                   'Featured',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 8,
//                   ),
//                 ),
//               ],
//             ).paddingOnly(left: 4, right: 4),
//           ),
//         ),
//       ),
//     ],
//   );


// }
