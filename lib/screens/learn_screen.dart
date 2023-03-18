import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/expansion_panel_generator.dart';
import 'package:said/widgets/buttons/said_icon_back_button.dart';
import 'package:said/widgets/textFields/said_text_field.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final List<bool> _isOpen = List.generate(10, (index) => false);
  final List<bool> _nestedIsOpen = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    // prepare titles:
    final List<String> titles = [
      AppLocalizations.of(context).whatIsCrcTitle,
      AppLocalizations.of(context).symptomsOfCrcTitle,
      AppLocalizations.of(context).riskTitle,
      AppLocalizations.of(context).screeningTypesTitle,
      AppLocalizations.of(context).stagesOfCrcTitle,
      AppLocalizations.of(context).screeningImportance,
      AppLocalizations.of(context).screeningGuidelines,
      AppLocalizations.of(context).preventionTitle,
      AppLocalizations.of(context).stats,
      AppLocalizations.of(context).communitySupportTitle,
    ];

    // prepare bodies:
    final List<Widget> bodies = [
      Column(
        children: [
          Text(AppLocalizations.of(context).whatIsCrcBody1),
          Text(AppLocalizations.of(context).whatIsCrcBody2),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).symptom1),
          Text(AppLocalizations.of(context).symptom2),
          Text(AppLocalizations.of(context).symptom3),
          Text(AppLocalizations.of(context).symptom4),
          Text(AppLocalizations.of(context).symptom5),
          Text(AppLocalizations.of(context).symptom6),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).riskBody),
          Text(AppLocalizations.of(context).risk1),
          Text(AppLocalizations.of(context).risk2),
          Text(AppLocalizations.of(context).risk2a),
          Text(AppLocalizations.of(context).risk2b),
          Text(AppLocalizations.of(context).risk3),
          Text(AppLocalizations.of(context).risk4),
          Text(AppLocalizations.of(context).risk5),
          Text(AppLocalizations.of(context).risk6),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).screeningTypes),
          Text(AppLocalizations.of(context).screeningType1Title),
          Text(AppLocalizations.of(context).screeningType1Body),
          Text(AppLocalizations.of(context).screeningType2Title),
          Text(AppLocalizations.of(context).screeningType2Body),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).stagesOfCrcTitle),
          Text(AppLocalizations.of(context).stagesOfCrcBody1),
          Text(AppLocalizations.of(context).stagesOfCrcBody2),
          Text(AppLocalizations.of(context).stage0),
          Text(AppLocalizations.of(context).stage2),
          Text(AppLocalizations.of(context).stage3),
          Text(AppLocalizations.of(context).stage4),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).screeningImportance),
          Text(AppLocalizations.of(context).screeningMsg1),
          Text(AppLocalizations.of(context).screeningMsg2),
          Text(AppLocalizations.of(context).screeningMsg3),
          Text(AppLocalizations.of(context).screeningMsg4),
          Text(AppLocalizations.of(context).screeningMsg5),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).screeningGuidelines),
          Text(AppLocalizations.of(context).screeningGHighRisk),
          Text(AppLocalizations.of(context).screeningGHighRisk1),
          Text(AppLocalizations.of(context).screeningGHighRisk2),
          Text(AppLocalizations.of(context).screeningGHighRisk3),
          Text(AppLocalizations.of(context).screeningGHighRisk4),
          Text(AppLocalizations.of(context).screeningGLowRisk),
          Text(AppLocalizations.of(context).screeningGLowRisk1),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).preventionQ),
          Text(AppLocalizations.of(context).preventionA),
          Text(AppLocalizations.of(context).preventionTitle),
          Text(AppLocalizations.of(context).screeningGHighRisk2),
          Text(AppLocalizations.of(context).screeningGHighRisk3),
          Text(AppLocalizations.of(context).screeningGHighRisk4),
          Text(AppLocalizations.of(context).screeningGLowRisk),
          Text(AppLocalizations.of(context).screeningGLowRisk1),
          ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            expansionCallback: (i, isOpen) {
              setState(() {
                _nestedIsOpen[i] = !isOpen;
              });
            },
            children: [
              ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: _nestedIsOpen[0],
                  headerBuilder: (context, isOpen) {
                    return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            AppLocalizations.of(context).primaryPrevention));
                  },
                  body: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                          AppLocalizations.of(context).primaryPreventionBody))),
              ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: _nestedIsOpen[1],
                  headerBuilder: (context, isOpen) {
                    return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            AppLocalizations.of(context).tertiaryPrevention));
                  },
                  body: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                          AppLocalizations.of(context).tertiaryPreventionBody)))
            ],
          )
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).stat1),
          Text(AppLocalizations.of(context).stat2),
          Text(AppLocalizations.of(context).stat3),
          Text(AppLocalizations.of(context).stat4),
          Text(AppLocalizations.of(context).stat5),
        ],
      ),
      Column(
        children: [
          Text(AppLocalizations.of(context).communityM1),
          Text(AppLocalizations.of(context).communityM2title),
          Text(AppLocalizations.of(context).communityM2pt1),
          Text(AppLocalizations.of(context).communityM2pt2),
          Text(AppLocalizations.of(context).communityM2pt3),
          Text(AppLocalizations.of(context).communityM2pt4),
          Text(AppLocalizations.of(context).communityM2pt5),
          Text(AppLocalizations.of(context).communityM2pt6),
          Text(AppLocalizations.of(context).communityM2pt7),
          Text(AppLocalizations.of(context).communityM3),
        ],
      ),
    ];

    List<ExpansionPanel> panels =
        generateExpansionPanels(titles, bodies, _isOpen);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(AppLocalizations.of(context).educationContent,
                style: subHeader()),
            centerTitle: true,
            leading: const SaidIconBackButton()),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Column(
                children: [
                  SaidTextField(
                    placeholder: AppLocalizations.of(context).search,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  ExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 500),
                    children: panels,
                    expansionCallback: (i, isOpen) {
                      setState(() {
                        _isOpen[i] = !isOpen;
                      });
                    },
                  )
                ],
              )),
        )));
  }
}
