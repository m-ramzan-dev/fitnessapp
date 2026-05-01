import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/main_tab_controller.dart';
import '../utils/app_colors.dart';
import 'shared/app_bottom_nav.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _pages = [
    _PlaceholderScreen(title: 'Nutrition'),
    _PlaceholderScreen(title: 'Plan'),
    _PlaceholderScreen(title: 'Mood'),
    _PlaceholderScreen(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final tabController = context.watch<MainTabController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: tabController.currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: tabController.currentIndex,
        onTap: tabController.changeTab,
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}