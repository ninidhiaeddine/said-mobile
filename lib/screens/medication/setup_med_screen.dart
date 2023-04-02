import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/medication/add_medication_screen.dart';
import 'package:said/screens/refresh_screen_interface.dart';
import 'package:said/services/medication_service.dart';
import 'package:said/services/models/medication.dart';
import 'package:said/services/models/user.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';
import 'package:said/widgets/buttons/said_icon_back_button.dart';
import 'package:said/widgets/medication/said_editable_med.dart';

class SetupMedScreen extends StatefulWidget {
  const SetupMedScreen({Key? key, required this.authenticatedUser})
      : super(key: key);

  final User authenticatedUser;

  @override
  State<SetupMedScreen> createState() => _SetupMedScreenState();
}

class _SetupMedScreenState extends State<SetupMedScreen>
    implements RefreshScreenInterface {
  late Future<List<Medication>> _medications;

  Future<void> _loadMedications() async {
    var userId = widget.authenticatedUser.id;
    setState(() {
      _medications = MedicationService.getAllMedications(userId!);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:
              Text(AppLocalizations.of(context).setUpMeds, style: subHeader()),
          centerTitle: true,
          leading: const SaidIconBackButton()),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                    child: FutureBuilder(
                        future: _medications,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(AppLocalizations.of(context).loading);
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return ListView(
                              children: snapshot.data!
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: SaidEditableMed(
                                          medication: e,
                                          authenticatedUser:
                                              widget.authenticatedUser,
                                          onRefreshUser: onRefreshScreen,
                                        ),
                                      ))
                                  .toList(),
                            );
                          } else {
                            return Text(
                                AppLocalizations.of(context).noMedications);
                          }
                        })),
                const Padding(padding: EdgeInsets.all(8)),
                SaidPrimaryButton(
                  text: AppLocalizations.of(context).addMedication,
                  context: context,
                  icon: const Icon(Icons.add_circle_outline),
                  linkTo: AddMedicationScreen(
                    authenticatedUser: widget.authenticatedUser,
                    onRefreshScreen: onRefreshScreen,
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void onRefreshScreen(User updatedUser) {
    _loadMedications();
  }
}
