import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_text_field.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Text(AppLocalizations.of(context).educationContent,
                style: subHeader()),
            SaidTextField(
              placeholder: AppLocalizations.of(context).search,
              icon: const Icon(Icons.search),
            ),
          ],
        )));
  }
}
