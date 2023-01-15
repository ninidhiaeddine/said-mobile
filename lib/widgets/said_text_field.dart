import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidTextField extends StatefulWidget {
  const SaidTextField(
      {super.key, this.icon, this.placeholder = "", this.linesCount = 1, this.blackVariant = false});

  final String placeholder;
  final bool blackVariant;
  final int linesCount;
  final Icon? icon;

  @override
  State<StatefulWidget> createState() => _SaidTextFieldState();
}

class _SaidTextFieldState extends State<SaidTextField> {
  String _value = "";

  void _updateValue(String newValue) {
    setState(() {
      _value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: widget.blackVariant ? const TextStyle(color: Colors.white) : null,
      maxLines: widget.linesCount,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        fillColor:
            widget.blackVariant ? Colors.black : ColorConstants.textFieldColor,
        filled: true,
        hintText: widget.placeholder,
        hintStyle:
            widget.blackVariant ? const TextStyle(color: Colors.grey) : null,
      ),
      onChanged: (newValue) {
        _updateValue(newValue);
      },
    );
  }
}
