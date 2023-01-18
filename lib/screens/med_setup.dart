import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/screens/single_med_setup.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_editable_med.dart';

class MedSetupPage extends StatefulWidget {
  const MedSetupPage({Key? key}) : super(key: key);

  @override
  State<MedSetupPage> createState() => _MedSetupPageState();
}

class _MedSetupPageState extends State<MedSetupPage> {
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
                    child: SingleChildScrollView(
                        child: Column(
                  children: const [
                    SaidEditableMed(
                        medName: "Vitamin A", method: "Before Eating"),
                    SaidEditableMed(
                        medName: "Vitamin A", method: "Before Eating"),
                    SaidEditableMed(
                        medName: "Vitamin A", method: "Before Eating"),
                    SaidEditableMed(
                        medName: "Vitamin A", method: "Before Eating"),
                    SaidEditableMed(
                        medName: "Vitamin A", method: "Before Eating"),
                    SaidEditableMed(
                        medName: "Vitamin A", method: "Before Eating"),
                  ],
                ))),
                const Padding(padding: EdgeInsets.all(8)),
                SaidButton(
                  text: AppLocalizations.of(context).addMedication,
                  context: context,
                  icon: const Icon(Icons.add_circle_outline),
                  linkTo: const SingleMedSetupPage(),
                )
              ],
            )),
      ),
    );
  }
}
