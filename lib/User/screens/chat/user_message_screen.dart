import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nlytical_app/controllers/user_controllers/chat_contro.dart';
import 'package:nlytical_app/User/screens/homeScreen/chat_screen.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/models/user_models/chat_list_model.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/size_config.dart';

class UserMessageScreen extends StatefulWidget {
  const UserMessageScreen({super.key});

  @override
  State<UserMessageScreen> createState() => _UserMessageScreenState();
}

class _UserMessageScreenState extends State<UserMessageScreen> {
  final ChatController messageController = Get.put(ChatController());
  TextEditingController searchcontroller = TextEditingController();

  Timer? timer;

  final searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    // timer = Timer.periodic(const Duration(seconds: 3), (timer) {

    // });
    messageController.chatApi(issearch: false);
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/search.png',
                        color: AppColors.white,
                        height: 22,
                      )),
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
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Column(
                      children: [
                        sizeBoxHeight(27),
                        Expanded(
                          child: StreamBuilder(
                            stream: messageController.streamController1.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<ChatListModel> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.blue,
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                      "Error: ${snapshot.error.toString()}"),
                                );
                              }
                              if (snapshot.hasData) {
                                // Calculate total unread messages
                                int totalUnreadMessages =
                                    snapshot.data!.chatList!.fold<int>(
                                  0,
                                  (total, chat) =>
                                      total +
                                      (int.tryParse(
                                              chat.unreadMessage ?? '0') ??
                                          0),
                                );

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Display total unread messages
                                    if (totalUnreadMessages > 0)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: label(
                                          "Total Unread Messages: $totalUnreadMessages",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          style: poppinsFont(16,
                                              AppColors.black, FontWeight.w600),
                                        ),
                                      ),

                                    searchController.text.isEmpty &&
                                            snapshot.data!.chatList!.isEmpty
                                        ? searchempty()
                                        : ListView.separated(
                                            itemCount:
                                                snapshot.data!.chatList!.length,
                                            shrinkWrap: true,
                                            clipBehavior: Clip.antiAlias,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            padding: EdgeInsets.zero,
                                            separatorBuilder: (context, index) {
                                              return const Divider(
                                                color: AppColors.colorE9E9E9,
                                                height: 1,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onTap: () {
                                                  messageController
                                                      .chatlistIndex
                                                      .value = index;
                                                  Get.to(ChatScreen(
                                                    toUserID: snapshot
                                                        .data!
                                                        .chatList![index]
                                                        .secondId
                                                        .toString(),
                                                    fname: snapshot
                                                        .data!
                                                        .chatList![index]
                                                        .firstName
                                                        .toString(),
                                                    lname: snapshot
                                                        .data!
                                                        .chatList![index]
                                                        .lastName
                                                        .toString(),
                                                    lastSeen: snapshot
                                                        .data!
                                                        .chatList![index]
                                                        .lastSeen
                                                        .toString(),
                                                    profile: snapshot
                                                        .data!
                                                        .chatList![index]
                                                        .profilePic
                                                        .toString(),
                                                    block: snapshot
                                                        .data!
                                                        .chatList![index]
                                                        .isBlock!,
                                                    isRought: false,
                                                  ));
                                                },
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                        child:
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
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child:
                                                                Image.network(
                                                              snapshot
                                                                  .data!
                                                                  .chatList![
                                                                      index]
                                                                  .profilePic!,
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
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: snapshot
                                                                          .data!
                                                                          .chatList![
                                                                              index]
                                                                          .isOnline ==
                                                                      1
                                                                  ? const Color(
                                                                      0xff4CAF50) // Online color
                                                                  : const Color(
                                                                      0xffA4A4A4), // Offline color (grey)
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                    sizeBoxWidth(10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          label(
                                                            "${snapshot.data!.chatList![index].firstName!} ${snapshot.data!.chatList![index].lastName!}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: poppinsFont(
                                                              15,
                                                              AppColors.black,
                                                              FontWeight.w500,
                                                            ),
                                                          ),
                                                          label(
                                                            snapshot
                                                                .data!
                                                                .chatList![
                                                                    index]
                                                                .lastMessage!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: poppinsFont(
                                                              12,
                                                              AppColors
                                                                  .colorA4A4A4,
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          label(
                                                            snapshot
                                                                .data!
                                                                .chatList![
                                                                    index]
                                                                .time!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: poppinsFont(
                                                              8,
                                                              AppColors
                                                                  .colorA4A4A4,
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                          snapshot
                                                                      .data!
                                                                      .chatList![
                                                                          index]
                                                                      .unreadMessage ==
                                                                  "0"
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColors
                                                                        .color0046AE,
                                                                  ),
                                                                  child: label(
                                                                    snapshot
                                                                        .data!
                                                                        .chatList![
                                                                            index]
                                                                        .unreadMessage!,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        poppinsFont(
                                                                      8,
                                                                      AppColors
                                                                          .colorFFFFFF,
                                                                      FontWeight
                                                                          .w500,
                                                                    ),
                                                                  ).paddingAll(
                                                                      6),
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingSymmetric(
                                                    horizontal: 20,
                                                    vertical: 12),
                                              );
                                            },
                                          ),
                                    // :Center(
                                    //     child: Column(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.center,
                                    //       children: [
                                    //         sizeBoxHeight(200),
                                    //         SizedBox(
                                    //           height: 160,
                                    //           child: Image.asset(
                                    //             'assets/images/Animation - 1736233762512.gif', // Path to your Lottie JSON file
                                    //             width: 200,
                                    //             height: 180,
                                    //           ),
                                    //         ),
                                    //         label(
                                    //           "No Messages to show",
                                    //           fontSize: 18,
                                    //           textColor: AppColors.black,
                                    //           fontWeight: FontWeight.w500,
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    sizeBoxHeight(20),
                                  ],
                                );
                              } else {
                                return label("No Messages to show");
                              }
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
              ),
            ),
            Positioned(
                top: getProportionateScreenHeight(95),
                left: 10,
                right: 10,
                child: searchBar()),
          ],
        ),
      ),
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
            textColor: AppColors.black,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      height: 42,
      child: TextField(
        controller: searchcontroller,
        onTap: () {
          // Get.to(Search());
        },
        onChanged: (value) {
          setState(() {
            messageController.chatApi(xyz: value, issearch: true);
          });
        },
        cursorColor: Colors.grey.shade300,
        readOnly: false,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: Colors.grey.shade300, width: 1.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: Colors.grey.shade300, width: 1.5)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.greyColor, width: 5)),
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
}
