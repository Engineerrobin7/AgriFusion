import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DownloadProgressWidget extends StatelessWidget {
  final String languageName;
  final double progress;
  final bool isDownloading;
  final bool isPaused;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final VoidCallback? onCancel;

  const DownloadProgressWidget({
    super.key,
    required this.languageName,
    required this.progress,
    required this.isDownloading,
    this.isPaused = false,
    this.onPause,
    this.onResume,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.primaryColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'download',
                color: AppTheme.lightTheme.primaryColor,
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Downloading $languageName',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      isPaused
                          ? 'Download paused'
                          : isDownloading
                              ? 'Language pack and models'
                              : 'Preparing download...',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (onCancel != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onCancel,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.textSecondaryLight,
                        size: 5.w,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 3.h),

          // Progress Bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimaryLight,
                    ),
                  ),
                  Text(
                    isPaused
                        ? 'Paused'
                        : isDownloading
                            ? 'Downloading...'
                            : 'Starting...',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.lightTheme.primaryColor,
                  ),
                  minHeight: 1.h,
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Control Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: isPaused ? onResume : onPause,
                  icon: CustomIconWidget(
                    iconName: isPaused ? 'play_arrow' : 'pause',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 4.w,
                  ),
                  label: Text(
                    isPaused ? 'Resume' : 'Pause',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: TextButton.icon(
                  onPressed: onCancel,
                  icon: CustomIconWidget(
                    iconName: 'cancel',
                    color: AppTheme.errorLight,
                    size: 4.w,
                  ),
                  label: Text(
                    'Cancel',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.errorLight,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
