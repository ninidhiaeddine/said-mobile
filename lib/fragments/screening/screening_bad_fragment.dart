import 'package:flutter/material.dart';
import 'package:said/screens/user_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/utils/said_session_manager.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';

class ScreeningBadFragment extends StatefulWidget {
  const ScreeningBadFragment(
      {Key? key,
      required this.symptomsCount,
      required this.totalSymptomsCount,
      this.symptoms})
      : super(key: key);

  final List<String>? symptoms;
  final int symptomsCount;
  final int totalSymptomsCount;

  @override
  State<ScreeningBadFragment> createState() => _ScreeningBadFragmentState();
}

class _ScreeningBadFragmentState extends State<ScreeningBadFragment> {
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
    return Expanded(
        child: Column(
      children: [
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        const Padding(padding: EdgeInsets.all(16)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).yourResponses,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.symptoms!.map((e) => Text("• $e")).toList()),
          ],
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
        const Spacer(),
        SaidPrimaryButton(
          text: AppLocalizations.of(context).goBackHome,
          context: context,
          icon: const Icon(Icons.home_outlined),
          linkTo: const UserScreen(),
        )
      ],
    ));
  }
}
