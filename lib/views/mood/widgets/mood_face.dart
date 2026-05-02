import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.96,
              end: 1,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: SvgPicture.asset(
        mood.faceAsset,
        key: ValueKey(mood),
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}