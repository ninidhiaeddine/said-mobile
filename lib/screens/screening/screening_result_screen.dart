import 'package:flutter/material.dart';
import 'package:said/fragments/screening/screening_bad_fragment.dart';
import 'package:said/fragments/screening/screening_good_fragment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';

class ScreeningResultScreen extends StatelessWidget {
  const ScreeningResultScreen(
      {Key? key,
      required this.isPositive,
      required this.symptoms,
      required this.symptomsCount,
      required this.totalSymptomsCount})
      : super(key: key);

  final bool isPositive;
  final List<String> symptoms;
  final int symptomsCount;
  final int totalSymptomsCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(48),
                child: Column(children: [
                  Text(AppLocalizations.of(context).response,
                      style: subHeader()),
                  const Padding(padding: EdgeInsets.all(24)),
                  isPositive
                      ? const ScreeningGoodFragment()
                      : ScreeningBadFragment(
                          symptoms: symptoms,
                          symptomsCount: symptomsCount,
                          totalSymptomsCount: totalSymptomsCount)
                ]))));
  }
}
