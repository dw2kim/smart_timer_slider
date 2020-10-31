import 'package:flutter/material.dart';
import 'package:smart_timer_slider/smart_timer_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration duration = Duration(seconds: 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SmartTimerSlider(
          duration: duration,
          onChange: (val) => setState(() => duration = val),
        ),
      ),
    );
  }
}
