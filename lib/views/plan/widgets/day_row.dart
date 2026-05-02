import 'package:fitnessapp/views/plan/widgets/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/plan_controller.dart';
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
    final controller = context.read<PlanController>();
    final dayName = _dayNames[day.weekday - 1];

    return DragTarget<WorkoutEntry>(
      onWillAcceptWithDetails: (details) {
        return controller.canMoveWorkout(
          workout: details.data,
          targetDate: day,
        );
      },
      onAcceptWithDetails: (details) {
        controller.moveWorkout(workout: details.data, targetDate: day);
      },
      builder: (context, candidateData, rejectedData) {
        final isDragHovering = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isDragHovering
                ? AppColors.arms.withOpacity(0.05)
                : Colors.transparent,
            border: const Border(bottom: BorderSide(color: AppColors.border)),
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
                            style: const TextStyle(
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
                        child: SizedBox(
                          height: 40,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isDragHovering
                                  ? 'Drop workout here'
                                  //: '+ Add workout',
                                  : '',
                              style: const TextStyle(
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
                          if (isDragHovering)
                            GestureDetector(
                              onTap: onAdd,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isDragHovering
                                          ? Icons.move_down_rounded
                                          : Icons.add,
                                      size: 14,
                                      color: AppColors.textMuted,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isDragHovering
                                          ? 'Drop workout here'
                                          : 'Add workout',
                                      style: const TextStyle(
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
      },
    );
  }
}
