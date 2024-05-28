import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:premedico/controller/auth_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/model/message_model.dart';
import 'package:premedico/model/order_model.dart';
import 'package:premedico/model/user_model.dart';
import 'package:premedico/view/screens/video_call_screen.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_loading.dart';
import 'package:premedico/view/widget/rating_bottom_sheet.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen(
      {super.key, required this.userData, required this.orderData});
  final UserModel userData;
  final OrderModel orderData;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<ChatMessage> messages = [];
  bool typing = false, available = true;
  Timer? _debounce;

  checkAvailablity() {
    if (DateTime.now()
                .difference(DateTime.parse(widget.orderData.dateTime))
                .inHours >=
            0 &&
        DateTime.now()
                .difference(DateTime.parse(widget.orderData.dateTime))
                .inHours <
            3) {
      available = true;
    } else {
      available = false;
    }
  }

  pickImage() async {
    // String path = '';
    // List<Media> listImagePaths = await ImagePickers.pickerPaths(
    //   galleryMode: GalleryMode.image,
    //   selectCount: 1,
    //   showGif: false,
    // );

    // if (listImagePaths.isEmpty) return;

    // setState(() {
    //   path = listImagePaths.first.path!;
    // });

    // ChatMessage m = ChatMessage(
    //     medias: [ChatMedia(url: path, fileName: path, type: MediaType.image)],
    //     customProperties: {'file': true},
    //     user: ChatUser(id: auth.userData.uid),
    //     status: MessageStatus.sent,

    //     createdAt: Timestamp.now().toDate());

    // onSendTap(m);
  }

  updateRead() {
    // firestore
    //     .collection('users')
    //     .doc(widget.userData.uid)
    //     .collection('chats')
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .collection('messages')
    //     .get()
    //     .then((messages) {
    //   messages.docs.forEach((element) async {
    //     await firestore
    //         .collection('users')
    //         .doc(widget.userData.uid)
    //         .collection('chats')
    //         .doc(firebaseAuth.currentUser!.uid)
    //         .collection('messages')
    //         .doc(element.id)
    //         .update({'seen': true});
    //   });
    // });

    // firestore
    //     .collection('users')
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .collection('chats')
    //     .doc(widget.userData.uid)
    //     .update({'clicked': true});
  }

  changeStatus(x) async {
    // await firestore
    //     .collection('users')
    //     .doc(widget.userData.uid)
    //     .collection('chats')
    //     .doc(firebaseAuth.currentUser!.uid)
    //     .update({'typing': x});
  }

  void onTextChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    changeStatus(true);

    _debounce = Timer(const Duration(seconds: 1), () {
      changeStatus(false);
    });
  }

  onSendTap(
    ChatMessage message,
  ) {
    setState(() {
      messages.insert(0, message);
    });
    sendMessage(message);
  }

  sendMessage(ChatMessage message) async {
    String url = '', id = message.customProperties!['id'];
    bool text = message.text.isNotEmpty;
    await firestore
        .collection('users')
        .doc(Get.find<AuthController>().userData!.uid)
        .collection('chats')
        .doc(widget.userData.uid)
        .collection('messages')
        .doc(id)
        .set({
      'text': text ? message.text : url,
      'createdAt': FieldValue.serverTimestamp(),
      'authorId': Get.find<AuthController>().userData!.uid,
      'type': text ? 'text' : 'image',
      'seen': false
    });

    await firestore
        .collection('users')
        .doc(widget.userData.uid)
        .collection('chats')
        .doc(Get.find<AuthController>().userData!.uid)
        .collection('messages')
        .doc(id)
        .set({
      'text': text ? message.text : url,
      'createdAt': FieldValue.serverTimestamp(),
      'authorId': Get.find<AuthController>().userData!.uid,
      'type': text ? 'text' : 'image',
      'seen': false
    });

    firestore
        .collection('users')
        .doc(Get.find<AuthController>().userData!.uid)
        .collection('chats')
        .doc(widget.userData.uid)
        .set({
      'lastMessage': text ? message.text : 'image',
      'updatedAt': FieldValue.serverTimestamp(),
      'userData': widget.userData.toJson(),
      'orderData': widget.orderData.toJson(),
      'typing': false,
      'clicked': true
    });

    await firestore
        .collection('users')
        .doc(widget.userData.uid)
        .collection('chats')
        .doc(Get.find<AuthController>().userData!.uid)
        .set({
      'lastMessage': text ? message.text : 'image',
      'updatedAt': FieldValue.serverTimestamp(),
      'userData': Get.find<AuthController>().userData!.toJson(),
      'orderData': widget.orderData.toJson(),
      'typing': false,
      'clicked': false
    });
  }

  loadData(List<MessageModel> x) async {
    for (var element in x) {
      if (!messages
          .map((e) => e.customProperties!['id'])
          .contains(element.id)) {
        messages.insert(
            0,
            ChatMessage(
                // medias: [
                //   if (element.type != 'text')
                //     ChatMedia(
                //         url: element.text,
                //         fileName: '${element.id}.png',
                //         type: MediaType.image),
                // ],
                customProperties: {
                  'type': element.type,
                  'id': element.id,
                  'file': false
                },
                user: ChatUser(id: element.authorId),
                status: element.seen ? MessageStatus.read : MessageStatus.sent,
                text: element.type == 'text' ? element.text : '',
                createdAt: element.timestamp!.toDate()));
      }
    }

    updateRead();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  showMessage() async {
    await Future.delayed(const Duration(milliseconds: 10));
    Get.showSnackbar(GetSnackBar(
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      borderRadius: 10,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.white,
      boxShadows: const [
        BoxShadow(blurRadius: 5, spreadRadius: 0.1, color: Colors.black12)
      ],
      messageText: Text(
        available
            ? 'you_can_consult_your_problem_to_the_doctor'.tr
            : 'you_are_out_of_consultation_time'.tr,
        textAlign: TextAlign.center,
      ),
      titleText: Text(
        available ? 'consultion_start'.tr : 'sorry'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: appConstant.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      snackPosition: SnackPosition.TOP,
    ));
  }

  @override
  void initState() {
    showMessage();
    checkAvailablity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 50,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          if (available)
            IconButton(
                onPressed: () {
                  Get.to(() => VideoCallScreen(
                        userData: widget.userData,
                      ));
                },
                icon: const Icon(
                  Icons.phone,
                  color: Colors.black,
                )),
          if (DateTime.parse(widget.orderData.dateTime)
              .isBefore(DateTime.now()))
            if (widget.orderData.rate!.isEmpty)
              IconButton(
                  onPressed: () {
                    customBottomSheet(RatingBottomSheet(
                      orderData: widget.orderData,
                    ));
                  },
                  icon: const Icon(
                    Icons.star,
                    color: Colors.black,
                  ))
        ],
        title: Text(
          widget.userData.name!,
          style: const TextStyle(
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: firestore
              .collection('users')
              .doc(Get.find<AuthController>().userData!.uid)
              .collection('chats')
              .doc(widget.userData.uid)
              .collection('messages')
              .orderBy('createdAt')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> data = snapshot.data!.docs
                  .map((doc) => MessageModel.fromJson(doc.data(), doc.id))
                  .toList();

              loadData(data);

              return StreamBuilder(
                  stream: firestore
                      .collection('users')
                      .doc(Get.find<AuthController>().userData!.uid)
                      .collection('chats')
                      .doc(widget.userData.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data?.data();

                      if (data != null) {
                        typing = data['typing'];
                      }
                    }

                    return DashChat(
                      readOnly: !available,
                      typingUsers: [
                        if (typing)
                          ChatUser(
                            id: widget.userData.uid!,
                            firstName: widget.userData.name,
                          ),
                      ],
                      messageOptions: MessageOptions(
                        messageTimeBuilder: (message, isOwnMessage) =>
                            isOwnMessage
                                ? Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          DateFormat.jm()
                                              .format(message.createdAt),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        if (message.status ==
                                            MessageStatus.read)
                                          const Icon(
                                            Icons.done_all,
                                            color: Colors.white,
                                            size: 12,
                                          )
                                      ],
                                    ))
                                : Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                        DateFormat.jm()
                                            .format(message.createdAt),
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white)),
                                  ),
                        textColor: Colors.white,
                        bottom: (message, previousMessage, nextMessage) =>
                            message.text.isEmpty &&
                                    message.user.id ==
                                        Get.find<AuthController>().userData!.uid
                                ? Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat.jm()
                                              .format(message.createdAt),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        if (message.status ==
                                            MessageStatus.read)
                                          const Icon(
                                            Icons.done_all,
                                            color: Colors.green,
                                            size: 12,
                                          )
                                      ],
                                    ))
                                : Container(),
                        containerColor: appConstant.secondaryColor,
                        currentUserContainerColor: appConstant.primaryColor,
                        showOtherUsersName: false,
                        showOtherUsersAvatar: false,
                        showTime: true,
                        onLongPressMessage: (p0) {
                          Clipboard.setData(ClipboardData(text: p0.text));
                        },
                      ),
                      inputOptions: InputOptions(
                        cursorStyle:
                            CursorStyle(color: appConstant.primaryColor),
                        inputDecoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'type_message'.tr,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appConstant.primaryColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100))),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)))),
                        alwaysShowSend: true,
                        sendButtonBuilder: (send) => Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CustomButton(
                              onPressed: () {
                                send();
                              },
                              title: 'send',
                              width: 100,
                            ),
                          ),
                        ),
                        inputToolbarMargin: const EdgeInsets.only(top: 20),
                        inputToolbarPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        onTextChange: (value) {
                          Get.closeCurrentSnackbar();
                          onTextChanged();
                        },
                      ),
                      currentUser: ChatUser(
                          id: Get.find<AuthController>().userData!.uid!),
                      onSend: (ChatMessage m) {
                        ChatMessage x = ChatMessage(
                            text: m.text,
                            customProperties: {
                              'id': Timestamp.now()
                                  .millisecondsSinceEpoch
                                  .toString()
                            },
                            user: ChatUser(
                                id: Get.find<AuthController>().userData!.uid!),
                            status: MessageStatus.sent,
                            createdAt: Timestamp.now().toDate());
                        onSendTap(x);
                      },
                      messages: messages,
                    );
                  });
            }

            return const Center(child: CustomLoading());
          }),
    );
  }
}
