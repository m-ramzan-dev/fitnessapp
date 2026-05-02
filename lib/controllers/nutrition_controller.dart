import 'package:flutter/material.dart';
class NutritionController extends ChangeNotifier {
  DateTime _selectedDate = _normalize(DateTime.now());
  DateTime _visibleCalendarMonth = _normalize(DateTime.now());

  int calories = 550;
  int calorieGoal = 2500;

  double weightKg = 75;
  double weightDeltaKg = 1.6;

  double hydrationLiters = 0;
  double hydrationGoalLiters = 2;

  DateTime get selectedDate => _selectedDate;

  DateTime get visibleCalendarMonth => _visibleCalendarMonth;

  void selectDate(DateTime date) {
    final normalized = _normalize(date);

    if (_selectedDate == normalized) return;

    _selectedDate = normalized;
    _visibleCalendarMonth = DateTime(normalized.year, normalized.month);

    notifyListeners();
  }

  void goToPreviousMonth() {
    _visibleCalendarMonth = DateTime(
      _visibleCalendarMonth.year,
      _visibleCalendarMonth.month - 1,
    );
    notifyListeners();
  }

  void goToNextMonth() {
    _visibleCalendarMonth = DateTime(
      _visibleCalendarMonth.year,
      _visibleCalendarMonth.month + 1,
    );
    notifyListeners();
  }

  int get selectedWeekOfMonth {
    return weekOfMonth(_selectedDate);
  }

  int get totalWeeksInSelectedMonth {
    return totalWeeksInMonth(_selectedDate.year, _selectedDate.month);
  }

  String get selectedWeekLabel {
    return 'Week $selectedWeekOfMonth/$totalWeeksInSelectedMonth';
  }

  List<DateTime> get visibleMonthCalendarDays {
    final firstDay = DateTime(
      _visibleCalendarMonth.year,
      _visibleCalendarMonth.month,
      1,
    );

    final totalWeeks = totalWeeksInMonth(
      _visibleCalendarMonth.year,
      _visibleCalendarMonth.month,
    );

    final startOffset = firstDay.weekday - DateTime.monday;
    final calendarStart = firstDay.subtract(Duration(days: startOffset));

    return List.generate(
      totalWeeks * 7,
          (index) => calendarStart.add(Duration(days: index)),
    );
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

  static int weekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final firstWeekOffset = firstDayOfMonth.weekday - DateTime.monday;

    return ((date.day + firstWeekOffset - 1) / 7).floor() + 1;
  }

  static int totalWeeksInMonth(int year, int month) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    final firstWeekOffset = firstDayOfMonth.weekday - DateTime.monday;
    final totalCalendarCells = firstWeekOffset + lastDayOfMonth.day;

    return (totalCalendarCells / 7).ceil();
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  static DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
// class NutritionController extends ChangeNotifier {
//   DateTime _selectedDate = _normalize(DateTime.now());
//
//   int calories = 550;
//   int calorieGoal = 2500;
//
//   double weightKg = 75;
//   double weightDeltaKg = 1.6;
//
//   double hydrationLiters = 0;
//   double hydrationGoalLiters = 2;
//
//   DateTime get selectedDate => _selectedDate;
//
//   void selectDate(DateTime date) {
//     final normalized = _normalize(date);
//
//     if (_selectedDate == normalized) return;
//
//     _selectedDate = normalized;
//     notifyListeners();
//   }
//
//   void logWater(double liters) {
//     hydrationLiters = (hydrationLiters + liters).clamp(0, hydrationGoalLiters);
//     notifyListeners();
//   }
//
//   int get remainingCalories {
//     return (calorieGoal - calories).clamp(0, calorieGoal);
//   }
//
//   double get calorieProgress {
//     if (calorieGoal == 0) return 0;
//     return (calories / calorieGoal).clamp(0, 1);
//   }
//
//   double get hydrationProgress {
//     if (hydrationGoalLiters == 0) return 0;
//     return (hydrationLiters / hydrationGoalLiters).clamp(0, 1);
//   }
//
//   static DateTime _normalize(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }
// }
