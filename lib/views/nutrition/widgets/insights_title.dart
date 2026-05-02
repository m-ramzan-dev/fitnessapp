import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/nutrition_controller.dart';
import '../../../utils/app_colors.dart';
import 'hydration_card.dart';
class InsightsTitle extends StatelessWidget {
  const InsightsTitle();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'My Insights',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}


