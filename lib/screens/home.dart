import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          const Padding(
              padding: EdgeInsets.all(32.0),
              child: Image(image: AssetImage('assets/images/logo.png'))),
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context).welcomeMsg))),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context).getStarted))))
        ]));
  }
}
