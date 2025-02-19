import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/login.dart';
import 'package:nlytical_app/User/screens/bottamBar/newtabbar.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AppAsstes.welcomebg),
          fit: BoxFit.fitWidth,
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Image.asset(
                  AppAsstes.logo,
                  height: 55,
                  width: 180,
                  fit: BoxFit.contain,
                  // width: SizeConfig.blockSizeHorizontal * 50,
                ).paddingSymmetric(horizontal: 100, vertical: 95),
                sizeBoxHeight(310),
                Center(
                  child: Image.asset(
                    AppAsstes.welcomehand,
                    height: getProportionateScreenHeight(53),
                    width: getProportionateScreenWidth(181),
                  ),
                ),
                Center(
                  child: label(
                    "Hello welcome to Nlytical app",
                    maxLines: 2,
                    textColor: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                sizeBoxHeight(25),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      const Login(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Container(
                    height: getProportionateScreenHeight(60),
                    width: getProportionateScreenWidth(300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/sms.png',
                          color: AppColors.blue,
                          height: 20,
                        ),
                        sizeBoxWidth(10),
                        label(
                          "Continue with Login",
                          maxLines: 2,
                          textColor: AppColors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
                sizeBoxHeight(25),
                GestureDetector(
                  onTap: () async {
                    // Access SharedPreferences instance
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    // Save guest user status (1 for guest, 0 for not a guest)
                    await prefs.setInt('isGuest', 1);

                    // Navigate to the Home screen
                    Get.to(TabbarScreen(
                      currentIndex: 0,
                    ));
                  },
                  child: Container(
                    height: getProportionateScreenHeight(60),
                    width: getProportionateScreenWidth(300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: AppColors.white)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/profile1.png',
                          height: 20,
                          color: Colors.white,
                        ),
                        sizeBoxWidth(10),
                        label(
                          "Continue As Guest",
                          maxLines: 2,
                          textColor: AppColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
