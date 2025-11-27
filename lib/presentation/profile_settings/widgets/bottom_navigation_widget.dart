import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 12.h,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, 'language', 'Language', '/language-selection'),
              _buildNavItem(1, 'mic', 'Voice', '/voice-query'),
              _buildNavItem(2, 'camera_alt', 'Camera', '/camera-diagnosis'),
              _buildNavItem(3, 'cloud', 'Weather', '/weather-insights'),
              _buildNavItem(4, 'chat', 'History', '/chat-history'),
              _buildNavItem(5, 'person', 'Profile', '/profile-settings'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconName, String label, String route) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 12.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(1.5.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.textSecondaryLight,
                size: 5.w,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.textSecondaryLight,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                fontSize: 9.sp,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
