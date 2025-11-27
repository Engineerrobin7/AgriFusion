import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class TermsAcceptanceWidget extends StatelessWidget {
  final bool termsAccepted;
  final Function(bool) onTermsChanged;

  const TermsAcceptanceWidget({
    super.key,
    required this.termsAccepted,
    required this.onTermsChanged,
  });

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Terms of Service',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTermsSection(
                  context,
                  'Account Usage',
                  '• You must provide accurate information during registration\n'
                      '• Your account is for personal agricultural use only\n'
                      '• You are responsible for maintaining account security',
                ),
                _buildTermsSection(
                  context,
                  'Agricultural Data',
                  '• Your farming data helps improve our recommendations\n'
                      '• We may use anonymized data for research purposes\n'
                      '• You retain ownership of your personal information',
                ),
                _buildTermsSection(
                  context,
                  'Service Availability',
                  '• AgriFusion services are provided "as is"\n'
                      '• We strive for 99% uptime but cannot guarantee it\n'
                      '• Features may be updated or discontinued',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: GoogleFonts.openSans(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Privacy Policy',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTermsSection(
                  context,
                  'Data Collection',
                  '• We collect farming data to improve recommendations\n'
                      '• Location data helps provide weather information\n'
                      '• Contact information is used for account verification',
                ),
                _buildTermsSection(
                  context,
                  'Data Usage',
                  '• Personal data is never sold to third parties\n'
                      '• Anonymized data may be used for research\n'
                      '• You can request data deletion at any time',
                ),
                _buildTermsSection(
                  context,
                  'Data Security',
                  '• All data is encrypted during transmission\n'
                      '• We use industry-standard security measures\n'
                      '• Regular security audits are conducted',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: GoogleFonts.openSans(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          'Terms & Privacy',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),

        SizedBox(height: 1.h),

        Text(
          'Please review and accept our terms to complete your registration.',
          style: GoogleFonts.openSans(
            fontSize: 14.sp,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.4,
          ),
        ),

        SizedBox(height: 4.h),

        // Terms overview
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              _buildTermsOverviewItem(
                context,
                Icons.security_outlined,
                'Data Protection',
                'Your agricultural data is encrypted and secure',
              ),
              SizedBox(height: 3.h),
              _buildTermsOverviewItem(
                context,
                Icons.share_outlined,
                'Information Sharing',
                'We never sell your personal information',
              ),
              SizedBox(height: 3.h),
              _buildTermsOverviewItem(
                context,
                Icons.support_agent_outlined,
                'Customer Support',
                '24/7 support for all agricultural queries',
              ),
            ],
          ),
        ),

        SizedBox(height: 4.h),

        // Terms acceptance checkbox
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: termsAccepted
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : Theme.of(context).colorScheme.error.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: termsAccepted
                  ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
                  : Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: termsAccepted,
                onChanged: (bool? value) {
                  onTermsChanged(value ?? false);
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.openSans(
                          fontSize: 13.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => _showTermsDialog(context),
                              child: Text(
                                'Terms of Service',
                                style: GoogleFonts.openSans(
                                  fontSize: 13.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => _showPrivacyDialog(context),
                              child: Text(
                                'Privacy Policy',
                                style: GoogleFonts.openSans(
                                  fontSize: 13.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'By accepting, you consent to the collection and use of your agricultural data to provide personalized recommendations.',
                      style: GoogleFonts.openSans(
                        fontSize: 11.sp,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        if (!termsAccepted) ...[
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_outlined,
                  color: Theme.of(context).colorScheme.error,
                  size: 5.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Please accept the terms and privacy policy to continue.',
                    style: GoogleFonts.openSans(
                      fontSize: 12.sp,
                      color: Theme.of(context).colorScheme.error,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTermsOverviewItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.5.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 5.w,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                description,
                style: GoogleFonts.openSans(
                  fontSize: 12.sp,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection(
      BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          content,
          style: GoogleFonts.openSans(
            fontSize: 12.sp,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
