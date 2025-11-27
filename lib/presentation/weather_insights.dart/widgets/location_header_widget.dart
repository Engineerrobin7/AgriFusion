import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LocationHeaderWidget extends StatelessWidget {
  final String location;
  final String lastUpdated;
  final VoidCallback onLocationTap;

  const LocationHeaderWidget({
    super.key,
    required this.location,
    required this.lastUpdated,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onLocationTap,
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'location_on',
                          size: 6.w,
                          color: AppTheme.primaryLight,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location,
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimaryLight,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                'Tap to change location',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'refresh',
                        size: 4.w,
                        color: AppTheme.primaryLight,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Live',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                  'Last updated: $lastUpdated',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
