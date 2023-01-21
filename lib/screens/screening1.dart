import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/screening2.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_button.dart';

class Screening1Page extends StatelessWidget {
  const Screening1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Text(AppLocalizations.of(context).selfScreening, style: subHeader()),
                const Padding(padding: EdgeInsets.all(32)),
                const Icon(Icons.warning, size: 36),
                Text(AppLocalizations.of(context).warning,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Padding(padding: EdgeInsets.all(32)),
                Text(AppLocalizations.of(context).warningText, textAlign: TextAlign.justify,),
                const Padding(padding: EdgeInsets.all(32)),
                SaidButton(
                  text: AppLocalizations.of(context).proceed,
                  context: context,
                  linkTo: const Screening2Page(),
                )
              ],
            ),
          ),
        ));
  }
}
