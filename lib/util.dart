String durationToTime(Duration duration) {
  String twoDigits(num n) => n.toString().padLeft(2, '0');
  var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  var twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  var hours = duration.inHours == 0 ? '' : '${twoDigits(duration.inHours)}:';

  return '$hours$twoDigitMinutes:$twoDigitSeconds';
}

String durationToInt(Duration duration) {
  return duration.inSeconds.toString();
}

Duration convertWorkValueToDuration(int value) {
  final firstRangeStart = 53;
  final secondRangeStart = 43;
  final thirdRangeStart = 38;
  final forthRangeStart = 30;
  final fifthRangeStart = 18;
  final sixthRangeStart = 14;
  final seventhRangeStart = 8;
  final eighthRangeStart = 4;

  if (value <= firstRangeStart && value >= secondRangeStart) {
    return Duration(seconds: firstRangeStart - value);
  } else if (value < secondRangeStart && value >= thirdRangeStart) {
    return Duration(seconds: 10 + (2 * (secondRangeStart - value)));
  } else if (value < thirdRangeStart && value >= forthRangeStart) {
    return Duration(seconds: 20 + (5 * (thirdRangeStart - value)));
  } else if (value < forthRangeStart && value >= fifthRangeStart) {
    return Duration(seconds: 60 + (10 * (forthRangeStart - value)));
  } else if (value < fifthRangeStart && value >= sixthRangeStart) {
    return Duration(seconds: 180 + (15 * (fifthRangeStart - value)));
  } else if (value < sixthRangeStart && value >= seventhRangeStart) {
    return Duration(seconds: 240 + (20 * (sixthRangeStart - value)));
  } else if (value < seventhRangeStart && value >= eighthRangeStart) {
    return Duration(seconds: 360 + (30 * (seventhRangeStart - value)));
  } else if (value < eighthRangeStart) {
    return Duration(seconds: 480 + (60 * (eighthRangeStart - value)));
  }

  return Duration(seconds: 0);
}

Duration convertRestValueToDuration(int value) {
  final firstRangeStart = 53;
  final secondRangeStart = 47;
  final thirdRangeStart = 24;
  final forthRangeStart = 12;
  final fifthRangeStart = 4;

  if (value <= firstRangeStart && value >= secondRangeStart) {
    return Duration(seconds: firstRangeStart - value);
  } else if (value < secondRangeStart && value >= thirdRangeStart) {
    return Duration(seconds: 5 + (5 * (secondRangeStart - value)));
  } else if (value < thirdRangeStart && value >= forthRangeStart) {
    return Duration(seconds: 120 + (10 * (thirdRangeStart - value)));
  } else if (value < forthRangeStart && value >= fifthRangeStart) {
    return Duration(seconds: 240 + (15 * (forthRangeStart - value)));
  } else if (value < fifthRangeStart) {
    return Duration(seconds: 360 + (30 * (fifthRangeStart - value)));
  }

  return Duration(seconds: 0);
}

Duration convertRepValueToDuration(int value) {
  final firstRangeStart = 53;
  return Duration(seconds: firstRangeStart - value);
}

int convertDurationToWorkValue(Duration duration) {
  for (int i = 53; i >= 0; i--) {
    if (duration == convertWorkValueToDuration(i)) {
      return i;
    }
  }

  return -1;
}

int convertDurationToRestValue(Duration duration) {
  for (int i = 53; i >= 0; i--) {
    if (duration == convertRestValueToDuration(i)) {
      return i;
    }
  }

  return -1;
}

int convertDurationToRepValue(Duration duration) {
  for (int i = 53; i >= 0; i--) {
    if (duration == convertRepValueToDuration(i)) {
      return i;
    }
  }

  return -1;
}
