import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/authentication/sign_up_screen.dart';
import 'package:said/screens/user_screen.dart';
import 'package:said/services/auth_service.dart';
import 'package:said/services/dtos/auth.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';
import 'package:said/widgets/misc/said_conditional_widget.dart';
import 'package:said/widgets/textfields/said_password_field.dart';
import 'package:said/widgets/textfields/said_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _emailValue = "";
  String _passwordValue = "";
  String _errorMsg = "";
  bool _signInInProgress = false;

  Future<void> storeUserInSession(Map<String, dynamic> data) async {
    await SaidSessionManager.storeJwt(data['jwt']);

    Map<String, dynamic> user = data['user'];
    await SaidSessionManager.storeUser(
        id: user['id'],
        username: user['username'],
        email: user['email'],
        firstName: user['firstName'],
        lastName: user['lastName'],
        phoneNumber: user['phoneNumber'],
        sex: user['sex'],
        age: user['age']);
  }

  Future<void> signIn(BuildContext context) async {
    // blocking semaphore:
    setState(() {
      _errorMsg = '';
      _signInInProgress = true;
    });

    var authDto = Auth(identifier: _emailValue, password: _passwordValue);
    var response = await AuthService.authenticate(authDto);
    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      // sign up failed:
      Map<String, dynamic> error = data['error'];
      setState(() {
        _errorMsg = error['message'];
      });

      // release semaphore:
      setState(() {
        _signInInProgress = false;
      });

      return;
    }
    // store session:
    await storeUserInSession(data);

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
              Text(AppLocalizations.of(context).signIn, style: blackHeader()),
              const Padding(padding: EdgeInsets.all(32)),
              SaidTextField(
                  placeholder: AppLocalizations.of(context).email,
                  suffixIcon: const Icon(Icons.email),
                  onChanged: (newValue) => {
                        setState(() {
                          _emailValue = newValue;
                        })
                      }),
              const Padding(padding: EdgeInsets.all(8)),
              SaidPasswordField(
                  callback: (newValue) => {
                        setState(() {
                          _passwordValue = newValue;
                        })
                      }),
              const Padding(padding: EdgeInsets.all(12)),
              SaidConditionalWidget(
                  widget: Column(children: const [
                    Padding(padding: EdgeInsets.all(12)),
                    CircularProgressIndicator(),
                    Padding(padding: EdgeInsets.all(12)),
                  ]),
                  condition: _signInInProgress),
              Text(_errorMsg,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
              SaidPrimaryButton(
                  text: AppLocalizations.of(context).cntn,
                  context: context,
                  onPressed: () => signIn(context)),
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
                            builder: (context) => const SignUpScreen())),
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
