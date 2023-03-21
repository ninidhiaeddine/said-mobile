import 'package:flutter/material.dart';
import 'package:said/config/app_constants.dart';
import 'package:said/config/color_constants.dart';

class SaidOutlinedButton extends StatelessWidget {
  const SaidOutlinedButton(
      {super.key,
      required this.text,
      required this.context,
      this.icon,
      this.linkTo,
      this.onPressed});

  final String text;
  final BuildContext context;
  final Widget? icon;
  final Widget? linkTo;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return SizedBox(
          height: AppConstants.buttonHeight,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  foregroundColor: ColorConstants.accentColor,
                  side: const BorderSide(
                      color: ColorConstants.accentColor, width: 1.0)),
              onPressed: () => {
                    linkTo == null
                        ? onPressed!.call()
                        : Navigator.push(context,
                            MaterialPageRoute(builder: (context) => linkTo!))
                  },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(text),
                const SizedBox(
                  width: 5,
                ),
                icon!,
              ])));
    } else {
      return SizedBox(
          height: AppConstants.buttonHeight,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  foregroundColor: ColorConstants.accentColor,
                  side: const BorderSide(
                      color: ColorConstants.accentColor, width: 1.0)),
              onPressed: () => {
                    linkTo == null
                        ? onPressed!.call()
                        : Navigator.push(context,
                            MaterialPageRoute(builder: (context) => linkTo!))
                  },
              child: Text(text)));
    }
  }
}
