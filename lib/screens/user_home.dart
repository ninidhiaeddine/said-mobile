import 'package:flutter/material.dart';
import 'package:said/screens/med_setup.dart';
import 'package:said/screens/screening1.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/user_service.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_conditional_widget.dart';
import 'package:said/widgets/said_screening_warning.dart';
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
  late User _user;

  Future<void> _loadUser() async {
    // get user id:
    int userId = await SaidSessionManager.getSessionValue('id');

    // get user from API service:
    _user = await UserService.getUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      children: [
        FutureBuilder(future: _loadUser(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SaidUserBar(
              userFullName: _user.username,
            );
          } else {
            return const SaidUserBar(
              userFullName: "Unknown User",
            );
          }
        }),
        const SaidUpcomingMedicationText(),
        const Padding(padding: EdgeInsets.all(8.0)),
        const SaidConditionalWidget(
            widget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SaidScreeningWarning()),
            condition: true),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SaidStepsCounter(
              stepsGoal: 8000,
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppLocalizations.of(context).actions, style: subHeader()),
              const Padding(padding: EdgeInsets.all(4.0)),
              SaidButton(
                text: AppLocalizations.of(context).setUpMeds,
                context: context,
                icon: const Icon(Icons.arrow_right_alt),
                linkTo: const MedSetupPage(),
              ),
              SaidButton(
                  text: AppLocalizations.of(context).selfScreening,
                  context: context,
                  icon: const Icon(Icons.arrow_right_alt),
                  linkTo: const Screening1Page()),
            ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppLocalizations.of(context).upcomingMedReminders,
                  style: subHeader()),
              const Padding(padding: EdgeInsets.all(4.0)),
              const SaidUpcomingMed(
                  medName: "Vitamin A", method: "Before Eating"),
              const SaidUpcomingMed(
                  medName: "Vitamin A", method: "Before Eating"),
            ])),
      ],
    ))));
  }
}
