import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/nutrition_controller.dart';
import '../../../controllers/plan_controller.dart';
import '../../../utils/app_colors.dart';

class NutritionTopRow extends StatelessWidget {
  const NutritionTopRow();

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionController>();
    final plan = context.watch<PlanController>();

    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/bell_icon.svg',
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/timelapse.svg',
              height: 18,
              width: 18,
              colorFilter: ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),

            const SizedBox(width: 6),
            Text(
              plan.formatWeekLabel(plan.getWeekStart(nutrition.selectedDate)),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.1,
              ),
            ),
            const SizedBox(width: 2),
            SvgPicture.asset(
              'assets/icons/arrow_down_filled.svg',
              height: 6,
              width: 6,
              colorFilter: ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
        const Spacer(),
        const SizedBox(width: 24),
      ],
    );
  }
}
