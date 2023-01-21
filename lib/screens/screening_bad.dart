import 'package:flutter/material.dart';
import 'package:said/screens/user_navigator_parent.dart';
import 'package:said/theme/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_button.dart';

class ScreeningBadPage extends StatefulWidget {
  const ScreeningBadPage(
      {Key? key,
      required this.symptomsCount,
      required this.totalSymptomsCount,
      this.symptoms})
      : super(key: key);

  final List<String>? symptoms;
  final int symptomsCount;
  final int totalSymptomsCount;

  @override
  State<ScreeningBadPage> createState() => _ScreeningBadPageState();
}

class _ScreeningBadPageState extends State<ScreeningBadPage> {
  late double _probability;
  static const double threshold = 0.4;

  double _computeProbability() {
    return widget.symptomsCount / widget.totalSymptomsCount;
  }

  @override
  void initState() {
    super.initState();
    _probability = _computeProbability();

    // store screening status in local session storage:
    if (_probability >= threshold) {
      SaidSessionManager.storeScreeningStatus(true);
    } else {
      SaidSessionManager.storeScreeningStatus(false);
    }
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
                              widget.symptoms!.map((e) => Text("• $e")).toList()),
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
                        value: _probability,
                      ),
                    ),
                    Positioned(
                        top: 65,
                        left: 53,
                        child: Text(
                          "${(_probability * 100).toInt()}%",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 30),
                        )),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(16)),
                Text(
                  "${AppLocalizations.of(context).youHaveA} ${(_probability * 100).toInt()}% ${AppLocalizations.of(context).crcChances}",
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
