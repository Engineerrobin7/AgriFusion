import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class FarmInfoWidget extends StatelessWidget {
  final Map<String, dynamic> farmData;
  final Function(String field, dynamic value) onFieldUpdate;

  const FarmInfoWidget({
    super.key,
    required this.farmData,
    required this.onFieldUpdate,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'agriculture',
                color: AppTheme.cropHealthy,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Farm Information',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          _buildFarmField(
            context,
            'Registered Crops',
            (farmData['crops'] as List<dynamic>?)?.join(', ') ??
                'No crops registered',
            'eco',
            'crops',
            isList: true,
          ),
          SizedBox(height: 2.h),
          _buildFarmField(
            context,
            'Farm Size',
            farmData['farmSize'] as String? ?? 'Not specified',
            'crop_landscape',
            'farmSize',
          ),
          SizedBox(height: 2.h),
          _buildFarmField(
            context,
            'Soil Type',
            farmData['soilType'] as String? ?? 'Not specified',
            'terrain',
            'soilType',
          ),
          SizedBox(height: 2.h),
          _buildFarmField(
            context,
            'Irrigation Methods',
            (farmData['irrigationMethods'] as List<dynamic>?)?.join(', ') ??
                'Not specified',
            'water_drop',
            'irrigationMethods',
            isList: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFarmField(
    BuildContext context,
    String label,
    String value,
    String iconName,
    String fieldKey, {
    bool isList = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimaryLight,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            border: Border.all(
              color: AppTheme.dividerLight.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: AppTheme.cropHealthy,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  value,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: value.contains('Not')
                        ? AppTheme.textDisabledLight
                        : AppTheme.textPrimaryLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    _showFarmEditDialog(context, label, fieldKey, isList),
                child: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 4.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFarmEditDialog(
      BuildContext context, String label, String fieldKey, bool isList) {
    if (fieldKey == 'soilType') {
      _showSoilTypeDialog(context);
    } else if (fieldKey == 'farmSize') {
      _showFarmSizeDialog(context);
    } else if (isList) {
      _showListEditDialog(context, label, fieldKey);
    }
  }

  void _showSoilTypeDialog(BuildContext context) {
    final List<String> soilTypes = [
      'Clay',
      'Sandy',
      'Loamy',
      'Silty',
      'Peaty',
      'Chalky',
      'Mixed'
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Soil Type'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: soilTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(soilTypes[index]),
                  onTap: () {
                    onFieldUpdate('soilType', soilTypes[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showFarmSizeDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: farmData['farmSize'] as String? ?? '',
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Farm Size'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'e.g., 2.5 acres',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.w),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onFieldUpdate('farmSize', controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showListEditDialog(
      BuildContext context, String label, String fieldKey) {
    List<String> options = [];
    if (fieldKey == 'crops') {
      options = [
        'Rice',
        'Wheat',
        'Corn',
        'Sugarcane',
        'Cotton',
        'Soybean',
        'Tomato',
        'Potato',
        'Onion',
        'Other'
      ];
    } else if (fieldKey == 'irrigationMethods') {
      options = [
        'Drip Irrigation',
        'Sprinkler',
        'Flood Irrigation',
        'Furrow Irrigation',
        'Rain-fed',
        'Other'
      ];
    }

    List<String> currentValues = [];
    if (fieldKey == 'crops') {
      currentValues =
          List<String>.from(farmData['crops'] as List<dynamic>? ?? []);
    } else if (fieldKey == 'irrigationMethods') {
      currentValues = List<String>.from(
          farmData['irrigationMethods'] as List<dynamic>? ?? []);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select $label'),
              content: SizedBox(
                width: double.maxFinite,
                height: 40.h,
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = currentValues.contains(option);

                    return CheckboxListTile(
                      title: Text(option),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            if (!currentValues.contains(option)) {
                              currentValues.add(option);
                            }
                          } else {
                            currentValues.remove(option);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onFieldUpdate(fieldKey, currentValues);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
