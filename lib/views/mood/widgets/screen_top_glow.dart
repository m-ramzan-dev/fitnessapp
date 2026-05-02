import 'package:flutter/material.dart';

class ScreenTopGlow extends StatelessWidget {
  const ScreenTopGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -170,
      left: -60,
      right: -60,
      child: Container(
        height: 340,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 0.9,
            colors: [Color(0x884E68A8), Color(0x330B5A5B), Colors.transparent],
          ),
        ),
      ),
    );
  }
}
