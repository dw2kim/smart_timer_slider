import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_timer_slider/smart_timer_slider.dart';

class AdjustTimerPage extends StatefulWidget {
  final Function(int) convertValueToDuration;
  final Function(Duration) convertDurationToValue;
  final Function(Duration) durationToString;

  AdjustTimerPage({
    Key? key,
    required this.convertValueToDuration,
    required this.convertDurationToValue,
    required this.durationToString,
  }) : super(key: key);

  @override
  _AdjustTimerPageState createState() => _AdjustTimerPageState();
}

class _AdjustTimerPageState extends State<AdjustTimerPage> {
  Duration duration = Duration(seconds: 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SmartTimerSlider(
          labelWidget: _getLabelWidget(),
          duration: duration,
          onChange: (val) => setState(() {
            duration = val;
            HapticFeedback.lightImpact();
          }),
          onTapUp: (dragUpdateDetails) {
            Navigator.pop(context);
          },
          convertValueToDuration: widget.convertValueToDuration,
          convertDurationToValue: widget.convertDurationToValue,
        ),
      ),
    );
  }

  Widget _getLabelWidget() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: IgnorePointer(
            child: Text(
          '${widget.durationToString(duration)}',
        )),
      ),
    );
  }
}
