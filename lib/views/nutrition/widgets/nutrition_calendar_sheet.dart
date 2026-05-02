import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/nutrition_controller.dart';
import '../../../utils/app_colors.dart';
class NutritionCalendarSheet extends StatelessWidget {
  const NutritionCalendarSheet({super.key});

  static const _monthNames = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const _dayLabels = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionController>();
    final visibleMonth = nutrition.visibleCalendarMonth;
    final days = nutrition.visibleMonthCalendarDays;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFB7B7D9),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 22),

            Row(
              children: [
                GestureDetector(
                  onTap: nutrition.goToPreviousMonth,
                  behavior: HitTestBehavior.opaque,
                  child: const SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(
                      Icons.chevron_left_rounded,
                      color: AppColors.textPrimary,
                      size: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${_monthNames[visibleMonth.month]} ${visibleMonth.year}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: nutrition.goToNextMonth,
                  behavior: HitTestBehavior.opaque,
                  child: const SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textPrimary,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: _dayLabels.map((label) {
                return Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 13),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: days.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 11,
                crossAxisSpacing: 7,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final date = days[index];

                final isSelected = NutritionController.isSameDay(
                  date,
                  nutrition.selectedDate,
                );

                final isCurrentMonth = NutritionController.isSameMonth(
                  date,
                  visibleMonth,
                );

                return _CalendarDayCell(
                  date: date,
                  isSelected: isSelected,
                  isCurrentMonth: isCurrentMonth,
                  onTap: () {
                    nutrition.selectDate(date);
                    Navigator.pop(context);
                  },
                );
              },
            ),

            const SizedBox(height: 18),

            Container(
              width: 156,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFF9797BE),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isCurrentMonth;
  final VoidCallback onTap;

  const _CalendarDayCell({
    required this.date,
    required this.isSelected,
    required this.isCurrentMonth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isCurrentMonth
        ? AppColors.textPrimary
        : AppColors.textMuted.withOpacity(0.45);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? AppColors.arms.withOpacity(0.16)
                : Colors.transparent,
            border: isSelected
                ? Border.all(
              color: AppColors.arms,
              width: 2,
            )
                : null,
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}