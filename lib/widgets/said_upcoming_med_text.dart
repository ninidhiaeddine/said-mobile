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
        Text(medsCount),
        Text(AppLocalizations.of(context).youHave)
      ],
    );
  }
  
  
}