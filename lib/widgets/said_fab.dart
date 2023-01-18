import 'package:flutter/material.dart';

class SaidFab extends StatelessWidget {
  const SaidFab(
      {Key? key, required this.dimensions, required this.backgroundColor, required this.icon, this.linkTo, this.onPressed})
      : super(key: key);

  final double dimensions;
  final Color backgroundColor;
  final Icon icon;
  final Widget? linkTo;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: dimensions,
        height: dimensions,
        child: FloatingActionButton(
            backgroundColor: backgroundColor,
            onPressed: () =>
            {
              linkTo == null
                  ? onPressed
                  : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => linkTo!))
            },
            child: icon
        ));
  }
}
