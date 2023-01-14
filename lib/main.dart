import 'package:flutter/material.dart';
import 'package:said/screens/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/theme.dart';

void main() {
  runApp(const SaidApp());
}

class SaidApp extends StatelessWidget {
  const SaidApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Said Ngo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: SaidTheme(),
      home: const HomePage(),
    );
  }
}
