import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/nutrition_controller.dart';
import '../../../utils/app_colors.dart';
import 'hydration_card.dart';
class InsightGrid extends StatelessWidget {
  const InsightGrid();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: _CaloriesCard()),
            SizedBox(width: 13),
            Expanded(child: _WeightCard()),
          ],
        ),
        SizedBox(height: 13),
        HydrationCard(),
      ],
    );
  }
}

class _CaloriesCard extends StatelessWidget {
  const _CaloriesCard();

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionController>();

    return Container(
      height: 151,
      padding: const EdgeInsets.fromLTRB(15, 13, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${nutrition.calories}',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 41,
                  fontWeight: FontWeight.w500,
                  height: 1,
                  letterSpacing: -1.2,
                ),
              ),
              const SizedBox(width: 1),
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Calories',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '${nutrition.remainingCalories} Remaining',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '0',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              Text(
                '${nutrition.calorieGoal}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: nutrition.calorieProgress,
              minHeight: 5,
              backgroundColor: AppColors.textMuted.withOpacity(0.6),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF65D7C7)),
            ),
          ),
        ],
      ),
    );
  }
}
class _WeightCard extends StatelessWidget {
  const _WeightCard();

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionController>();

    return Container(
      height: 151,
      padding: const EdgeInsets.fromLTRB(15, 13, 14, 13),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                nutrition.weightKg.toStringAsFixed(0),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 41,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  letterSpacing: -1.2,
                ),
              ),
              const SizedBox(width: 4),
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  'kg',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF158B42),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: AppColors.arms,
                  size: 11,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '+${nutrition.weightDeltaKg.toStringAsFixed(1)}kg',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'Weight',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}
