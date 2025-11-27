import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';

class WeatherSummaryWidget extends StatelessWidget {
  const WeatherSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
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
              Text(
                'Weather Summary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.weatherInsights);
                },
                child: Text(
                  'View Details',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              // Current Weather
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withValues(alpha: 0.1),
                        Colors.blue.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            color: Colors.orange,
                            size: 24,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Sunny',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        '28°C',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      Text(
                        'Feels like 32°C',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              // Today's Forecast
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildForecastItem(
                      context,
                      'Morning',
                      Icons.wb_sunny,
                      '26°C',
                      Colors.orange,
                    ),
                    SizedBox(height: 1.h),
                    _buildForecastItem(
                      context,
                      'Afternoon',
                      Icons.wb_sunny,
                      '32°C',
                      Colors.deepOrange,
                    ),
                    SizedBox(height: 1.h),
                    _buildForecastItem(
                      context,
                      'Evening',
                      Icons.cloud,
                      '24°C',
                      Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Critical Alert
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.amber.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Colors.amber[700],
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'High temperature expected. Consider irrigation in early morning.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.amber[700],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastItem(
    BuildContext context,
    String time,
    IconData icon,
    String temperature,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Text(
            temperature,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}
