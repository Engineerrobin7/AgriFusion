import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final String? imagePath;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onButtonPressed,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 60.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'chat_bubble_outline',
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.6),
                    size: 20.w,
                  ),
                  SizedBox(height: 2.h),
                  CustomIconWidget(
                    iconName: 'agriculture',
                    color: AppTheme.cropHealthy.withValues(alpha: 0.8),
                    size: 12.w,
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),

            // Title
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimaryLight,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),

            // Subtitle
            Text(
              subtitle,
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondaryLight,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),

            // Action Button
            if (onButtonPressed != null)
              SizedBox(
                width: 70.w,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                    foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'mic',
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        buttonText,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 2.h),

            // Additional help text
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      AppTheme.lightTheme.dividerColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'lightbulb_outline',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          'You can ask about:',
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            color: AppTheme.textPrimaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  _buildHelpItem('Crop diseases and treatments'),
                  _buildHelpItem('Fertilizer recommendations'),
                  _buildHelpItem('Weather updates and alerts'),
                  _buildHelpItem('Government agricultural schemes'),
                  _buildHelpItem('Best farming practices'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          SizedBox(width: 7.w),
          CustomIconWidget(
            iconName: 'check_circle_outline',
            color: AppTheme.cropHealthy,
            size: 4.w,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              text,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

