
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'enums.dart';

extension WorkoutTypeX on WorkoutType {
  String get label {
    switch (this) {
      case WorkoutType.arms:
        return 'Arms Workout';
      case WorkoutType.legs:
        return 'Leg Workout';
      case WorkoutType.cardio:
        return 'Cardio';
      case WorkoutType.core:
        return 'Core Workout';
    }
  }

  Color get color {
    switch (this) {
      case WorkoutType.arms:
        return AppColors.arms;
      case WorkoutType.legs:
        return AppColors.legs;
      case WorkoutType.cardio:
        return AppColors.cardio;
      case WorkoutType.core:
        return AppColors.core;
    }
  }

  Color get bgColor => color.withOpacity(0.12);

  IconData get icon {
    switch (this) {
      case WorkoutType.arms:
        return Icons.fitness_center_rounded;
      case WorkoutType.legs:
        return Icons.directions_run_rounded;
      case WorkoutType.cardio:
        return Icons.favorite_rounded;
      case WorkoutType.core:
        return Icons.self_improvement_rounded;
    }
  }
}

extension MoodTypeX on MoodType {
  String get label {
    switch (this) {
      case MoodType.calm:
        return 'Calm';
      case MoodType.content:
        return 'Content';
      case MoodType.happy:
        return 'Happy';
      case MoodType.peaceful:
        return 'Peaceful';
    }
  }

  Color get faceColor {
    switch (this) {
      case MoodType.calm:
        return const Color(0xFFECC6B8);
      case MoodType.content:
        return const Color(0xFFF7D34D);
      case MoodType.happy:
        return const Color(0xFFFFC884);
      case MoodType.peaceful:
        return const Color(0xFFFFC884);
    }
  }

  Color get accentColor {
    switch (this) {
      case MoodType.calm:
        return const Color(0xFF8ACEC4);
      case MoodType.content:
        return const Color(0xFFC8B7F2);
      case MoodType.happy:
        return const Color(0xFFFF9A58);
      case MoodType.peaceful:
        return const Color(0xFFF47FA9);
    }
  }
}

