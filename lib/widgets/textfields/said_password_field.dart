import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidPasswordField extends StatefulWidget {
  const SaidPasswordField({super.key, this.callback, this.placeholder = "Password"});

  final Function(String)? callback;
  final String placeholder;

  @override
  State<StatefulWidget> createState() => _SaidPasswordFieldState();
}

class _SaidPasswordFieldState extends State<SaidPasswordField> {
  bool _passwordVisible = false;

  final TextEditingController _controller = TextEditingController();

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
        widget.callback!(newValue);
      },
    );
  }
}
