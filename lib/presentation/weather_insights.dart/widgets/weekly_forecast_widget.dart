import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WeeklyForecastWidget extends StatelessWidget {
  final List<Map<String, dynamic>> weeklyData;

  const WeeklyForecastWidget({
    super.key,
    required this.weeklyData,
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
              '7-Day Forecast',
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
            itemCount: weeklyData.length,
            itemBuilder: (context, index) {
              final day = weeklyData[index];
              return Container(
                margin: EdgeInsets.only(bottom: 1.h),
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowLight,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            day['day'] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimaryLight,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            day['date'] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CustomIconWidget(
                        iconName: day['icon'] as String,
                        size: 6.w,
                        color: AppTheme.primaryLight,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${day['high']}°',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimaryLight,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '${day['low']}°',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: AppTheme.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomIconWidget(
                                iconName: 'water_drop',
                                size: 3.w,
                                color: AppTheme.secondaryLight,
                              ),
                              SizedBox(width: 0.5.w),
                              Text(
                                '${day['rainfall']} mm',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.secondaryLight,
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
}
