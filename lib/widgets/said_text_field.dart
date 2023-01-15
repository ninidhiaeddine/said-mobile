import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidTextField extends StatefulWidget {
  const SaidTextField({super.key, this.icon, this.placeholder = ""});

  final String placeholder;
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
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        fillColor: ColorConstants.textFieldColor,
        filled: true,
        hintText: widget.placeholder,
      ),
      onChanged: (newValue) {
        _updateValue(newValue);
      },
    );
  }
}
