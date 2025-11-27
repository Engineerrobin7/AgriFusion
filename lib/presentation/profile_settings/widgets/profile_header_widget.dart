import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProfileHeaderWidget extends StatefulWidget {
  final Map<String, dynamic> userProfile;
  final VoidCallback onEditPressed;

  const ProfileHeaderWidget({
    super.key,
    required this.userProfile,
    required this.onEditPressed,
  });

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
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
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.lightTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: CustomImageWidget(
                        imageUrl:
                            widget.userProfile['profileImage'] as String? ?? '',
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.cover,
                        semanticLabel: widget.userProfile['profileImageLabel']
                                as String? ??
                            'Profile photo of farmer',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: widget.onEditPressed,
                      child: Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.surface,
                            width: 2,
                          ),
                        ),
                        child: CustomIconWidget(
                          iconName: 'edit',
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          size: 3.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userProfile['name'] as String? ?? 'Unknown User',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'location_on',
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            widget.userProfile['location'] as String? ??
                                'Location not set',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondaryLight,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'agriculture',
                          color: AppTheme.cropHealthy,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            '${widget.userProfile['experience'] as String? ?? '0'} years farming experience',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.textSecondaryLight,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.onEditPressed,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color:
                        AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: CustomIconWidget(
                    iconName: 'edit',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 5.w,
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
