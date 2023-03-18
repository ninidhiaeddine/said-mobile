import 'package:flutter/material.dart';
import 'package:said/fragments/screening/screening_bad_fragment.dart';
import 'package:said/fragments/screening/screening_good_fragment.dart';

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
    if (isPositive) {
      return const ScreeningGoodFragment();
    } else {
      return ScreeningBadFragment(
          symptomsCount: symptomsCount, totalSymptomsCount: totalSymptomsCount);
    }
  }
}
