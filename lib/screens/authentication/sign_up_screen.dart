import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/user_screen.dart';
import 'package:said/services/dtos/register.dart';
import 'package:said/services/register_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/navigator.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';
import 'package:said/widgets/misc/said_conditional_widget.dart';
import 'package:said/widgets/textfields/said_password_field.dart';
import 'package:said/widgets/textfields/said_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _usernameValue = "";
  String _emailValue = "";
  String _passwordValue = "";
  String _errorMsg = "";
  bool _signUpInProgress = false;

  Future<void> signUp(BuildContext context) async {
    // blocking semaphore:
    setState(() {
      _errorMsg = '';
      _signUpInProgress = true;
    });

    var registerDto = Register(
        username: _usernameValue, email: _emailValue, password: _passwordValue);
    var response = await RegisterService.register(registerDto);
    Map<String, dynamic> temp = jsonDecode(response.body);

    if (response.statusCode != 200) {
      // sign up failed:
      Map<String, dynamic> error = temp['error'];
      setState(() {
        _errorMsg = error['message'];
      });

      // release semaphore:
      setState(() {
        _signUpInProgress = false;
      });

      return;
    }
    // store session:
    SaidSessionManager.storeJwt(temp['jwt']);

    Map<String, dynamic> user = temp['user'];
    SaidSessionManager.storeUser(
        id: user['id'],
        username: user['username'],
        email: user['email']);

    // go to user home screen:
    if (!mounted) {
      return;
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserScreen()),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
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
                callback: (newValue, controller) => {
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
                callback: (newValue, controller) => {
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
              SaidConditionalWidget(
                  widget: Column(children: const [
                    Padding(padding: EdgeInsets.all(12)),
                    CircularProgressIndicator(),
                    Padding(padding: EdgeInsets.all(12)),
                  ]),
                  condition: _signUpInProgress),
              Text(_errorMsg,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
              SaidPrimaryButton(
                text: AppLocalizations.of(context).signUp,
                context: context,
                enabled: !_signUpInProgress,
                onPressed: () => signUp(context),
              ),
              const Padding(padding: EdgeInsets.all(24)),
            ]),
      ),
    )));
  }
}
