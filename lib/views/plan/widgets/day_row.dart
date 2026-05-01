import 'package:fitnessapp/views/plan/widgets/workout_card.dart';
import 'package:flutter/material.dart';

import '../../../models/workout_entry.dart';
import '../../../utils/app_colors.dart';
class DayRow extends StatelessWidget {
  final DateTime day;
  final bool isToday;
  final List<WorkoutEntry> workouts;
  final VoidCallback onAdd;
  final ValueChanged<String> onDelete;

  const DayRow({
    super.key,
    required this.day,
    required this.isToday,
    required this.workouts,
    required this.onAdd,
    required this.onDelete,
  });

  static const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final dayName = _dayNames[day.weekday - 1];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isToday ? AppColors.arms : AppColors.textMuted,
                    letterSpacing: 0.08,
                  ),
                ),
                const SizedBox(height: 2),
                if (isToday)
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.arms,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    '${day.day}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      height: 1.1,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: workouts.isEmpty
                ? GestureDetector(
              onTap: onAdd,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '+ Add workout',
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...workouts.map(
                      (workout) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: WorkoutCard(
                      entry: workout,
                      onDelete: () => onDelete(workout.id),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onAdd,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 14,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Add workout',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
