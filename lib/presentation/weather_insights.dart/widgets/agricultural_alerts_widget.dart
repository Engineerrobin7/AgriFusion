import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AgriculturalAlertsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> alerts;

  const AgriculturalAlertsWidget({
    super.key,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              'Agricultural Alerts',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryLight,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Container(
                margin: EdgeInsets.only(bottom: 1.h),
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: _getAlertColor(alert['type'] as String)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getAlertColor(alert['type'] as String)
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: _getAlertColor(alert['type'] as String),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomIconWidget(
                        iconName: _getAlertIcon(alert['type'] as String),
                        size: 5.w,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert['title'] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimaryLight,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            alert['description'] as String,
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondaryLight,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'schedule',
                                size: 3.w,
                                color: AppTheme.textSecondaryLight,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                alert['time'] as String,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getAlertColor(String type) {
    switch (type.toLowerCase()) {
      case 'warning':
        return AppTheme.warningLight;
      case 'danger':
        return AppTheme.errorLight;
      case 'info':
        return AppTheme.primaryLight;
      default:
        return AppTheme.successLight;
    }
  }

  String _getAlertIcon(String type) {
    switch (type.toLowerCase()) {
      case 'warning':
        return 'warning';
      case 'danger':
        return 'dangerous';
      case 'info':
        return 'info';
      default:
        return 'check_circle';
    }
  }
}
