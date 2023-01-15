import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_social_media_bar.dart';
import 'package:said/widgets/said_text_field.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      backgroundColor: ColorConstants.secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Text(AppLocalizations.of(context).contactUs, style: subHeader()),
            SaidTextField(
              placeholder: AppLocalizations.of(context).message,
            ),
            SaidButton(
              text: AppLocalizations.of(context).send,
              context: context,
              icon: const Icon(Icons.send),
            ),
            const Padding(padding: EdgeInsets.all(32.0)),
            Row(
              children: [
                const Icon(Icons.location_pin),
                Text(AppLocalizations.of(context).saidLocation)
              ],
            ),
            Row(
              children: [
                const Icon(Icons.phone),
                Text(AppLocalizations.of(context).saidPhoneNumber)
              ],
            ),
            Row(
              children: [
                const Icon(Icons.email_rounded),
                Text(AppLocalizations.of(context).saidEmail)
              ],
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            Row(
              children: [
                Text(AppLocalizations.of(context).followUs),
                Text(AppLocalizations.of(context).socialMedia),
              ],
            ),
            SaidSocialMediaBar(),
          ],
        ),
      ),
    );
  }
}
