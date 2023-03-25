import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/expansion_panel_generator.dart';
import 'package:said/widgets/buttons/said_icon_back_button.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final List<bool> _isOpen = List.generate(10, (index) => false);
  final List<bool> _nestedIsOpen = List.generate(2, (index) => false);

  late List<String> titles = [];
  late List<Widget> bodies = [];
  late List<ExpansionPanel> panels = [];

  void initVariables() {
    // prepare titles:
    titles = [
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
    bodies = [
      Column(
        children: [
          Text(
            AppLocalizations.of(context).whatIsCrcBody1,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 16,
          ),
          const Image(
              image:
                  AssetImage("assets/images/learn_content/key-message-1.jpg")),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(AppLocalizations.of(context).whatIsCrcBody2,
                textAlign: TextAlign.justify),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("\t\u2022 ${AppLocalizations.of(context).symptom1}"),
          Text("\t\u2022 ${AppLocalizations.of(context).symptom2}"),
          Text("\t\u2022 ${AppLocalizations.of(context).symptom3}"),
          Text("\t\u2022 ${AppLocalizations.of(context).symptom4}"),
          Text("\t\u2022 ${AppLocalizations.of(context).symptom5}"),
          Text("\t\u2022 ${AppLocalizations.of(context).symptom6}"),
        ],
      ),
      Column(
        children: [
          Text(
            AppLocalizations.of(context).riskBody,
            textAlign: TextAlign.justify,
            style: const TextStyle(decoration: TextDecoration.underline),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(AppLocalizations.of(context).risk1,
                textAlign: TextAlign.justify),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(AppLocalizations.of(context).risk2,
                  textAlign: TextAlign.justify)),
          const SizedBox(
            height: 8,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(AppLocalizations.of(context).risk2a,
                  textAlign: TextAlign.justify)),
          const SizedBox(
            height: 8,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(AppLocalizations.of(context).risk2b,
                  textAlign: TextAlign.justify)),
          const SizedBox(
            height: 8,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(AppLocalizations.of(context).risk3,
                  textAlign: TextAlign.justify)),
          const SizedBox(
            height: 8,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(AppLocalizations.of(context).risk4,
                  textAlign: TextAlign.justify)),
          const SizedBox(
            height: 8,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(AppLocalizations.of(context).risk5,
                  textAlign: TextAlign.justify)),
          Text(
            AppLocalizations.of(context).riskNote,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage("assets/images/learn_content/risk.png"),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            AppLocalizations.of(context).screeningType1Title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              AppLocalizations.of(context).screeningType1Body,
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(AppLocalizations.of(context).screeningType2Title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                AppLocalizations.of(context).screeningType2Body,
                textAlign: TextAlign.justify,
              )),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).stagesOfCrcBody1,
            textAlign: TextAlign.justify,
          ),
          const Image(
            image: AssetImage("assets/images/learn_content/stages.png"),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(AppLocalizations.of(context).stagesOfCrcBody2,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\n${AppLocalizations.of(context).stage} 0:",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(AppLocalizations.of(context).stage0,
                  textAlign: TextAlign.justify),
              Text("\n${AppLocalizations.of(context).stage} 1:",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(AppLocalizations.of(context).stage1,
                  textAlign: TextAlign.justify),
              Text("\n${AppLocalizations.of(context).stage} 2:",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(AppLocalizations.of(context).stage2,
                  textAlign: TextAlign.justify),
              Text("\n${AppLocalizations.of(context).stage} 3:",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(AppLocalizations.of(context).stage3,
                  textAlign: TextAlign.justify),
              Text("\n${AppLocalizations.of(context).stage} 4:",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(AppLocalizations.of(context).stage4,
                  textAlign: TextAlign.justify),
            ],
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).screeningMsg1,
            textAlign: TextAlign.justify,
          ),
          const Text("--"),
          Text(
            "\n${AppLocalizations.of(context).screeningMsg2}",
            textAlign: TextAlign.justify,
          ),
          const Text("\n--"),
          Text(
            AppLocalizations.of(context).screeningMsg3,
            textAlign: TextAlign.justify,
          ),
          const Image(image: AssetImage("assets/images/learn_content/screening.png"),),
          Text("\n${AppLocalizations.of(context).screeningMsg4}",
              textAlign: TextAlign.justify),
          Text(
            AppLocalizations.of(context).screeningMsg5,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
          const Image(image: AssetImage("assets/images/learn_content/screening2.png"),),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).screeningGHighRisk,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline)),
          Text(
            AppLocalizations.of(context).screeningGHighRisk1,
            textAlign: TextAlign.justify,
          ),
          Text(AppLocalizations.of(context).screeningGHighRisk2,
              textAlign: TextAlign.justify),
          Text(AppLocalizations.of(context).screeningGHighRisk3,
              textAlign: TextAlign.justify),
          Text(AppLocalizations.of(context).screeningGHighRisk4,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 16,
          ),
          Text(AppLocalizations.of(context).screeningGLowRisk,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline)),
          Text(AppLocalizations.of(context).screeningGLowRisk1,
              textAlign: TextAlign.justify),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).preventionQ,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            AppLocalizations.of(context).preventionA,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(AppLocalizations.of(context).preventionTitle,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              AppLocalizations.of(context).preventionBody,
              textAlign: TextAlign.justify,
            ),
          ),
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
                        AppLocalizations.of(context).primaryPreventionBody,
                        textAlign: TextAlign.justify,
                      ))),
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
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context).tertiaryPreventionBody,
                            textAlign: TextAlign.justify,
                          ),
                          const Image(image: AssetImage("assets/images/learn_content/tertiary-prevention.png"),),
                        ],
                      )))
            ],
          )
        ],
      ),
      Column(
        children: [
          Text(
            AppLocalizations.of(context).stat1,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).stat2,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).stat3,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).stat4,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).stat5,
              textAlign: TextAlign.justify),
        ],
      ),
      Column(
        children: [
          Text(
            AppLocalizations.of(context).communityM1,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 16,
          ),
          const Image(image: AssetImage("assets/images/learn_content/community.jpg"),),
          const SizedBox(
            height: 16,
          ),
          Text(AppLocalizations.of(context).communityM2title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM2pt1,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM2pt2,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM2pt3,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM2pt4,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM2pt5,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM2pt6,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM2pt7,
              textAlign: TextAlign.justify),
          const SizedBox(
            height: 8,
          ),
          Text(AppLocalizations.of(context).communityM3,
              style: const TextStyle(fontWeight: FontWeight.w300),
              textAlign: TextAlign.justify),
        ],
      ),
    ];

    // generate panels:
    panels = generateExpansionPanels(titles, bodies, _isOpen);
  }

  @override
  Widget build(BuildContext context) {
    initVariables();

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
              physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                children: [
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
