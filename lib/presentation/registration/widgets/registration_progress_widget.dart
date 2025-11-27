import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class RegistrationProgressWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const RegistrationProgressWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Step labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepLabel(context, 0, 'Personal Info'),
              _buildStepLabel(context, 1, 'Farm Details'),
              _buildStepLabel(context, 2, 'Terms'),
            ],
          ),

          SizedBox(height: 2.h),

          // Progress indicator
          Row(
            children: List.generate(
              totalSteps,
              (index) => Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= currentStep
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (index < totalSteps - 1) SizedBox(width: 2.w),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Progress text
          Text(
            'Step ${currentStep + 1} of $totalSteps',
            style: GoogleFonts.openSans(
              fontSize: 12.sp,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepLabel(BuildContext context, int stepIndex, String label) {
    final isActive = stepIndex == currentStep;
    final isCompleted = stepIndex < currentStep;

    return Column(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: isCompleted || isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 4.w,
                  )
                : Text(
                    '${stepIndex + 1}',
                    style: GoogleFonts.openSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                    ),
                  ),
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 10.sp,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive || isCompleted
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
