import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';

class HomeDashboardBottomNavigation extends StatefulWidget {
  const HomeDashboardBottomNavigation({super.key});

  @override
  State<HomeDashboardBottomNavigation> createState() =>
      _HomeDashboardBottomNavigationState();
}

class _HomeDashboardBottomNavigationState
    extends State<HomeDashboardBottomNavigation> {
  int _selectedIndex = 0; // Dashboard tab is active

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on dashboard
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.cameraDiagnosis);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.weatherInsights);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.chatHistory);
        break;
      case 4:
        Navigator.pushNamed(context, AppRoutes.profileSettings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.dashboard,
                activeIcon: Icons.dashboard,
                label: 'Dashboard',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.camera_alt_outlined,
                activeIcon: Icons.camera_alt,
                label: 'Scan',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.wb_sunny_outlined,
                activeIcon: Icons.wb_sunny,
                label: 'Weather',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'History',
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool isSelected = _selectedIndex == index;
    final Color activeColor = Theme.of(context).primaryColor;
    final Color inactiveColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
            Colors.grey;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 4.w : 2.w,
          vertical: 1.h,
        ),
        decoration: isSelected
            ? BoxDecoration(
                color: activeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected ? activeColor : inactiveColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
