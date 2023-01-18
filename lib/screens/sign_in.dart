import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/sign_up.dart';
import 'package:said/screens/user_navigator_parent.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_password_field.dart';
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
            child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(48.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
                  child: Image(image: AssetImage('assets/images/logo.png'))),
              const Padding(padding: EdgeInsets.all(24)),
              Text(AppLocalizations.of(context).signIn, style: blackHeader()),
              const Padding(padding: EdgeInsets.all(32)),
              SaidTextField(
                placeholder: AppLocalizations.of(context).email,
                suffixIcon: Icon(Icons.email),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              const SaidPasswordField(),
              const Padding(padding: EdgeInsets.all(12)),
              SaidButton(
                  text: AppLocalizations.of(context).cntn,
                  context: context,
                  linkTo: const UserNavigatorParent()),
              const Padding(padding: EdgeInsets.all(24)),
              Row(
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
              )
            ]),
      ),
    )));
  }
}
