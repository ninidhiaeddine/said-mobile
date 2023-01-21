import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/add_medication_page.dart';
import 'package:said/services/medication_service.dart';
import 'package:said/services/models/medication.dart';
import 'package:said/services/models/user.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/buttons/said_button.dart';
import 'package:said/widgets/misc/said_editable_med.dart';

class MedSetupPage extends StatefulWidget {
  const MedSetupPage({Key? key, required this.authenticatedUser})
      : super(key: key);

  final User authenticatedUser;

  @override
  State<MedSetupPage> createState() => _MedSetupPageState();
}

class _MedSetupPageState extends State<MedSetupPage> {
  late Future<List<Medication>> _medications;

  Future<void> _loadMedications() async {
    var userId = widget.authenticatedUser.id;
    _medications = MedicationService.getAllMedications(userId!);
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
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(AppLocalizations.of(context).setUpMeds,
                    style: subHeader()),
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                    child: FutureBuilder(
                        future: _medications,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return ListView(
                              children: snapshot.data!
                                  .map((e) => SaidEditableMed(
                                        medName: e.name,
                                        method: e.method.toString(),
                                        authenticatedStudent:
                                            widget.authenticatedUser,
                                      ))
                                  .toList(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(AppLocalizations.of(context).loading);
                          } else {
                            return Text(
                                AppLocalizations.of(context).noMedications);
                          }
                        })),
                const Padding(padding: EdgeInsets.all(8)),
                SaidButton(
                  text: AppLocalizations.of(context).addMedication,
                  context: context,
                  icon: const Icon(Icons.add_circle_outline),
                  linkTo: AddMedicationPage(
                      authenticatedUser: widget.authenticatedUser),
                )
              ],
            )),
      ),
    );
  }
}
