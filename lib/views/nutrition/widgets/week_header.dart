import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class WeekHeader extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime weekStart;
  final List<DateTime> weekDays;
  final ValueChanged<DateTime> onDateSelected;

  const WeekHeader({
    required this.selectedDate,
    required this.weekStart,
    required this.weekDays,
    required this.onDateSelected,
  });

  static const _dayLabels = ['M', 'TU', 'W', 'TH', 'F', 'SA', 'SU'];
  static const _months = [
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

  bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isSelectedToday = _sameDay(selectedDate, today);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${isSelectedToday ? 'Today' : _dayName(selectedDate)}, '
          '${selectedDate.day} ${_months[selectedDate.month]} ${selectedDate.year}',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(weekDays.length, (index) {
            final date = weekDays[index];
            final selected = _sameDay(date, selectedDate);

            return GestureDetector(
              onTap: () => onDateSelected(date),
              behavior: HitTestBehavior.opaque,
              child: _DatePill(
                label: _dayLabels[index],
                day: date.day,
                selected: selected,
              ),
            );
          }),
        ),
      ],
    );
  }

  String _dayName(DateTime date) {
    const names = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return names[date.weekday - 1];
  }
}

class _DatePill extends StatelessWidget {
  final String label;
  final int day;
  final bool selected;

  const _DatePill({
    required this.label,
    required this.day,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surface2,
              shape: BoxShape.circle,
              border: selected
                  ? Border.all(color: AppColors.arms, width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                '$day',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: selected ? AppColors.arms : AppColors.background,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
