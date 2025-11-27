import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class AccountSectionWidget extends StatelessWidget {
  final Map<String, dynamic> accountData;
  final Function(String field, String value) onFieldUpdate;

  const AccountSectionWidget({
    super.key,
    required this.accountData,
    required this.onFieldUpdate,
  });

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
          Text(
            'Account Information',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.primaryColor,
            ),
          ),
          SizedBox(height: 3.h),
          _buildAccountField(
            context,
            'Phone Number',
            accountData['phoneNumber'] as String? ?? '',
            'phone',
            'phoneNumber',
          ),
          SizedBox(height: 2.h),
          _buildAccountField(
            context,
            'Email (Optional)',
            accountData['email'] as String? ?? '',
            'email',
            'email',
          ),
          SizedBox(height: 2.h),
          _buildDropdownField(
            context,
            'Farming Experience',
            accountData['experienceLevel'] as String? ?? 'Beginner',
            ['Beginner', 'Intermediate', 'Advanced', 'Expert'],
            'experienceLevel',
          ),
          SizedBox(height: 2.h),
          _buildDropdownField(
            context,
            'Primary Language',
            accountData['primaryLanguage'] as String? ?? 'Hindi',
            ['Hindi', 'Marathi', 'Tamil', 'Telugu', 'Punjabi', 'English'],
            'primaryLanguage',
          ),
        ],
      ),
    );
  }

  Widget _buildAccountField(
    BuildContext context,
    String label,
    String value,
    String iconName,
    String fieldKey,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimaryLight,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
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
                iconName: iconName,
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  value.isEmpty ? 'Not set' : value,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: value.isEmpty
                        ? AppTheme.textDisabledLight
                        : AppTheme.textPrimaryLight,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showEditDialog(context, label, value, fieldKey),
                child: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 4.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    BuildContext context,
    String label,
    String value,
    List<String> options,
    String fieldKey,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
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
                  onFieldUpdate(fieldKey, newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, String label, String currentValue,
      String fieldKey) {
    final TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter $label',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.w),
              ),
            ),
            keyboardType: fieldKey == 'phoneNumber'
                ? TextInputType.phone
                : TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onFieldUpdate(fieldKey, controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
