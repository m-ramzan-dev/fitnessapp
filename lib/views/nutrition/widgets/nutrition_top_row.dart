import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/nutrition_controller.dart';
import '../../../controllers/plan_controller.dart';
import '../../../utils/app_colors.dart';
import 'nutrition_calendar_sheet.dart';

class NutritionTopRow extends StatelessWidget {
  const NutritionTopRow({super.key});

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionController>();

    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/bell_icon.svg",
          height: 24,
          width: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.textPrimary,
            BlendMode.srcIn,
          ),
        ),

        const Spacer(),
        GestureDetector(
          onTap: () => _showCalendarSheet(context),
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/icons/timelapse.svg",
                height: 18,
                width: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),

              const SizedBox(width: 6),
              Text(
                nutrition.selectedWeekLabel,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.1,
                ),
              ),
              const SizedBox(width: 6),
              SvgPicture.asset(
                "assets/icons/arrow_down_filled.svg",
                height: 6,
                width: 6,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        const SizedBox(width: 24),
      ],
    );
  }

  void _showCalendarSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.72),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: context.read<NutritionController>(),
          child: const NutritionCalendarSheet(),
        );
      },
    );
  }
}
