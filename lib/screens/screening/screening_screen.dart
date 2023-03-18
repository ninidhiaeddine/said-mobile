import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:said/fragments/screening/screening_step1_fragment.dart';
import 'package:said/fragments/screening/screening_step2_fragment.dart';
import 'package:said/fragments/screening/step_interface.dart';

class ScreeningScreen extends StatefulWidget {
  const ScreeningScreen({Key? key}) : super(key: key);

  @override
  State<ScreeningScreen> createState() => _ScreeningScreenState();
}

class _ScreeningScreenState extends State<ScreeningScreen>
    implements StepInterface {
  static const numberOfSteps = 2;
  int _stepIndex = 0;
  late List<Widget> fragments;

  @override
  void onStepCancelled() {
    if (_stepIndex > 0) {
      setState(() {
        _stepIndex--;
      });
    }
  }

  @override
  void onStepFinished() {
    if (_stepIndex + 1 < numberOfSteps) {
      setState(() {
        _stepIndex++;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fragments = [
      ScreeningStep1Fragment(
        onStepCancelled: onStepCancelled,
        onStepFinished: onStepFinished,
      ),
      ScreeningStep2Fragment(
          onStepCancelled: onStepCancelled, onStepFinished: onStepFinished),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
            child: Column(
          children: [
            DotStepper(
              activeStep: _stepIndex,
              shape: Shape.squircle,
              dotRadius: 12,
              dotCount: numberOfSteps,
              spacing: 50,
              fixedDotDecoration: const FixedDotDecoration(color: Colors.black),
              indicatorDecoration: const IndicatorDecoration(
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: Colors.black),
              lineConnectorsEnabled: true,
              lineConnectorDecoration: const LineConnectorDecoration(
                  color: Colors.black, strokeWidth: 2),
              tappingEnabled: false,
            ),
            fragments.elementAt(_stepIndex)
          ],
        )));
  }
}
