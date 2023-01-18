import 'package:flutter/material.dart';
import 'package:said/widgets/said_button.dart';
import 'package:said/widgets/said_date_range_picker.dart';
import 'package:said/widgets/said_dropdown.dart';
import 'package:said/widgets/said_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/widgets/said_time_picker.dart';

class SingleMedSetupPage extends StatefulWidget {
  const SingleMedSetupPage({Key? key}) : super(key: key);

  @override
  State<SingleMedSetupPage> createState() => _SingleMedSetupPageState();
}

class _SingleMedSetupPageState extends State<SingleMedSetupPage> {
  bool notifsAreOn = false;
  final List<bool> _selections = List.generate(7, (index) => false);

  List<String> typeOptions = ["Pill", "Injection"];
  List<String> methodOptions = ["Before Eating", "After Eating"];

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
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.medical_services_rounded,
                                size: 30))),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidTextField(
                      placeholder: AppLocalizations.of(context).medName,
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidTextField(
                      placeholder: AppLocalizations.of(context).amount,
                      textInputType: TextInputType.number,
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidDropdown(
                        placeholder: AppLocalizations.of(context).type,
                        options: typeOptions),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidDropdown(
                        placeholder: AppLocalizations.of(context).method,
                        options: methodOptions),
                    const Padding(padding: EdgeInsets.all(16)),
                    SaidTimePicker(
                      placeholder: AppLocalizations.of(context).time,
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidDateRangePicker(
                        placeholder: AppLocalizations.of(context).dateRange),
                    const Padding(padding: EdgeInsets.all(8)),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).notifications),
                        const Spacer(),
                        Switch(
                            value: notifsAreOn,
                            onChanged: (value) {
                              setState(() {
                                notifsAreOn = value;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: 75,
                      child: Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ToggleButtons(
                          direction: Axis.horizontal,
                          isSelected: _selections,
                          onPressed: !notifsAreOn
                              ? null
                              : (index) {
                                  setState(() {
                                    _selections[index] = !_selections[index];
                                  });
                                },
                          children: [
                            Text(AppLocalizations.of(context).monday),
                            Text(AppLocalizations.of(context).tuesday),
                            Text(AppLocalizations.of(context).wednesday),
                            Text(AppLocalizations.of(context).thursday),
                            Text(AppLocalizations.of(context).friday),
                            Text(AppLocalizations.of(context).saturday),
                            Text(AppLocalizations.of(context).sunday),
                          ],
                        ),
                      )),
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidButton(
                        text: AppLocalizations.of(context).save,
                        context: context)
                  ],
                )),
          ),
        ));
  }
}
