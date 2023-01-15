import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Padding(
              padding: EdgeInsets.fromLTRB(90.0, 0.0, 90.0, 0.0),
              child: Image(image: AssetImage('assets/images/logo.png'))),
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(AppLocalizations.of(context).signUp,
                  style: blackHeader())),
          Padding(
              padding: const EdgeInsets.fromLTRB(64.0, 8.0, 64.0, 0.0),
              child: SaidTextField(
                placeholder: AppLocalizations.of(context).email,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 0.0),
              child: SaidTextField(
                placeholder: AppLocalizations.of(context).password,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 0.0),
              child: SizedBox(
                  width: double.infinity,
                  child: SaidButton(
                    text: AppLocalizations.of(context).signUp,
                    context: context,
                    onPressed: null,
                  ))),
        ])));
  }
}
