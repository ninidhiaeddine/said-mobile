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
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(AppLocalizations.of(context).contactUs,
                    style: subHeaderWhite()),
                const Padding(padding: EdgeInsets.all(16.0)),
                SaidTextField(
                  placeholder: AppLocalizations.of(context).message,
                  linesCount: 6,
                  blackVariant: true,
                ),
                const Padding(padding: EdgeInsets.all(4)),
                SaidButton(
                  text: AppLocalizations.of(context).send,
                  context: context,
                  icon: const Icon(Icons.send),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Padding(
                    padding: const EdgeInsets.all(60),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_pin, color: Colors.white),
                            const Padding(padding: EdgeInsets.all(6)),
                            Text(AppLocalizations.of(context).saidLocation,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))
                          ],
                        ),
                        const Padding(padding: EdgeInsets.all(4)),
                        Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.white),
                            const Padding(padding: EdgeInsets.all(6)),
                            Text(AppLocalizations.of(context).saidPhoneNumber,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))
                          ],
                        ),
                        const Padding(padding: EdgeInsets.all(4)),
                        Row(
                          children: [
                            const Icon(Icons.email_rounded,
                                color: Colors.white),
                            const Padding(padding: EdgeInsets.all(6)),
                            Text(AppLocalizations.of(context).saidEmail,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))
                          ],
                        ),
                      ],
                    )),
                const Padding(padding: EdgeInsets.all(2.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context).followUs,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                    const Padding(padding: EdgeInsets.all(2)),
                    Text(AppLocalizations.of(context).socialMedia,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primaryColor)),
                  ],
                ),
                SaidSocialMediaBar(),
              ],
            )),
      ),
    );
  }
}
