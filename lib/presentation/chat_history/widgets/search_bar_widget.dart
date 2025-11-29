import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback? onVoiceSearch;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.onSearchChanged,
    this.onVoiceSearch,
    this.hintText = 'Search conversations...',
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      widget.onSearchChanged(_searchController.text);
      setState(() {
        _isSearchActive = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isSearchActive
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3)
              : AppTheme.lightTheme.dividerColor.withValues(alpha: 0.3),
        ),
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
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: CustomIconWidget(
              iconName: 'search',
              color: _isSearchActive
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.textSecondaryLight,
              size: 6.w,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textDisabledLight,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 2.h,
                ),
              ),
              onChanged: (value) {
                // Already handled by listener
              },
            ),
          ),
          if (_isSearchActive)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: CustomIconWidget(
                  iconName: 'clear',
                  color: AppTheme.textSecondaryLight,
                  size: 5.w,
                ),
              ),
            ),
          if (widget.onVoiceSearch != null)
            GestureDetector(
              onTap: widget.onVoiceSearch,
              child: Container(
                margin: EdgeInsets.only(right: 3.w),
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'mic',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
