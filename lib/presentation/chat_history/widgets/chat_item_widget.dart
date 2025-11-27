import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ChatItemWidget extends StatelessWidget {
  final Map<String, dynamic> chatData;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;
  final VoidCallback? onContinue;

  const ChatItemWidget({
    super.key,
    required this.chatData,
    this.onTap,
    this.onBookmark,
    this.onShare,
    this.onDelete,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final String title = chatData['title'] ?? '';
    final String preview = chatData['preview'] ?? '';
    final String timestamp = chatData['timestamp'] ?? '';
    final String type = chatData['type'] ?? '';
    final bool isBookmarked = chatData['isBookmarked'] ?? false;
    final bool hasVoice = chatData['hasVoice'] ?? false;
    final bool hasImage = chatData['hasImage'] ?? false;

    return Dismissible(
      key: Key(chatData['id'].toString()),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color:
              AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: 'bookmark',
              color: AppTheme.lightTheme.colorScheme.tertiary,
              size: 6.w,
            ),
            SizedBox(width: 2.w),
            Text(
              'Bookmark',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Delete',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 2.w),
            CustomIconWidget(
              iconName: 'delete',
              color: AppTheme.lightTheme.colorScheme.error,
              size: 6.w,
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onBookmark?.call();
          return false;
        } else if (direction == DismissDirection.endToStart) {
          return await _showDeleteConfirmation(context);
        }
        return false;
      },
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => _showContextMenu(context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowLight,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildTypeIcon(type),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            title,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (hasVoice)
                        Padding(
                          padding: EdgeInsets.only(right: 1.w),
                          child: CustomIconWidget(
                            iconName: 'mic',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 4.w,
                          ),
                        ),
                      if (hasImage)
                        Padding(
                          padding: EdgeInsets.only(right: 1.w),
                          child: CustomIconWidget(
                            iconName: 'camera_alt',
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            size: 4.w,
                          ),
                        ),
                      if (isBookmarked)
                        CustomIconWidget(
                          iconName: 'bookmark',
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                          size: 4.w,
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                preview,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryLight,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timestamp,
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: AppTheme.textDisabledLight,
                    ),
                  ),
                  _buildTypeChip(type),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIcon(String type) {
    String iconName;
    Color iconColor;

    switch (type.toLowerCase()) {
      case 'disease':
        iconName = 'local_hospital';
        iconColor = AppTheme.cropDiseased;
        break;
      case 'fertilizer':
        iconName = 'eco';
        iconColor = AppTheme.cropHealthy;
        break;
      case 'weather':
        iconName = 'wb_sunny';
        iconColor = AppTheme.weatherSunny;
        break;
      case 'schemes':
        iconName = 'account_balance';
        iconColor = AppTheme.lightTheme.colorScheme.primary;
        break;
      case 'general':
      default:
        iconName = 'chat';
        iconColor = AppTheme.lightTheme.colorScheme.secondary;
        break;
    }

    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomIconWidget(
        iconName: iconName,
        color: iconColor,
        size: 5.w,
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    Color chipColor;

    switch (type.toLowerCase()) {
      case 'disease':
        chipColor = AppTheme.cropDiseased;
        break;
      case 'fertilizer':
        chipColor = AppTheme.cropHealthy;
        break;
      case 'weather':
        chipColor = AppTheme.weatherSunny;
        break;
      case 'schemes':
        chipColor = AppTheme.lightTheme.colorScheme.primary;
        break;
      case 'general':
      default:
        chipColor = AppTheme.lightTheme.colorScheme.secondary;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: chipColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        type.toUpperCase(),
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: chipColor,
          fontWeight: FontWeight.w600,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Delete Conversation',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              content: Text(
                'Are you sure you want to delete this conversation? This action cannot be undone.',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppTheme.textSecondaryLight),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onDelete?.call();
                  },
                  child: Text(
                    'Delete',
                    style:
                        TextStyle(color: AppTheme.lightTheme.colorScheme.error),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 2.h),
              _buildContextMenuItem(
                icon: 'bookmark_border',
                title: 'Bookmark',
                onTap: () {
                  Navigator.pop(context);
                  onBookmark?.call();
                },
              ),
              _buildContextMenuItem(
                icon: 'share',
                title: 'Share',
                onTap: () {
                  Navigator.pop(context);
                  onShare?.call();
                },
              ),
              _buildContextMenuItem(
                icon: 'play_arrow',
                title: 'Continue Discussion',
                onTap: () {
                  Navigator.pop(context);
                  onContinue?.call();
                },
              ),
              _buildContextMenuItem(
                icon: 'file_download',
                title: 'Export Conversation',
                onTap: () {
                  Navigator.pop(context);
                  // Export functionality would be handled by parent
                },
              ),
              _buildContextMenuItem(
                icon: 'notifications',
                title: 'Set Reminder',
                onTap: () {
                  Navigator.pop(context);
                  // Reminder functionality would be handled by parent
                },
              ),
              _buildContextMenuItem(
                icon: 'delete',
                title: 'Delete',
                color: AppTheme.lightTheme.colorScheme.error,
                onTap: () {
                  Navigator.pop(context);
                  onDelete?.call();
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContextMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final itemColor = color ?? AppTheme.textPrimaryLight;

    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: itemColor,
        size: 6.w,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: itemColor,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
    );
  }
}
