import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class SupportSectionWidget extends StatelessWidget {
  final VoidCallback onHelpPressed;
  final VoidCallback onTutorialsPressed;
  final VoidCallback onContactExpertPressed;
  final VoidCallback onExportDataPressed;

  const SupportSectionWidget({
    super.key,
    required this.onHelpPressed,
    required this.onTutorialsPressed,
    required this.onContactExpertPressed,
    required this.onExportDataPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'support_agent',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Support & Help',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          _buildSupportOption(
            'Help Documentation',
            'Browse through comprehensive help guides',
            'help',
            onHelpPressed,
          ),
          SizedBox(height: 2.h),
          _buildSupportOption(
            'Tutorial Videos',
            'Watch step-by-step video tutorials',
            'play_circle',
            onTutorialsPressed,
          ),
          SizedBox(height: 2.h),
          _buildSupportOption(
            'Contact Agricultural Expert',
            'Get personalized advice from experts',
            'person',
            onContactExpertPressed,
          ),
          SizedBox(height: 2.h),
          _buildSupportOption(
            'Export Data',
            'Download your consultation history and data',
            'download',
            onExportDataPressed,
          ),
          SizedBox(height: 3.h),
          _buildPrivacySection(),
        ],
      ),
    );
  }

  Widget _buildSupportOption(
    String title,
    String description,
    String iconName,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          border: Border.all(
            color: AppTheme.dividerLight.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: AppTheme.lightTheme.primaryColor,
                size: 5.w,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimaryLight,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    description,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: AppTheme.textSecondaryLight,
              size: 5.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy & Data',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.primaryColor,
          ),
        ),
        SizedBox(height: 2.h),
        _buildPrivacyOption(
          'Data Sharing Preferences',
          'Manage how your data is shared',
          'share',
        ),
        SizedBox(height: 1.h),
        _buildPrivacyOption(
          'Location Access',
          'Control location-based services',
          'location_on',
        ),
        SizedBox(height: 1.h),
        _buildPrivacyOption(
          'Agricultural Data Usage',
          'Manage usage of your farming data',
          'agriculture',
        ),
      ],
    );
  }

  Widget _buildPrivacyOption(
      String title, String description, String iconName) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        border: Border.all(
          color: AppTheme.dividerLight.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: AppTheme.textSecondaryLight,
            size: 4.w,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimaryLight,
                  ),
                ),
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryLight,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (bool value) {
              // Handle privacy setting toggle
            },
            activeColor: AppTheme.lightTheme.primaryColor,
            activeTrackColor:
                AppTheme.lightTheme.primaryColor.withValues(alpha: 0.5),
            inactiveThumbColor: AppTheme.textDisabledLight,
            inactiveTrackColor:
                AppTheme.textDisabledLight.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
