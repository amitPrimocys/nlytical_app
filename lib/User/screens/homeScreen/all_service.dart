import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/service_contro.dart';
import 'package:nlytical_app/User/screens/homeScreen/sub_details.dart';
import 'package:nlytical_app/User/screens/shimmer_loader/categories_loader.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/comman_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class AllService extends StatefulWidget {
  const AllService({super.key});

  @override
  State<AllService> createState() => _AllServiceState();
}

class _AllServiceState extends State<AllService> {
  ServiceContro servicecontro = Get.put(ServiceContro());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          appBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  catlist(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget catlist() {
    return Obx(() {
      return servicecontro.isservice.value
          ? cat(context)
          // const Center(
          //     child: CircularProgressIndicator(
          //       color: AppColors.blue,
          //     ),
          //   )
          : SingleChildScrollView(child: serviceslist());
    });
  }

  Widget serviceslist() {
    return servicecontro.servicemodel.value!.stores!.isNotEmpty
        ? SizedBox(
            height: Get.height,
            child: GridView.builder(
              itemCount: servicecontro.servicemodel.value!.stores!.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 3),
              // padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1, // To ensure the grid is square
              ),
              itemBuilder: (context, index) {
                return allservice(
                  imagepath: servicecontro
                      .servicemodel.value!.stores![index].storeImages![0]
                      .toString(),
                  cname: servicecontro
                      .servicemodel.value!.stores![index].storeName
                      .toString(),
                  cateOnTap: () {
                    Get.to(
                        SubDetails(
                          index: index,
                        ),
                        transition: Transition.rightToLeft);
                  },
                );
              },
            ).paddingSymmetric(horizontal: 15, vertical: 15),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SizedBox(
                height: 100,
                child: label("No services Found",
                    fontSize: 16,
                    textColor: AppColors.brown,
                    fontWeight: FontWeight.w500),
              ),
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
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/arrow-left1.png',
                    height: 24,
                  )),
              sizeBoxWidth(10),
              label(
                "Services",
                fontSize: 20,
                textColor: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          )).paddingOnly(left: 15, right: 20, top: 25),
    );
  }
}
