import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/fragments/screening/screening_step1_fragment.dart';
import 'package:said/fragments/screening/screening_step2_fragment.dart';
import 'package:said/fragments/screening/step_interface.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_icon_back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: Text(AppLocalizations.of(context).selfScreening,
                style: subHeader()),
            centerTitle: true,
            leading: const SaidIconBackButton()),
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            DotStepper(
              activeStep: _stepIndex,
              shape: Shape.squircle,
              dotRadius: 12,
              dotCount: numberOfSteps,
              spacing: 50,
              fixedDotDecoration: const FixedDotDecoration(
                  color: ColorConstants.secondaryColor),
              indicatorDecoration: const IndicatorDecoration(
                  color: ColorConstants.backgroundColor,
                  strokeWidth: 2,
                  strokeColor: ColorConstants.secondaryColor),
              lineConnectorsEnabled: true,
              lineConnectorDecoration: const LineConnectorDecoration(
                  color: ColorConstants.secondaryColor, strokeWidth: 2),
              tappingEnabled: false,
            ),
            fragments.elementAt(_stepIndex)
          ],
        )));
  }
}
