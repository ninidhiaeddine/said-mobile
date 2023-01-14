import 'package:flutter/widgets.dart';
import 'package:said/config/color_constants.dart';

class SaidUpcomingMed extends StatelessWidget {
  const SaidUpcomingMed(
      {super.key, required this.medName, required this.method});

  final String medName;
  final String method;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      color: ColorConstants.primaryColor
    );
  }
}
