library smart_timer_slider;

import 'dart:math' as math;

import 'package:flutter/material.dart';

class SmartTimerSlider extends StatefulWidget {
  final Duration duration;
  final ValueChanged<Duration> onChange;
  final GestureTapUpCallback onTapUp;
  final Function(int) convertValueToDuration;
  final Function(Duration) convertDurationToValue;
  final Widget labelWidget;
  final Color pointerColor;
  final Color backgroundColor;
  final int totalUnits; // This is the number of units

  const SmartTimerSlider({
    Key key,
    @required this.duration,
    @required this.labelWidget,
    @required this.onChange,
    @required this.onTapUp,
    @required this.convertValueToDuration,
    @required this.convertDurationToValue,
    this.totalUnits = 54,
    this.pointerColor = Colors.red,
    this.backgroundColor = Colors.blueGrey,
  })  : assert(totalUnits > 0),
        super(key: key);

  @override
  _SmartTimerSliderState createState() => _SmartTimerSliderState();
}

class _SmartTimerSliderState extends State<SmartTimerSlider> {
  final double pointerHeight = 50;

  double startDragYOffset;
  int startDragHeight;
  double widgetHeight = 50;
  double tapAreaSize = 12.0;
  int prevHeight = -1;

  double get _pixelsPerUnit {
    return _currentHeight / widget.totalUnits;
  }

  double get _sliderPosition {
    double halfOfBottomLabel = tapAreaSize / 2;
    int unitsFromBottom = widget.convertDurationToValue(widget.duration);
    return halfOfBottomLabel + unitsFromBottom * _pixelsPerUnit;
  }

  double get _currentHeight {
    double totalHeight = this.widgetHeight;
    double marginBottom = 12.0;
    double marginTop = 12.0;
    return totalHeight - (marginBottom + marginTop + tapAreaSize);
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
            onTapUp: widget.onTapUp,
            onVerticalDragEnd: (_) => widget.onTapUp(null),
            onVerticalDragStart: this._onDragStart,
            onVerticalDragUpdate: this._onDragUpdate,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                _getSlider(),
                _getSliderBackground(),
                widget.labelWidget,
              ],
            ),
          );
        }),
      ),
    );
  }

  _onTapDown(TapDownDetails details) {
    int height = _globalOffsetToHeight(details.globalPosition);
    height = _normalizeHeight(height);
    if (prevHeight != height) {
      prevHeight = height;
      widget.onChange(widget.convertValueToDuration(height));
    }
  }

  _onDragStart(DragStartDetails details) {
    int newHeight = _globalOffsetToHeight(details.globalPosition);
    if (prevHeight != newHeight) {
      prevHeight = newHeight;
      widget.onChange(widget.convertValueToDuration(newHeight));
    }
    setState(() {
      startDragYOffset = details.globalPosition.dy;
      startDragHeight = newHeight;
    });
  }

  _onDragUpdate(DragUpdateDetails details) {
    double currentYOffset = details.globalPosition.dy;
    double verticalDifference = startDragYOffset - currentYOffset;
    int diffHeight = verticalDifference ~/ _pixelsPerUnit;
    int height = _normalizeHeight(startDragHeight + diffHeight);

    if (prevHeight != height) {
      prevHeight = height;
      setState(() => widget.onChange(widget.convertValueToDuration(height)));
    }
  }

  int _normalizeHeight(int height) {
    return math.max(
        0,
        math.min(
          widget.totalUnits - 1, // Skip the first block
          height,
        ));
  }

  int _globalOffsetToHeight(Offset offset) {
    RenderBox getBox = context.findRenderObject();
    Offset localPosition = getBox.globalToLocal(offset);
    double dy = localPosition.dy;
    dy = dy - 12.0 - tapAreaSize / 2;
    int height = widget.totalUnits - (dy ~/ _pixelsPerUnit);
    return height;
  }

  Widget _getSlider() {
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

  Widget _getSliderBackground() {
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
}
