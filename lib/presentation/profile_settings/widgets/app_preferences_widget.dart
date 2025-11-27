import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class AppPreferencesWidget extends StatefulWidget {
  final Map<String, dynamic> appSettings;
  final Function(String key, dynamic value) onSettingUpdate;

  const AppPreferencesWidget({
    super.key,
    required this.appSettings,
    required this.onSettingUpdate,
  });

  @override
  State<AppPreferencesWidget> createState() => _AppPreferencesWidgetState();
}

class _AppPreferencesWidgetState extends State<AppPreferencesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
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
            children: [
              CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.lightTheme.primaryColor,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'App Preferences',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          _buildLanguageSelector(),
          SizedBox(height: 2.h),
          _buildVoiceSettings(),
          SizedBox(height: 2.h),
          _buildToggleSetting(
            'Offline Mode',
            'Enable offline functionality for basic features',
            'offlineMode',
            'offline_bolt',
          ),
          SizedBox(height: 2.h),
          _buildToggleSetting(
            'Auto Sync',
            'Automatically sync data when connected',
            'autoSync',
            'sync',
          ),
          SizedBox(height: 2.h),
          _buildDataUsageSetting(),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    final String currentLanguage =
        widget.appSettings['language'] as String? ?? 'Hindi';
    final List<String> languages = [
      'Hindi',
      'Marathi',
      'Tamil',
      'Telugu',
      'Punjabi',
      'English'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App Language',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimaryLight,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            border: Border.all(
              color: AppTheme.dividerLight.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'language',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: currentLanguage,
                    isExpanded: true,
                    icon: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 5.w,
                    ),
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimaryLight,
                    ),
                    items: languages.map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        widget.onSettingUpdate('language', newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voice Settings',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimaryLight,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            border: Border.all(
              color: AppTheme.dividerLight.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'mic',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      'Speech Recognition Sensitivity',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Slider(
                value:
                    (widget.appSettings['speechSensitivity'] as double?) ?? 0.7,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label:
                    '${((widget.appSettings['speechSensitivity'] as double?) ?? 0.7 * 100).round()}%',
                onChanged: (double value) {
                  widget.onSettingUpdate('speechSensitivity', value);
                },
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'volume_up',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      'Text-to-Speech Voice',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showVoiceSelectionDialog(),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.primaryColor
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                      child: Text(
                        widget.appSettings['ttsVoice'] as String? ?? 'Default',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSetting(
      String title, String description, String key, String iconName) {
    final bool isEnabled = widget.appSettings[key] as bool? ?? false;

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        border: Border.all(
          color: AppTheme.dividerLight.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                  : AppTheme.textDisabledLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: CustomIconWidget(
              iconName: iconName,
              color: isEnabled
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.textDisabledLight,
              size: 5.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (bool value) {
              widget.onSettingUpdate(key, value);
            },
            activeColor: AppTheme.lightTheme.primaryColor,
            activeTrackColor:
                AppTheme.lightTheme.primaryColor.withValues(alpha: 0.5),
            inactiveThumbColor: AppTheme.textDisabledLight,
            inactiveTrackColor:
                AppTheme.textDisabledLight.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildDataUsageSetting() {
    final String currentSetting =
        widget.appSettings['dataUsage'] as String? ?? 'Medium';
    final List<String> options = ['Low', 'Medium', 'High', 'Unlimited'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Usage Limit',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimaryLight,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            border: Border.all(
              color: AppTheme.dividerLight.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'data_usage',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: currentSetting,
                    isExpanded: true,
                    icon: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 5.w,
                    ),
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimaryLight,
                    ),
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        widget.onSettingUpdate('dataUsage', newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showVoiceSelectionDialog() {
    final List<String> voices = [
      'Default',
      'Male Voice',
      'Female Voice',
      'Regional Accent'
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Voice'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: voices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(voices[index]),
                  onTap: () {
                    widget.onSettingUpdate('ttsVoice', voices[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
