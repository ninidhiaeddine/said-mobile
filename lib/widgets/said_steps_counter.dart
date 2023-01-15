import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';

class SaidStepsCounter extends StatefulWidget {
  const SaidStepsCounter({super.key});

  @override
  State<StatefulWidget> createState() => _SaidStepsCounterState();
}

class _SaidStepsCounterState extends State<SaidStepsCounter> {
  String _value = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: ColorConstants.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
    );
  }
}
