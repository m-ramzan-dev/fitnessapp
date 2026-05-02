import 'dart:math' as math;

import 'package:flutter/material.dart';
class MoodRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final ringRect = rect.deflate(15.5);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 31
      ..strokeCap = StrokeCap.butt
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: [
          Color(0xFFFF9A58),
          Color(0xFFFFA25D),
          Color(0xFFF47FA9),
          Color(0xFFEE7DA8),
          Color(0xFFC8B7F2),
          Color(0xFF8ACEC4),
          Color(0xFFFF9A58),
        ],
        stops: [
          0.00,
          0.18,
          0.38,
          0.55,
          0.72,
          0.88,
          1.00,
        ],
      ).createShader(ringRect);

    canvas.drawArc(
      ringRect,
      0,
      math.pi * 2,
      false,
      paint,
    );

    final dividerPaint = Paint()
      ..color = Colors.white.withOpacity(0.16)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 1;
    final innerRadius = outerRadius - 31;

    final dividerAngles = [
      -math.pi / 2,
      -math.pi / 4,
      0,
      math.pi / 4,
      math.pi / 2,
      math.pi * 0.75,
      math.pi,
      math.pi * 1.25,
    ];

    for (final angle in dividerAngles) {
      final start = Offset(
        center.dx + math.cos(angle) * innerRadius,
        center.dy + math.sin(angle) * innerRadius,
      );

      final end = Offset(
        center.dx + math.cos(angle) * outerRadius,
        center.dy + math.sin(angle) * outerRadius,
      );

      canvas.drawLine(start, end, dividerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant MoodRingPainter oldDelegate) {
    return false;
  }
}