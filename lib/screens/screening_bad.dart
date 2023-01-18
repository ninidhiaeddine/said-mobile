import 'package:flutter/material.dart';
import 'package:said/screens/user_navigator_parent.dart';
import 'package:said/theme/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/widgets/said_button.dart';

class ScreeningBadPage extends StatelessWidget {
  const ScreeningBadPage(
      {Key? key,
      required this.symptomsCount,
      required this.totalSymptomsCount,
      this.symptoms})
      : super(key: key);

  final List<String>? symptoms;
  final int symptomsCount;
  final int totalSymptomsCount;

  double _computeProbability() {
    return symptomsCount / totalSymptomsCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              children: [
                Text(AppLocalizations.of(context).response, style: subHeader()),
                const Padding(padding: EdgeInsets.all(24)),
                const Icon(
                  Icons.warning,
                  size: 40,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Text(
                  AppLocalizations.of(context).screeningBadBody,
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Text(
                  AppLocalizations.of(context).screeningBadTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const Padding(padding: EdgeInsets.all(16)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).yourResponses,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      Column(
                          children:
                              symptoms!.map((e) => Text("• $e")).toList()),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(16)),
                Stack(
                  children: [
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: CircularProgressIndicator(
                        strokeWidth: 12,
                        backgroundColor: Colors.white54,
                        value: _computeProbability(),
                      ),
                    ),
                    Positioned(
                        top: 65,
                        left: 53,
                        child: Text(
                          "${(_computeProbability() * 100).toInt()}%",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 30),
                        )),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(16)),
                Text(
                  "${AppLocalizations.of(context).youHaveA} ${(_computeProbability() * 100).toInt()}% ${AppLocalizations.of(context).crcChances}",
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                SaidButton(
                  text: AppLocalizations.of(context).goBackHome,
                  context: context,
                  icon: const Icon(Icons.home_outlined),
                  linkTo: const UserNavigatorParent(),
                )
              ],
            )),
      ),
    );
  }
}
