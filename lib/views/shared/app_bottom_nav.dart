import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_BottomNavItem> _items = [
    _BottomNavItem(
      label: 'Nutrition',
      iconPath: 'assets/icons/bottom_nav_nutrition_icon.svg',
    ),
    _BottomNavItem(
      label: 'Plan',
      iconPath: 'assets/icons/bottom_nav_plan_icon.svg',
    ),
    _BottomNavItem(
      label: 'Mood',
      iconPath: 'assets/icons/bottom_nav_mood_icon.svg',
    ),
    _BottomNavItem(
      label: 'Profile',
      iconPath: 'assets/icons/bottom_nav_profile_icon.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      margin: EdgeInsets.only(bottom: 6),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.navDivider, width: 1)),
      ),
      child: Row(
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isActive = currentIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(top: 11),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      item.iconPath,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        isActive ? AppColors.white : AppColors.navInactive,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.15,
                        fontWeight: FontWeight.w400,
                        color: isActive
                            ? AppColors.white
                            : AppColors.navInactive,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomNavItem {
  final String label;
  final String iconPath;

  const _BottomNavItem({required this.label, required this.iconPath});
}
