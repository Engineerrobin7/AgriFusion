import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

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
                'Recent Activity',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.chatHistory);
                },
                child: Text(
                  'View All',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ..._buildActivityList(context),
        ],
      ),
    );
  }

  List<Widget> _buildActivityList(BuildContext context) {
    final activities = [
      {
        'type': 'consultation',
        'title': 'Crop Disease Diagnosis',
        'description': 'Identified early blight on tomato leaves',
        'time': '2 hours ago',
        'icon': Icons.local_hospital,
        'color': Colors.red,
        'status': 'completed',
      },
      {
        'type': 'voice_query',
        'title': 'Voice Consultation',
        'description': 'Asked about organic fertilizer for wheat',
        'time': '1 day ago',
        'icon': Icons.mic,
        'color': Theme.of(context).primaryColor,
        'status': 'completed',
      },
      {
        'type': 'weather_alert',
        'title': 'Weather Alert Received',
        'description': 'Heavy rain warning for next 3 days',
        'time': '2 days ago',
        'icon': Icons.warning_amber,
        'color': Colors.orange,
        'status': 'alert',
      },
      {
        'type': 'community',
        'title': 'Community Discussion',
        'description': 'Participated in pest management discussion',
        'time': '3 days ago',
        'icon': Icons.forum,
        'color': Colors.blue,
        'status': 'completed',
      },
      {
        'type': 'camera_scan',
        'title': 'Camera Scan',
        'description': 'Scanned soil condition in field A',
        'time': '5 days ago',
        'icon': Icons.camera_alt,
        'color': Colors.purple,
        'status': 'completed',
      },
    ];

    return activities
        .map((activity) => _buildActivityItem(context, activity))
        .toList();
  }

  Widget _buildActivityItem(
      BuildContext context, Map<String, dynamic> activity) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: (activity['color'] as Color).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (activity['color'] as Color).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: (activity['color'] as Color).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              activity['icon'] as IconData,
              color: activity['color'] as Color,
              size: 6.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        activity['title'] as String,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    if (activity['status'] == 'alert')
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  activity['description'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.3,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      activity['time'] as String,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color
                                ?.withValues(alpha: 0.6),
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigateToDetails(context, activity['type'] as String);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: (activity['color'] as Color)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: activity['color'] as Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(width: 1.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                              color: activity['color'] as Color,
                            ),
                          ],
                        ),
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
  }

  void _navigateToDetails(BuildContext context, String activityType) {
    switch (activityType) {
      case 'consultation':
        Navigator.pushNamed(context, AppRoutes.cameraDiagnosis);
        break;
      case 'voice_query':
        Navigator.pushNamed(context, AppRoutes.voiceQuery);
        break;
      case 'weather_alert':
        Navigator.pushNamed(context, AppRoutes.weatherInsights);
        break;
      case 'community':
        Navigator.pushNamed(context, AppRoutes.chatHistory);
        break;
      case 'camera_scan':
        Navigator.pushNamed(context, AppRoutes.cameraDiagnosis);
        break;
      default:
        Navigator.pushNamed(context, AppRoutes.chatHistory);
    }
  }
}
