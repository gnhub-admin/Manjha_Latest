import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//=============================================================================
//===================Common TextField Login/Forgot Password====================

class CommonTextField extends StatefulWidget {
  CommonTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    required this.hintText,
    this.labelTextOption,
    this.inputFormatter,
    this.numberLength,
    this.maxLine,
    this.addValidation,
    this.onChange,
    this.suffixData,
    this.suffixDesign,
    this.initialData,
    this.inputAction,
  });

  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? labelTextOption;
  final List<TextInputFormatter>? inputFormatter;
  final int? numberLength;
  final int? maxLine;
  final addValidation;
  final onChange;
  final String? suffixData;
  final dynamic suffixDesign;
  final dynamic initialData;
  final dynamic inputAction;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool display = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Row(
            children: [
              Text(
                widget.labelText,
                textScaleFactor: 1.2,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.labelTextOption ?? "",
                textScaleFactor: 1.2,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          textAlign: TextAlign.start,
          cursorColor: Colors.black,
          textInputAction: widget.inputAction,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: widget.addValidation,
          onChanged: widget.onChange,
          initialValue: widget.initialData,
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).textScaleFactor * 12,
          ),
          inputFormatters: widget.inputFormatter,
          maxLength: widget.numberLength ?? 200,
          minLines: 1,
          maxLines: widget.maxLine ?? 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            hintText: widget.hintText,
            suffixText: widget.suffixData,
            suffix: widget.suffixDesign,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).textScaleFactor * 12,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5), width: 0.75),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.5), width: 0.75),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.withOpacity(0.5), width: 1.25),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.withOpacity(0.5), width: 1.25),
            ),
          ),
        ),
      ],
    );
  }
}
