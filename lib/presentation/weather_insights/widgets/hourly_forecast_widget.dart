import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HourlyForecastWidget extends StatelessWidget {
  final List<Map<String, dynamic>> hourlyData;

  const HourlyForecastWidget({
    super.key,
    required this.hourlyData,
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
              'Hourly Forecast',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryLight,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 15.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              itemBuilder: (context, index) {
                final hour = hourlyData[index];
                return Container(
                  width: 18.w,
                  margin: EdgeInsets.only(right: 3.w),
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.dividerLight.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        hour['time'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomIconWidget(
                        iconName: hour['icon'] as String,
                        size: 6.w,
                        color: AppTheme.primaryLight,
                      ),
                      Text(
                        '${hour['temperature']}°',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimaryLight,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'water_drop',
                            size: 3.w,
                            color: AppTheme.secondaryLight,
                          ),
                          SizedBox(width: 0.5.w),
                          Text(
                            '${hour['precipitation']}%',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.secondaryLight,
                              fontSize: 8.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
