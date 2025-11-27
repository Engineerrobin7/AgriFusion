import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AnalysisProgressWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback onAnalysisComplete;

  const AnalysisProgressWidget({
    super.key,
    required this.imagePath,
    required this.onAnalysisComplete,
  });

  @override
  State<AnalysisProgressWidget> createState() => _AnalysisProgressWidgetState();
}

class _AnalysisProgressWidgetState extends State<AnalysisProgressWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _startAnalysis();
  }

  void _startAnalysis() {
    _progressController.forward();
    _pulseController.repeat(reverse: true);

    // Simulate analysis completion
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onAnalysisComplete();
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          // Top spacing
          SizedBox(height: 10.h),

          // Title
          Text(
            'Analyzing Crop Image',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),

          SizedBox(height: 2.h),

          Text(
            'AI is examining your plant for diseases and pests',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 6.h),

          // Image with analysis overlay
          Container(
            width: 80.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
              border:
                  Border.all(color: AppTheme.lightTheme.primaryColor, width: 2),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                  child: CustomImageWidget(
                    imageUrl: widget.imagePath,
                    width: 80.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                    semanticLabel:
                        "Captured plant image being analyzed for diseases and pests",
                  ),
                ),

                // Analysis overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    color:
                        AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
                  ),
                ),

                // Scanning animation
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Center(
                      child: Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: CustomIconWidget(
                            iconName: 'search',
                            color: Colors.white,
                            size: 10.w,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 6.h),

          // Progress indicator
          SizedBox(
            width: 70.w,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _progressAnimation.value,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.lightTheme.primaryColor,
                      ),
                      minHeight: 1.h,
                    );
                  },
                ),
                SizedBox(height: 2.h),
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    String status = 'Initializing...';
                    if (_progressAnimation.value > 0.3) {
                      status = 'Detecting plant features...';
                    }
                    if (_progressAnimation.value > 0.6) {
                      status = 'Analyzing for diseases...';
                    }
                    if (_progressAnimation.value > 0.9) {
                      status = 'Generating recommendations...';
                    }

                    return Text(
                      status,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 11.sp,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          // Analysis steps
          SizedBox(
            width: 80.w,
            child: Column(
              children: [
                _buildAnalysisStep('Plant identification', true),
                SizedBox(height: 1.h),
                _buildAnalysisStep('Disease detection', true),
                SizedBox(height: 1.h),
                _buildAnalysisStep('Pest analysis', false),
                SizedBox(height: 1.h),
                _buildAnalysisStep('Treatment recommendations', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisStep(String title, bool isCompleted) {
    return Row(
      children: [
        Container(
          width: 5.w,
          height: 5.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? AppTheme.lightTheme.primaryColor
                : Colors.white.withValues(alpha: 0.3),
          ),
          child: isCompleted
              ? CustomIconWidget(
                  iconName: 'check',
                  color: Colors.white,
                  size: 3.w,
                )
              : null,
        ),
        SizedBox(width: 3.w),
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: isCompleted
                ? Colors.white
                : Colors.white.withValues(alpha: 0.6),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
