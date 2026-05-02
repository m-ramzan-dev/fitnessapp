import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/mood_controller.dart';
import 'mood_face.dart';
import 'mood_ring_painter.dart';

class MoodRingPicker extends StatelessWidget {
  const MoodRingPicker({super.key});

  static const double ringSize = 282;
  static const double ringStroke = 31;
  static const double knobSize = 57;

  // Extra room around the ring so the knob never gets cropped.
  static const double knobOverflow = knobSize / 2 + 4;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MoodController>();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (details) {
        controller.updateFromDrag(
          localPosition: _toRingLocalPosition(details.localPosition),
          size: const Size(ringSize, ringSize),
        );
      },
      onPanUpdate: (details) {
        controller.updateFromDrag(
          localPosition: _toRingLocalPosition(details.localPosition),
          size: const Size(ringSize, ringSize),
        );
      },
      child: SizedBox(
        width: ringSize + knobOverflow * 2,
        height: ringSize + knobOverflow * 2,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              left: knobOverflow,
              top: knobOverflow,
              child: SizedBox(
                width: ringSize,
                height: ringSize,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(ringSize, ringSize),
                      painter: MoodRingPainter(),
                    ),
                    MoodFace(mood: controller.mood, size: 110),
                    _MoodKnob(
                      angle: controller.angle,
                      ringSize: ringSize,
                      ringStroke: ringStroke,
                      knobSize: knobSize,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Offset _toRingLocalPosition(Offset position) {
    return Offset(position.dx - knobOverflow, position.dy - knobOverflow);
  }
}

class _MoodKnob extends StatelessWidget {
  final double angle;
  final double ringSize;
  final double ringStroke;
  final double knobSize;

  const _MoodKnob({
    required this.angle,
    required this.ringSize,
    required this.ringStroke,
    required this.knobSize,
  });

  @override
  Widget build(BuildContext context) {
    final radius = (ringSize - ringStroke) / 2;
    final center = ringSize / 2;

    final x = center + math.cos(angle) * radius - knobSize / 2;
    final y = center + math.sin(angle) * radius - knobSize / 2;

    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: knobSize,
        height: knobSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE8F7F3),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 16,
              offset: const Offset(0, 7),
            ),
          ],
        ),
      ),
    );
  }
}
