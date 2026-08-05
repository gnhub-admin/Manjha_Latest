import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../services/assets_manager.dart';
import 'text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? Colors.transparent : Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: CircleAvatar(
                      foregroundColor: Colors.black,
                      backgroundColor: cartbackgroundcolor,
                      backgroundImage: AssetImage(
                        chatIndex == 0
                            ? AssetsManager.userImage
                            : AssetsManager.botImage,
                      ),
                    ),
                  ),
                  // Image.asset(
                  //   chatIndex == 0
                  //       ? AssetsManager.userImage
                  //       : AssetsManager.botImage,
                  //   height: 30,
                  //   width: 30,
                  // ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: chatIndex == 0
                        ? TextWidget(
                            label: msg,
                            color: Colors.black,
                          )
                        : shouldAnimate
                            ? DefaultTextStyle(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                child: AnimatedTextKit(
                                    pause: const Duration(milliseconds: 0),
                                    isRepeatingAnimation: false,
                                    repeatForever: false,
                                    displayFullTextOnTap: true,
                                    totalRepeatCount: 0,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                          // speed = const Duration(milliseconds: 10)
                                          msg,
                                          speed:
                                              const Duration(milliseconds: 8)),
                                    ]),
                              )
                            : SelectableText(
                                msg.trim(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
