import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:said/config/color_constants.dart';

class SaidDateRangePicker extends StatefulWidget {
  const SaidDateRangePicker({Key? key, required this.placeholder})
      : super(key: key);

  final String placeholder;

  @override
  State<SaidDateRangePicker> createState() => _SaidDateRangePickerState();
}

class _SaidDateRangePickerState extends State<SaidDateRangePicker> {
  final TextEditingController _controller = TextEditingController();

  String formatDateRange(DateTimeRange range) {
    var dateFormatter = DateFormat.yMd();
    return "${dateFormatter.format(range.start)} to ${dateFormatter.format(range.end)}";
  }

  Future<void> _selectDateRange(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime lastDate = today.add(const Duration(days: 365));

    final DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: today,
        end: today.add(const Duration(days: 7)),
      ),
      firstDate: today,
      lastDate: lastDate,
      helpText: 'Select a date',
    );

    if (newDateRange == null) {
      return;
    }

    _controller.text = formatDateRange(newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.none,
      onTap: () => _selectDateRange(context),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.date_range),
        fillColor: ColorConstants.textFieldColor,
        filled: true,
        hintText: widget.placeholder,
      ),
    );
  }
}
