import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/privacy_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  PrivacyPolicyContro privacycontro = Get.put(PrivacyPolicyContro());

  @override
  void initState() {
    privacycontro.privacypolicyApi();
    super.initState();
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
        //         'Privacy & Policy',
        //         fontSize: 20,
        //         textColor: Colors.black,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ],
        //   ),
        // ),
        body: Obx(() {
          return privacycontro.isprivacy.value
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.blue,
                ))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label(
                        'Privacy & Policy',
                        fontSize: 20,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      sizeBoxHeight(15),
                      SizedBox(
                        width: Get.width,
                        child: label(
                          privacycontro.privacymodel.value!.data![0].text
                              .toString(),
                          fontSize: 12,
                          maxLines: 20,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                );
        }));
  }
}
