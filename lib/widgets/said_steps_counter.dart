import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:said/config/color_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/widgets/said_button.dart';

class SaidStepsCounter extends StatefulWidget {
  const SaidStepsCounter(
      {super.key, required this.stepsGoal});

  final int stepsGoal;

  @override
  State<StatefulWidget> createState() => _SaidStepsCounterState();
}

class _SaidStepsCounterState extends State<SaidStepsCounter> {
  late Stream<StepCount> _stepCountStream;
  late int _stepsDone;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    setState(() {
      _stepsDone = 0;
    });
  }

  void onStepCount(StepCount event) {
    /// Handle step count changed
    int steps = event.steps;
    DateTime timeStamp = event.timeStamp;

    setState(() {
      _stepsDone = steps;
    });
  }

  void onStepCountError(error) {
    /// Handle the error
  }

  Future<void> initPlatformState() async {
    /// Init stream
    _stepCountStream = await Pedometer.stepCountStream;

    /// Listen to stream and handle errors
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  double _computeProgressValue() {
    return _stepsDone / widget.stepsGoal;
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
            child: Text(_stepsDone.toString(),
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
                enabled: widget.stepsGoal <= _stepsDone))
      ]),
    );
  }
}
