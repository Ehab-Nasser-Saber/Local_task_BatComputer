import 'package:flutter/material.dart';

import '../../core/color/colors.dart';

class CustomTextFieldForAuth extends StatelessWidget {
  const CustomTextFieldForAuth({
    Key? key,
    this.textEditingController,
    this.keyboardType,
    this.hintText,
    this.labelText,
  }) : super(key: key);
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final String? hintText, labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Container(
            decoration: BoxDecoration(
              color: lightBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                    controller: textEditingController,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: labelText,
                    )))));
  }
}
