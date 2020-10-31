library smart_timer_slider;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_timer_slider/util.dart';

class SmartTimerSlider extends StatefulWidget {
  final Duration duration;
  final ValueChanged<Duration> onChange;
  final Color pointerColor;
  final Color backgroundColor;

  const SmartTimerSlider({
    Key key,
    @required this.duration,
    @required this.onChange,
    this.pointerColor = Colors.red,
    this.backgroundColor = Colors.blueGrey,
  }) : super(key: key);

  @override
  _SmartTimerSliderState createState() => _SmartTimerSliderState();
}

class _SmartTimerSliderState extends State<SmartTimerSlider> {
  final double pointerHeight = 50;
  final int totalUnits = 54; // This is the number of units

  double startDragYOffset;
  int startDragHeight;
  double widgetHeight = 50;
  double labelFontSize = 12.0;

  double get _pixelsPerUnit {
    return _drawingHeight / totalUnits;
  }

  double get _sliderPosition {
    double halfOfBottomLabel = labelFontSize / 2;
    int unitsFromBottom = convertDurationToValue(widget.duration);
    return halfOfBottomLabel + unitsFromBottom * _pixelsPerUnit;
  }

  double get _drawingHeight {
    double totalHeight = this.widgetHeight;
    double marginBottom = 12.0;
    double marginTop = 12.0;
    return totalHeight - (marginBottom + marginTop + labelFontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: pointerHeight / 2),
        child: LayoutBuilder(builder: (context, constraints) {
          this.widgetHeight = constraints.maxHeight;
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: this._onTapDown,
            onVerticalDragStart: this._onDragStart,
            onVerticalDragUpdate: this._onDragUpdate,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                _drawSlider(),
                _drawerSliderBackground(),
                _drawLabels(),
              ],
            ),
          );
        }),
      ),
    );
  }

  _onTapDown(TapDownDetails tapDownDetails) {
    int height = _globalOffsetToHeight(tapDownDetails.globalPosition);
    height = _normalizeHeight(height);
    widget.onChange(convertValueToDuration(height));
  }

  int _normalizeHeight(int height) {
    return math.max(
        0,
        math.min(
          totalUnits - 1, // Skip the first block
          height,
        ));
  }

  int _globalOffsetToHeight(Offset globalOffset) {
    RenderBox getBox = context.findRenderObject();
    Offset localPosition = getBox.globalToLocal(globalOffset);
    double dy = localPosition.dy;
    dy = dy - 12.0 - labelFontSize / 2;
    int height = totalUnits - (dy ~/ _pixelsPerUnit);
    return height;
  }

  _onDragStart(DragStartDetails dragStartDetails) {
    int newHeight = _globalOffsetToHeight(dragStartDetails.globalPosition);
    widget.onChange(convertValueToDuration(newHeight));
    setState(() {
      startDragYOffset = dragStartDetails.globalPosition.dy;
      startDragHeight = newHeight;
    });
  }

  _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    double currentYOffset = dragUpdateDetails.globalPosition.dy;
    double verticalDifference = startDragYOffset - currentYOffset;
    int diffHeight = verticalDifference ~/ _pixelsPerUnit;
    int height = _normalizeHeight(startDragHeight + diffHeight);
    setState(() => widget.onChange(convertValueToDuration(height)));
  }

  Widget _drawSlider() {
    return Positioned(
      child: Opacity(
        opacity: 0.5,
        child: Container(
          height: pointerHeight,
          color: widget.pointerColor,
        ),
      ),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPosition,
    );
  }

  Widget _drawerSliderBackground() {
    return Positioned(
      child: Container(
        height: widgetHeight,
        color: widget.pointerColor,
      ),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPosition + pointerHeight,
    );
  }

  Widget _drawLabels() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Align(
        alignment: Alignment.topCenter,
        child:
            IgnorePointer(child: Text('${durationToString(widget.duration)}')),
      ),
    );
  }
}
