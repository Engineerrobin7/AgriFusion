import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LanguageCardWidget extends StatelessWidget {
  final Map<String, dynamic> language;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onAudioPreview;

  const LanguageCardWidget({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
    required this.onAudioPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                  : AppTheme.lightTheme.colorScheme.surface,
              border: Border.all(
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.lightTheme.dividerColor,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowLight,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Flag Icon
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppTheme.lightTheme.colorScheme.surface,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomImageWidget(
                      imageUrl: language['flagUrl'] as String,
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.cover,
                      semanticLabel: language['semanticLabel'] as String,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),

                // Language Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language['nativeName'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppTheme.lightTheme.primaryColor
                              : AppTheme.textPrimaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        language['romanizedName'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        language['greeting'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppTheme.textSecondaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Audio Preview Button
                Container(
                  width: 10.w,
                  height: 10.w,
                  margin: EdgeInsets.only(right: 2.w),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onAudioPreview,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.lightTheme.dividerColor,
                          ),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: 'volume_up',
                            color: AppTheme.lightTheme.primaryColor,
                            size: 5.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Selection Indicator
                isSelected
                    ? Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: 'check',
                            color: Colors.white,
                            size: 4.w,
                          ),
                        ),
                      )
                    : SizedBox(width: 6.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
