import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_button.dart';

class ScreeningStep1Fragment extends StatelessWidget {
  const ScreeningStep1Fragment(
      {Key? key, required this.onStepCancelled, required this.onStepFinished})
      : super(key: key);

  final Function() onStepCancelled;
  final Function() onStepFinished;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        children: [
          Text(AppLocalizations.of(context).selfScreening, style: subHeader()),
          const Padding(padding: EdgeInsets.all(32)),
          const Icon(Icons.warning, size: 36),
          Text(AppLocalizations.of(context).warning,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Padding(padding: EdgeInsets.all(32)),
          Text(
            AppLocalizations.of(context).warningText,
            textAlign: TextAlign.justify,
          ),
          const Spacer(),
          SaidButton(
            text: AppLocalizations.of(context).proceed,
            context: context,
            onPressed: onStepFinished,
          )
        ],
      ),
    ));
  }
}
