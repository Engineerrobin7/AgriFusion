import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OfflineLanguageWidget extends StatelessWidget {
  final List<Map<String, dynamic>> availableLanguages;
  final List<Map<String, dynamic>> downloadableLanguages;
  final String? selectedLanguageCode;
  final Function(String) onLanguageSelect;
  final Function(String) onDownloadRequest;

  const OfflineLanguageWidget({
    super.key,
    required this.availableLanguages,
    required this.downloadableLanguages,
    this.selectedLanguageCode,
    required this.onLanguageSelect,
    required this.onDownloadRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.warningLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.warningLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Offline Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'wifi_off',
                color: AppTheme.warningLight,
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Limited Connectivity',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningLight,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Choose from downloaded languages or download when connected',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Available Languages Section
          if (availableLanguages.isNotEmpty) ...[
            Text(
              'Available Languages',
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryLight,
              ),
            ),
            SizedBox(height: 2.h),
            ...availableLanguages.map((language) => _buildLanguageItem(
                  language: language,
                  isAvailable: true,
                  isSelected: selectedLanguageCode == language['code'],
                  onTap: () => onLanguageSelect(language['code'] as String),
                )),
            SizedBox(height: 3.h),
          ],

          // Downloadable Languages Section
          if (downloadableLanguages.isNotEmpty) ...[
            Text(
              'Download When Connected',
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryLight,
              ),
            ),
            SizedBox(height: 2.h),
            ...downloadableLanguages.map((language) => _buildLanguageItem(
                  language: language,
                  isAvailable: false,
                  isSelected: false,
                  onTap: () => onDownloadRequest(language['code'] as String),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildLanguageItem({
    required Map<String, dynamic> language,
    required bool isAvailable,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(3.w),
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Flag
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppTheme.lightTheme.colorScheme.surface,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CustomImageWidget(
                      imageUrl: language['flagUrl'] as String,
                      width: 10.w,
                      height: 10.w,
                      fit: BoxFit.cover,
                      semanticLabel: language['semanticLabel'] as String,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),

                // Language Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language['nativeName'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppTheme.lightTheme.primaryColor
                              : AppTheme.textPrimaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        language['romanizedName'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Status Icon
                CustomIconWidget(
                  iconName: isAvailable
                      ? (isSelected ? 'check_circle' : 'check')
                      : 'cloud_download',
                  color: isAvailable
                      ? (isSelected
                          ? AppTheme.lightTheme.primaryColor
                          : AppTheme.successLight)
                      : AppTheme.textSecondaryLight,
                  size: 5.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
