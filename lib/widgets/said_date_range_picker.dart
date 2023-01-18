import 'package:flutter/material.dart';

class SaidDatePicker extends StatefulWidget {
  const SaidDatePicker({Key? key}) : super(key: key);

  @override
  State<SaidDatePicker> createState() => _SaidDatePickerState();
}

class _SaidDatePickerState extends State<SaidDatePicker> {
  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: DateTime(2020, 11, 17),
        end: DateTime(2020, 11, 24),
      ),
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.none,
      onTap: () => _selectDateRange(context),
    );
  }
}
