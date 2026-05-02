import 'package:flutter/material.dart';

class NutritionController extends ChangeNotifier {
  DateTime _selectedDate = _normalize(DateTime.now());

  int calories = 550;
  int calorieGoal = 2500;

  double weightKg = 75;
  double weightDeltaKg = 1.6;

  double hydrationLiters = 0;
  double hydrationGoalLiters = 2;

  DateTime get selectedDate => _selectedDate;

  void selectDate(DateTime date) {
    final normalized = _normalize(date);

    if (_selectedDate == normalized) return;

    _selectedDate = normalized;
    notifyListeners();
  }

  void logWater(double liters) {
    hydrationLiters = (hydrationLiters + liters).clamp(0, hydrationGoalLiters);
    notifyListeners();
  }

  int get remainingCalories {
    return (calorieGoal - calories).clamp(0, calorieGoal);
  }

  double get calorieProgress {
    if (calorieGoal == 0) return 0;
    return (calories / calorieGoal).clamp(0, 1);
  }

  double get hydrationProgress {
    if (hydrationGoalLiters == 0) return 0;
    return (hydrationLiters / hydrationGoalLiters).clamp(0, 1);
  }

  static DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}