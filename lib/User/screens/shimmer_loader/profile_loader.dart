// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

double? h, w;

Widget ProfileLoader(BuildContext context) {
  h = MediaQuery.sizeOf(context).height;
  w = MediaQuery.sizeOf(context).width;
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                // color: Theme.of(context).brightness == Brightness.dark
                //     ? AppColors.darkColor
                //     : Colors.white,
                ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              // baseColor: Theme.of(context).brightness == Brightness.dark
              //     ? Colors.white12
              //     : Colors.grey.shade300,
              // highlightColor: Theme.of(context).brightness == Brightness.dark
              //     ? Colors.white24
              //     : Colors.grey.shade100,
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // openBottomForImagePick(context);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: getProportionateScreenHeight(100),
                            width: getProportionateScreenWidth(100),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,
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
                                ),
                              ),
                              child: ClipOval(
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  '',
                                  fit: BoxFit.cover,
                                ),
                              ).paddingAll(3),
                            ).paddingAll(3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizeBoxHeight(5),
                  Container(
                    height: 20,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: label('',
                        fontSize: 12,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  sizeBoxHeight(5),
                  Container(
                    height: 20,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: label('',
                        fontSize: 12,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )),
      ],
    ),
  );
}
