import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidDropdown extends StatefulWidget {
  const SaidDropdown(
      {Key? key, required this.placeholder, required this.options})
      : super(key: key);

  final String placeholder;
  final List<String> options;

  @override
  State<SaidDropdown> createState() => _SaidDropdownState();
}

class _SaidDropdownState extends State<SaidDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.textFieldColor,
          hintText: widget.placeholder,
        ),
        items: widget.options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {});
  }
}
