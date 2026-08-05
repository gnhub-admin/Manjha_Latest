import 'package:flutter/material.dart';
import 'package:manjha/screens/const.dart';

class NormalForm extends StatelessWidget {
  final IconData? icon;
  final String hint;
  final TextEditingController? controller;
  final TextCapitalization textInputStyle;
  final TextInputType? textInputType;
  final bool readOnly;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextStyle? customHintStyle;

  NormalForm(this.icon, this.hint,
      {this.controller,
      this.validator,
      this.onChanged,
      this.textInputStyle = TextCapitalization.sentences,
      this.textInputType = TextInputType.text,
      this.readOnly = false, this.customHintStyle,
      this.maxLength});

  NormalForm.plain(this.hint,
      {this.icon,
      this.controller,
      this.validator,
      this.onChanged,
      this.textInputStyle = TextCapitalization.sentences,
      this.textInputType,
      this.readOnly = false,
      this.maxLength, this.customHintStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textInputStyle,
      keyboardType: textInputType,
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      maxLength: maxLength,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: false,
      style: TextStyle(fontFamily: "nunito", fontWeight: FontWeight.w500, color: kgreyDark, fontSize: 15.5),
      decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.grey.shade100,
          counterText: "",
          prefixIcon: icon != null
              ? Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kwhite,
                  ),
                  child: Icon(
                    icon,
                    color: kheader,
                    size: 16,
                  ))
              : null,
          hintText: hint,
          hintStyle: customHintStyle != null ? customHintStyle : TextStyle(fontFamily: "nunito", fontWeight: FontWeight.w500, color: kgreyDivider, fontSize: 15.5),
          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 12.0),
          focusColor: Colors.grey.shade700,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
