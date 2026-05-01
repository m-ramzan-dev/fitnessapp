
import '../utils/enums.dart';

class WorkoutEntry {
  final String id;
  final DateTime date;
  final String title;
  final WorkoutType type;
  final int minDuration;
  final int maxDuration;

  const WorkoutEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.type,
    required this.minDuration,
    required this.maxDuration,
  });

  String get durationLabel => '${minDuration}m - ${maxDuration}m';

  int get averageDuration => ((minDuration + maxDuration) / 2).round();

  WorkoutEntry copyWith({
    DateTime? date,
    String? title,
    WorkoutType? type,
    int? minDuration,
    int? maxDuration,
  }) {
    return WorkoutEntry(
      id: id,
      date: date ?? this.date,
      title: title ?? this.title,
      type: type ?? this.type,
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
    );
  }
}
