// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:nlytical_app/models/user_models/add_chat_model.dart';
import 'package:nlytical_app/models/user_models/chat_get_model.dart';
import 'package:nlytical_app/models/user_models/chat_list_model.dart';
import 'package:nlytical_app/models/user_models/online_model.dart';
import 'package:nlytical_app/utils/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:nlytical_app/utils/global.dart';

class ChatController extends GetxController {
  RxBool isChatListLoading = false.obs;
  Rx<ChatListModel?> chatmodel = ChatListModel().obs;
  StreamController<ChatListModel> streamController1 =
      StreamController<ChatListModel>.broadcast();

  StreamController<OnlineModel> streamControlleronline =
      StreamController<OnlineModel>.broadcast();
  // RxList<ChatList> chatlist = <ChatList>[].obs;
  RxInt chatlistIndex = (-1).obs;
  RxInt totalUnreadMessages = 0.obs;

  final ApiHelper apiHelper = ApiHelper();

  // @override
  // void dispose() {
  //   streamController.close();
  //   super.dispose();
  // }

  chatApi({String? xyz, required bool issearch}) async {
    isChatListLoading.value = true;
    print(xyz);
    try {
      var uri = Uri.parse(apiHelper.chatList);
      var request = http.MultipartRequest('POST', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] = userID;
      if (issearch) {
        request.fields['first_name'] = xyz!;
      }

      // request.headers.addAll(headers);
      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      chatmodel.value = ChatListModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");
      // chatlist.clear();

      if (chatmodel.value!.success == true) {
        streamController1.sink.add(chatmodel.value!);
        calculateTotalUnreadMessages();
        // chatlist.addAll(chatmodel.value!.chatList!);
        isChatListLoading.value = false;
      } else {
        isChatListLoading.value = false;
        print(chatmodel.value!.message);
      }
    } catch (e) {
      isChatListLoading.value = false;
    }
  }

  void calculateTotalUnreadMessages() {
    if (chatmodel.value?.chatList != null) {
      totalUnreadMessages.value = chatmodel.value!.chatList!.fold<int>(
        0,
        (sum, chat) => sum + (int.tryParse(chat.unreadMessage ?? '0') ?? 0),
      );
    } else {
      totalUnreadMessages.value = 0;
    }
  }

  // RxBool isgetLoading = false.obs;
  // Rx<GetMessageModel> getMessageModel = GetMessageModel().obs;
  // StreamController<GetMessageModel> streamController =
  //     StreamController<GetMessageModel>.broadcast();
  // chatgetApi({required String toUSerID}) async {
  //   isgetLoading.value = true;

  //   try {
  //     var uri = Uri.parse(apiHelper.innerChat);
  //     var request = http.MultipartRequest('POST', uri);

  //     Map<String, String> headers = {
  //       "Accept": "application/json",
  //       "Content-Type": "application/x-www-form-urlencoded",
  //     };

  //     request.headers.addAll(headers);

  //     request.fields['from_user'] = userID;

  //     request.fields['to_user'] = toUSerID;

  //     print("FROM_USER:${userID}");

  //     var response = await request.send();
  //     String responsData = await response.stream.transform(utf8.decoder).join();
  //     var userData = json.decode(responsData);

  //     getMessageModel.value = GetMessageModel.fromJson(userData);
  //     print(request.fields);
  //     print(responsData);
  //     print("status${response.statusCode}");
  //     print("/////// ${chatmodel.value!.success}");
  //     if (chatmodel.value!.success == true) {
  //       print("Inside success true");
  //       streamController.sink.add(getMessageModel.value);
  //       isgetLoading.value = false;
  //     } else {
  //       isgetLoading.value = false;
  //       print("MESSAGE${chatmodel.value!.message}");
  //     }
  //   } catch (e) {
  //     isgetLoading.value = false;
  //   }
  // }

  RxBool isgetLoading = false.obs;
  RxString isonlinestatus = ''.obs;
  Rx<GetMessageModel> getMessageModel = GetMessageModel().obs;
  StreamController<GetMessageModel> streamController =
      StreamController<GetMessageModel>.broadcast();

  chatgetApi({required String toUSerID}) async {
    isgetLoading.value = true;

    try {
      var uri = Uri.parse(apiHelper.innerChat);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      Map<String, String> body = {
        'from_user': userID,
        'to_user': toUSerID,
      };

      print("FROM_USER**: $userID");
      print("Request Fields: $body");

      // Make the POST request
      var response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var userData = json.decode(response.body);

        getMessageModel.value = GetMessageModel.fromJson(userData);

        print("Response Data: ${response.body}");
        print("Status Code: ${response.statusCode}");

        if (getMessageModel.value.success == true) {
          print("Inside success true");
          isonlinestatus.value =
              getMessageModel.value.toUserDetails!.status.toString();
          streamController.sink.add(getMessageModel.value);
        } else {
          print("MESSAGE: ${getMessageModel.value.message}");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isgetLoading.value = false;
    }
  }

  RxBool isSendMessage = false.obs;
  Rx<AddChatModel> addchatmodel = AddChatModel().obs;
  addChatText(
    image, {
    required String toUSerID,
    required String message,
    required String type,
  }) async {
    isSendMessage.value = true;

    try {
      var uri = Uri.parse(apiHelper.addChat);
      var request = http.MultipartRequest('POST', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['from_user'] = userID;

      request.fields['to_user'] = toUSerID;

      request.fields['message'] = message;

      request.fields['type'] = type;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('url', image));
      }

      print("FROM_USER:$userID");

      print("*******${request.files}");

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);

      addchatmodel.value = AddChatModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (chatmodel.value!.success == true) {
        isSendMessage.value = false;
      } else {
        isSendMessage.value = false;
        print(chatmodel.value!.message);
      }
    } catch (e) {
      isSendMessage.value = false;
    }
  }

  RxBool isonline = false.obs;

  Rx<OnlineModel> online = OnlineModel().obs;
  onlineuser({required String onlineStatus}) async {
    isonline.value = true;

    try {
      var uri = Uri.parse(apiHelper.useronline);
      var request = http.MultipartRequest('POST', uri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      request.headers.addAll(headers);

      request.fields['user_id'] = userID;

      request.fields['status'] = onlineStatus;

      print("FROM_USER:$userID");

      print("*******${request.files}");

      var response = await request.send();
      String responsData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responsData);
      online.value = OnlineModel.fromJson(userData);
      print(request.fields);
      print(responsData);
      print("status${response.statusCode}");

      if (online.value.status == true) {
        print("Inside success true");
        streamControlleronline.sink.add(online.value);
      } else {
        print("MESSAGE: ${online.value.message}");
      }

      // if (online.value.status == true) {
      //     print("Inside success true");
      //     streamController1.sink.add(online.value!);
      //   } else {
      //     print("MESSAGE: ${online.value.message}");
      //   }
    } catch (e) {
      isonline.value = false;
    }
  }
}
