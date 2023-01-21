import 'package:flutter/material.dart';

class SaidFab extends StatelessWidget {
  const SaidFab(
      {Key? key,
      required this.dimensions,
      required this.backgroundColor,
      required this.icon,
      this.linkTo,
      this.onPressed,
      this.enabled = true})
      : super(key: key);

  final double dimensions;
  final Color backgroundColor;
  final Icon icon;
  final Widget? linkTo;
  final Function? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: dimensions,
        height: dimensions,
        child: FloatingActionButton(
            backgroundColor: backgroundColor,
            onPressed: !enabled ? null : () => {
                  linkTo == null
                      ? onPressed!.call()
                      : Navigator.push(context,
                          MaterialPageRoute(builder: (context) => linkTo!))
                },
            child: icon));
  }
}
