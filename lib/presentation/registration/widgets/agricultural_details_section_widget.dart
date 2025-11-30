import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class AgriculturalDetailsSectionWidget extends StatelessWidget {
  final String selectedExperienceLevel;
  final String selectedCropType;
  final String selectedFarmSize;
  final String selectedSoilType;
  final String selectedLanguage;
  final List<String> experienceLevels;
  final List<String> cropTypes;
  final List<String> farmSizes;
  final List<String> soilTypes;
  final List<String> languages;
  final Function(String) onExperienceLevelChanged;
  final Function(String) onCropTypeChanged;
  final Function(String) onFarmSizeChanged;
  final Function(String) onSoilTypeChanged;
  final Function(String) onLanguageChanged;

  const AgriculturalDetailsSectionWidget({
    super.key,
    required this.selectedExperienceLevel,
    required this.selectedCropType,
    required this.selectedFarmSize,
    required this.selectedSoilType,
    required this.selectedLanguage,
    required this.experienceLevels,
    required this.cropTypes,
    required this.farmSizes,
    required this.soilTypes,
    required this.languages,
    required this.onExperienceLevelChanged,
    required this.onCropTypeChanged,
    required this.onFarmSizeChanged,
    required this.onSoilTypeChanged,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          'Agricultural Details',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),

        SizedBox(height: 1.h),

        Text(
          'Help us understand your farming background to provide personalized recommendations.',
          style: GoogleFonts.openSans(
            fontSize: 14.sp,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.4,
          ),
        ),

        SizedBox(height: 4.h),

        // Farming experience level
        _buildDropdownField(
          context: context,
          label: 'Farming Experience',
          icon: Icons.trending_up_outlined,
          value: selectedExperienceLevel,
          items: experienceLevels,
          onChanged: onExperienceLevelChanged,
          itemDisplayNames: {
            'beginner': 'Beginner (0-2 years)',
            'intermediate': 'Intermediate (2-5 years)',
            'expert': 'Expert (5+ years)',
          },
        ),

        SizedBox(height: 3.h),

        // Primary crops
        _buildDropdownField(
          context: context,
          label: 'Primary Crops',
          icon: Icons.grass_outlined,
          value: selectedCropType,
          items: cropTypes,
          onChanged: onCropTypeChanged,
          itemDisplayNames: {
            'rice': 'Rice',
            'wheat': 'Wheat',
            'corn': 'Corn/Maize',
            'vegetables': 'Vegetables',
            'fruits': 'Fruits',
            'mixed': 'Mixed Crops',
          },
        ),

        SizedBox(height: 3.h),

        // Farm size
        _buildDropdownField(
          context: context,
          label: 'Farm Size',
          icon: Icons.landscape_outlined,
          value: selectedFarmSize,
          items: farmSizes,
          onChanged: onFarmSizeChanged,
          itemDisplayNames: {
            'small': 'Small (< 2 acres)',
            'medium': 'Medium (2-10 acres)',
            'large': 'Large (10-50 acres)',
            'commercial': 'Commercial (50+ acres)',
          },
        ),

        SizedBox(height: 3.h),

        // Soil type
        _buildDropdownField(
          context: context,
          label: 'Soil Type',
          icon: Icons.eco_outlined,
          value: selectedSoilType,
          items: soilTypes,
          onChanged: onSoilTypeChanged,
          itemDisplayNames: {
            'clay': 'Clay Soil',
            'sandy': 'Sandy Soil',
            'loamy': 'Loamy Soil',
            'silt': 'Silt Soil',
            'mixed': 'Mixed Soil Types',
          },
        ),

        SizedBox(height: 3.h),

        // Language preference
        _buildDropdownField(
          context: context,
          label: 'Preferred Language',
          icon: Icons.language_outlined,
          value: selectedLanguage,
          items: languages,
          onChanged: onLanguageChanged,
          itemDisplayNames: {
            'english': 'English',
            'hindi': 'हिन्दी (Hindi)',
            'spanish': 'Español (Spanish)',
            'french': 'Français (French)',
            'portuguese': 'Português (Portuguese)',
          },
        ),

        SizedBox(height: 3.h),

        // Location section
        _buildLocationSection(context),

        SizedBox(height: 2.h),

        // Info note
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Theme.of(context).colorScheme.secondary,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'This information helps us provide personalized farming advice and connect you with relevant agricultural experts.',
                  style: GoogleFonts.openSans(
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.secondary,
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

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
    Map<String, String>? itemDisplayNames,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        DropdownButtonFormField<String>(
          initialValue: value,
          decoration: InputDecoration(
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
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                itemDisplayNames?[item] ?? item.capitalize(),
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Farm Location',
          style: GoogleFonts.openSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enable GPS Location',
                      style: GoogleFonts.openSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Get weather updates and local farming tips',
                      style: GoogleFonts.openSans(
                        fontSize: 12.sp,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // Implement GPS location request
                },
                child: Text(
                  'Enable',
                  style: GoogleFonts.openSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension StringCapitalize on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
