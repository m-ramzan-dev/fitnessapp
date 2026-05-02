import 'package:fitnessapp/views/mood/widgets/mood_ring_picker.dart';
import 'package:fitnessapp/views/mood/widgets/screen_top_glow.dart';
import 'package:fitnessapp/views/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/mood_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/extensions.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mood = context.watch<MoodController>().mood;

    return Container(
      color: AppColors.background,
      child: Stack(
        children: [
          const ScreenTopGlow(),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mood',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Start your day',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'How are you feeling at the\nMoment?',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.17,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 38),
                  const Center(child: MoodRingPicker()),
                  const SizedBox(height: 22),
                  Center(
                    child: Text(
                      mood.label,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.9,
                      ),
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(label: "Continue"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
