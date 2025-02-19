// ignore_for_file: prefer_is_empty, prefer_if_null_operators

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/vendor_controllers/chat_controller.dart';
import 'package:nlytical_app/Vendor/screens/new_tabber.dart/service_profile/chat_screen.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:nlytical_app/models/user_models/chat_list_model.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final ChatControllervendor messageController =
      Get.put(ChatControllervendor());

  TextEditingController searchcontroller = TextEditingController();

  Timer? timer;

  // final searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      messageController.chatApi(issearch: false);
    });

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  List<ChatList>? allchat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.white
          : AppColors.darkMainBlack,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          clipBehavior: Clip.antiAlias,
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
              top: getProportionateScreenHeight(50),
              left:
                  100, // Ensures alignment is calculated across the entire width
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: label(
                      "Message",
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizeBoxWidth(90),
                  GestureDetector(
                    onTap: () {
                      messageController.isSearchVisible.toggle();
                    },
                    child: Image.asset(
                      'assets/images/search.png',
                      color: AppColors.white,
                      height: 22,
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
              ),
            ),
            Positioned(
                top: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
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
                        children: [
                          sizeBoxHeight(27),
                          Expanded(
                            child: StreamBuilder(
                              stream:
                                  messageController.streamController1.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<ChatListModel> snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.blue),
                                    ),
                                  );
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: const Center(
                                      child: Text("Please wait...!"),
                                    ),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    child: Center(
                                      child: Text("Error ${snapshot.error}"),
                                    ),
                                  );
                                }

                                allchat = snapshot.data!.chatList ?? [];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    allchat!.isNotEmpty
                                        ? (searchcontroller.text
                                                .trim()
                                                .isNotEmpty
                                            ? searchResult.isNotEmpty
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount:
                                                        searchResult.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return chatlistwidget(
                                                          searchResult[index],
                                                          index);
                                                    },
                                                  )
                                                : searchempty() // Show empty search state if no match
                                            : ListView.separated(
                                                itemCount: allchat!.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const Divider(
                                                    color:
                                                        AppColors.colorE9E9E9,
                                                    height: 1,
                                                  );
                                                },
                                                itemBuilder: (context, index) {
                                                  return chatlistwidget(
                                                      allchat![index], index);
                                                },
                                              ))
                                        : searchempty(), // Show default empty state
                                    sizeBoxHeight(20),
                                  ],
                                );
                              },
                            ),

                            // SingleChildScrollView(
                            //   clipBehavior: Clip.antiAlias,
                            //   child:
                            //    Obx(() {
                            //     return messageController.isChatListLoading.value ==
                            //             true
                            //         ? Center(child: commonLoading())
                            //         : Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               messageController.chatlist.isNotEmpty
                            //                   ? ListView.separated(
                            //                       itemCount: messageController
                            //                           .chatlist.length,
                            //                       shrinkWrap: true,
                            //                       clipBehavior: Clip.antiAlias,
                            //                       physics:
                            //                           const BouncingScrollPhysics(),
                            //                       scrollDirection: Axis.vertical,
                            //                       padding: EdgeInsets.zero,
                            //                       separatorBuilder:
                            //                           (context, index) {
                            //                         return const Divider(
                            //                           color: AppColors.colorE9E9E9,
                            //                           height: 1,
                            //                         );
                            //                       },
                            //                       itemBuilder: (context, index) {
                            //                         return GestureDetector(
                            //                           behavior: HitTestBehavior
                            //                               .translucent,
                            //                           onTap: () {
                            //                              messageController.chatlistIndex.value = index;
                            //                             Get.to(ChatScreen(
                            //                               toUserID:
                            //                                   messageController
                            //                                       .chatlist[index]
                            //                                       .secondId
                            //                                       .toString(),
                            //                               isRought: false,
                            //                             ));
                            //                           },
                            //                           // onTap: () {
                            //                           //   messageController.chatlistIndex.value = index;
                            //                           //   Get.to(
                            //                           //     ChatScreen(
                            //                           //         toUserID: messageController
                            //                           //             .chatListData[index].secondId
                            //                           //             .toString(),
                            //                           //         isRought: false),
                            //                           //   );
                            //                           // },
                            //                           child: Row(
                            //                             crossAxisAlignment:
                            //                                 CrossAxisAlignment
                            //                                     .center,
                            //                             children: [
                            //                               commonImage(
                            //                                 image: messageController
                            //                                     .chatlist[index]
                            //                                     .profilePic!,
                            //                                 height:
                            //                                     getProportionateScreenHeight(
                            //                                         50),
                            //                                 width:
                            //                                     getProportionateScreenWidth(
                            //                                         50),
                            //                                 radius: 30,
                            //                               ),
                            //                               sizeBoxWidth(10),
                            //                               Expanded(
                            //                                 child: Column(
                            //                                   crossAxisAlignment:
                            //                                       CrossAxisAlignment
                            //                                           .start,
                            //                                   mainAxisAlignment:
                            //                                       MainAxisAlignment
                            //                                           .spaceBetween,
                            //                                   children: [
                            //                                     label(
                            //                                       "${messageController.chatlist[index].firstName!} ${messageController.chatlist[index].lastName!}",
                            //                                       overflow:
                            //                                           TextOverflow
                            //                                               .ellipsis,
                            //                                       style:
                            //                                           poppinsFont(
                            //                                         15,
                            //                                         AppColors.black,
                            //                                         FontWeight.w500,
                            //                                       ),
                            //                                     ),
                            //                                     label(
                            //                                       messageController
                            //                                           .chatlist[
                            //                                               index]
                            //                                           .lastMessage!,
                            //                                       overflow:
                            //                                           TextOverflow
                            //                                               .ellipsis,
                            //                                       style:
                            //                                           poppinsFont(
                            //                                         12,
                            //                                         AppColors
                            //                                             .colorA4A4A4,
                            //                                         FontWeight.w400,
                            //                                       ),
                            //                                     ),
                            //                                   ],
                            //                                 ),
                            //                               ),
                            //                               Expanded(
                            //                                 child: Column(
                            //                                   crossAxisAlignment:
                            //                                       CrossAxisAlignment
                            //                                           .end,
                            //                                   mainAxisAlignment:
                            //                                       MainAxisAlignment
                            //                                           .spaceBetween,
                            //                                   children: [
                            //                                     label(
                            //                                       messageController
                            //                                           .chatlist[
                            //                                               index]
                            //                                           .time!,
                            //                                       overflow:
                            //                                           TextOverflow
                            //                                               .ellipsis,
                            //                                       style:
                            //                                           poppinsFont(
                            //                                         8,
                            //                                         AppColors
                            //                                             .colorA4A4A4,
                            //                                         FontWeight.w400,
                            //                                       ),
                            //                                     ),
                            //                                     messageController
                            //                                                 .chatlist[
                            //                                                     index]
                            //                                                 .unreadMessage ==
                            //                                             "0"
                            //                                         ? const SizedBox
                            //                                             .shrink()
                            //                                         : Container(
                            //                                             decoration:
                            //                                                 const BoxDecoration(
                            //                                               shape: BoxShape
                            //                                                   .circle,
                            //                                               color: AppColors
                            //                                                   .color0046AE,
                            //                                             ),
                            //                                             child:
                            //                                                 label(
                            //                                               messageController
                            //                                                   .chatlist[
                            //                                                       index]
                            //                                                   .unreadMessage!,
                            //                                               overflow:
                            //                                                   TextOverflow
                            //                                                       .ellipsis,
                            //                                               style:
                            //                                                   poppinsFont(
                            //                                                 8,
                            //                                                 AppColors
                            //                                                     .colorFFFFFF,
                            //                                                 FontWeight
                            //                                                     .w500,
                            //                                               ),
                            //                                             ).paddingAll(
                            //                                                     6),
                            //                                           )
                            //                                   ],
                            //                                 ),
                            //                               ),
                            //                             ],
                            //                           ).paddingSymmetric(
                            //                               horizontal: 20,
                            //                               vertical: 12),
                            //                         );
                            //                       },
                            //                     )
                            //                   : Column(
                            //                       children: [
                            //                         sizeBoxHeight(260),
                            //                         Image.asset(
                            //                             "assets/images/empty_image.png",
                            //                             height:
                            //                                 getProportionateScreenHeight(
                            //                                     72)),
                            //                         sizeBoxHeight(20),
                            //                         Center(
                            //                           child: label(
                            //                             "No messages to show",
                            //                             fontSize: 16,
                            //                             maxLines: 1,
                            //                             overflow:
                            //                                 TextOverflow.ellipsis,
                            //                             fontWeight: FontWeight.w600,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //               sizeBoxHeight(20)
                            //             ],
                            //           );
                            //   }),

                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Obx(
              () => messageController.isSearchVisible.value
                  ? Positioned(
                      top: getProportionateScreenHeight(95),
                      left: 10,
                      right: 10,
                      child: searchBar(),
                    )
                  : const SizedBox(), // Jab search bar na ho to kuch na dikhaye
            ),
          ],
        ),
      ),
    );
  }

  Widget chatlistwidget(ChatList data, index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        messageController.chatlistIndex.value = index;
        Get.to(ChatScreen(
          toUserID: data.secondId.toString(),
          fname: data.firstName.toString(),
          lname: data.lastName.toString(),
          lastSeen: data.lastSeen.toString(),
          profile: data.profilePic.toString(),
          block: data.isBlock,
          isRought: false,
        ));
      },
      // onTap: () {
      //   messageController.chatlistIndex.value = index;
      //   Get.to(
      //     ChatScreen(
      //         toUserID: messageController
      //             .chatListData[index].secondId
      //             .toString(),
      //         isRought: false),
      //   );
      // },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // commonImage(
          //   image: snapshot
          //       .data!
          //       .chatList![index]
          //       .profilePic!,
          //   height:
          //       getProportionateScreenHeight(
          //           50),
          //   width:
          //       getProportionateScreenWidth(
          //           50),
          //   radius: 30,
          // ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    data.profilePic!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 2,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: data.isOnline == 1
                        ? const Color(0xff4CAF50) // Online color
                        : const Color(0xffA4A4A4), // Offline color (grey)
                  ),
                ),
              )
            ],
          ),
          sizeBoxWidth(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                label(
                  "${data.firstName!} ${data.lastName!}",
                  overflow: TextOverflow.ellipsis,
                  style: poppinsFont(
                    15,
                    themeContro.isLightMode.value
                        ? AppColors.black
                        : AppColors.white,
                    FontWeight.w500,
                  ),
                ),
                label(
                  data.type == "doc"
                      ? "Document"
                      : data.lastMessage!.capitalizeFirst!,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsFont(
                    12,
                    AppColors.colorA4A4A4,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                label(
                  data.time!,
                  overflow: TextOverflow.ellipsis,
                  style: poppinsFont(
                    8,
                    AppColors.colorA4A4A4,
                    FontWeight.w400,
                  ),
                ),
                data.unreadMessage == "0"
                    ? const SizedBox.shrink()
                    : Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.color0046AE,
                        ),
                        child: label(
                          data.unreadMessage!,
                          overflow: TextOverflow.ellipsis,
                          style: poppinsFont(
                            8,
                            AppColors.colorFFFFFF,
                            FontWeight.w500,
                          ),
                        ).paddingAll(6),
                      )
              ],
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 12),
    );
  }

  Widget searchempty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeBoxHeight(200),
          SizedBox(
            height: 160,
            child: Image.asset(
              'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
              width: 200,
              height: 180,
            ),
          ),
          label(
            "No Messages to show",
            fontSize: 18,
            textColor: themeContro.isLightMode.value
                ? AppColors.black
                : AppColors.grey1,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      height: 42,
      child: TextField(
        style: TextStyle(
            color:
                themeContro.isLightMode.value ? Colors.black : AppColors.white),
        controller: searchcontroller,
        // onTap: () {
        //   // Get.to(Search());
        // },
        onChanged: onSearchTextChanged,
        cursorColor: Colors.grey.shade300,
        readOnly: false,
        decoration: InputDecoration(
            fillColor: themeContro.isLightMode.value
                ? Colors.white
                : AppColors.darkGray,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray,
                    width: 1.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray,
                    width: 1.5)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: themeContro.isLightMode.value
                        ? Colors.grey.shade300
                        : AppColors.darkGray,
                    width: 5)),
            hintText: "Listing Search",
            // hintStyle: label(fontSize:  13, Colors.grey.shade400, FontWeight.w500),
            hintStyle: poppinsFont(13, Colors.grey.shade500, FontWeight.w500),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 11, top: 11),
              child: Image.asset(
                AppAsstes.search,
                color: Colors.grey.shade400,
                height: 10,
              ),
            )),
      ).paddingSymmetric(horizontal: 10),
    );
  }

  void onSearchTextChanged(String text) {
    searchResult.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }

    if (allchat != null) {
      for (var userDetail in allchat!) {
        if (userDetail.firstName != null &&
            userDetail.firstName!.toLowerCase().contains(text.toLowerCase())) {
          searchResult.add(userDetail);
        }
      }
    }

    setState(() {});
  }
}

List searchResult = [];
