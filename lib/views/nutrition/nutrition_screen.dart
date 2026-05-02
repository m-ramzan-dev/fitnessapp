import 'package:fitnessapp/views/nutrition/widgets/insight_grid.dart';
import 'package:fitnessapp/views/nutrition/widgets/insights_title.dart';
import 'package:fitnessapp/views/nutrition/widgets/nutrition_top_row.dart';
import 'package:fitnessapp/views/nutrition/widgets/small_seek_indicator.dart';
import 'package:fitnessapp/views/nutrition/widgets/week_header.dart';
import 'package:fitnessapp/views/nutrition/widgets/workout_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/nutrition_controller.dart';
import '../../controllers/plan_controller.dart';
import '../../utils/app_colors.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionController>();
    final plan = context.watch<PlanController>();

    final weekStart = plan.getWeekStart(nutrition.selectedDate);
    final weekDays = plan.getWeekDays(weekStart);
    final workouts = plan.workoutsFor(nutrition.selectedDate);

    return Container(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          children: [
            const NutritionTopRow(),
            const SizedBox(height: 34),
            WeekHeader(
              selectedDate: nutrition.selectedDate,
              weekStart: weekStart,
              weekDays: weekDays,
              onDateSelected: nutrition.selectDate,
            ),
            const SizedBox(height: 12),
            const SmallWeekIndicator(),
            const SizedBox(height: 28),
            WorkoutSection(workouts: workouts),
            const SizedBox(height: 30),
            const InsightsTitle(),
            const SizedBox(height: 24),
            const InsightGrid(),
          ],
        ),
      ),
    );
  }
}