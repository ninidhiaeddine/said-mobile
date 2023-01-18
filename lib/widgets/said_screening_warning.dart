import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_outlined_button.dart';

class SaidScreeningWarning extends StatelessWidget {
  const SaidScreeningWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.red, ColorConstants.primaryColor],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).screeningWarningTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.warning_amber,
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                AppLocalizations.of(context).screeningWarningBody,
              ),
              const Padding(padding: EdgeInsets.all(8)),
              SaidOutlinedButton(
                  text: AppLocalizations.of(context).updateRecords,
                  context: context)
            ],
          )),
    );
  }
}
