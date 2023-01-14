import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaidTextField extends StatefulWidget {
  const SaidTextField({super.key, this.placeholder = ""});

  final String placeholder;

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
        fillColor: const Color(0xffcbd0df),
        filled: true,
        hintText: widget.placeholder,
      ),
      onChanged: (newValue) {
        _updateValue(newValue);
      },
    );
  }
}
