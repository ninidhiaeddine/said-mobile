import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';

class SaidTimePicker extends StatefulWidget {
  const SaidTimePicker({Key? key, this.callback, required this.placeholder}) : super(key: key);

  final Function(TimeOfDay)? callback;
  final String placeholder;

  @override
  State<SaidTimePicker> createState() => _SaidTimePickerState();
}

class _SaidTimePickerState extends State<SaidTimePicker> {
  final TextEditingController _controller = TextEditingController();

  String formatTime(TimeOfDay time, BuildContext context) {
    return time.format(context);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 7, minute: 15),
    );

    if (newTime == null) {
      return;
    }

    // update text on field:
    _controller.text = formatTime(newTime, context);

    // callback with new time value:
    widget.callback!(newTime);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.none,
      onTap: () => _selectTime(context),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.access_time),
        fillColor: ColorConstants.textFieldColor,
        filled: true,
        hintText: widget.placeholder,
      ),
    );
  }
}
