import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Text(AppLocalizations.of(context).about, style: subHeader()),
              const Image(image: AssetImage('assets/images/logo.png')),
            ],
          ),
        ));
  }
}
