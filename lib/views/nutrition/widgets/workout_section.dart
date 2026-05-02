import 'package:fitnessapp/views/nutrition/widgets/live_day_night_icon.dart';
import 'package:flutter/material.dart';

import '../../../models/workout_entry.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/extensions.dart';

class WorkoutSection extends StatelessWidget {
  final List<WorkoutEntry> workouts;

  const WorkoutSection({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Workouts',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
              ),
            ),
            Spacer(),
            LiveDayNightIcon(),
            SizedBox(width: 10),
            Text(
              '9°',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 23,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (workouts.isEmpty)
          const _EmptyWorkoutCard()
        else
          ...workouts.map(
            (workout) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _SyncedWorkoutCard(workout: workout),
            ),
          ),
      ],
    );
  }
}

class _SyncedWorkoutCard extends StatelessWidget {
  final WorkoutEntry workout;

  const _SyncedWorkoutCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(7),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            width: 7,
            decoration: BoxDecoration(
              color: workout.type.color,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(7),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(17, 14, 18, 14),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_formatMonthDay(workout.date)} - ${workout.durationLabel}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            workout.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.textPrimary,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatMonthDay(DateTime date) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month]} ${date.day}';
  }
}

class _EmptyWorkoutCard extends StatelessWidget {
  const _EmptyWorkoutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Text(
        'No workout scheduled',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
