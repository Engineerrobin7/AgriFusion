import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DiagnosisResultsWidget extends StatelessWidget {
  final Map<String, dynamic> diagnosisData;
  final VoidCallback onBookmark;
  final VoidCallback onShare;
  final VoidCallback onNewDiagnosis;

  const DiagnosisResultsWidget({
    super.key,
    required this.diagnosisData,
    required this.onBookmark,
    required this.onShare,
    required this.onNewDiagnosis,
  });

  @override
  Widget build(BuildContext context) {
    final disease = diagnosisData['disease'] as Map<String, dynamic>;
    final treatments =
        (diagnosisData['treatments'] as List).cast<Map<String, dynamic>>();
    final confidence = diagnosisData['confidence'] as double;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.lightTheme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image and basic info
            SizedBox(
              width: double.infinity,
              height: 35.h,
              child: Stack(
                children: [
                  CustomImageWidget(
                    imageUrl: diagnosisData['analyzedImage'] as String,
                    width: double.infinity,
                    height: 35.h,
                    fit: BoxFit.cover,
                    semanticLabel:
                        "Analyzed plant image showing disease symptoms and affected areas",
                  ),

                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),

                  // Action buttons
                  Positioned(
                    top: 8.h,
                    right: 5.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: onBookmark,
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: CustomIconWidget(
                              iconName: 'bookmark_border',
                              color: Colors.white,
                              size: 6.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        GestureDetector(
                          onTap: onShare,
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: CustomIconWidget(
                              iconName: 'share',
                              color: Colors.white,
                              size: 6.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Disease info overlay
                  Positioned(
                    bottom: 3.h,
                    left: 5.w,
                    right: 5.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          disease['name'] as String,
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: _getConfidenceColor(confidence),
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: Text(
                                '${(confidence * 100).toInt()}% Confidence',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: _getSeverityColor(
                                    disease['severity'] as String),
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: Text(
                                disease['severity'] as String,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Disease description
            Container(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disease Description',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    disease['description'] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Visual comparison
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visual Comparison',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: AppTheme.cropHealthy, width: 2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3.w),
                                child: CustomImageWidget(
                                  imageUrl: disease['healthyImage'] as String,
                                  width: double.infinity,
                                  height: 20.h,
                                  fit: BoxFit.cover,
                                  semanticLabel:
                                      "Healthy plant example showing normal leaf color and structure",
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Healthy Plant',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontSize: 11.sp,
                                color: AppTheme.cropHealthy,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),
                                border: Border.all(
                                    color: AppTheme.cropDiseased, width: 2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3.w),
                                child: CustomImageWidget(
                                  imageUrl: disease['diseasedImage'] as String,
                                  width: double.infinity,
                                  height: 20.h,
                                  fit: BoxFit.cover,
                                  semanticLabel:
                                      "Diseased plant example showing symptoms like discolored leaves and spots",
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Affected Plant',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontSize: 11.sp,
                                color: AppTheme.cropDiseased,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            // Treatment recommendations
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Treatment Recommendations',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: treatments.length,
                    separatorBuilder: (context, index) => SizedBox(height: 3.h),
                    itemBuilder: (context, index) {
                      final treatment = treatments[index];
                      return _buildTreatmentCard(treatment);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            // New diagnosis button
            Container(
              padding: EdgeInsets.all(5.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNewDiagnosis,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                  ),
                  child: Text(
                    'Diagnose Another Plant',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentCard(Map<String, dynamic> treatment) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: treatment['type'] == 'Organic'
              ? AppTheme.cropHealthy
              : AppTheme.lightTheme.primaryColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: treatment['type'] == 'Organic'
                      ? AppTheme.cropHealthy
                      : AppTheme.lightTheme.primaryColor,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Text(
                  treatment['type'] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              CustomIconWidget(
                iconName: treatment['type'] == 'Organic' ? 'eco' : 'science',
                color: treatment['type'] == 'Organic'
                    ? AppTheme.cropHealthy
                    : AppTheme.lightTheme.primaryColor,
                size: 5.w,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            treatment['name'] as String,
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            treatment['description'] as String,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontSize: 11.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Application',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      treatment['application'] as String,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Timing',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      treatment['timing'] as String,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return AppTheme.cropHealthy;
    if (confidence >= 0.6) return AppTheme.cropWarning;
    return AppTheme.cropDiseased;
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return AppTheme.cropHealthy;
      case 'moderate':
        return AppTheme.cropWarning;
      case 'severe':
        return AppTheme.cropDiseased;
      default:
        return AppTheme.lightTheme.primaryColor;
    }
  }
}