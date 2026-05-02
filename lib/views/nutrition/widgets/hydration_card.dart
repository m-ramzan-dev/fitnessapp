import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/nutrition_controller.dart';
import '../../../utils/app_colors.dart';
class HydrationCard extends StatelessWidget {
  const HydrationCard();

  @override
  Widget build(BuildContext context) {
    final nutrition = context.watch<NutritionController>();

    return Container(
      height: 193,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(7),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 16, 15, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${(nutrition.hydrationProgress * 100).round()}%',
                            style: const TextStyle(
                              color: Color(0xFF58B7FF),
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              height: 1,
                              letterSpacing: -1.4,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Hydration',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Log Now',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 165,
                    child: _HydrationScale(
                      liters: nutrition.hydrationLiters,
                      goalLiters: nutrition.hydrationGoalLiters,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.read<NutritionController>().logWater(0.5),
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 41,
              alignment: Alignment.center,
              color: const Color(0xFF173F46),
              child: const Text(
                '500 ml added to water log',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationScale extends StatelessWidget {
  final double liters;
  final double goalLiters;

  const _HydrationScale({
    required this.liters,
    required this.goalLiters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '2 L',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '0 L',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 18,
            height: 113,
            child: CustomPaint(
              painter: _HydrationTicksPainter(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                height: 1,
                color: AppColors.textMuted.withOpacity(0.45),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Text(
              '${liters.toStringAsFixed(1)} L',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationTicksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final inactivePaint = Paint()
      ..color = AppColors.textMuted.withOpacity(0.65)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = const Color(0xFF58B7FF)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const tickCount = 10;

    for (int index = 0; index <= tickCount; index++) {
      final y = size.height * index / tickCount;
      final isMajor = index == 0 || index == 5 || index == 10;
      final width = isMajor ? 7.5 : 3.5;

      canvas.drawLine(
        Offset(0, y),
        Offset(width, y),
        isMajor ? activePaint : inactivePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HydrationTicksPainter oldDelegate) {
    return false;
  }
}
