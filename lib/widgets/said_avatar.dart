import 'package:said/config/color_constants.dart';
import 'package:flutter/material.dart';

class SaidAvatar extends StatelessWidget {
  const SaidAvatar({super.key, this.networkImg, this.nameInitials, this.dimensions = 60});

  // TODO: show network image if available:

  final NetworkImage? networkImg;
  final String? nameInitials;
  final double dimensions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimensions,
      height: dimensions,
      decoration: const BoxDecoration(
        color: ColorConstants.secondaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          nameInitials!,
          style: TextStyle(
            fontSize: dimensions / 2,
              color: Colors.white),
        ),
      ),
    );
  }
}
