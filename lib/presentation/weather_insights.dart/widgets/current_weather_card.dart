import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CurrentWeatherCard extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const CurrentWeatherCard({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weatherData['temperature']}°C',
                      style:
                          AppTheme.lightTheme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryLight,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      weatherData['condition'] as String,
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.textSecondaryLight,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Feels like ${weatherData['feelsLike']}°C',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: weatherData['icon'] as String,
                  size: 10.w,
                  color: AppTheme.primaryLight,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildWeatherMetric(
                  'Humidity',
                  '${weatherData['humidity']}%',
                  'water_drop',
                ),
              ),
              Expanded(
                child: _buildWeatherMetric(
                  'Wind',
                  '${weatherData['windSpeed']} km/h',
                  'air',
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: _buildWeatherMetric(
                  'Rainfall',
                  '${weatherData['rainfall']} mm',
                  'grain',
                ),
              ),
              Expanded(
                child: _buildWeatherMetric(
                  'UV Index',
                  '${weatherData['uvIndex']}',
                  'wb_sunny',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherMetric(String label, String value, String iconName) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                size: 4.w,
                color: AppTheme.textSecondaryLight,
              ),
              SizedBox(width: 1.w),
              Text(
                label,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryLight,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
