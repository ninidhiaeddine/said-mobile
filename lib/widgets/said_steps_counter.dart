import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';

class SaidStepsCounter extends StatefulWidget {
  const SaidStepsCounter(
      {super.key, this.stepsDone = 0, required this.stepsGoal});

  final int stepsDone;
  final int stepsGoal;

  @override
  State<StatefulWidget> createState() => _SaidStepsCounterState();
}

class _SaidStepsCounterState extends State<SaidStepsCounter> {
  double _computeProgressValue() {
    return widget.stepsDone / widget.stepsGoal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          color: ColorConstants.secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: _computeProgressValue(),
            strokeWidth: 20,
            color: ColorConstants.primaryColor,
            backgroundColor: const Color(0xff2d4385),
          ),
        ),
        Positioned(
            top: 110,
            child: Text(AppLocalizations.of(context).steps,
                style: const TextStyle(color: Colors.white, fontSize: 18))),
        Positioned(
            top: 130,
            child: Text(widget.stepsDone.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 34))),
        Positioned(
            top: 190,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).goal,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(widget.stepsGoal.toString(),
                    style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ],
            ))
      ]),
    );
  }
}
