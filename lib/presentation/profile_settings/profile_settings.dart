import 'dart:convert';
import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:universal_html/html.dart' as html;

import '../../core/app_export.dart';
import './widgets/account_section_widget.dart';
import './widgets/app_preferences_widget.dart';
import './widgets/bottom_navigation_widget.dart';
import './widgets/farm_info_widget.dart';
import './widgets/notification_preferences_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/support_section_widget.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  int _currentNavIndex = 5; // Profile tab is active

  // Mock user profile data
  final Map<String, dynamic> _userProfile = {
    'name': 'Rajesh Kumar',
    'location': 'Pune, Maharashtra',
    'experience': '8',
    'profileImage':
        'https://images.unsplash.com/photo-1719593622919-70d3e620e8fb',
    'profileImageLabel':
        'Portrait of a middle-aged Indian farmer with a warm smile, wearing a traditional white kurta, standing in front of green agricultural fields',
  };

  // Mock account data
  final Map<String, dynamic> _accountData = {
    'phoneNumber': '+91 9876543210',
    'email': 'rajesh.kumar@gmail.com',
    'experienceLevel': 'Advanced',
    'primaryLanguage': 'Hindi',
  };

  // Mock farm data
  final Map<String, dynamic> _farmData = {
    'crops': ['Rice', 'Wheat', 'Sugarcane'],
    'farmSize': '5.2 acres',
    'soilType': 'Loamy',
    'irrigationMethods': ['Drip Irrigation', 'Sprinkler'],
  };

  // Mock notification settings
  final Map<String, dynamic> _notificationSettings = {
    'weatherAlerts': true,
    'governmentSchemes': true,
    'seasonalReminders': true,
    'marketPrices': false,
    'expertTips': true,
  };

  // Mock app settings
  final Map<String, dynamic> _appSettings = {
    'language': 'Hindi',
    'speechSensitivity': 0.7,
    'ttsVoice': 'Default',
    'offlineMode': true,
    'autoSync': true,
    'dataUsage': 'Medium',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile Settings',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: _showLogoutDialog,
            icon: CustomIconWidget(
              iconName: 'logout',
              color: AppTheme.errorLight,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              // Profile Header
              ProfileHeaderWidget(
                userProfile: _userProfile,
                onEditPressed: _showProfileEditOptions,
              ),
              SizedBox(height: 3.h),

              // Account Section
              AccountSectionWidget(
                accountData: _accountData,
                onFieldUpdate: _updateAccountField,
              ),
              SizedBox(height: 3.h),

              // Farm Information
              FarmInfoWidget(
                farmData: _farmData,
                onFieldUpdate: _updateFarmField,
              ),
              SizedBox(height: 3.h),

              // Notification Preferences
              NotificationPreferencesWidget(
                notificationSettings: _notificationSettings,
                onToggle: _updateNotificationSetting,
              ),
              SizedBox(height: 3.h),

              // App Preferences
              AppPreferencesWidget(
                appSettings: _appSettings,
                onSettingUpdate: _updateAppSetting,
              ),
              SizedBox(height: 3.h),

              // Support Section
              SupportSectionWidget(
                onHelpPressed: _showHelpDocumentation,
                onTutorialsPressed: _showTutorialVideos,
                onContactExpertPressed: _contactExpert,
                onExportDataPressed: _exportUserData,
              ),
              SizedBox(height: 3.h),

              // Account Actions
              _buildAccountActions(),
              SizedBox(height: 10.h), // Space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentNavIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  Widget _buildAccountActions() {
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
          Text(
            'Account Actions',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.primaryColor,
            ),
          ),
          SizedBox(height: 3.h),
          _buildActionButton(
            'Sync Data',
            'Sync your data across devices',
            'sync',
            AppTheme.lightTheme.primaryColor,
            _syncData,
          ),
          SizedBox(height: 2.h),
          _buildActionButton(
            'Delete Account',
            'Permanently delete your account and data',
            'delete_forever',
            AppTheme.errorLight,
            _showDeleteAccountDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    String description,
    String iconName,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: color,
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
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    description,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: color,
              size: 5.w,
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileEditOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profile Photo',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3.h),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'camera_alt',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 6.w,
                ),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'photo_library',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 6.w,
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _chooseFromGallery();
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  void _takePhoto() {
    Fluttertoast.showToast(
      msg: "Camera functionality would open here",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _chooseFromGallery() {
    Fluttertoast.showToast(
      msg: "Gallery selection would open here",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _updateAccountField(String field, String value) {
    setState(() {
      _accountData[field] = value;
    });
    Fluttertoast.showToast(
      msg: "Account information updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _updateFarmField(String field, dynamic value) {
    setState(() {
      _farmData[field] = value;
    });
    Fluttertoast.showToast(
      msg: "Farm information updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _updateNotificationSetting(String key, bool value) {
    setState(() {
      _notificationSettings[key] = value;
    });
    Fluttertoast.showToast(
      msg: "Notification preferences updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _updateAppSetting(String key, dynamic value) {
    setState(() {
      _appSettings[key] = value;
    });
    Fluttertoast.showToast(
      msg: "App preferences updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _showHelpDocumentation() {
    Fluttertoast.showToast(
      msg: "Opening help documentation...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _showTutorialVideos() {
    Fluttertoast.showToast(
      msg: "Opening tutorial videos...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _contactExpert() {
    Fluttertoast.showToast(
      msg: "Connecting to agricultural expert...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<void> _exportUserData() async {
    try {
      final Map<String, dynamic> exportData = {
        'profile': _userProfile,
        'account': _accountData,
        'farm': _farmData,
        'notifications': _notificationSettings,
        'appSettings': _appSettings,
        'exportDate': DateTime.now().toIso8601String(),
      };

      final String jsonData =
          const JsonEncoder.withIndent('  ').convert(exportData);
      final String filename =
          'agriassist_profile_${DateTime.now().millisecondsSinceEpoch}.json';

      if (kIsWeb) {
        final bytes = utf8.encode(jsonData);
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
         html.AnchorElement(href: url)
          ..setAttribute("download", filename)
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$filename');
        await file.writeAsString(jsonData);
      }

      Fluttertoast.showToast(
        msg: "Profile data exported successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to export data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _syncData() {
    Fluttertoast.showToast(
      msg: "Syncing data across devices...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content:
              const Text('Are you sure you want to logout from your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorLight,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: TextStyle(color: AppTheme.errorLight),
          ),
          content: const Text(
            'This action cannot be undone. All your data will be permanently deleted. Are you sure you want to delete your account?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorLight,
              ),
              child: const Text('Delete Account'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Fluttertoast.showToast(
      msg: "Logged out successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _deleteAccount() {
    Fluttertoast.showToast(
      msg: "Account deletion initiated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    // Navigate to different screens based on index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/language-selection');
        break;
      case 1:
        Navigator.pushNamed(context, '/voice-query');
        break;
      case 2:
        Navigator.pushNamed(context, '/camera-diagnosis');
        break;
      case 3:
        Navigator.pushNamed(context, '/weather-insights');
        break;
      case 4:
        Navigator.pushNamed(context, '/chat-history');
        break;
      case 5:
        // Already on profile settings
        break;
    }
  }
}
