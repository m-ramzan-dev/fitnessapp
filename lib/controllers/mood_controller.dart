import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import '../utils/enums.dart';

class MoodController extends ChangeNotifier {
  MoodType _mood = MoodType.calm;

  double _angle = -0.35;

  MoodType get mood => _mood;

  double get angle => _angle;

  void updateFromDrag({
    required Offset localPosition,
    required Size size,
  }) {
    final center = Offset(size.width / 2, size.height / 2);
    final vector = localPosition - center;

    final rawAngle = math.atan2(vector.dy, vector.dx);
    _angle = rawAngle;

    final nextMood = _moodFromAngle(rawAngle);

    if (nextMood != _mood) {
      _mood = nextMood;
    }

    notifyListeners();
  }

  void setMood(MoodType mood) {
    _mood = mood;
    _angle = _angleForMood(mood);
    notifyListeners();
  }

  MoodType _moodFromAngle(double angle) {
    final normalized = _normalizeAngle(angle);

    if (normalized >= 300 || normalized < 35) {
      return MoodType.calm;
    }

    if (normalized >= 35 && normalized < 130) {
      return MoodType.content;
    }

    if (normalized >= 130 && normalized < 225) {
      return MoodType.happy;
    }

    return MoodType.peaceful;
  }

  double _angleForMood(MoodType mood) {
    switch (mood) {
      case MoodType.calm:
        return -0.35;
      case MoodType.content:
        return 0.75;
      case MoodType.happy:
        return -2.25;
      case MoodType.peaceful:
        return 2.45;
    }
  }

  double _normalizeAngle(double angle) {
    final degrees = angle * 180 / math.pi;
    final normalized = (degrees + 360) % 360;
    return normalized;
  }
}