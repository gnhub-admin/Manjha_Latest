import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../const.dart';
import '../providers/chats_provider.dart';
import '../providers/models_provider.dart';
import '../services/services.dart';
import '../widgets/chat_widget.dart';
import '../widgets/text_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatGPTScreen extends StatefulWidget {
  const ChatGPTScreen({super.key});

  @override
  State<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  bool _isTyping = false;

  TextEditingController textEditingController = TextEditingController();
  ScrollController _listScrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    chatController.addListener(_scrollToBottom);
    super.initState();
  }

  final ChatController chatController = Get.put(ChatController());
  final ModelsController modelsController = Get.put(ModelsController());

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_listScrollController.hasClients) {
        _listScrollController.animateTo(
          _listScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    chatController.removeListener(_scrollToBottom);
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    // final modelsProvider = Provider.of<ModelsController>(context);
    // final chatProvider = Provider.of<ChatController>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.light,
      // systemNavigationBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      // backgroundColor: scaffoldBackgroundColor,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kblack),
        // backgroundColor: cardColor,
        backgroundColor: kwhite,
        elevation: 0,
        // leading: const Icon(
        //   Icons.menu_rounded,
        //   color: Colors.white,
        // ),
        title: const Text(
          "ChatGPT",
          style: TextStyle(
              color: kblack, fontWeight: FontWeight.w600, fontSize: 25),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Card(
                elevation: 0,
                // margin: EdgeInsets.symmetric(vertical: 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    // color: Color(0xffD1D3D5),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    focusNode: focusNode,
                    style: const TextStyle(color: Colors.black),
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSubmitted: (value) async {
                      await sendMessageFCT(
                          // modelsProvider: modelsProvider,
                          // chatProvider: chatProvider
                          );
                    },
                    decoration: InputDecoration(
                      hintText: "Message ChatGPT",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      suffixIcon: Container(
                        height: 20,
                        width: 20,
                        padding: EdgeInsets.only(left: 0),
                        decoration: BoxDecoration(
                          color: textEditingController.text.isEmpty
                              ? Colors.black.withOpacity(0.25)
                              : Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                              constraints:
                                  BoxConstraints(maxHeight: 20, maxWidth: 20),
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              onPressed: () async {
                                await sendMessageFCT(
                                    // modelsProvider: modelsProvider,
                                    // chatProvider: chatProvider
                                    );
                              },
                              icon: Icon(
                                Icons.arrow_upward_rounded,
                                // color: textEditingController.text.isEmpty ? Colors.white.withOpacity(0.1) : Colors.white,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    // decoration: InputDecoration(
                    //   suffix: Container(
                    //     // width: 50,
                    //     height: 15,
                    //     child: IconButton(
                    //       splashColor: Colors.transparent,
                    //       highlightColor: Colors.transparent,
                    //       padding: EdgeInsets.zero,
                    //       onPressed: () async {
                    //
                    //       },
                    //       icon: Icon(
                    //         CupertinoIcons.location,
                    //         size: 18,color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    //   // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    //   hintText: '${translate("Write your message...")}',
                    //   hintStyle: TextStyle(color: Colors.grey),
                    //   border: InputBorder.none,
                    // ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount:
                      chatController.getChatList.length, //chatList.length,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatController
                          .getChatList[index].msg, // chatList[index].msg,
                      chatIndex: chatController.getChatList[index]
                          .chatIndex, //chatList[index].chatIndex,
                      shouldAnimate:
                          chatController.getChatList.length - 1 == index,
                    );
                  }),
            ),
          ),
          if (_isTyping) ...[
            LoadingAnimationWidget.waveDots(color: Colors.white, size: 30)
            // const SpinKitThreeBounce(
            //   color: Colors.white,
            //   size: 18,
            // ),
          ],
          const SizedBox(
            height: 70,
          ),
          // Material(
          //   color: cardColor,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: TextField(
          //             focusNode: focusNode,
          //             style: const TextStyle(color: Colors.white),
          //             controller: textEditingController,
          //             onChanged: (value) {
          //               setState(() {});
          //             },
          //             onSubmitted: (value) async {
          //               await sendMessageFCT(
          //                   // modelsProvider: modelsProvider,
          //                   // chatProvider: chatProvider
          //               );
          //             },
          //             decoration: const InputDecoration.collapsed(
          //                 hintText: "Message ChatGPT",
          //                 hintStyle: TextStyle(color: Colors.grey)),
          //           ),
          //         ),
          //         Container(
          //           padding: EdgeInsets.only(left: 0),
          //           decoration: BoxDecoration(
          //             color: textEditingController.text.isEmpty ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.25),
          //             shape: BoxShape.circle,
          //           ),
          //           child: Center(
          //             child: IconButton(
          //               alignment: Alignment.center,
          //                 onPressed: () async {
          //                   await sendMessageFCT(
          //                       // modelsProvider: modelsProvider,
          //                       // chatProvider: chatProvider
          //                   );
          //                 },
          //                 icon: Icon(
          //                   Icons.arrow_upward_rounded,
          //                   color: textEditingController.text.isEmpty ? Colors.white.withOpacity(0.1) : Colors.white,
          //                 )),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT() async {
    final ChatController chatController = Get.find<ChatController>();
    final ModelsController modelsController = Get.find<ModelsController>();

    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You can't send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatController.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatController.sendMessageAndGetAnswers(
        msg: msg,
        chosenModelId: modelsController.getCurrentModel,
      );
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: error.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
