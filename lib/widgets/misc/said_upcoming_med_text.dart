import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaidUpcomingMedicationText extends StatelessWidget
{
  const SaidUpcomingMedicationText({super.key, this.medsCount = 0});
  
  final int medsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(AppLocalizations.of(context).youHave),
        const Padding(padding: EdgeInsets.all(2.0)),
        Text(medsCount.toString()),
        const Padding(padding: EdgeInsets.all(2.0)),
        Text(AppLocalizations.of(context).medsToTake)
      ],
    );
  }
  
  
}