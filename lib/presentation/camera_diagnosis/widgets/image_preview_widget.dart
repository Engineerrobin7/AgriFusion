import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ImagePreviewWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRetake;
  final VoidCallback onConfirm;

  const ImagePreviewWidget({
    super.key,
    required this.imagePath,
    required this.onRetake,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          // Image preview
          Center(
            child: Container(
              width: 90.w,
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                    color: AppTheme.lightTheme.primaryColor, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.w),
                child: kIsWeb
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: CustomIconWidget(
                                iconName: 'image',
                                color: Colors.grey[600]!,
                                size: 15.w,
                              ),
                            ),
                          );
                        },
                      )
                    : Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: CustomIconWidget(
                                iconName: 'image',
                                color: Colors.grey[600]!,
                                size: 15.w,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),

          // Top bar with title
          Positioned(
            top: 8.h,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                'Preview Captured Image',
                textAlign: TextAlign.center,
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),

          // Bottom action buttons
          Positioned(
            bottom: 8.h,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Retake button
                  GestureDetector(
                    onTap: onRetake,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8.w),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'refresh',
                            color: Colors.white,
                            size: 5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Retake',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Confirm button
                  GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.primaryColor,
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'check',
                            color: Colors.white,
                            size: 5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Analyze',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
