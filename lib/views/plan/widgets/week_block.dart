import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/plan_controller.dart';
import '../../../utils/app_colors.dart';
import 'day_row.dart';
class WeekBlock extends StatelessWidget {
  final DateTime weekStart;
  final ValueChanged<DateTime> onAdd;

  const WeekBlock({
    super.key,
    required this.weekStart,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlanController>();
    final weekDays = controller.getWeekDays(weekStart);
    final totalMinutes = controller.weekTotalMinutes(weekStart);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.formatWeekLabel(weekStart),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      controller.formatDateRange(weekStart),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  totalMinutes > 0 ? 'Total: ${totalMinutes}min' : 'Rest week',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...weekDays.map(
                (day) => DayRow(
              day: day,
              isToday: controller.isToday(day),
              workouts: controller.workoutsFor(day),
              onAdd: () => onAdd(day),
              onDelete: controller.deleteWorkout,
            ),
          ),
        ],
      ),
    );
  }
}
