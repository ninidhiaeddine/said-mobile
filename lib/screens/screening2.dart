import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/screens/screening_bad.dart';
import 'package:said/screens/screening_good.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';

class Screening2Page extends StatefulWidget {
  const Screening2Page({Key? key}) : super(key: key);

  @override
  State<Screening2Page> createState() => _Screening2PageState();
}

class _Screening2PageState extends State<Screening2Page> {
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

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                Text(AppLocalizations.of(context).selfScreening,
                    style: subHeader()),
                const Padding(padding: EdgeInsets.all(32)),
                SizedBox(
                  width: double.infinity,
                  child: ToggleButtons(
                      isSelected: _selections,
                      direction: Axis.vertical,
                      onPressed: (index) {
                        setState(() {
                          _selections[index] = !_selections[index];
                        });
                      },
                      fillColor: ColorConstants.announcementColor,
                      selectedColor: ColorConstants.secondaryColor,
                      splashColor: ColorConstants.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                      selectedBorderColor: ColorConstants.secondaryColor,
                      children: symptoms.map((e) => Text(e)).toList()),
                ),
                const Padding(padding: EdgeInsets.all(32)),
                SaidButton(
                  text: AppLocalizations.of(context).cntn,
                  context: context,
                  linkTo: _determineGoodOrBad()
                      ? const ScreeningGoodPage()
                      : ScreeningBadPage(
                          symptoms: _getSelectedSymptoms(symptoms),
                          symptomsCount: _getSelectionsCount(),
                          totalSymptomsCount: _selections.length),
                )
              ],
            ),
          ),
        ));
  }
}
