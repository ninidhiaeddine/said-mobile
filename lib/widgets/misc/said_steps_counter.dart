import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:said/config/color_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:said/services/models/post.dart';
import 'package:said/services/models/user.dart';
import 'package:said/services/post_service.dart';
import 'package:said/widgets/buttons/said_primary_button.dart';

class SaidStepsCounter extends StatefulWidget {
  const SaidStepsCounter(
      {super.key, required this.authenticatedUser, required this.stepsGoal});

  final User authenticatedUser;
  final int stepsGoal;

  @override
  State<StatefulWidget> createState() => _SaidStepsCounterState();
}

class _SaidStepsCounterState extends State<SaidStepsCounter> {
  late Stream<StepCount> _stepCountStream;
  late int _stepsDone;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    setState(() {
      _stepsDone = 0;
    });
  }

  void onStepCount(StepCount event) {
    /// Handle step count changed
    int steps = event.steps;

    setState(() {
      _stepsDone = steps;
    });
  }

  void onStepCountError(error) {
    /// Handle the error
  }

  void initPlatformState() {
    /// Init stream
    _stepCountStream = Pedometer.stepCountStream;

    /// Listen to stream and handle errors
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  double _computeProgressValue() {
    return _stepsDone / widget.stepsGoal;
  }

  Future<void> _shareMilestone(BuildContext context) async {
    // prepare post:
    var postContent = 'Here is my steps milestone!\n$_stepsDone';
    var post = Post(
        user: widget.authenticatedUser,
        createdAt: DateTime.now(),
        postContent: postContent,
        postLikes: []);

    // make api call:
    var response = await PostService.addPost(post);

    if (response.statusCode == 200) {
      if (!mounted) {
        return;
      }

      // show snackbar:
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context).changesSavedSuccess),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (!mounted) {
        return;
      }

      var body = jsonDecode(response.body);
      var errMsg = body['error']['message'];

      // show snackbar:
      final snackBar = SnackBar(
        content:
            Text('${AppLocalizations.of(context).changesSavedError}: $errMsg'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 315,
        decoration: const BoxDecoration(
            color: ColorConstants.secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          children: [
            SizedBox(
                height: 235,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        top: 30,
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            value: _computeProgressValue(),
                            strokeWidth: 20,
                            color: ColorConstants.primaryColor,
                            backgroundColor: const Color(0xff2d4385),
                          ),
                        )),
                    Positioned(
                        top: 90,
                        child: Text(AppLocalizations.of(context).steps,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18))),
                    Positioned(
                        top: 110,
                        child: Text(_stepsDone.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 34))),
                    Positioned(
                        top: 170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).goal,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            Text(widget.stepsGoal.toString(),
                                style: const TextStyle(
                                    color: ColorConstants.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ],
                        )),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SaidPrimaryButton(
                  text: AppLocalizations.of(context).shareMilestone,
                  context: context,
                  icon: const Icon(Icons.star_purple500),
                  enabled: widget.stepsGoal <= _stepsDone,
                  onPressed: () => _shareMilestone(context)),
            )
          ],
        ));
  }
}
