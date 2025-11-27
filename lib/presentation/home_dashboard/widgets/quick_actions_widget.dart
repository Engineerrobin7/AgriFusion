import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            // Voice Query (Larger)
            Expanded(
              flex: 2,
              child: _buildActionCard(
                context,
                'Voice Query',
                'Ask anything about farming',
                Icons.mic,
                Theme.of(context).primaryColor,
                isLarge: true,
                onTap: () => Navigator.pushNamed(context, AppRoutes.voiceQuery),
              ),
            ),
            SizedBox(width: 3.w),
            // Camera Diagnosis
            Expanded(
              child: _buildActionCard(
                context,
                'Camera\nDiagnosis',
                'Scan crops',
                Icons.camera_alt,
                Colors.blue,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.cameraDiagnosis),
              ),
            ),
          ],
        ),
        SizedBox(height: 3.w),
        Row(
          children: [
            // Weather Insights
            Expanded(
              child: _buildActionCard(
                context,
                'Weather\nInsights',
                'Detailed forecast',
                Icons.wb_sunny,
                Colors.orange,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.weatherInsights),
              ),
            ),
            SizedBox(width: 3.w),
            // Chat History
            Expanded(
              child: _buildActionCard(
                context,
                'Chat\nHistory',
                'Previous chats',
                Icons.chat_bubble,
                Colors.purple,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.chatHistory),
              ),
            ),
            SizedBox(width: 3.w),
            // Language
            Expanded(
              child: _buildActionCard(
                context,
                'Language\nSettings',
                'Change language',
                Icons.language,
                Colors.teal,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.languageSelection),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color, {
    bool isLarge = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isLarge ? 20.h : 15.h,
        padding: EdgeInsets.all(3.w),
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
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: isLarge ? 14.w : 12.w,
              height: isLarge ? 14.w : 12.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: isLarge ? 8.w : 6.w,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withValues(alpha: 0.7),
                    fontSize: isLarge ? 12 : 10,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
