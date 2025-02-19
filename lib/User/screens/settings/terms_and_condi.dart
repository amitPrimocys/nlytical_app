import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/terms_contro.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';

class TermsAndCondi extends StatefulWidget {
  const TermsAndCondi({super.key});

  @override
  State<TermsAndCondi> createState() => _TermsAndCondiState();
}

class _TermsAndCondiState extends State<TermsAndCondi> {
  TermsContro termscontro = Get.put(TermsContro());

  @override
  void initState() {
    termscontro.termsandcondiApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        //         'Terms and Condition',
        //         fontSize: 20,
        //         textColor: Colors.black,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ],
        //   ),
        // ),
        body: Obx(() {
          return termscontro.isterms.value
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.blue,
                ))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizeBoxHeight(10),
                      label(
                        'Terms and Condition',
                        fontSize: 20,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      sizeBoxHeight(15),
                      SizedBox(
                        width: Get.width,
                        child: label(
                          termscontro.termsandcondimodel.value!.data![0].text
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
