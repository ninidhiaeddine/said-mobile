import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/services/medication_reminder_service.dart';
import 'package:said/services/medication_service.dart';
import 'package:said/services/models/medication.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/utils/medication_reminder_utils.dart';
import 'package:said/theme/text_styles.dart';
import 'package:said/utils/medication_reminders_generator.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';
import 'package:said/widgets/buttons/said_icon_back_button.dart';
import 'package:said/widgets/dates/said_date_range_picker.dart';
import 'package:said/widgets/dropdowns/said_dropdown.dart';
import 'package:said/widgets/textfields/said_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/widgets/dates/said_time_picker.dart';

class EditMedicationScreen extends StatefulWidget {
  const EditMedicationScreen(
      {Key? key,
      required this.authenticatedUser,
      required this.onRefreshScreen,
      required this.medication})
      : super(key: key);

  final User authenticatedUser;
  final Medication medication;
  final Function(User) onRefreshScreen;

  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  bool _notifsAreOn = false;
  final List<bool> _selections = List.generate(7, (index) => false);
  final TextEditingController medNameController = TextEditingController();
  final TextEditingController medAmountController = TextEditingController();
  bool _loading = false;

  List<String> typeOptions = ["Pill", "Injection", "Drop", "Solution", "Other"];
  List<String> methodOptions = [
    "Before Eating",
    "After Eating",
    "Halfway through a meal"
  ];

  late String _medicationName;
  late double _amount;
  late String _type;
  late String _method;
  late TimeOfDay _timeOfTaking;
  late DateTimeRange _dateRange;

  Future<void> _editMedication(BuildContext context) async {
    var medication = Medication(
        id: widget.medication.id,
        user: widget.authenticatedUser,
        name: _medicationName,
        amount: _amount,
        type: _type,
        method: _method,
        startDate: _dateRange.start,
        endDate: _dateRange.end);

    setState(() {
      _loading = true;
    });

    // make api call:
    var response = await MedicationService.updateMedication(medication);

    if (response.statusCode == 200) {
      // delete existing medication reminders:
      await deleteAssociatedMedicationReminders(medication);

      // add medication reminders:
      await _addMedicationReminders(medication, _dateRange.start,
          _dateRange.end, _timeOfTaking, _selections);

      // once done with adding reminders, go to the previous page:
      if (!mounted) {
        return;
      }

      // refresh medications screen:
      widget.onRefreshScreen(widget.authenticatedUser);

      // go back to previous screen:
      Navigator.pop(context);
    } else {
      var body = jsonDecode(response.body);
      var errMsg = body['error']['message'];

      if (!mounted) {
        return;
      }

      // show snackbar:
      final snackBar = SnackBar(
        content:
            Text('${AppLocalizations.of(context).changesSavedError}: $errMsg'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> _addMedicationReminders(
      Medication medication,
      DateTime startDate,
      DateTime endDate,
      TimeOfDay timeOfTaking,
      List<bool> daysSelections) async {
    var reminders = generateMedicationReminders(
        medication, startDate, endDate, timeOfTaking, daysSelections);

    for (var reminder in reminders) {
      // make api call:
      var response =
          await MedicationReminderService.addMedicationReminder(reminder);

      if (response.statusCode != 200) {
        // show snackbar:
        var body = jsonDecode(response.body);
        var errMsg = body['error']['message'];

        if (!mounted) {
          return;
        }

        final snackBar = SnackBar(
          content: Text(
              '${AppLocalizations.of(context).changesSavedError}: $errMsg'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        break;
      }
    }
  }

  void populateTextFields() {
    medNameController.text = widget.medication.name;
    medAmountController.text = widget.medication.amount.toString();
  }

  void initStateValues() {
    _medicationName = widget.medication.name;
    _amount = widget.medication.amount;
    _type = widget.medication.type;
    _method = widget.medication.method;
    _dateRange = DateTimeRange(
        start: widget.medication.startDate, end: widget.medication.endDate);
  }

  @override
  void initState() {
    super.initState();
    initStateValues();
    populateTextFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).editMedication,
              style: subHeader()),
          centerTitle: true,
          leading: const SaidIconBackButton(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.secondaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.medical_services_rounded,
                              size: 30,
                              color: ColorConstants.secondaryColor,
                            ))),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidTextField(
                      placeholder: AppLocalizations.of(context).medName,
                      controller: medNameController,
                      onChanged: (newValue) {
                        setState(() {
                          _medicationName = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidTextField(
                      placeholder: AppLocalizations.of(context).amount,
                      textInputType: TextInputType.number,
                      controller: medAmountController,
                      onChanged: (newValue) {
                        setState(() {
                          _amount = double.parse(newValue);
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidDropdown(
                        placeholder: AppLocalizations.of(context).type,
                        options: typeOptions,
                        value: widget.medication.type,
                        callback: (newValue) {
                          setState(() {
                            _type = newValue!;
                          });
                        }),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidDropdown(
                      placeholder: AppLocalizations.of(context).method,
                      options: methodOptions,
                      value: widget.medication.method,
                      callback: (newValue) {
                        setState(() {
                          _method = newValue!;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(16)),
                    SaidTimePicker(
                      placeholder: AppLocalizations.of(context).time,
                      callback: (newValue) {
                        setState(() {
                          _timeOfTaking = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    SaidDateRangePicker(
                      placeholder: AppLocalizations.of(context).dateRange,
                      callback: (newValue) {
                        setState(() {
                          _dateRange = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).notifications),
                        const Spacer(),
                        Switch(
                            value: _notifsAreOn,
                            onChanged: (value) {
                              setState(() {
                                _notifsAreOn = value;
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
                          onPressed: !_notifsAreOn
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
                    SaidPrimaryButton(
                        text: _loading
                            ? AppLocalizations.of(context).loading
                            : AppLocalizations.of(context).save,
                        context: context,
                        onPressed: () => _editMedication(context))
                  ],
                )),
          ),
        ));
  }
}
