import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
class MoodFace extends StatelessWidget {
  final MoodType mood;
  final double size;

  const MoodFace({
    super.key,
    required this.mood,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: mood.faceColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CustomPaint(
        painter: _MoodFacePainter(mood),
      ),
    );
  }
}

class _MoodFacePainter extends CustomPainter {
  final MoodType mood;

  _MoodFacePainter(this.mood);

  @override
  void paint(Canvas canvas, Size size) {
    final facePaint = Paint()
      ..color = const Color(0xFF173F3F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF173F3F)
      ..style = PaintingStyle.fill;

    final blushPaint = Paint()
      ..color = const Color(0xFFF17AAA)
      ..style = PaintingStyle.fill;

    switch (mood) {
      case MoodType.calm:
        _drawCalm(canvas, size, facePaint, blushPaint);
        break;
      case MoodType.content:
        _drawContent(canvas, size, facePaint, fillPaint);
        break;
      case MoodType.happy:
        _drawHappy(canvas, size, facePaint);
        break;
      case MoodType.peaceful:
        _drawPeaceful(canvas, size, fillPaint);
        break;
    }
  }

  void _drawCalm(
      Canvas canvas,
      Size size,
      Paint facePaint,
      Paint blushPaint,
      ) {
    canvas.drawArc(
      Rect.fromLTWH(size.width * 0.22, size.height * 0.40, 22, 18),
      math.pi * 1.1,
      math.pi * 0.75,
      false,
      facePaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(size.width * 0.62, size.height * 0.40, 22, 18),
      math.pi * 1.1,
      math.pi * 0.75,
      false,
      facePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.24, size.height * 0.59),
      7,
      blushPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.86, size.height * 0.59),
      7,
      blushPaint,
    );

    final mouthPaint = Paint()
      ..color = const Color(0xFFF17AAA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.49, size.height * 0.70)
      ..quadraticBezierTo(
        size.width * 0.52,
        size.height * 0.64,
        size.width * 0.56,
        size.height * 0.70,
      );

    canvas.drawPath(path, mouthPaint);
  }

  void _drawContent(
      Canvas canvas,
      Size size,
      Paint facePaint,
      Paint fillPaint,
      ) {
    canvas.drawArc(
      Rect.fromLTWH(size.width * 0.20, size.height * 0.35, 28, 23),
      math.pi * 1.05,
      math.pi * 0.85,
      false,
      facePaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(size.width * 0.58, size.height * 0.35, 28, 23),
      math.pi * 1.05,
      math.pi * 0.85,
      false,
      facePaint,
    );

    final mouthPath = Path()
      ..moveTo(size.width * 0.31, size.height * 0.58)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.82,
        size.width * 0.70,
        size.height * 0.58,
      )
      ..close();

    canvas.drawPath(mouthPath, fillPaint);
  }

  void _drawHappy(Canvas canvas, Size size, Paint facePaint) {
    canvas.drawArc(
      Rect.fromLTWH(size.width * 0.22, size.height * 0.37, 25, 22),
      math.pi,
      math.pi,
      false,
      facePaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(size.width * 0.58, size.height * 0.37, 25, 22),
      math.pi,
      math.pi,
      false,
      facePaint,
    );

    final mouthPath = Path()
      ..moveTo(size.width * 0.24, size.height * 0.63)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.82,
        size.width * 0.76,
        size.height * 0.63,
      );

    canvas.drawPath(mouthPath, facePaint);
  }

  void _drawPeaceful(Canvas canvas, Size size, Paint fillPaint) {
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.30, size.height * 0.38),
        width: 9,
        height: 17,
      ),
      fillPaint,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.72, size.height * 0.38),
        width: 9,
        height: 17,
      ),
      fillPaint,
    );

    final mouthPath = Path()
      ..moveTo(size.width * 0.31, size.height * 0.57)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.77,
        size.width * 0.69,
        size.height * 0.57,
      )
      ..close();

    canvas.drawPath(mouthPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood;
  }
}