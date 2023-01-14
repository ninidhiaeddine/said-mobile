import 'package:flutter/material.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_steps_counter.dart';
import 'package:said/widgets/said_upcoming_med.dart';
import 'package:said/widgets/said_upcoming_med_text.dart';
import 'package:said/widgets/said_user_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SaidUserBar(),
          const SaidUpcomingMedicationText(),
          const SaidStepsCounter(),
          Text(AppLocalizations.of(context).actions, style: subHeader()),
          SaidButton(text: AppLocalizations.of(context).setUpMeds, context: context),
          SaidButton(text: AppLocalizations.of(context).selfScreening, context: context),
          Text(AppLocalizations.of(context).upcomingMedReminders, style: subHeader()),
          const SaidUpcomingMed(medName: "Vitamin A", method: "Before Eating")
        ],
      )
    );
  }
}
