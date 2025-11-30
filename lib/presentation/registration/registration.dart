import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/agricultural_details_section_widget.dart';
import './widgets/personal_info_section_widget.dart';
import './widgets/registration_progress_widget.dart';
import './widgets/terms_acceptance_widget.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();

  // Form controllers
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  // Form state
  int _currentStep = 0;
  bool _isLoading = false;
  String? _profileImagePath;
  String _selectedExperienceLevel = 'beginner';
  String _selectedCropType = 'rice';
  String _selectedFarmSize = 'small';
  String _selectedSoilType = 'loamy';
  String _selectedLanguage = 'english';
  bool _termsAccepted = false;

  final List<String> _experienceLevels = ['beginner', 'intermediate', 'expert'];
  final List<String> _cropTypes = [
    'rice',
    'wheat',
    'corn',
    'vegetables',
    'fruits',
    'mixed'
  ];
  final List<String> _farmSizes = ['small', 'medium', 'large', 'commercial'];
  final List<String> _soilTypes = ['clay', 'sandy', 'loamy', 'silt', 'mixed'];
  final List<String> _languages = [
    'english',
    'hindi',
    'spanish',
    'french',
    'portuguese'
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      if (_validateCurrentStep()) {
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _validatePersonalInfo();
      case 1:
        return _validateAgriculturalDetails();
      case 2:
        return _termsAccepted;
      default:
        return false;
    }
  }

  bool _validatePersonalInfo() {
    if (_fullNameController.text.trim().isEmpty) {
      _showErrorToast('Please enter your full name');
      return false;
    }
    if (_phoneController.text.trim().isEmpty ||
        _phoneController.text.length < 10) {
      _showErrorToast('Please enter a valid phone number');
      return false;
    }
    return true;
  }

  bool _validateAgriculturalDetails() {
    // All agricultural details have default values, so they're always valid
    return true;
  }

  void _showErrorToast(String message) {
    if (!mounted) return;
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Theme.of(context).colorScheme.error,
      textColor: Theme.of(context).colorScheme.onError,
    );
  }

  void _showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  Future<void> _submitRegistration() async {
    if (!_validateCurrentStep()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate registration API call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate phone verification
      await _sendPhoneVerification();

      // Show success message
      _showSuccessToast(
          'Account created successfully! Please verify your phone number.');

      // Navigate to appropriate screen (could be phone verification or onboarding)
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.languageSelection);
      }
    } catch (e) {
      _showErrorToast('Registration failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendPhoneVerification() async {
    // Simulate SMS OTP sending
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _navigateToLogin() {
    // Navigate to login screen when implemented
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Progress indicator
          RegistrationProgressWidget(
            currentStep: _currentStep,
            totalSteps: 3,
          ),

          // Form content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPersonalInfoStep(),
                _buildAgriculturalDetailsStep(),
                _buildTermsStep(),
              ],
            ),
          ),

          // Bottom navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Create Account',
        style: GoogleFonts.poppins(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: _currentStep > 0
            ? _previousStep
            : () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Form(
        key: _formKey,
        child: PersonalInfoSectionWidget(
          fullNameController: _fullNameController,
          phoneController: _phoneController,
          emailController: _emailController,
          profileImagePath: _profileImagePath,
          onImageSelected: (imagePath) {
            setState(() {
              _profileImagePath = imagePath;
            });
          },
        ),
      ),
    );
  }

  Widget _buildAgriculturalDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: AgriculturalDetailsSectionWidget(
        selectedExperienceLevel: _selectedExperienceLevel,
        selectedCropType: _selectedCropType,
        selectedFarmSize: _selectedFarmSize,
        selectedSoilType: _selectedSoilType,
        selectedLanguage: _selectedLanguage,
        experienceLevels: _experienceLevels,
        cropTypes: _cropTypes,
        farmSizes: _farmSizes,
        soilTypes: _soilTypes,
        languages: _languages,
        onExperienceLevelChanged: (value) {
          setState(() {
            _selectedExperienceLevel = value;
          });
        },
        onCropTypeChanged: (value) {
          setState(() {
            _selectedCropType = value;
          });
        },
        onFarmSizeChanged: (value) {
          setState(() {
            _selectedFarmSize = value;
          });
        },
        onSoilTypeChanged: (value) {
          setState(() {
            _selectedSoilType = value;
          });
        },
        onLanguageChanged: (value) {
          setState(() {
            _selectedLanguage = value;
          });
        },
      ),
    );
  }

  Widget _buildTermsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: TermsAcceptanceWidget(
        termsAccepted: _termsAccepted,
        onTermsChanged: (value) {
          setState(() {
            _termsAccepted = value;
          });
        },
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : (_currentStep == 2 ? _submitRegistration : _nextStep),
              child: _isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Text(
                      _currentStep == 2 ? 'Create Account' : 'Next',
                      style: GoogleFonts.openSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          SizedBox(height: 2.h),

          // Sign in link
          TextButton(
            onPressed: _navigateToLogin,
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                children: [
                  const TextSpan(text: 'Already have an account? '),
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
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
