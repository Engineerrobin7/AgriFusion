import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../core/app_export.dart';

class PersonalInfoSectionWidget extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String? profileImagePath;
  final Function(String?) onImageSelected;

  const PersonalInfoSectionWidget({
    super.key,
    required this.fullNameController,
    required this.phoneController,
    required this.emailController,
    required this.profileImagePath,
    required this.onImageSelected,
  });

  Future<void> _selectProfileImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('Photo Library', style: GoogleFonts.openSans()),
                onTap: () async {
                  Navigator.of(context).pop();
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    onImageSelected(pickedFile.path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text('Camera', style: GoogleFonts.openSans()),
                onTap: () async {
                  Navigator.of(context).pop();
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    onImageSelected(pickedFile.path);
                  }
                },
              ),
            ],
          ),
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
          'Personal Information',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),

        SizedBox(height: 1.h),

        Text(
          'Please provide your basic information to get started with AgriFusion.',
          style: GoogleFonts.openSans(
            fontSize: 14.sp,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.4,
          ),
        ),

        SizedBox(height: 4.h),

        // Profile photo section
        Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _selectProfileImage(context),
                child: Container(
                  width: 25.w,
                  height: 25.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.5.w),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: profileImagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.w),
                          child: Image.file(
                            File(profileImagePath!),
                            fit: BoxFit.cover,
                            width: 25.w,
                            height: 25.w,
                          ),
                        )
                      : Icon(
                          Icons.add_a_photo,
                          size: 8.w,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Add Profile Photo',
                style: GoogleFonts.openSans(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 4.h),

        // Full name field
        _buildTextField(
          context: context,
          controller: fullNameController,
          label: 'Full Name',
          hint: 'Enter your full name',
          icon: Icons.person_outline,
          isRequired: true,
        ),

        SizedBox(height: 3.h),

        // Phone number field
        _buildTextField(
          context: context,
          controller: phoneController,
          label: 'Phone Number',
          hint: '+91 9876543210',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          isRequired: true,
        ),

        SizedBox(height: 3.h),

        // Email field (optional)
        _buildTextField(
          context: context,
          controller: emailController,
          label: 'Email Address',
          hint: 'your.email@example.com (Optional)',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),

        SizedBox(height: 2.h),

        // Info note
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Your phone number will be used as your primary identifier for account verification.',
                  style: GoogleFonts.openSans(
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.primary,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.openSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: [
              TextSpan(text: label),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '$label is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}
