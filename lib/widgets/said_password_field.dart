import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidPasswordField extends StatefulWidget {
  const SaidPasswordField({super.key, this.placeholder = "Password"});

  final String placeholder;

  @override
  State<StatefulWidget> createState() => _SaidPasswordFieldState();
}

class _SaidPasswordFieldState extends State<SaidPasswordField> {
  String _value = "";
  bool _passwordVisible = false;

  final TextEditingController _controller = TextEditingController();

  void _updateValue(String newValue) {
    setState(() {
      _value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: _controller,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
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
