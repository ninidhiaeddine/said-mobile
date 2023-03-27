import 'package:flutter/material.dart';
import 'package:said/config/app_constants.dart';

class SaidSecondaryButton extends StatelessWidget {
  const SaidSecondaryButton(
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
        return SizedBox(
            height: AppConstants.buttonHeight,
            child: ElevatedButton(
                onPressed: () => {
                      linkTo == null
                          ? onPressed!.call()
                          : Navigator.push(context, MaterialPageRoute(builder: (context) => linkTo!))
                    },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(text),
                  const SizedBox(
                    width: 5,
                  ),
                  icon!,
                ])));
      }
      return SizedBox(
          height: AppConstants.buttonHeight,
          child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.white),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(text),
                const SizedBox(
                  width: 5,
                ),
                icon!,
              ])));
    } else {
      if (enabled) {
        return SizedBox(
            height: AppConstants.buttonHeight,
            child: ElevatedButton(
                onPressed: () {
                  linkTo == null
                      ? onPressed!.call()
                      : Navigator.push(context, MaterialPageRoute(builder: (context) => linkTo!));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text)
                  ],
                )));
      }
      return SizedBox(
          height: AppConstants.buttonHeight,
          child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text)
                ],
              )));
    }
  }
}
