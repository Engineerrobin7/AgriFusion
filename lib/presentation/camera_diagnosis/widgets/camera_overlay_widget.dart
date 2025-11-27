import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CameraOverlayWidget extends StatelessWidget {
  final bool isFlashOn;
  final bool isFrontCamera;
  final VoidCallback onFlashToggle;
  final VoidCallback onCameraFlip;
  final VoidCallback onGalleryTap;
  final VoidCallback onCapture;

  const CameraOverlayWidget({
    super.key,
    required this.isFlashOn,
    required this.isFrontCamera,
    required this.onFlashToggle,
    required this.onCameraFlip,
    required this.onGalleryTap,
    required this.onCapture,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Corner guides for optimal framing
        Positioned(
          top: 20.h,
          left: 10.w,
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
                left: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20.h,
          right: 10.w,
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
                right: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 35.h,
          left: 10.w,
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
                left: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 35.h,
          right: 10.w,
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
                right: BorderSide(
                    color: AppTheme.lightTheme.primaryColor, width: 3),
              ),
            ),
          ),
        ),

        // Center focus point
        Center(
          child: Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.8),
                width: 2,
              ),
            ),
            child: Center(
              child: Container(
                width: 2.w,
                height: 2.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            ),
          ),
        ),

        // Top controls
        Positioned(
          top: 8.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Flash toggle
              GestureDetector(
                onTap: onFlashToggle,
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: isFlashOn ? 'flash_on' : 'flash_off',
                    color: isFlashOn
                        ? AppTheme.lightTheme.primaryColor
                        : Colors.white,
                    size: 6.w,
                  ),
                ),
              ),

              // Camera flip
              GestureDetector(
                onTap: onCameraFlip,
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: 'flip_camera_android',
                    color: Colors.white,
                    size: 6.w,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom controls
        Positioned(
          bottom: 8.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Gallery button
              GestureDetector(
                onTap: onGalleryTap,
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CustomIconWidget(
                    iconName: 'photo_library',
                    color: Colors.white,
                    size: 8.w,
                  ),
                ),
              ),

              // Capture button
              GestureDetector(
                onTap: onCapture,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppTheme.lightTheme.primaryColor, width: 4),
                  ),
                  child: Center(
                    child: Container(
                      width: 15.w,
                      height: 15.w,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),

              // Spacer for symmetry
              SizedBox(width: 15.w),
            ],
          ),
        ),

        // Guidance text
        Positioned(
          bottom: 25.h,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Text(
              'Position the plant within the frame for best results',
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
