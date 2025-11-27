import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterChipsWidget extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterChipsWidget({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;

          return GestureDetector(
            onTap: () => onFilterSelected(filter),
            child: Container(
              margin: EdgeInsets.only(right: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.dividerColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppTheme.shadowLight,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFilterIcon(filter, isSelected),
                  SizedBox(width: 2.w),
                  Text(
                    _getFilterDisplayName(filter),
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.onPrimary
                          : AppTheme.textPrimaryLight,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterIcon(String filter, bool isSelected) {
    String iconName;
    Color iconColor;

    switch (filter.toLowerCase()) {
      case 'all':
        iconName = 'apps';
        break;
      case 'disease':
        iconName = 'local_hospital';
        break;
      case 'fertilizer':
        iconName = 'eco';
        break;
      case 'weather':
        iconName = 'wb_sunny';
        break;
      case 'schemes':
        iconName = 'account_balance';
        break;
      case 'general':
        iconName = 'chat';
        break;
      case 'bookmarked':
        iconName = 'bookmark';
        break;
      default:
        iconName = 'help';
        break;
    }

    iconColor = isSelected
        ? AppTheme.lightTheme.colorScheme.onPrimary
        : _getFilterColor(filter);

    return CustomIconWidget(
      iconName: iconName,
      color: iconColor,
      size: 4.w,
    );
  }

  Color _getFilterColor(String filter) {
    switch (filter.toLowerCase()) {
      case 'disease':
        return AppTheme.cropDiseased;
      case 'fertilizer':
        return AppTheme.cropHealthy;
      case 'weather':
        return AppTheme.weatherSunny;
      case 'schemes':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'bookmarked':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'general':
        return AppTheme.lightTheme.colorScheme.secondary;
      default:
        return AppTheme.textSecondaryLight;
    }
  }

  String _getFilterDisplayName(String filter) {
    switch (filter.toLowerCase()) {
      case 'all':
        return 'All';
      case 'disease':
        return 'Diseases';
      case 'fertilizer':
        return 'Fertilizers';
      case 'weather':
        return 'Weather';
      case 'schemes':
        return 'Schemes';
      case 'general':
        return 'General';
      case 'bookmarked':
        return 'Bookmarked';
      default:
        return filter;
    }
  }
}
