import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidDropdown extends StatefulWidget {
  const SaidDropdown(
      {Key? key, this.callback, this.value, required this.placeholder, required this.options})
      : super(key: key);

  final Function(String?)? callback;
  final String placeholder;
  final String? value;
  final List<String> options;

  @override
  State<SaidDropdown> createState() => _SaidDropdownState();
}

class _SaidDropdownState extends State<SaidDropdown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: widget.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.textFieldColor,
          hintText: widget.placeholder,
        ),
        items: widget.options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (newValue) {
          widget.callback!(newValue);
        });
  }
}
