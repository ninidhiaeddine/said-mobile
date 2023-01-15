import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/sign_up.dart';
import 'package:said/screens/user_navigator_parent.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              child: Text(AppLocalizations.of(context).signIn,
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
                      text: AppLocalizations.of(context).cntn,
                      context: context,
                      linkTo: const UserNavigatorParent()))),
          Padding(
              padding: const EdgeInsets.fromLTRB(64.0, 48.0, 64.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context).newHere),
                  const Padding(padding: EdgeInsets.all(2.0)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage())),
                    child: Text(AppLocalizations.of(context).createAccount,
                        style: primaryText()),
                  )
                ],
              ))
        ])));
  }
}
