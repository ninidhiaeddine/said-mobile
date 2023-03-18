import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/screens/screening/screening_result_screen.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';

class ScreeningStep2Fragment extends StatefulWidget {
  const ScreeningStep2Fragment(
      {Key? key, required this.onStepCancelled, required this.onStepFinished})
      : super(key: key);

  final Function() onStepCancelled;
  final Function() onStepFinished;

  @override
  State<ScreeningStep2Fragment> createState() => _ScreeningStep2FragmentState();
}

class _ScreeningStep2FragmentState extends State<ScreeningStep2Fragment> {
  final List<bool> _selections = List.generate(5, (index) => false);

  int _getSelectionsCount() {
    return _selections.where((s) => s == true).length;
  }

  bool _determineGoodOrBad() {
    return _getSelectionsCount() == 0;
  }

  List<String> _getSelectedSymptoms(List<String> symptoms) {
    List<String> selectedSymptoms = [];
    for (var i = 0; i < _selections.length; i++) {
      if (_selections[i]) {
        selectedSymptoms.add(symptoms[i]);
      }
    }

    return selectedSymptoms;
  }

  @override
  Widget build(BuildContext context) {
    // init symptoms:
    final List<String> symptoms = [
      AppLocalizations.of(context).stomachPain,
      AppLocalizations.of(context).weaknessAndFatigue,
      AppLocalizations.of(context).weightLoss,
      AppLocalizations.of(context).bloodStool,
      AppLocalizations.of(context).diarrheaOrConstipation,
    ];

    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          Text(AppLocalizations.of(context).step2, style: subHeader()),
          const Padding(padding: EdgeInsets.all(32)),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.secondaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ToggleButtons(
                  isSelected: _selections,
                  direction: Axis.vertical,
                  onPressed: (index) {
                    setState(() {
                      _selections[index] = !_selections[index];
                    });
                  },
                  fillColor: ColorConstants.secondaryColor,
                  selectedColor: Colors.white,
                  splashColor: ColorConstants.secondaryColor,
                  renderBorder: false,
                  children: symptoms.map((e) => Text(e)).toList()),
            ),
          ),
          const Spacer(),
          SaidPrimaryButton(
            text: AppLocalizations.of(context).cntn,
            context: context,
            linkTo: ScreeningResultScreen(
                isPositive: _determineGoodOrBad(),
                symptoms: _getSelectedSymptoms(symptoms),
                symptomsCount: _getSelectionsCount(),
                totalSymptomsCount: _selections.length),
          )
        ],
      ),
    ));
  }
}
