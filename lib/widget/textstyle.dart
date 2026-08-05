import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/const.dart';

//ignore: must_be_immutable
class BoldText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final TextAlign? textAlign;
  bool isVeryBold = false;
  TextOverflow? overflow = TextOverflow.visible;

  BoldText(this.text, this.size, this.color, {this.overflow, this.textAlign});
  BoldText.veryBold(this.text, this.size, this.color, this.isVeryBold, {this.overflow, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: this.textAlign,
        overflow: this.overflow,
        softWrap: false,
        style: TextStyle(
            fontFamily: "nunito",
            fontWeight: isVeryBold ? FontWeight.w900 : FontWeight.w700,
            color: color,
            fontSize: size));
  }
}

class NormalText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final TextAlign textAlign;

  NormalText(this.text, this.color, this.size, {this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: this.textAlign,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: "nunito",
          fontWeight: FontWeight.w300,
          color: color,
          fontSize: size,
        ));
  }
}

class TextCustom extends StatelessWidget {
  final double size;
  final bool cancel;
  final String text;
  final FontWeight fonntweight;
  final Color color;
  final TextAlign textAlign;

  const TextCustom(this.text, this.color, this.size,
      {super.key, this.textAlign = TextAlign.left, this.fonntweight = FontWeight.w300, this.cancel = false});

  @override
  Widget build(BuildContext context) {
    return Text(text.tr,
        textAlign: textAlign,
        // overflow: TextOverflow.ellipsis,
        style: TextStyle(
          decoration: cancel ? TextDecoration.lineThrough : TextDecoration.none,
          fontFamily: "nunito",
          fontWeight: fonntweight,
          color: color,
          fontSize: size,
        ));
  }
}

class TextCustomRow extends StatelessWidget {
  final double size;
  final bool cancel;
  final String text;
  final FontWeight fonntweight;
  final Color color;
  final TextAlign textAlign;
  final String text2;

  const TextCustomRow(
    this.text,
    this.color,
    this.size, {
    super.key,
    this.textAlign = TextAlign.left,
    this.fonntweight = FontWeight.w300,
    this.cancel = false,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(text2,
            textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              decoration: cancel ? TextDecoration.lineThrough : TextDecoration.none,
              fontFamily: "nunito",
              fontWeight: FontWeight.w600,
              color: kblack,
              fontSize: size,
            )),
        Text(text,
            textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              decoration: cancel ? TextDecoration.lineThrough : TextDecoration.none,
              fontFamily: "nunito",
              fontWeight: FontWeight.w500,
              color: color,
              fontSize: size,
            )),
      ],
    );
  }
}
