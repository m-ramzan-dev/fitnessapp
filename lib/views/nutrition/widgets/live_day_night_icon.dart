import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class LiveDayNightIcon extends StatefulWidget {
  const LiveDayNightIcon({
    super.key,
    this.dayStartHour = 6,
    this.nightStartHour = 18,
  });

  final int dayStartHour;
  final int nightStartHour;

  @override
  State<LiveDayNightIcon> createState() => _LiveDayNightIconState();
}

class _LiveDayNightIconState extends State<LiveDayNightIcon> {
  late DateTime _now;
  Timer? _timer;

  bool get _isDayTime {
    final hour = _now.hour;
    return hour >= widget.dayStartHour && hour < widget.nightStartHour;
  }

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!mounted) return;

      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      child: Icon(
        _isDayTime ? Icons.wb_sunny_rounded : Icons.nightlight_round_rounded,
        key: ValueKey(_isDayTime),
        color: AppColors.textPrimary,
        size: 22,
      ),
    );
  }
}
