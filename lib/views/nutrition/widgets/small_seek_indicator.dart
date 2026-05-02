import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
class SmallWeekIndicator extends StatelessWidget {
  const SmallWeekIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 37,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.legs.withOpacity(0.42),
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}