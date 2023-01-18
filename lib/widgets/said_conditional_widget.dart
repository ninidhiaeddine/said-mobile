import 'package:flutter/material.dart';

class SaidConditionalWidget extends StatelessWidget {
  const SaidConditionalWidget({Key? key, required this.widget, required this.condition}) : super(key: key);

  final Widget widget;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return condition ? widget : Container();
  }
}
