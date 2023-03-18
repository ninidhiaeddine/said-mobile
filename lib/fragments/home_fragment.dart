import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/medication/setup_med_screen.dart';
import 'package:said/fragments/screening/screening_step1_fragment.dart';
import 'package:said/screens/screening/screening_screen.dart';
import 'package:said/services/medication_reminder_service.dart';
import 'package:said/services/models/medication_reminder.dart';
import 'package:said/services/models/user.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';
import 'package:said/widgets/misc/said_conditional_widget.dart';
import 'package:said/widgets/misc/said_screening_warning.dart';
import 'package:said/widgets/misc/said_steps_counter.dart';
import 'package:said/widgets/misc/said_upcoming_med.dart';
import 'package:said/widgets/misc/said_upcoming_med_text.dart';
import 'package:said/widgets/misc/said_user_bar.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key, required this.authenticatedUser});

  final User authenticatedUser;

  @override
  State<StatefulWidget> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  late Future<dynamic> _mustSeeDoctor;
  late Future<List<MedicationReminder>> _medicationReminders;

  @override
  void initState() {
    super.initState();
    _mustSeeDoctor = SaidSessionManager.getSessionValue("mustSeeDoctor");
    _medicationReminders =
        MedicationReminderService.getAllMedicationReminders(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Builder(builder: (context) {
              if (widget.authenticatedUser.firstName != null) {
                var fullName =
                    '${widget.authenticatedUser.firstName} ${widget.authenticatedUser.lastName}';
                return SaidUserBar(
                  userFullName: fullName,
                );
              } else {
                return SaidUserBar(
                  userFullName: widget.authenticatedUser.username,
                );
              }
            }),
            const Padding(padding: EdgeInsets.all(8.0)),
            const SaidUpcomingMedicationText(),
            const Padding(padding: EdgeInsets.all(8.0)),
            FutureBuilder(
                future: _mustSeeDoctor,
                builder: (context, snapshot) {
                  bool show = false;
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    show = snapshot.data as bool;
                  }
                  return SaidConditionalWidget(
                      widget: const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: SaidScreeningWarning(),
                      ),
                      condition: show);
                }),
            SaidStepsCounter(
              authenticatedUser: widget.authenticatedUser,
              stepsGoal: 8000,
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(AppLocalizations.of(context).actions,
                    style: subHeader())),
            const Padding(padding: EdgeInsets.all(4.0)),
            SaidPrimaryButton(
              text: AppLocalizations.of(context).setUpMeds,
              context: context,
              icon: const Icon(Icons.arrow_right_alt),
              linkTo:
                  SetupMedScreen(authenticatedUser: widget.authenticatedUser),
            ),
            SaidPrimaryButton(
                text: AppLocalizations.of(context).selfScreening,
                context: context,
                icon: const Icon(Icons.arrow_right_alt),
                linkTo: const ScreeningScreen()),
            const Padding(padding: EdgeInsets.all(8.0)),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(AppLocalizations.of(context).upcomingMedReminders,
                    style: subHeader())),
            const Padding(padding: EdgeInsets.all(4.0)),
            FutureBuilder(
                future: _medicationReminders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      children: snapshot.data!
                          .map((e) => Dismissible(
                              key: ValueKey<int>(e.hashCode),
                              child: SaidUpcomingMed(
                                  medName: e.medication.name,
                                  method: e.medication.method,
                                  timeOfTaking: e.dateTime)))
                          .toList(),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text(AppLocalizations.of(context).loading);
                  } else {
                    return Text(AppLocalizations.of(context).noReminders);
                  }
                }),
            const Padding(padding: EdgeInsets.all(8.0))
          ],
        ),
      ),
    )));
  }
}
