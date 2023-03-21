import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/authentication/sign_in_screen.dart';
import 'package:said/screens/user_screen.dart';
import 'package:said/utils/navigator.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  Future<void> _checkLoggedInStatus() async {
    // check whether user is logged in:
    if (await SaidSessionManager.containsKey("isLoggedIn") &&
        await SaidSessionManager.getSessionValue("isLoggedIn")) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const UserScreen()),
              (route) => false);
    }
  }

  @override
  initState() {
    super.initState();
    _checkLoggedInStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Padding(
              padding: EdgeInsets.all(32.0),
              child: Image(image: AssetImage('assets/images/logo.png'))),
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(AppLocalizations.of(context).welcomeMsg,
                  textAlign: TextAlign.center)),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  width: 200,
                  child: SaidPrimaryButton(
                      text: AppLocalizations.of(context).getStarted,
                      context: context,
                      linkTo: const SignInScreen())))
        ])));
  }
}
