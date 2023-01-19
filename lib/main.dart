import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/home.dart';
import 'package:said/theme/theme.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
      theme: saidTheme(),
      home: const HomePage(),
    );
  }
}
