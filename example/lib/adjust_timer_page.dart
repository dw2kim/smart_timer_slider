import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_timer_slider/smart_timer_slider.dart';
import 'package:smart_timer_slider/util.dart';

class AdjustTimerPage extends StatefulWidget {
  AdjustTimerPage({Key key}) : super(key: key);

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
        ),
      ),
    );
  }

  Widget _getLabelWidget() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: IgnorePointer(child: Text('${durationToString(duration)}')),
      ),
    );
  }
}
