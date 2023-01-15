import 'package:said/config/color_constants.dart';
import 'package:flutter/material.dart';

class SaidProfilePic extends StatelessWidget {
  const SaidProfilePic({super.key, this.networkImgSrc, this.nameInitials});

  final String? networkImgSrc;
  final String? nameInitials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: ColorConstants.secondaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          "JD",
          style: TextStyle(
            fontSize: 24,
              color: Colors.white),
        ),
      ),
    );
  }
}
