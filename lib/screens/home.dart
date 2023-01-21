import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/sign_in.dart';
import 'package:said/screens/user_navigator_parent.dart';
import 'package:said/utils/navigator.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _checkLoggedInStatus() async {
    // check whether user is logged in:
    if (await SaidSessionManager.containsKey("isLoggedIn") &&
        await SaidSessionManager.getSessionValue("isLoggedIn")) {
      navigateToRoute(context, const UserNavigatorParent());
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
                  child: SaidButton(
                      text: AppLocalizations.of(context).getStarted,
                      context: context,
                      linkTo: const SignInPage())))
        ])));
  }
}
