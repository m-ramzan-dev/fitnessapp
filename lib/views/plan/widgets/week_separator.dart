import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class WeekSeparator extends StatelessWidget {
  final Color? color;

  const WeekSeparator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: color ?? AppColors.legs,
        border: Border.symmetric(
          horizontal: BorderSide(color: color ?? AppColors.legs),
        ),
      ),
    );
  }
}
