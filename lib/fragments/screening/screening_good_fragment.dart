import 'package:flutter/material.dart';
import 'package:said/screens/user_screen.dart';
import 'package:said/theme/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/widgets/buttons/said_button.dart';

class ScreeningGoodFragment extends StatelessWidget {
  const ScreeningGoodFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const Icon(
          Icons.check_circle,
          size: 40,
        ),
        const Padding(padding: EdgeInsets.all(8)),
        Text(
          AppLocalizations.of(context).screeningGoodBody,
          textAlign: TextAlign.center,
        ),
        const Padding(padding: EdgeInsets.all(32)),
        Text(
          AppLocalizations.of(context).screeningGoodTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        const Spacer(),
        SaidButton(
          text: AppLocalizations.of(context).goBackHome,
          context: context,
          icon: const Icon(Icons.home_outlined),
          linkTo: const UserScreen(),
        )
      ],
    ));
  }
}
