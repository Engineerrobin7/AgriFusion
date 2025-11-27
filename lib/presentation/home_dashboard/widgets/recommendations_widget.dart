import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecommendationsWidget extends StatelessWidget {
  const RecommendationsWidget({super.key});

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
                "Today's Recommendations",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'AI Powered',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ..._buildRecommendationsList(context),
        ],
      ),
    );
  }

  List<Widget> _buildRecommendationsList(BuildContext context) {
    final recommendations = [
      {
        'title': 'Irrigation Schedule',
        'description':
            'Water your tomato crops between 6-8 AM for optimal absorption',
        'icon': Icons.water_drop,
        'color': Colors.blue,
        'priority': 'High',
        'timeEstimate': '30 min',
      },
      {
        'title': 'Pest Monitoring',
        'description':
            'Check for aphids on wheat crops, especially lower leaves',
        'icon': Icons.bug_report,
        'color': Colors.red,
        'priority': 'Medium',
        'timeEstimate': '15 min',
      },
      {
        'title': 'Fertilizer Application',
        'description':
            'Apply nitrogen fertilizer to corn fields before evening',
        'icon': Icons.scatter_plot,
        'color': Colors.green,
        'priority': 'Medium',
        'timeEstimate': '45 min',
      },
      {
        'title': 'Weather Preparation',
        'description':
            'Prepare cover for vegetable crops due to expected rain tomorrow',
        'icon': Icons.umbrella,
        'color': Colors.orange,
        'priority': 'High',
        'timeEstimate': '60 min',
      },
    ];

    return recommendations
        .map((rec) => _buildRecommendationItem(context, rec))
        .toList();
  }

  Widget _buildRecommendationItem(
      BuildContext context, Map<String, dynamic> recommendation) {
    final Color priorityColor =
        recommendation['priority'] == 'High' ? Colors.red : Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: (recommendation['color'] as Color).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (recommendation['color'] as Color).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color:
                      (recommendation['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  recommendation['icon'] as IconData,
                  color: recommendation['color'] as Color,
                  size: 5.w,
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
                        Text(
                          recommendation['title'] as String,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: priorityColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            recommendation['priority'] as String,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: priorityColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      recommendation['description'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            height: 1.3,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Est. ${recommendation['timeEstimate']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color
                              ?.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // Mark as done
                    },
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      minimumSize: Size.zero,
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  ElevatedButton(
                    onPressed: () {
                      // Handle action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: recommendation['color'] as Color,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Take Action',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
