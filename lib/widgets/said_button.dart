import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaidButton extends StatelessWidget {
  const SaidButton(
      {super.key,
      required this.text,
      required this.context,
      this.icon,
      this.linkTo,
      this.onPressed});

  final String text;
  final BuildContext context;
  final Icon? icon;
  final Widget? linkTo;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              linkTo == null
                  ? onPressed
                  : Navigator.push(
                      context, MaterialPageRoute(builder: (context) => linkTo!))
            },
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold)));
  }
}
