import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/widgets/said_text_field.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final List<bool> _isOpen = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context).educationContent,
                      style: subHeader()),
                  const Padding(padding: EdgeInsets.all(8)),
                  SaidTextField(
                    placeholder: AppLocalizations.of(context).search,
                    icon: const Icon(Icons.search),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  ExpansionPanelList(
                    animationDuration: const Duration(seconds: 1),
                    children: [
                      ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: _isOpen[0],
                          headerBuilder: (context, isOpen) {
                            return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text("Header"));
                          },
                          body: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text("Inside Expandable"))),
                      ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: _isOpen[1],
                          headerBuilder: (context, isOpen) {
                            return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text("Header"));
                          },
                          body: const Text("Inside Expandable"))
                    ],
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
