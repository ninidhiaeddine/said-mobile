import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsCounter {
  late final SharedPreferences _prefs;
  late final Stream<StepCount> _stepCountStream;
  late int _stepsDone;
  late final Function(int) _onStepCount;

  late int _helper;

  StepsCounter(Function(int) onStepCount) {
    _onStepCount = onStepCount;
    _stepsDone = 0;
    _helper = 0;
    _initPlatformState();
    _initSharedPrefs();
  }

  void _initPlatformState() {
    /// Init stream
    _stepCountStream = Pedometer.stepCountStream;

    /// Listen to stream and handle errors
    _stepCountStream.listen(_onData).onError(_onStepCountError);
  }

  Future<void> _initSharedPrefs() async {
    // Obtain shared preferences.
    _prefs = await SharedPreferences.getInstance();

    _getStoredData();
  }

  void _getStoredData() {
    // check whether a value for `stepsDone` was already stored:
    if (!_prefs.containsKey("stepsDone")) {
      return;
    }

    // check whether the time stamp is the same as today:
    String? timeStampString = _prefs.getString("timeStamp");
    DateTime timeStamp = DateTime.parse(timeStampString!);

    if (!_isSameDay(timeStamp, DateTime.now())) {
      return;
    }

    _stepsDone = _prefs.getInt("stepsDone")!;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month &&
        date1.year == date2.year;
  }

  void _storeStepsDone(int steps) {
    _prefs.setInt("stepsDone", steps);
    _prefs.setString("timeStamp", DateTime.now().toIso8601String());
  }

  void _onData(StepCount event) {
    if (event.steps == _helper) {
      return;
    }

    // increment steps count:
    _stepsDone++;

    // store new steps count in shared prefs:
    _storeStepsDone(_stepsDone);

    // update helper:
    _helper = event.steps;

    // callback:
    _onStepCount(_stepsDone);
  }

  void _onStepCountError(error) {
    /// Handle the error
  }
}
