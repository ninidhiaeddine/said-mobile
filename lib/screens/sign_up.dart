import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/api_constants.dart';
import 'package:said/screens/user_navigator_parent.dart';
import 'package:said/services/dtos/register.dart';
import 'package:said/services/register_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_password_field.dart';
import 'package:said/widgets/said_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _usernameValue = "";
  String _emailValue = "";
  String _passwordValue = "";

  Future<void> signUp() async {
    var registerDto = Register(
        username: _usernameValue, email: _emailValue, password: _passwordValue);
    var response = await RegisterService.register(registerDto);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
                  child: Image(image: AssetImage('assets/images/logo.png'))),
              const Padding(padding: EdgeInsets.all(24)),
              Text(AppLocalizations.of(context).signUp, style: blackHeader()),
              const Padding(padding: EdgeInsets.all(32)),
              SaidTextField(
                placeholder: AppLocalizations.of(context).username,
                textInputType: TextInputType.text,
                callback: (newValue) => {
                  setState(() {
                    _usernameValue = newValue;
                  })
                },
              ),
              const Padding(padding: EdgeInsets.all(8)),
              SaidTextField(
                placeholder: AppLocalizations.of(context).email,
                textInputType: TextInputType.emailAddress,
                suffixIcon: const Icon(Icons.email_rounded),
                callback: (newValue) => {
                  setState(() {
                    _emailValue = newValue;
                  })
                },
              ),
              const Padding(padding: EdgeInsets.all(8)),
              SaidPasswordField(
                callback: (newValue) => {
                  setState(() {
                    _passwordValue = newValue;
                  })
                },
              ),
              const Padding(padding: EdgeInsets.all(12)),
              SaidButton(
                text: AppLocalizations.of(context).signUp,
                context: context,
                onPressed: signUp,
              ),
              const Padding(padding: EdgeInsets.all(24)),
            ]),
      ),
    )));
  }
}
