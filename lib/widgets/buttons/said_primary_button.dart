import 'package:flutter/material.dart';
import 'package:said/utils/navigator.dart';

class SaidPrimaryButton extends StatelessWidget {
  const SaidPrimaryButton(
      {super.key,
      required this.text,
      required this.context,
      this.enabled = true,
      this.icon,
      this.linkTo,
      this.onPressed});

  final String text;
  final BuildContext context;
  final bool enabled;
  final Widget? icon;
  final Widget? linkTo;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      if (enabled) {
        return ElevatedButton(
            onPressed: () => {
                  linkTo == null ? onPressed!.call() : navigateToRoute(context, linkTo!)
                },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 5,
              ),
              icon!,
            ]));
      }
      return ElevatedButton(
          onPressed: null,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 5,
            ),
            icon!,
          ]));
    } else {
      if (enabled) {
        return ElevatedButton(
            onPressed: () {
                  linkTo == null ? onPressed!.call() : navigateToRoute(context, linkTo!);
                },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold))
              ],
            ));
      }
      return ElevatedButton(
          onPressed: null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold))
            ],
          ));
    }
  }
}
