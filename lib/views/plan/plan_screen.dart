import 'package:fitnessapp/views/plan/widgets/add_workout_sheet.dart';
import 'package:fitnessapp/views/plan/widgets/header.dart';
import 'package:fitnessapp/views/plan/widgets/week_separator.dart';
import 'package:fitnessapp/views/plan/widgets/week_block.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/plan_controller.dart';
import '../../utils/app_colors.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlanController>();

    return SafeArea(
      child: Column(
        children: [
          Header(),
          const WeekSeparator(color: AppColors.arms),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 16),
              children: [
                WeekBlock(
                  weekStart: controller.currentWeekStart,
                  onAdd: (date) => _showAddSheet(context, date),
                ),
                const WeekSeparator(),
                WeekBlock(
                  weekStart: controller.nextWeekStart,
                  onAdd: (date) => _showAddSheet(context, date),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context, DateTime date) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: context.read<PlanController>(),
          child: AddWorkoutSheet(date: date),
        );
      },
    );
  }
}
