import 'package:example/adjust_timer_page.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer_slider/util.dart';

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
        child: Column(
          children: [
            Spacer(),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdjustTimerPage(
                            convertValueToDuration: (x) =>
                                convertRestValueToDuration(x),
                            convertDurationToValue: (x) =>
                                convertDurationToRestValue(x),
                            durationToString: (x) => durationToTime(x),
                          )),
                );
              },
              child: Text('Go to Smart Timer Page - Rest Time'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdjustTimerPage(
                            convertValueToDuration: (x) =>
                                convertWorkValueToDuration(x),
                            convertDurationToValue: (x) =>
                                convertDurationToWorkValue(x),
                            durationToString: (x) => durationToTime(x),
                          )),
                );
              },
              child: Text('Go to Smart Timer Page - Work Time'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdjustTimerPage(
                            convertValueToDuration: (x) =>
                                convertRepValueToDuration(x),
                            convertDurationToValue: (x) =>
                                convertDurationToRepValue(x),
                            durationToString: (x) => durationToInt(x),
                          )),
                );
              },
              child: Text('Go to Smart Timer Page - rep'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
