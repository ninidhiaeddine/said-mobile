import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidTextField extends StatelessWidget {
  const SaidTextField(
      {super.key,
      this.onChanged,
      this.text,
      this.prefixIcon,
      this.suffixIcon,
      this.placeholder = "",
      this.linesCount = 1,
      this.controller,
      this.textInputType = TextInputType.text,
      this.blackVariant = false});

  final Function(String)? onChanged;
  final String placeholder;
  final bool blackVariant;
  final int linesCount;
  final TextInputType textInputType;
  final String? text;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      style: blackVariant ? const TextStyle(color: Colors.white) : null,
      maxLines: linesCount,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor:
            blackVariant ? Colors.black : ColorConstants.textFieldColor,
        filled: true,
        hintText: placeholder,
        hintStyle:
            blackVariant ? const TextStyle(color: Colors.grey) : null,
      ),
      onChanged: (newValue) {
        onChanged!(newValue);
      },
    );
  }
}
