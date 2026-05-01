import 'package:flutter/cupertino.dart';

import '../models/workout_entry.dart';
import '../utils/enums.dart';

class PlanController extends ChangeNotifier {
  final Map<DateTime, List<WorkoutEntry>> _workoutsByDate = {};

  PlanController() {
    _seedDemoData();
  }

  DateTime get today => _normalize(DateTime.now());

  DateTime get currentWeekStart => getWeekStart(today);

  DateTime get nextWeekStart => currentWeekStart.add(const Duration(days: 7));

  List<DateTime> getWeekDays(DateTime weekStart) {
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  DateTime getWeekStart(DateTime date) {
    final normalized = _normalize(date);
    final diff = normalized.weekday - DateTime.monday;
    return normalized.subtract(Duration(days: diff));
  }

  bool isToday(DateTime date) {
    final normalized = _normalize(date);
    return normalized == today;
  }

  List<WorkoutEntry> workoutsFor(DateTime date) {
    return List.unmodifiable(_workoutsByDate[_normalize(date)] ?? const []);
  }

  int weekTotalMinutes(DateTime weekStart) {
    return getWeekDays(weekStart)
        .expand(workoutsFor)
        .fold<int>(0, (total, item) => total + item.averageDuration);
  }

  void addWorkout({
    required DateTime date,
    required String title,
    required WorkoutType type,
    required int minDuration,
    required int maxDuration,
  }) {
    final trimmedTitle = title.trim();

    if (trimmedTitle.isEmpty) return;

    final key = _normalize(date);

    final workout = WorkoutEntry(
      id: _newId(),
      date: key,
      title: trimmedTitle,
      type: type,
      minDuration: minDuration,
      maxDuration: maxDuration,
    );

    _workoutsByDate.putIfAbsent(key, () => []);
    _workoutsByDate[key]!.add(workout);

    notifyListeners();
  }

  void deleteWorkout(String id) {
    for (final workouts in _workoutsByDate.values) {
      workouts.removeWhere((item) => item.id == id);
    }

    _workoutsByDate.removeWhere((_, workouts) => workouts.isEmpty);

    notifyListeners();
  }

  void updateWorkout(WorkoutEntry updatedWorkout) {
    deleteWorkout(updatedWorkout.id);

    final key = _normalize(updatedWorkout.date);

    _workoutsByDate.putIfAbsent(key, () => []);
    _workoutsByDate[key]!.add(updatedWorkout.copyWith(date: key));

    notifyListeners();
  }

  String formatDateRange(DateTime weekStart) {
    final end = weekStart.add(const Duration(days: 6));

    if (weekStart.month == end.month) {
      return '${_monthsShort[weekStart.month]} ${weekStart.day}-${end.day}';
    }

    return '${_monthsShort[weekStart.month]} ${weekStart.day} - '
        '${_monthsShort[end.month]} ${end.day}';
  }

  String formatWeekLabel(DateTime weekStart) {
    final thursday = weekStart.add(const Duration(days: 3));
    final weekOfMonth = (thursday.day / 7).ceil();

    return 'Week $weekOfMonth/${thursday.month}';
  }

  String formatSheetDate(DateTime date) {
    final normalized = _normalize(date);

    return '${_dayNames[normalized.weekday - 1]}, '
        '${_monthsShort[normalized.month]} '
        '${normalized.day} '
        '${normalized.year}';
  }

  void _seedDemoData() {
    final seedDate = today;

    void addSeed(
        int offsetDays,
        String title,
        WorkoutType type,
        int minDuration,
        int maxDuration,
        ) {
      addWorkout(
        date: seedDate.add(Duration(days: offsetDays)),
        title: title,
        type: type,
        minDuration: minDuration,
        maxDuration: maxDuration,
      );
    }

    addSeed(0, 'Arm Blaster', WorkoutType.arms, 25, 30);
    addSeed(2, 'Core Crusher', WorkoutType.core, 20, 25);
    addSeed(3, 'Leg Day Blitz', WorkoutType.legs, 25, 30);
    addSeed(5, 'Morning Run', WorkoutType.cardio, 30, 40);

    addSeed(7, 'Arm Blaster', WorkoutType.arms, 25, 30);
    addSeed(9, 'Core Crusher', WorkoutType.core, 20, 25);
    addSeed(10, 'Leg Day Blitz', WorkoutType.legs, 30, 35);
    addSeed(12, 'HIIT Session', WorkoutType.cardio, 20, 30);
  }

  static DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static String _newId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  static const _monthsShort = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
}
