import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidTextField extends StatefulWidget {
  const SaidTextField(
      {super.key, this.callback, this.text, this.prefixIcon, this.suffixIcon, this.placeholder = "", this.linesCount = 1, this.textInputType = TextInputType.text, this.blackVariant = false});

  final Function(String, TextEditingController)? callback;
  final String placeholder;
  final bool blackVariant;
  final int linesCount;
  final TextInputType textInputType;
  final String? text;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  @override
  State<StatefulWidget> createState() => _SaidTextFieldState();
}

class _SaidTextFieldState extends State<SaidTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.text != null) {
      print("widget.text from initState() : ${widget.text}");
      _controller.text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: widget.textInputType,
      style: widget.blackVariant ? const TextStyle(color: Colors.white) : null,
      maxLines: widget.linesCount,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        fillColor:
            widget.blackVariant ? Colors.black : ColorConstants.textFieldColor,
        filled: true,
        hintText: widget.placeholder,
        hintStyle:
            widget.blackVariant ? const TextStyle(color: Colors.grey) : null,
      ),
      onChanged: (newValue) {
        widget.callback!(newValue, _controller);
      },
    );
  }
}
