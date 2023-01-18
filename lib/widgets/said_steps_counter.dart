import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/widgets/said_button.dart';

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
      height: 350,
      decoration: const BoxDecoration(
          color: ColorConstants.secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Stack(alignment: Alignment.center, children: [
        Positioned(
            top: 50,
            child: SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: _computeProgressValue(),
                strokeWidth: 20,
                color: ColorConstants.primaryColor,
                backgroundColor: const Color(0xff2d4385),
              ),
            )),
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
                    style: const TextStyle(
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ],
            )),
        Positioned(
            bottom: 16,
            child: SaidButton(
                text: AppLocalizations.of(context).shareMilestone,
                context: context,
                icon: const Icon(Icons.star_purple500),
                enabled: widget.stepsGoal <= widget.stepsDone))
      ]),
    );
  }
}
