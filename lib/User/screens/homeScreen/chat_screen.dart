// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nlytical_app/auth/splash.dart';
import 'package:nlytical_app/controllers/user_controllers/block_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/chat_contro.dart';
import 'package:nlytical_app/controllers/user_controllers/report_contro.dart';
import 'package:nlytical_app/models/user_models/chat_get_model.dart';
import 'package:nlytical_app/models/user_models/online_model.dart';
import 'package:nlytical_app/User/screens/homeScreen/vendor_info.dart';
import 'package:nlytical_app/utils/assets.dart';
import 'package:nlytical_app/utils/colors.dart';
import 'package:nlytical_app/utils/common_widgets.dart';
import 'package:nlytical_app/utils/global.dart';
import 'package:nlytical_app/utils/global_fonts.dart';
import 'package:nlytical_app/utils/global_text_form_field.dart';
import 'package:nlytical_app/utils/size_config.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ChatScreen extends StatefulWidget {
  final String toUserID;
  final bool isRought;
  String? fname;
  String? lname;
  String? profile;
  String? lastSeen;
  int? block;
  ChatScreen(
      {super.key,
      required this.toUserID,
      required this.isRought,
      this.fname,
      this.lname,
      this.profile,
      this.lastSeen,
      this.block});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController messageController = Get.find();
  BlockContro blockcontro = Get.put(BlockContro());
  ReportContro reportcontro = Get.put(ReportContro());

  final sendMessageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode signUpEmailIDFocusNode = FocusNode();

  Timer? timer;
  bool onTapbutton = false;

  _scrollToLastMessage() {
    _scrollController.jumpTo(
      _scrollController.position.minScrollExtent,
    );
  }

  @override
  void initState() {
    print("Block_status:${widget.block}");
    reportcontro.reportgetApi();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      messageController.onlineuser(onlineStatus: "1");
      messageController.chatgetApi(toUSerID: widget.toUserID);
    });
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    // messageController.streamControlleronline.close();
    messageController.getMessageModel = GetMessageModel().obs;
    super.dispose();
  }

  void _scrollListener() {
    // Handle scroll events if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeContro.isLightMode.value
          ? Colors.white
          : AppColors.darkMainBlack,
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
                top: getProportionateScreenHeight(50),
                right: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.to(VendorInfo(
                      oppositeid: widget.toUserID,
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                // messageController.onlineuser(onlineStatus: "0");
                                Get.back();
                              },
                              child: Image.asset(
                                'assets/images/arrow-left1.png',
                                height: 24,
                                color: AppColors.white,
                              )),
                          sizeBoxWidth(10),
                          GestureDetector(
                            onTap: () {
                              Get.to(VendorInfo(
                                oppositeid: widget.toUserID,
                              ));
                            },
                            child: widget.isRought == true
                                ? commonImage(
                                    image: widget.profile!,
                                    height: getProportionateScreenHeight(47),
                                    width: getProportionateScreenWidth(47),
                                    radius: 30,
                                  )
                                : commonImage(
                                    image: widget.profile!,
                                    height: getProportionateScreenHeight(47),
                                    width: getProportionateScreenWidth(47),
                                    radius: 30,
                                  ),
                          ),
                          sizeBoxWidth(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.isRought == true
                                  ? label(
                                      "${widget.fname!} ${widget.lname!}",
                                      overflow: TextOverflow.ellipsis,
                                      style: poppinsFont(
                                        16,
                                        AppColors.white,
                                        FontWeight.w500,
                                      ),
                                    )
                                  : label(
                                      "${widget.fname!} ${widget.lname!}",
                                      overflow: TextOverflow.ellipsis,
                                      style: poppinsFont(
                                        16,
                                        AppColors.white,
                                        FontWeight.w500,
                                      ),
                                    ),
                              StreamBuilder(
                                stream: messageController
                                    .streamControlleronline.stream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<OnlineModel> snapshot) {
                                  if (snapshot.hasData) {
                                    // Ensure proper null checks
                                    final toUserDetails = messageController
                                        .getMessageModel.value.toUserDetails;
                                    final updatedAt = toUserDetails?.updatedAt;

                                    return Text(
                                      messageController.isonlinestatus.value ==
                                              "1"
                                          ? "Online"
                                          : (updatedAt != null
                                              ? formatLastSeen(
                                                  updatedAt.toString())
                                              : ""), // Fallback for null `updatedAt`
                                      style: const TextStyle(
                                        color: Color(0xffE6E6E6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  } else {
                                    return const Text('123');
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      // sizeBoxWidth(50),
                      Theme(
                        data: Theme.of(context).copyWith(
                          popupMenuTheme: PopupMenuThemeData(
                            color: Colors.white, // Background color
                            shadowColor: themeContro.isLightMode.value
                                ? Colors.grey.withOpacity(0.5)
                                : AppColors.darkShadowColor, // Shadow color
                            elevation: 12, // Elevation for box shadow
                          ),
                        ),
                        child: PopupMenuButton<String>(
                          color: themeContro.isLightMode.value
                              ? AppColors.white
                              : AppColors.darkGray,
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.white,
                            size: 30,
                          ),
                          onSelected: (value) {
                            if (value == 'Report') {
                              reportcontro.reportgetApi();
                              bottomSheetGobal(
                                  bottomsheetHeight: 370,
                                  title: "Report",
                                  child: report());
                            } else if (value == 'Block') {
                              bottomSheetGobal(
                                  bottomsheetHeight: 250,
                                  title: widget.block == 1
                                      ? "Block Account"
                                      : "Unblock Account",
                                  child: selectblock());
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem<String>(
                              value: 'Report',
                              child: Text(
                                'Report',
                                style: TextStyle(
                                    color: themeContro.isLightMode.value
                                        ? Colors.black
                                        : AppColors.white),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Block',
                              child: widget.block == 1
                                  ? Text(
                                      'Block',
                                      style: TextStyle(
                                          color: themeContro.isLightMode.value
                                              ? Colors.black
                                              : AppColors.white),
                                    )
                                  : Text(
                                      'UnBlock',
                                      style: TextStyle(
                                          color: themeContro.isLightMode.value
                                              ? Colors.black
                                              : AppColors.white),
                                    ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 10),
                )),
            Positioned.fill(
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
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          sizeBoxHeight(27),
                          Expanded(
                            child: StreamBuilder(
                                stream:
                                    messageController.streamController.stream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<GetMessageModel> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.blue,
                                    ));
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                        child: Text(
                                            "Error: ${snapshot.error.toString()}"));
                                  }
                                  if (snapshot.hasData) {
                                    return snapshot.data!.chatMessages!.isEmpty
                                        ? Column(
                                            children: [
                                              sizeBoxHeight(300),
                                              label("Start your conversation",
                                                  fontSize: 16,
                                                  textColor:
                                                      Colors.grey.shade400)
                                            ],
                                          )
                                        : ListView.builder(
                                            controller: _scrollController,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            reverse: true,
                                            itemCount: snapshot
                                                .data!.chatMessages!.length,
                                            itemBuilder: (context, index1) {
                                              return StickyHeader(
                                                header: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 5,
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        formatDate1(snapshot
                                                            .data!
                                                            .chatMessages![
                                                                index1]
                                                            .date!),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                content: ListView.builder(
                                                    itemCount: snapshot
                                                        .data!
                                                        .chatMessages![index1]
                                                        .messages!
                                                        .length,
                                                    shrinkWrap: true,
                                                    reverse: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return _buildType(
                                                          index,
                                                          snapshot
                                                              .data!
                                                              .chatMessages![
                                                                  index1]
                                                              .messages![index]);
                                                    }),
                                              );
                                            });
                                  } else {
                                    return label("No Messages to show");
                                  }
                                }),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: widget.block == 1
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: globalTextField(
                                            controller: sendMessageController,
                                            onEditingComplete: () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      signUpPasswordFocusNode);
                                            },
                                            focusNode: signUpEmailIDFocusNode,
                                            // onEditingComplete: () {},
                                            hintText: 'Type Message',
                                            context: context,
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // openImagePickerGALLERY();
                                                    // getDocsFromLocal();
                                                    // pickAndSendFile();
                                                    // setState(() {
                                                    //   onTapbutton = !onTapbutton;
                                                    // });

                                                    chatimageselect();
                                                  },
                                                  child: Image.asset(
                                                    AppAsstes.pin,
                                                    scale: 3.5,
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.transparent
                                                        : AppColors.grey1,
                                                  ),
                                                ),
                                                sizeBoxWidth(5),
                                                GestureDetector(
                                                  onTap: () {
                                                    openImagePickerCAMERA();
                                                  },
                                                  child: Image.asset(
                                                    AppAsstes.camerachat,
                                                    scale: 3.5,
                                                    color: themeContro
                                                            .isLightMode.value
                                                        ? Colors.transparent
                                                        : AppColors.grey1,
                                                  ),
                                                ),
                                              ],
                                            ).paddingOnly(right: 13)),
                                      ),
                                      sizeBoxWidth(13),
                                      InkWell(
                                        onTap: () {
                                          (sendMessageController.text.isEmpty ||
                                                  sendMessageController.text
                                                      .trim()
                                                      .isEmpty)
                                              ? snackBar("Please type message")
                                              : addChatAPI();

                                          sendMessageController.clear();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.color0046AE,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              )),
                                          child: Image.asset(
                                            AppAsstes.share,
                                            height:
                                                getProportionateScreenHeight(
                                                    24),
                                            width:
                                                getProportionateScreenWidth(24),
                                          ).paddingSymmetric(
                                              horizontal: 13, vertical: 11),
                                        ).paddingOnly(top: 13),
                                      )
                                    ],
                                  ).paddingOnly(left: 14, right: 14, bottom: 15)
                                : InkWell(
                                    onTap: () {
                                      // blockApi();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          " This user is currently blocked and unavailable.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 13.5,
                                              color: Colors.white,
                                              fontFamily: 'Poppins'),
                                        )),
                                      ).paddingOnly(bottom: 15),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      // onTapbutton == true
                      //     ?
                      // Positioned(
                      //     bottom: 65, right: 80, child: chatimageselect())
                      // : const SizedBox.shrink(),
                      // AnimatedPositioned(
                      //   duration: const Duration(
                      //       milliseconds: 900), // Slower animation
                      //   curve: Curves.easeInOut, // Smooth transition
                      //   bottom: onTapbutton ? 65 : -100, // Move in only once
                      //   right: onTapbutton ? 80 : -100, // Fixed right position
                      //   child: onTapbutton
                      //       ? chatimageselect() // Display only when onTapbutton is true
                      //       : const SizedBox.shrink(), // Hide otherwise
                      // ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildType(int index, Messages data) {
    switch (data.type) {
      case "text":
        return getTextMessageType(index, data);
      case "image":
        return getIMAGEMessageType(index, data);
      case "doc":
        return getDOCMessageType(index, data);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget getTextMessageType(int index, Messages data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: data.message!));
          snackBar("Message copied");
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: data.fromUser.toString() != userID ? 12 : 12,
                    right: 12,
                    top: 0,
                    bottom: 0),
                child: Column(
                  children: [
                    Align(
                      alignment: (data.fromUser.toString() != userID
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Column(
                        crossAxisAlignment: data.fromUser.toString() != userID
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * .6),
                                decoration: BoxDecoration(
                                    borderRadius: data.fromUser.toString() !=
                                            userID
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15))
                                        : const BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                    gradient: data.fromUser.toString() != userID
                                        ? AppColors.oppositechat
                                        : AppColors.ownchat

                                    // data.fromUser.toString() !=
                                    //         SharedPrefs.getString(
                                    //             SharedPreferencesKey
                                    //                 .LOGGED_IN_USERID)
                                    //     ? Colors.grey.shade300
                                    //     : const Color.fromRGBO(176, 208, 255, 1),
                                    ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  data.message!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: data.fromUser.toString() != userID
                                          ? AppColors.black
                                          : AppColors.white),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                child: Text(
                                  convertUTCTimeTo12HourFormat(data.chatTime!),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget getIMAGEMessageType(int index, Messages data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: data.message!));
          snackBar("Message copied");
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: data.fromUser.toString() != userID ? 12 : 12,
                    right: 12,
                    top: 0,
                    bottom: 0),
                child: Column(
                  children: [
                    Align(
                      alignment: (data.fromUser.toString() != userID
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Column(
                        crossAxisAlignment: data.fromUser.toString() != userID
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              .6),
                                  decoration: BoxDecoration(
                                      borderRadius: data.fromUser.toString() !=
                                              userID
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15))
                                          : const BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                      gradient:
                                          data.fromUser.toString() != userID
                                              ? AppColors.oppositechat
                                              : AppColors.ownchat),
                                  padding: const EdgeInsets.all(4),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5.0, sigmaY: 5.0),
                                            child: AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              content: Container(
                                                height: 300,
                                                width: 400,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          data.url!,
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: data.fromUser
                                                    .toString() !=
                                                userID
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(0))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomRight: Radius.circular(0),
                                                bottomLeft:
                                                    Radius.circular(15)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: data.fromUser
                                                    .toString() !=
                                                userID
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(0))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomRight: Radius.circular(0),
                                                bottomLeft:
                                                    Radius.circular(15)),
                                        child: CachedNetworkImage(
                                          imageUrl: data.url!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return const CupertinoActivityIndicator();
                                          },
                                          errorWidget: (context, url, error) {
                                            return const Icon(
                                              Icons.error,
                                              size: 20,
                                              color: Colors.red,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                child: Text(
                                  convertUTCTimeTo12HourFormat(data.chatTime!),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget getDOCMessageType(int index, Messages data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: data.message!));
          snackBar("Message copied");
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: data.fromUser.toString() != userID ? 12 : 12,
                    right: 12,
                    top: 0,
                    bottom: 0),
                child: Column(
                  children: [
                    Align(
                      alignment: (data.fromUser.toString() != userID
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Column(
                        crossAxisAlignment: data.fromUser.toString() != userID
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              .6),
                                  decoration: BoxDecoration(
                                      borderRadius: data.fromUser.toString() !=
                                              userID
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15))
                                          : const BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                      gradient:
                                          data.fromUser.toString() != userID
                                              ? AppColors.oppositechat
                                              : AppColors.ownchat

                                      // data.fromUser.toString() !=
                                      //         SharedPrefs.getString(
                                      //             SharedPreferencesKey
                                      //                 .LOGGED_IN_USERID)
                                      //     ? Colors.grey.shade300
                                      //     : const Color.fromRGBO(176, 208, 255, 1),
                                      ),
                                  padding: const EdgeInsets.all(4),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => PDFViewerScreen(data.url!));
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: data.fromUser
                                                    .toString() !=
                                                userID
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12),
                                                bottomLeft: Radius.circular(0))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomRight: Radius.circular(0),
                                                bottomLeft:
                                                    Radius.circular(12)),
                                      ),
                                      child:

                                          // Text(
                                          //   extractFilename(data.url!).toString()
                                          //   // .split("-")
                                          //   // .last

                                          //   ,
                                          //   style: TextStyle(
                                          //       fontSize: 12,
                                          //       color: data.fromUser.toString() !=
                                          //               SharedPrefs.getString(
                                          //                   SharedPreferencesKey
                                          //                       .LOGGED_IN_USERID)
                                          //           ? AppColors.black
                                          //           : AppColors.white),
                                          // ),

                                          Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          width: 285,
                                          height: 36,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/pdf2.png',
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                extractFilename(data.url!)
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: data.fromUser
                                                              .toString() !=
                                                          userID
                                                      ? AppColors.black
                                                      : AppColors.black,
                                                ),
                                              ),
                                            ],
                                          ).paddingSymmetric(horizontal: 10),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                child: Text(
                                  convertUTCTimeTo12HourFormat(data.chatTime!),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  String extractFilename(String url) {
    // Extract the filename from the URL
    return url.split('/').last;
  }

  // String? extractFilename(String url) {
  //   // Extract the full filename from the URL
  //   String fullFilename = url.split('/').last;

  //   // Use a regular expression to remove any leading characters before the actual filename
  //   RegExp regExp = RegExp(r'\d+\.\w+$');
  //   RegExpMatch? match = regExp.firstMatch(fullFilename);
  //   if (match != null) {
  //     return match.group(0);
  //   } else {
  //     return fullFilename; // Return full filename if regex match fails
  //   }
  // }
  // addChatAPI() async {
  //   await messageController.addChatText(
  //     toUSerID: widget.toUserID,
  //     message: sendMessageController.text.isEmpty
  //         ? ""
  //         : sendMessageController.text.trim(),

  //   );
  //   _scrollToLastMessage();
  //   sendMessageController.text = '';
  // }

  final _picker = ImagePicker();
  String imagePath = "";
  Future<void> openImagePickerCAMERA() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;

        String fileName = imagePath.split('/').last;
        log("FILE NAEM ${fileName.split('.').last}");
        messageController.addChatText(
          imagePath, // Pass the image here
          toUSerID: widget.toUserID,
          message: sendMessageController.text.isEmpty
              ? ""
              : sendMessageController.text.trim(),
          type: "image", // Or another type based on your API requirement
        );
      });

      log("IMAGE PATH $imagePath");
      // imagePath = pickedImage.path as RxString;
    } else {
      //  Get.back();
    }
  }

  // Future<void> openImagePickerGALLERY() async {
  //   final XFile? pickedImage =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       imagePath = pickedImage.path;

  //       String fileName = imagePath.split('/').last;
  //       log("FILE NAEM ${fileName.split('.').last}");
  //       messageController.addChatText(
  //         imagePath, // Pass the image here
  //         toUSerID: widget.toUserID,
  //         message: sendMessageController.text.isEmpty
  //             ? ""
  //             : sendMessageController.text.trim(),
  //         type: "image", // Or another type based on your API requirement
  //       );
  //     });

  //     log("IMAGE PATH $imagePath");
  //     // imagePath = pickedImage.path as RxString;
  //   } else {
  //     //  Get.back();
  //   }
  // }

  // File? doc;
  // Future getDocsFromLocal() async {
  //   FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ["pdf", "doc", "docx", "png", "jpg", "jpeg", "webp"],
  //       allowCompression: true,
  //       allowMultiple: false);
  //   // final pickedFileV = await picker.getVideo(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       doc = File(pickedFile.files.single.path!);

  //       // print('file type =============== > file $image');

  //       messageController.addChatText(
  //         doc!.path, // Pass the image here
  //         toUSerID: widget.toUserID,
  //         message: sendMessageController.text.isEmpty
  //             ? ""
  //             : sendMessageController.text.trim(),
  //         type: "doc", // Or another type based on your API requirement
  //       );

  //       // print('Api Complete');
  //     } else {
  //       // print('No image selected.');
  //     }
  //   });
  // }

  // Future<void> pickAndSendFile() async {
  //   FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ["pdf", "doc", "docx", "png", "jpg", "jpeg", "webp"],
  //     allowCompression: true,
  //     allowMultiple: false,
  //   );

  //   if (pickedFile != null) {
  //     String filePath = pickedFile.files.single.path!;
  //     String fileName = filePath.split('/').last;
  //     String fileExtension = fileName.split('.').last.toLowerCase();

  //     // Determine the file type
  //     String fileType;
  //     if (["png", "jpg", "jpeg", "webp"].contains(fileExtension)) {
  //       fileType = "image";
  //     } else if (["pdf", "doc", "docx"].contains(fileExtension)) {
  //       fileType = "doc";
  //     } else {
  //       // Handle unsupported file types
  //       return;
  //     }

  //     // Pass the file to your messageController
  //     setState(() {
  //       messageController.addChatText(
  //         filePath, // Pass the file path here
  //         toUSerID: widget.toUserID,
  //         message: sendMessageController.text.isEmpty
  //             ? ""
  //             : sendMessageController.text.trim(),
  //         type: fileType, // Use the determined file type
  //       );
  //     });

  //     log("File selected: $filePath, Type: $fileType");
  //   } else {
  //     log("No file selected.");
  //   }
  // }

  Future<void> pickAndSendImage() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpg", "jpeg", "webp"],
      allowCompression: true,
      allowMultiple: false,
    );

    if (pickedFile != null) {
      String filePath = pickedFile.files.single.path!;
      String fileName = filePath.split('/').last;

      setState(() {
        messageController.addChatText(
          filePath, // Image file path
          toUSerID: widget.toUserID,
          message: sendMessageController.text.isEmpty
              ? ""
              : sendMessageController.text.trim(),
          type: "image", // File type as image
        );
      });

      log("Image selected: $filePath");
    } else {
      log("No image selected.");
    }
  }

  Future<void> pickAndSendDocument() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "doc", "docx"],
      allowCompression: true,
      allowMultiple: false,
    );

    if (pickedFile != null) {
      String filePath = pickedFile.files.single.path!;
      String fileName = filePath.split('/').last;

      setState(() {
        messageController.addChatText(
          filePath, // Document file path
          toUSerID: widget.toUserID,
          message: sendMessageController.text.isEmpty
              ? ""
              : sendMessageController.text.trim(),
          type: "doc", // File type as document
        );
      });

      log("Document selected: $filePath");
    } else {
      log("No document selected.");
    }
  }

  addChatAPI() async {
    await messageController.addChatText(
      null, // If there's no image, pass `null`
      toUSerID: widget.toUserID,
      message: sendMessageController.text.isEmpty
          ? ""
          : sendMessageController.text.trim(),
      type: "message", // Ensure the type is correct for a text message
    );
    sendMessageController.clear();
    _scrollToLastMessage();
    sendMessageController.text = '';
  }

  // File? selectedImages;
  // final picker = ImagePicker();

  // Future getImageFromCamera() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       selectedImages = File(pickedFile.path);
  //       print("$selectedImages");
  //       messageController.addChatText(
  //         selectedImages, // Pass the image here
  //         toUSerID: widget.toUserID,
  //         message: sendMessageController.text.isEmpty
  //             ? ""
  //             : sendMessageController.text.trim(),
  //         type: "image", // Or another type based on your API requirement
  //       );
  //     } else {
  //       print("No image selected");
  //     }
  //   });
  // }

  // Future getImageFromGallery() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       selectedImages = File(pickedFile.path);
  //       messageController.addChatText(
  //         selectedImages, // Pass the image here
  //         toUSerID: widget.toUserID,
  //         message: sendMessageController.text.isEmpty
  //             ? ""
  //             : sendMessageController.text.trim(),
  //         type: "image", // Or another type based on your API requirement
  //       );
  //     } else {
  //       print("No image selected");
  //     }
  //   });
  // }

  // Widget chatimageselect() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           pickAndSendImage();
  //           setState(() {
  //             onTapbutton = false; // Set onTapbutton to false
  //           });
  //         },
  //         child: Container(
  //           height: 70,
  //           width: 150,
  //           decoration: const BoxDecoration(
  //               color: AppColors.blue1,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(10),
  //                   topRight: Radius.circular(10))),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                       height: 35,
  //                       width: 35,
  //                       decoration: const BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         color: AppColors.blue,
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Image.asset('assets/images/gallery.png'),
  //                       )),
  //                   sizeBoxHeight(5),
  //                   label('Gallery',
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w400,
  //                       textColor: AppColors.brown)
  //                 ],
  //               ),
  //               sizeBoxWidth(20),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       pickAndSendDocument();
  //                       setState(() {
  //                         onTapbutton = false; // Set onTapbutton to false
  //                       });
  //                     },
  //                     child: Container(
  //                         height: 35,
  //                         width: 35,
  //                         decoration: const BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: AppColors.blue,
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Image.asset('assets/images/document.png'),
  //                         )),
  //                   ),
  //                   sizeBoxHeight(5),
  //                   label('Document',
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w400,
  //                       textColor: AppColors.brown)
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  chatimageselect() {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.bottomCenter,
            insetPadding:
                const EdgeInsets.only(bottom: 65, left: 10, right: 10),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,

            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10)),
            content: StatefulBuilder(builder: (context, kk) {
              return SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      pickAndSendImage();
                      Get.back();
                    },
                    child: Container(
                      height: 70,
                      width: 150,
                      decoration: const BoxDecoration(
                          color: AppColors.blue1,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                        'assets/images/gallery.png'),
                                  )),
                              sizeBoxHeight(5),
                              label('Gallery',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.brown)
                            ],
                          ),
                          sizeBoxWidth(20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pickAndSendDocument();
                                  Get.back();
                                },
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blue,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          'assets/images/document.png'),
                                    )),
                              ),
                              sizeBoxHeight(5),
                              label('Document',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.brown)
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
            }),
          );
        });
  }

  selectblock() {
    return Column(
      children: [
        sizeBoxHeight(20),
        Center(
          child: Text(
            widget.block == 1
                ? "Are you sure you want to \nBlock Account?"
                : "Are you sure you want to \nUnblock Account?",
            textAlign: TextAlign.center,
            style: poppinsFont(16, AppColors.greyColor, FontWeight.w500),
          ),
        ),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                  color: themeContro.isLightMode.value
                      ? Colors.white
                      : Colors.transparent,
                  border: Border.all(
                      color: themeContro.isLightMode.value
                          ? AppColors.blue
                          : AppColors.grey1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: label(
                    'Cancel',
                    fontSize: 14,
                    textColor: themeContro.isLightMode.value
                        ? Colors.black
                        : AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            sizeBoxWidth(30),
            widget.block == 1
                ? GestureDetector(
                    onTap: () {
                      blockcontro.BlockApi(oppsiteId: widget.toUserID);
                      setState(() {
                        widget.block = 0;
                      });
                      Get.back();
                    },
                    child: Container(
                      height: getProportionateScreenHeight(50),
                      width: getProportionateScreenWidth(150),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: label(
                          widget.block == 1 ? 'Block' : "Unblock",
                          fontSize: 14,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      blockcontro.UnBlockApi(oppsiteId: widget.toUserID);
                      setState(() {
                        widget.block = 1;
                      });
                      Get.back();
                    },
                    child: Container(
                      height: getProportionateScreenHeight(50),
                      width: getProportionateScreenWidth(150),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: label(
                          'UnBlock',
                          fontSize: 14,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  report() {
    return Obx(() {
      return reportcontro.isreport.value
          ? Center(
              child: CircularProgressIndicator(
              color: themeContro.isLightMode.value
                  ? Colors.transparent
                  : AppColors.blue,
            ))
          : Column(
              children: [
                sizeBoxHeight(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "why are you reporting this Post?",
                    textAlign: TextAlign.center,
                    style: poppinsFont(
                        12,
                        themeContro.isLightMode.value
                            ? AppColors.greyColor
                            : AppColors.white,
                        FontWeight.w600),
                  ),
                ).paddingSymmetric(horizontal: 20),
                sizeBoxHeight(10),
                reportcontro.reportlist.isNotEmpty
                    ? ListView.separated(
                        itemCount: reportcontro.reportlist.length,
                        shrinkWrap: true,
                        clipBehavior: Clip.antiAlias,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: themeContro.isLightMode.value
                                ? AppColors.colorE9E9E9
                                : Colors.grey.shade900,
                            height: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              reportcontro.ReportUserApi(
                                  reportoppsiteId: widget.toUserID,
                                  reportText: reportcontro
                                      .reportlist[index].text
                                      .toString());
                              Get.back();
                            },
                            child: label(
                                    reportcontro.reportlist[index].text
                                        .toString(),
                                    fontSize: 12,
                                    textColor: themeContro.isLightMode.value
                                        ? const Color.fromRGBO(58, 58, 58, 1)
                                        : AppColors.grey1,
                                    fontWeight: FontWeight.w600)
                                .paddingSymmetric(vertical: 10)
                                .paddingSymmetric(horizontal: 20),
                          );
                        })
                    : const Text('Report List Empty')
              ],
            );
    });
  }
}
