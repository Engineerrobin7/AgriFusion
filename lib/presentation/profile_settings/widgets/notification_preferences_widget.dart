import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class NotificationPreferencesWidget extends StatefulWidget {
  final Map<String, dynamic> notificationSettings;
  final Function(String key, bool value) onToggle;

  const NotificationPreferencesWidget({
    super.key,
    required this.notificationSettings,
    required this.onToggle,
  });

  @override
  State<NotificationPreferencesWidget> createState() =>
      _NotificationPreferencesWidgetState();
}

class _NotificationPreferencesWidgetState
    extends State<NotificationPreferencesWidget> {
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
                iconName: 'notifications',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Notification Preferences',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          _buildNotificationToggle(
            'Weather Alerts',
            'Get notified about weather changes and warnings',
            'weatherAlerts',
            'cloud',
          ),
          SizedBox(height: 2.h),
          _buildNotificationToggle(
            'Government Schemes',
            'Updates on new agricultural schemes and subsidies',
            'governmentSchemes',
            'account_balance',
          ),
          SizedBox(height: 2.h),
          _buildNotificationToggle(
            'Seasonal Reminders',
            'Crop calendar and seasonal farming reminders',
            'seasonalReminders',
            'schedule',
          ),
          SizedBox(height: 2.h),
          _buildNotificationToggle(
            'Market Prices',
            'Daily updates on crop market prices',
            'marketPrices',
            'trending_up',
          ),
          SizedBox(height: 2.h),
          _buildNotificationToggle(
            'Expert Tips',
            'Agricultural tips and best practices',
            'expertTips',
            'lightbulb',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String description,
    String key,
    String iconName,
  ) {
    final bool isEnabled = widget.notificationSettings[key] as bool? ?? false;

    return Container(
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
              color: isEnabled
                  ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                  : AppTheme.textDisabledLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: CustomIconWidget(
              iconName: iconName,
              color: isEnabled
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.textDisabledLight,
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
          Switch(
            value: isEnabled,
            onChanged: (bool value) {
              widget.onToggle(key, value);
            },
            activeThumbColor: AppTheme.lightTheme.primaryColor,
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
