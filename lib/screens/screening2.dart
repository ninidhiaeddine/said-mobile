import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/screens/screening_good.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_button.dart';

class Screening2Page extends StatefulWidget {
  const Screening2Page({Key? key}) : super(key: key);

  @override
  State<Screening2Page> createState() => _Screening2PageState();
}

class _Screening2PageState extends State<Screening2Page> {
  final List<bool> _selections = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                Text(AppLocalizations.of(context).selfScreening,
                    style: subHeader()),
                const Padding(padding: EdgeInsets.all(32)),
                SizedBox(
                  width: double.infinity,
                  child: ToggleButtons(
                      isSelected: _selections,
                      direction: Axis.vertical,
                      onPressed: (index) {
                        setState(() {
                          _selections[index] = !_selections[index];
                        });
                      },
                      fillColor: ColorConstants.announcementColor,
                      selectedColor: ColorConstants.secondaryColor,
                      splashColor: ColorConstants.secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                      selectedBorderColor: ColorConstants.secondaryColor,
                      children: [
                        Text(AppLocalizations.of(context).stomachPain),
                        Text(AppLocalizations.of(context).weaknessAndFatigue),
                        Text(AppLocalizations.of(context).weightLoss),
                        Text(AppLocalizations.of(context).bloodStool),
                        Text(AppLocalizations.of(context)
                            .diarrheaOrConstipation),
                      ]),
                ),
                const Padding(padding: EdgeInsets.all(32)),
                SaidButton(
                  text: AppLocalizations.of(context).cntn,
                  context: context,
                  linkTo: const Screening3Page(),
                )
              ],
            ),
          ),
        ));
  }
}
