import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

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
      height: 12.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              index: 0,
              iconName: 'language',
              label: 'Language',
              route: '/language-selection',
              context: context,
            ),
            _buildNavItem(
              index: 1,
              iconName: 'mic',
              label: 'Voice Query',
              route: '/voice-query',
              context: context,
            ),
            _buildNavItem(
              index: 2,
              iconName: 'camera_alt',
              label: 'Camera',
              route: '/camera-diagnosis',
              context: context,
            ),
            _buildNavItem(
              index: 3,
              iconName: 'wb_sunny',
              label: 'Weather',
              route: '/weather-insights',
              context: context,
            ),
            _buildNavItem(
              index: 4,
              iconName: 'chat',
              label: 'History',
              route: '/chat-history',
              context: context,
            ),
            _buildNavItem(
              index: 5,
              iconName: 'person',
              label: 'Profile',
              route: '/profile-settings',
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconName,
    required String label,
    required String route,
    required BuildContext context,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        onTap(index);
        if (!isSelected) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: isSelected
                  ? BoxDecoration(
                      color: AppTheme.lightTheme.primaryColor
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(3.w),
                    )
                  : null,
              child: CustomIconWidget(
                iconName: iconName,
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontSize: 9.sp,
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
